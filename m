Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAIPLm>; Tue, 9 Jan 2001 10:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130012AbRAIPLZ>; Tue, 9 Jan 2001 10:11:25 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32128 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129324AbRAIPLJ>; Tue, 9 Jan 2001 10:11:09 -0500
Date: Tue, 9 Jan 2001 10:10:16 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Richard Henderson <rth@twiddle.net>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>,
        richbaum@acm.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] More compile warning fixes for 2.4.0
In-Reply-To: <200101091002.f09A2gw281603@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.95.1010109094113.8427A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Albert D. Cahalan wrote:

> [about labels w/o statements after them]
> 
> >> Is this really a kernel bug? This is common idiom in C, so gcc
> >> shouldn't warn about it. If it does, it is a bug in gcc IMHO.
> >
> > No, it is not a common idiom in C.  It has _never_ been valid C.
> >
> > GCC originally allowed it due to a mistake in the grammar; we
> > now warn for it.  Fix your source.
> 
> Since neither -ansi nor -std=foo was specified, gcc should just
> shut up and be happy. Consider this as another GNU extension.
> 

It has to do with ; "a label at the end of a compound statement..."
This has never been correctly allowed. Many don't realilize that
	case 'X':
	case 'Y':
	default:

... are all labels. Modern compilers are now enforcing the rules.
When a 'switch' is a compound statement, tt follows the rules for
other compound statements. For instance, you can code (correctly)

	switch(a) case 1: a--;

... this, with no braces at all. If a == 1, it gets changed to 0,
otherwise it is untouched. If we need another test, it becomes
a compound statement requiring braces as:

	switch(a) { case 1: a--; default: }

Observe that we have tricked the compiler into generating code without
using a ';' denoting the end of a statement. The standards makers don't
like this and and now requiring that the above be coded as:

	switch(a) { case 1: a--; default: ; }
	                                  ^___ no tricks allowed.

A 'program unit', denoted by {} braces has never required a terminating
semicolon, so putting a ';' at the end of the physical statement
just won't do it in this case.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
