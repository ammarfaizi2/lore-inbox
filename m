Return-Path: <linux-kernel-owner+w=401wt.eu-S1750971AbXAIDvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbXAIDvg (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 22:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbXAIDvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 22:51:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:38691 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962AbXAIDvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 22:51:35 -0500
Date: Mon, 8 Jan 2007 19:51:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl /
 xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-Id: <20070108195127.67fe86b8.akpm@osdl.org>
In-Reply-To: <45A30E1D.4030401@sandeen.net>
References: <20070104001420.GA32440@m.safari.iki.fi>
	<20070107213734.GS44411608@melbourne.sgi.com>
	<20070108110323.GA3803@m.safari.iki.fi>
	<45A27416.8030600@sandeen.net>
	<20070108234728.GC33919298@melbourne.sgi.com>
	<20070108161917.73a4c2c6.akpm@osdl.org>
	<45A30828.6000508@sandeen.net>
	<20070108191800.9d83ff5e.akpm@osdl.org>
	<45A30E1D.4030401@sandeen.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jan 2007 21:38:05 -0600
Eric Sandeen <sandeen@sandeen.net> wrote:

> Andrew Morton wrote:
> > On Mon, 08 Jan 2007 21:12:40 -0600
> > Eric Sandeen <sandeen@sandeen.net> wrote:
> > 
> >> Andrew Morton wrote:
> >>> On Tue, 9 Jan 2007 10:47:28 +1100
> >>> David Chinner <dgc@sgi.com> wrote:
> >>>
> >>>> On Mon, Jan 08, 2007 at 10:40:54AM -0600, Eric Sandeen wrote:
> >>>>> Sami Farin wrote:
> >>>>>> On Mon, Jan 08, 2007 at 08:37:34 +1100, David Chinner wrote:
> >>>>>> ...
> >>>>>>>> fstab was there just fine after -u.
> >>>>>>> Oh, that still hasn't been fixed?
> >>>>>> Looked like it =)
> >>>>> Hm, it was proposed upstream a while ago:
> >>>>>
> >>>>> http://lkml.org/lkml/2006/9/27/137
> >>>>>
> >>>>> I guess it got lost?
> >>>> Seems like it. Andrew, did this ever get queued for merge?
> >>> Seems not.  I think people were hoping that various nasties in there
> >>> would go away.  We return to userspace with a kernel lock held??
> >> Is a semaphore any worse than the current mutex in this respect?  At 
> >> least unlocking from another thread doesn't violate semaphore rules.  :)
> > 
> > I assume that if we weren't returning to userspace with a lock held, this
> > mutex problem would simply go away.
> > 
> 
> Well nobody's asserting that the filesystem must always be locked & 
> unlocked by the same thread, are they?  That'd be a strange rule to 
> enforce upon the userspace doing the filesystem management wouldn't it? 
>   Or am I thinking about this wrong...

I don't even know what code we're talking about here...

I'm under the impression that XFS will return to userspace with a
filesystem lock held, under the expectation (ie: requirement) that
userspace will later come in and release that lock.

If that's not true, then what _is_ happening in there?

If that _is_ true then, well, that sucks a bit.
