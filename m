Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282859AbRLWAj0>; Sat, 22 Dec 2001 19:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282861AbRLWAjR>; Sat, 22 Dec 2001 19:39:17 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:45316 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S282859AbRLWAjD>; Sat, 22 Dec 2001 19:39:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alexander Viro <viro@math.psu.edu>,
        "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 19:28:18 -0500
X-Mailer: KMail [version 1.3.2]
Cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0112172059510.6100-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HwUt-0001rU-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 December 2001 21:31, Alexander Viro wrote:

> *shrug*  Your "all they have to do" is quite heavy.

Lilo (broken), syslinux (not very difficult), GRUB, (already implemented).
The list is not long. It's little differeent then a boot loader supporting
initrd loading.

> > I don't think this will obsolete any existing boot methods, but it seems
> > like an additional genuinely useful capability for the Linux kernel to
> > have.
>
> I've had a very dubious pleasure of dealing with our boot sequence lately.

Yes the guilty are well known... 

> Adding more cruft to it (including in-kernel linker, for fsck sake) is
> _not_ a good idea.

Which is why all of that shit that loads multiple initrd floppies, etc,
etc should be gutting and replaced with a solid initrd system that
can load tar.gz's to tmpfs. Jeez...I happen to have such a patch RIGHT 
HERE....for 3 years now. (minix prior to tmpfs existance...)

Loading initrd and boot time kernel modules, from multiple sources,
belongs in 'pre-kernel' (prom/bootloader) land. Most importantly this
boot loader is already implemented for IA32.

> That goes for a _lot_ of code.  Mounting root.  Detecting the type of
> initrd contents.  Loading ramdisk from floppies.  Asking to press
> key (you really ought to look what is done for _that_).  Speaking
> DHCP - we have a kernel DHCP client, of all things.  All that stuff
> can (and should) be done from userland process. 

Already done (properly) in GRUB. Userland (after the kernel boots) is
no place for this. It's too late to be done cleanly. I agree the kernel
is no place either.
 
> Let loader leave an archive to be unpacked into rootfs?  Sure.  Let kernel
> exec /init on rootfs and leave the rest to it?  Absolutely.  But let's
> stop adding userland stuff into the kernel.  Loading modules _can_ be
> done from userland - insmod does it just fine.  And that's where it should
> be done.

This is a very much a failed concept. In theory it sounds nice. My
experience in
	1) implementing a Linux OS from scratch
	2) administering multiple networks of mission critical servers
says this doesn't work well.  

Dave

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
