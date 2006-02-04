Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWBDNwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBDNwm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbWBDNwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:52:42 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:161 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932202AbWBDNwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:52:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Sat, 4 Feb 2006 14:51:44 +0100
User-Agent: KMail/1.9.1
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
References: <200602030918.07006.nigel@suspend2.net> <20060204010833.GD4845@dspnet.fr.eu.org> <20060204012312.GH3291@elf.ucw.cz>
In-Reply-To: <20060204012312.GH3291@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602041451.45232.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 04 February 2006 02:23, Pavel Machek wrote:
> On So 04-02-06 02:08:33, Olivier Galibert wrote:
> > On Sat, Feb 04, 2006 at 01:49:44AM +0100, Pavel Machek wrote:
> > > > Why don't you try to design the system so that the progress bar can't
> > > > fuck up the suspend unless they really, really want to?  Instead of
> > > > one where a forgotten open(O_CREAT) in a corner of graphics code can
> > > > randomly trash the filesystem through metadata corruption?
> > > 
> > > Even if I only put chrome code to userspace, open() would still be
> > > deadly. I could do something fancy with disallowing syscalls,
> > 
> > Nah, simply chroot to an empty virtual filesystem (a tmpfs with max
> > size=0 will do) and they can't do any fs-related fuckup anymore.  Just
> > give them a fd through which request some specific resources
> > (framebuffer mmap essentially I would say) and exchange messages with
> > the suspend system (status, cancel, etc) and maybe log stderr for
> > debugging purposes and that's it.  They can't do damage by mistake
> > anymore.  They can always send signals to random pids, but that's not
> > called a mistake at that point.
> > 
> > Even better, you can run _multiple_ processes that way, some for
> > compression/encryption, some for chrome, etc.
> 
> No, I do not want to deal with multiple processes. Chrome code is not
> *as* evil as you paint it... But yes, chroot is a nice idea. Doing
> chroot into nowhere after freezing system will prevent most stupid
> mistakes. Rest of userland is frozen, so it can not do anything really
> wrong (at most you deadlock), if you kill someone -- well, that's only
> as dangerous as any other code running as root.

I like the chroot idea too.

Are we going to chroot from the kernel level (eg. the atomic snapshot
ioctl()) or from within the suspending utility?

I think the kernel level would protect some people from bugs in their own
suspending utilities, but then we'd have to mount the tmpfs from the kernel
level as well.

Greetings,
Rafael
