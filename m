Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSJRVCI>; Fri, 18 Oct 2002 17:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbSJRVCI>; Fri, 18 Oct 2002 17:02:08 -0400
Received: from cs.columbia.edu ([128.59.16.20]:23189 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S265361AbSJRVCD>;
	Fri, 18 Oct 2002 17:02:03 -0400
Subject: Re: can chroot be made safe for non-root?
From: Shaya Potter <spotter@cs.columbia.edu>
To: David Wagner <daw@mozart.cs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aopq2p$9pm$2@abraham.cs.berkeley.edu>
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
	 <20021018190101.GE237@elf.ucw.cz>  <aopq2p$9pm$2@abraham.cs.berkeley.edu>
Content-Type: text/plain
Organization: 
Message-Id: <1034975267.2259.81.camel@zaphod>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.2 (Preview Release)
Date: 18 Oct 2002 17:07:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 16:14, David Wagner wrote:
> Pavel Machek  wrote:
> >> I am eager to be able to sandbox my processes on a system without the
> >> help of suid-root programs (as I prefer to have none of these on my
> >> system).
> >
> >You can do that using ptrace. subterfugue.sf.net.
> 
> ptrace() is ok, but it also has lots of disadvantages: performance,
> expressiveness, security, assurance.  I've posted before on this mailing
> list, at length, about them.  In short, ptrace() is not an ideal solution,
> and a secure chroot() or other way to construct a jail/sandbox would
> be better.  (LSM will be much better.)

the problem with chroot() is that they dont nest.  If you get an fd
outside the chroot, you effectively broke the chroot.  Therefore, if
someone can get root inside the chroot, all they have to do is open an
fd, chroot somewhere else, then fchdir to that fd.

If however, one could provide even a single level of nesting, such that
a chroot outside of a chroot sets the first level, and any other chroot
after that sets the inner level, then even root wouldn't be able to
break out of the chroot (presuming it didn't bring any fd's into the
chroot w/ it).  

It might be nice to provide even more levels than this, but not sure if
one gain much by doing that and the add complexity might make it not
worthwhile.  Then again, even 2 levels might be too complex.  I've
actually thought a little of this in regards to some research I'm doing,
but haven't had a chance yet to persue, and see what would need to be
effected.  It would seem to come into play mostly on the path walking
algorithms, but that's from a very very cursory reading of the stuff. 
anyone else have any ideas on this? Or am I crazy :)

thanks,

shaya

