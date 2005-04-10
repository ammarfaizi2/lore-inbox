Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVDJStu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDJStu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDJSsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:48:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29659 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261567AbVDJSp3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:45:29 -0400
Date: Sun, 10 Apr 2005 20:45:22 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050410184522.GA5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091208470.6947@ppc970.osdl.org> <20050409200709.GC3451@pasky.ji.cz> <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050410174512.GA18768@elte.hu>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 07:45:12PM CEST, I got a letter
where Ingo Molnar <mingo@elte.hu> told me that...
> 
> * Willy Tarreau <willy@w.ods.org> wrote:
> 
> > > >   I will also need to do more testing on the linux kernel tree.
> > > > Committing patch-2.6.7 on 2.6.6 kernel and then diffing results in
> > > > 
> > > > 	$ time gitdiff.sh `parent-id` `tree-id` >p
> > > > 	real    5m37.434s
> > > > 	user    1m27.113s
> > > > 	sys     2m41.036s
> > > > 
> > > > which is pretty horrible, it seems to me. Any benchmarking help is of
> > > > course welcomed, as well as any other feedback.
> > > 
> > > it seems from the numbers that your system doesnt have enough RAM for 
> > > this and is getting IO-bound?
> > 
> > Not the only problem, without I/O, he will go down to 4m8s (u+s) which 
> > is still in the same order of magnitude.
> 
> probably not the only problem - but if we are lucky then his system was 
> just trashing within the kernel repository and then most of the overhead 
> is the _unnecessary_ IO that happened due to that (which causes CPU 
> overhead just as much). The dominant system time suggests so, to a 
> certain degree. Maybe this is wishful thinking.

It turns out to be the forks for doing all the cuts and such what is
bogging it down so awfully (doing diff-tree takes 0.48s ;-). I do about
15 forks per change, I guess, and for some reason cut takes a long of
time on its own.

I've rewritten the cuts with the use of bash arrays and other smart
stuff. I somehow don't feel comfortable using this and prefer the
old-fashioned ways, but it would be plain unusable without this.

Now I'm down to

	real    1m21.440s
	user    0m32.374s
	sys     0m42.200s

and I kinda doubt if it is possible to cut this much down. Almost no
disk activity, I have almost everything cached by now, apparently.

Anyway, you can git pull to get the optimized version.

Thanks for the help,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
