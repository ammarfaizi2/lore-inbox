Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRHaPfw>; Fri, 31 Aug 2001 11:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266827AbRHaPfm>; Fri, 31 Aug 2001 11:35:42 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:61200 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S266797AbRHaPfa>;
	Fri, 31 Aug 2001 11:35:30 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108311534.RAA15990@nbd.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: <Pine.LNX.4.33.0108310655590.15502-100000@penguin.transmeta.com>
 "from Linus Torvalds at Aug 31, 2001 07:02:46 am"
To: Linus Torvalds <torvalds@transmeta.com>
Date: Fri, 31 Aug 2001 17:34:56 +0200 (CEST)
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

"A month of sundays ago Linus Torvalds wrote:"
> I _would_ suggest that you change the MIN_BUG() thing to the traditional
> 
> 	#define compile_time_assert(x) \
> 		do { switch (0) { case 0: case (x) != 0: ; } } while (0)
> 
> which gives the error from the compiler, and does not depend on the
> assembler.

OK. I did that here (inverting the logic from the if blah then bug form).
It goes just as well. Do you want this made up as a patch for 2.4.9?
Leaving code that thereby becomes non-compiling to its owner's tender
care?

What assertions on the types do you want, btw? People have been
saying that unequal size types are ok, and that it's just signed vs
unsigned that's the problem, and even then only when it's the longer
type that's unsigned and the shorter that's signed. I'd be inclined
to be paranoid and leave the alarms ringing when sizes or signs don't
match exactly.

> What I _really_ think might be interesting is a
> 
> 	-Wsign-promote
> 
> warnign that hits outside compares (at any implicit promotion that
> changes the sign - ie exactly the cases where K&R v1 and v2 differ), but I
> suspect that it will have even _more_ problems than -Wsign-compare in the

Peter
