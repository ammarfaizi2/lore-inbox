Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWBFPMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWBFPMY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 10:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWBFPMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 10:12:24 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:46507 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932152AbWBFPMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 10:12:23 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Mon, 6 Feb 2006 16:13:39 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org,
       Bernard Blackham <bernard@blackham.com.au>
References: <200602030918.07006.nigel@suspend2.net> <200602041451.45232.rjw@sisk.pl> <200602060902.50386.ncunningham@cyclades.com>
In-Reply-To: <200602060902.50386.ncunningham@cyclades.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061613.40496.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 06 February 2006 00:02, Nigel Cunningham wrote:
> On Saturday 04 February 2006 23:51, Rafael J. Wysocki wrote:
> > On Saturday 04 February 2006 02:23, Pavel Machek wrote:
> > > On So 04-02-06 02:08:33, Olivier Galibert wrote:
> > > > On Sat, Feb 04, 2006 at 01:49:44AM +0100, Pavel Machek wrote:
> > > > > > Why don't you try to design the system so that the progress bar
> > > > > > can't fuck up the suspend unless they really, really want to? 
> > > > > > Instead of one where a forgotten open(O_CREAT) in a corner of
> > > > > > graphics code can randomly trash the filesystem through metadata
> > > > > > corruption?
> > > > >
> > > > > Even if I only put chrome code to userspace, open() would still be
> > > > > deadly. I could do something fancy with disallowing syscalls,
> > > >
> > > > Nah, simply chroot to an empty virtual filesystem (a tmpfs with max
> > > > size=0 will do) and they can't do any fs-related fuckup anymore. 
> > > > Just give them a fd through which request some specific resources
> > > > (framebuffer mmap essentially I would say) and exchange messages
> > > > with the suspend system (status, cancel, etc) and maybe log stderr
> > > > for debugging purposes and that's it.  They can't do damage by
> > > > mistake anymore.  They can always send signals to random pids, but
> > > > that's not called a mistake at that point.
> > > >
> > > > Even better, you can run _multiple_ processes that way, some for
> > > > compression/encryption, some for chrome, etc.
> > >
> > > No, I do not want to deal with multiple processes. Chrome code is not
> > > *as* evil as you paint it... But yes, chroot is a nice idea. Doing
> > > chroot into nowhere after freezing system will prevent most stupid
> > > mistakes. Rest of userland is frozen, so it can not do anything really
> > > wrong (at most you deadlock), if you kill someone -- well, that's only
> > > as dangerous as any other code running as root.
> >
> > I like the chroot idea too.
> 
> You're making this too complicated. Just require that the userspace program 
> does all it's file opening etc prior to telling kernelspace to do 
> anything. Then clearly document the requirement. If someone breaks the 
> rule, it is their problem, and their testing should show their 
> foolishness. We have done a similar thing in the Suspend2 userspace user 
> interface code, and it works fine.

Unfortunately I'd like to open at least one device file after freeze, for a
technical reason that probably does not exist in suspend2, so I need a
temporary filesystem anyway.  Chrooting to it is just a cake.

[BTW, we have the list suspend-devel@lists.sourceforge.net we'd like
to be a place for discussing the userspace suspend issues.  If you could
subscribe to it, we'd be able to move the discussion there.]

Greetings,
Rafael
