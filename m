Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268063AbTBYQQb>; Tue, 25 Feb 2003 11:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268066AbTBYQQb>; Tue, 25 Feb 2003 11:16:31 -0500
Received: from ns.suse.de ([213.95.15.193]:60429 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S268063AbTBYQQ2>;
	Tue, 25 Feb 2003 11:16:28 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
X-Yow: Now, let's SEND OUT for QUICHE!!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 25 Feb 2003 17:26:27 +0100
In-Reply-To: <Pine.LNX.4.44.0302250742400.10210-100000@home.transmeta.com> (Linus
 Torvalds's message of "Tue, 25 Feb 2003 08:02:15 -0800 (PST)")
Message-ID: <jesmuc498s.fsf@sykes.suse.de>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.3.50
References: <Pine.LNX.4.44.0302250742400.10210-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

|> On Tue, 25 Feb 2003, Andreas Schwab wrote:
|> > |> 
|> > |> So? Gcc does that anyway. _Any_ good compiler has to.
|> > 
|> > But the point is that determining the common type does not require _any_
|> > kind of data flow analysis, and this is the place where the unsigned
|> > warning is generated.
|> 
|> Go back and read my mail. In fact, go back and read just about _any_ of my 
|> mails on the subject. Gop back and read the part you snipped:
|> 
|>  "And if the compiler isn't good enough to do it, then the compiler 
|>   shouldn't be warning about something that it hasn't got a clue about."
|> 
|> In other words, either gcc should do it right, or it should not be done at 
|> all. Right now the warning IS GENERATED IN THE WRONG PLACE. Your argument 
|> seems to be "but that's the place it is generated" is a total 
|> non-argument. It's just stating a fact, and it's exactly that fact that 
|> causes the BUG IN GCC.

Then we have to agree to disagree.  Signed/unsigned mixups are just too
easy to get wrong in C, and a constant source of security bugs.

|> > |> Trivial example:
|> > |> 
|> > |> 	int x[2][2];
|> > |> 
|> > |> 	int main(int argc, char **argv)
|> > |> 	{
|> > |> 		return x[1][-1];
|> > |> 	}
|> > |> 
|> > |> 
|> > |> the above is actually a well-defined C program, and 100%
|> > |> standards-conforming ("strictly conforming").
|> > 
|> > This isn't as trivial as it seems.  Look in comp.std.c for recent
|> > discussions on this topic (out-of-array references). 
|> 
|> It is as trivial as it seems, and this is _not_ an out-of-array reference.  

It is out of the x[1] array, *if* you consider it an object of its own
(whether this is the right viewpoint is the point of the issue).

|> So if they argued about this on comp.std.c, they either had clueless
|> people there (in addition to the ones that obviously aren't ;), _or_ you
|> misunderstood the argument.

I'd guess that the language experts on comp.std.c are more clueful about
the C standard than both you and me.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
