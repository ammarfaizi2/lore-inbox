Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLEWYI>; Tue, 5 Dec 2000 17:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbQLEWX6>; Tue, 5 Dec 2000 17:23:58 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:45771 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129849AbQLEWXo>; Tue, 5 Dec 2000 17:23:44 -0500
Date: Tue, 5 Dec 2000 20:42:15 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test11: kernel: waitpid(823) failed, -512
Message-ID: <20001205204215.B17332@iapetus.localdomain>
In-Reply-To: <20001203233611.A8410@iapetus.localdomain>; <200012050133.eB51XdJ14685@snap.thunk.org> <3A2C4917.1AEEE91D@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A2C4917.1AEEE91D@uow.edu.au>; from andrewm@uow.edu.au on Tue, Dec 05, 2000 at 12:47:03PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2000 at 12:47:03PM +1100, Andrew Morton wrote:
> tytso@mit.edu wrote:
> > 
> > On Sun, Dec 03, 2000 at 11:36:11PM +0100, Frank van Maarseveen wrote:
> > > While playing with routing (zebra) and PPP I regularly see this
> > > message appearing. It always happens when pppd terminates a connection,
> > > e.g:
> > > Dec  3 23:09:08 mimas kernel: waitpid(823) failed, -512
> > 
> > This means a system call returned with an error code of -ERESTARTSYS
> > when a signal wasn't pending; this is a kernel bug.
> > 
> > However, I've looked at the code to sys_wait4 (which implements
> > waitpid), and I can't see where this might happen.  Just before
> > end_wait4, it does do something potentially dangerous in that it
> > leaves retval set to -ERESTARTSYS, but in all of the code paths I can
> > see, retval gets reset before it exits.  The only thing I can think of
> > is a compiler bug; what version of gcc are you using?

gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release), from RH6.1

> > 
> > Puzzled
> 
> Ted,
> 
> it's caused by exec_usermodehelper().

I'm using modules as much as possible (for the fun of it). something
(zebra?) often tries to load net-pf-10 which I believe is ipv6. Not
configured however.

I'll try the patch.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
