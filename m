Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267821AbTAMKXO>; Mon, 13 Jan 2003 05:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267823AbTAMKXO>; Mon, 13 Jan 2003 05:23:14 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:61842 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267821AbTAMKXN>; Mon, 13 Jan 2003 05:23:13 -0500
Message-Id: <200301131032.h0DAWHEG022612@eeyore.valparaiso.cl>
To: robw@optonline.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gotos in kernel [Was: Re: any chance of 2.6.0-test*?]
In-Reply-To: Your message of "Sun, 12 Jan 2003 14:34:54 EST."
             <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> 
Date: Mon, 13 Jan 2003 11:32:17 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Wilkens <robw@optonline.net> said:
> I'm REALLY opposed to the use of the word "goto" in any code where it's
> not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
> to comment

My, my, my, an anti-goto zealot now.

> Let me comment below the relevant code snippet below as to how I would
> change it:
> 
> On Sun, 2003-01-12 at 14:15, Linus Torvalds wrote:
> > 		if (spin_trylock(&tty_lock.lock))
> > 			goto got_lock;
> > 		if (tsk == tty_lock.lock_owner) {
> > 			WARN_ON(!tty_lock.lock_count);
> > 			tty_lock.lock_count++;
> > 			return flags;
> > 		}
> > 		spin_lock(&tty_lock.lock);
> > 	got_lock:
> > 		WARN_ON(tty_lock.lock_owner);
> 	    	   <etc...>
> 
> I would change it to something like the following (without testing the
> code through a compiler or anything to see if it's valid):

It just to happens that sometimes the compiler generates stupid code for
goto-less solutions. While the famous "no goto needed" theorem is certainly
true, it duplicates lots of code to get rid of gotos, and that is a no -
never - only over my dead body proposition in a kernel that tries to be as
fast as humanly possible.

And if used with care and good taste, a goto can lead to clearer, more
understandable (and thus more probably correct) code. Just look up what
sort of "programming style" Dijkstra was complaining about when asking to
ban gotos, and what D. E. Knuth has to say on structured programming with
gotos.
--
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
