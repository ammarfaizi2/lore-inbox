Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272538AbRH3Wru>; Thu, 30 Aug 2001 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272539AbRH3Wrl>; Thu, 30 Aug 2001 18:47:41 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:36618 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S272538AbRH3Wr3>;
	Thu, 30 Aug 2001 18:47:29 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302247.f7UMl4f31365@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <11888.999209611@redhat.com> from "David Woodhouse" at "Aug 30,
 2001 11:13:31 pm"
To: "David Woodhouse" <dwmw2@infradead.org>
Date: Fri, 31 Aug 2001 00:47:04 +0200 (MET DST)
CC: ptb@it.uc3m.es, "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago David Woodhouse wrote:"
> 
> ptb@it.uc3m.es said:
> >  You got me curious enough to try it.  It compiles and links fine with
> > -O1 and higher under
> 
> >        gcc version 2.95.2 20000220 (Debian GNU/Linux)
> >        gcc version 2.8.1
> >        gcc version 2.7.2.3 
> 
> Oh well, then it _must_ be safe then - gcc has never changed unspecified 
> behaviour on us before, has it?

Well, I understand what you mean, but if the linux kernel wants it
and the C spec doesn't forbid it, then it'll either stay that way
or an "official" way will be found of evoking the desired behaviour.

The kernel already relies on -O1 expanding outb().

> The gcc engineer who took one look at the __buggy_udelay cruft, raised his
> eyebrows, swore and wandered off muttering must just have been having a bad
> day or something.

Actually, I was a bit more worried that 

  const unsigned int i = 1;
  if (i < 0)
      foo();

would generate warnings about the comparison always failing. But it
doesn't, at least not with -Wall. It does generate a warning about
implicitly declaring the function foo()! So I guess one has to add a
decl for it just above the call.  But it doesn't emit code for the call
itself, so the link is fine.

OTOH I now can't get #__LINE__ to expand as I want it where I want it.

Peter
