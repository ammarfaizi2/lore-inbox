Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUDHTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbUDHTV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:21:58 -0400
Received: from prime.hereintown.net ([141.157.132.3]:28831 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S262370AbUDHTVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:21:39 -0400
Subject: initramfs howto?
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081451826.238.23.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Thu, 08 Apr 2004 15:17:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been a monolithic kernel guy forever.  But with all the new toys
going into 2.6 I figured I'd try to catch up with the times.

I've got udev + hotplug halfway functioning, and wanted to try moving
even my fs and IDE/SCSI modules out of the kernel.  It seems the way to
do that is with an initramfs.

So I figure I'll start simple, I got klibc and built it.  Copied the the
lib and executables into a new tree, lib in lib and bins in bin.
Symlinked linuxrc to /bin/sh.  I also added a dev directory with ram0,
ram1, and initrd (later in my experimentation).  Then I cpio'd up the
tree, gzip'd it, and put it where I told grub to find it:
 "initrd (hd0,0)/boot/test/initramfs.cpio.gz"

When I boot the kernel associated with that initrd line, it says that it
found a compressed image at block 0.  But then panics saying it can't
mount the root filesystem.

I've tried various root= options.
>From /dev/ram0, /dev/ram1, /dev/initrd, and initramfs.  All fail.
Although /dev/ram0, spit out its own name instead of an unknown block
device 0,0.

So, what am I missing?  I've Googled for about an hour now.  Everyone is
just talking about the neat new features of initramfs, but no one says,
"do this".  The in-tree documentation isn't much better, although it is
what got me this far.  The early-userspace document talks about
short-circuting the kernel build to get a custom initramfs appended to
the kernel image.  But that seems a bit rough, shouldn't the bootloader
be able to do the appending?

Any help will be welcomed.

-- 
Chris

