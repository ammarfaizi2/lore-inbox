Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVBWU2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVBWU2f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVBWU2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:28:35 -0500
Received: from aun.it.uu.se ([130.238.12.36]:20219 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261561AbVBWU2c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:28:32 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16924.59237.581247.498382@alkaid.it.uu.se>
Date: Wed, 23 Feb 2005 21:28:21 +0100
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: ppc32 weirdness with gcc-4.0 in 2.6.11-rc4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.11-rc4 built with gcc-3.4.3 works fine on my eMac.
Building with gcc-4.0.0 (20050220) however gives me a kernel
with dead USB, and thus no keyboard or mouse, but everything
else seems to be working.

A diff between dmesg on the two kernels has an interesting nugget:

--- dmesg-2.6.11-rc4-gcc343	2005-02-23 20:57:54.000000000 +0100
+++ dmesg-2.6.11-rc4-gcc400	2005-02-23 21:14:44.000000000 +0100
@@ -1,5 +1,5 @@
 Total memory = 256MB; using 512kB for hash table (at c0300000)
-Linux version 2.6.11-rc4-gcc343 (mikpe@darwin) (gcc version 3.4.3) #1 Wed Feb 23 20:53:57 CET 2005
+Linux version 2.6.11-rc4-gcc400 (mikpe@darwin) (gcc version 4.0.0 20050220 (experimental)) #1 Wed Feb 23 21:10:27 CET 2005
 Found UniNorth memory controller & host bridge, revision: 210
 Mapped at 0xfdf00000
 Found a Intrepid mac-io controller, rev: 0, mapped at 0xfde80000
@@ -26,11 +26,11 @@
 OpenPIC timer frequency is 4.160000 MHz
 PID hash table entries: 2048 (order: 11, 32768 bytes)
 GMT Delta read from XPRAM: 0 minutes, DST: off
-time_init: decrementer frequency = 41.600661 MHz
+time_init: decrementer frequency = 41.600571 MHz
 Console: colour dummy device 80x25
 Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
 Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
-Memory: 255872k available (1788k kernel code, 976k data, 144k init, 0k highmem)
+Memory: 255872k available (1776k kernel code, 0k data, 144k init, 0k highmem)
 AGP special page: 0xcffff000
 Calibrating delay loop... 830.66 BogoMIPS (lpj=4153344)
 Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
@@ -132,13 +132,7 @@
 VFS: Mounted root (ext3 filesystem) readonly.
 Freeing unused kernel memory: 144k init 4k chrp 8k prep
 usb 3-2: new full speed USB device using ohci_hcd and address 2
-hub 3-2:1.0: USB hub found
-hub 3-2:1.0: 3 ports detected
-usb 3-2.1: new low speed USB device using ohci_hcd and address 3
-input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:1b.0-2.1
-usb 3-2.3: new full speed USB device using ohci_hcd and address 4
-input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
-input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:10:1b.0-2.3
+usb 3-2: can't connect bus-powered hub to this port
 EXT3 FS on hda5, internal journal
 Adding 1048568k swap on /dev/hda3.  Priority:-1 extents:1
 SCSI subsystem initialized

Note: "Memory: ... 0k data ..." !? Surely that can't be correct.

/Mikael
