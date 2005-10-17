Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVJQHeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVJQHeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVJQHeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:34:18 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:9943 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932123AbVJQHeR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:34:17 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Felix Oxley <lkml@oxley.org>
Subject: Re: [PATCH 1/1] Kconfig help text for RAM Disk & initrd
Date: Mon, 17 Oct 2005 02:33:46 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200510170102.19717.lkml@oxley.org> <200510170037.37034.rob@landley.net> <200510170812.11590.lkml@oxley.org>
In-Reply-To: <200510170812.11590.lkml@oxley.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170233.46811.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 02:12, Felix Oxley wrote:
> On Monday 17 October 2005 06:37, Rob Landley wrote:
> > Actually if this is a patch against 2.6, between ramfs (including
> > initramfs) and the ability to loopback mount files, I personally consider
> > ramdisks semi-obsolete.  (This might be _why_ it says most normal users
> > won't need them.)
>
> Well, you may well know better than I, however on my Suse 10 box,
> initrd is used and I see only CONFIG_INITRAMFS_SOURCE="" in my .config.

There's no config symbol for it because you can't disable it.  It's always 
hardwired in.  (Most of the code for ramfs is just the normal page cache 
stuff anyway.  It's a filesystem that uses the disk cache mechanism to store 
its data.  Quiet clever, really.)  Initramfs is called "rootfs" in the mount 
list, and is always there.  (Check proc/mounts on any 2.6 kernel.)  Getting 
rid of rootfs would cause an immediate deadlock becuase it's used as a search 
terminator in the doubly linked list of mounts inside the kernel.

And yes, moving off of initramfs is non-obvious because of this.  I talked 
about that a bit here:

http://www.busybox.net/lists/busybox/2005-October/016597.html

By default, the build creates an empty archive to initialize initramfs (this 
archive gets linked into the kernel image, it's not a separate file), and the 
boot process extracts it (a NOP) and then tries to exec /init in rootfs 
(which is empty, so this fails), and then falls through to the normal root 
partition finding behavior.

> I made this patch because omiting intrd caused my system to be unable to
> boot.

Then your system is setup to boot via initrd.  Probably your vendor has 
an /sbin/installkernel script that makes one.  (See arch/i386/boot/install.sh 
for details.  When you run "make install" that script looks for an 
"installkernel" script on the current system and runs it if it finds it, so 
that any vendor weirdness can apply to your new kernel automatically...)

> regards,
> Felix

Rob
