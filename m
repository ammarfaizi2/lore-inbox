Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272677AbRHaMOY>; Fri, 31 Aug 2001 08:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272676AbRHaMOO>; Fri, 31 Aug 2001 08:14:14 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:52752 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272674AbRHaMOC>;
	Fri, 31 Aug 2001 08:14:02 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108311213.OAA01600@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0108311342570.24131-100000@serv> "from Roman Zippel
 at Aug 31, 2001 02:01:22 pm"
To: Roman Zippel <zippel@linux-m68k.org>
Date: Fri, 31 Aug 2001 14:13:33 +0200 (CEST)
CC: "Peter T. Breuer" <ptb@it.uc3m.es>,
        "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Roman Zippel wrote:"
> On Fri, 31 Aug 2001, Peter T. Breuer wrote:
> 
> >    if (sizeof(_x) != sizeof(_y)) \
> >      MIN_BUG(); \
> 
> What bug are you trying to fix here?

Wake up!

> > int main() {
> >   unsigned i = 1;
> >   signed j = -2;
> >   return MIN(i,j);
> > }
> 
> Try -Wsign-compare.

Wake up harder!

Try reading the last 10 days kernel messages. The last 48 hours are
particularly rewarding.

To be honest, nobody has precisely formulated the problem. I'll attempt
a quick summary of the most salient:

  C silently transforms signed int to unsigned int in cross-signed
  comparisons. This results in 1U < -2, and gives rise to all kinds
  of error paths from min/max codes (in particular, but they're not
  all) of the form

     min(unsigned_positive_constant, signed_ok_or_error_value)

  whose authors were expecting to get the error value out when the
  error value went in!

There are apparently more problems too, but nobody has explained them
to me in a manner that I can comprehend. I suspect that nobody knows
the full range of possible faults. I put in the size comparison
that you remarked upon so that people could tell me about it. Tell me
about it.

Linus wants possible mistakes flagged. He specifically does not want
-Wsign-compare because it apparently gives false positives.
  

Peter
