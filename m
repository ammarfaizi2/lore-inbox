Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUJ3Pb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUJ3Pb5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbUJ3Paa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:30:30 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:59552 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261239AbUJ3Owy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:52:54 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041030145253.23855.10323.39099@localhost.localdomain>
Subject: [PATCH] floppy: Updates to Documentation/floppy.txt
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.211.53] at Sat, 30 Oct 2004 09:52:53 -0500
Date: Sat, 30 Oct 2004 09:52:53 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Cleanup and update to Documentation/floppy.txt.  Fix one incorrect
option in listing.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/floppy.txt linux-2.6.9/Documentation/floppy.txt
--- linux-2.6.9-original/Documentation/floppy.txt	2004-10-18 17:53:51.000000000 -0400
+++ linux-2.6.9/Documentation/floppy.txt	2004-10-30 10:38:23.828024351 -0400
@@ -13,15 +13,20 @@
  The floppy driver is configured using the 'floppy=' option in
 lilo. This option can be typed at the boot prompt, or entered in the
 lilo configuration file.
- Example: If your kernel is called linux-2.2.13, type the following line
+
+ Example: If your kernel is called linux-2.6.9, type the following line
 at the lilo boot prompt (if you have a thinkpad):
- linux-2.2.13 floppy=thinkpad
+
+ linux-2.6.9 floppy=thinkpad
+
 You may also enter the following line in /etc/lilo.conf, in the description
-of linux-2.2.13:
+of linux-2.6.9:
+
  append = "floppy=thinkpad"
 
  Several floppy related options may be given, example:
- linux-2.2.13 floppy=daring floppy=two_fdc
+
+ linux-2.6.9 floppy=daring floppy=two_fdc
  append = "floppy=daring floppy=two_fdc"
 
  If you give options both in the lilo config file and on the boot
@@ -29,17 +34,25 @@
 prompt options coming last. That's why there are also options to
 restore the default behavior.
 
+
+Module configuration options
+============================
+
  If you use the floppy driver as a module, use the following syntax:
- insmod floppy <options>
+modprobe floppy <options>
 
 Example:
- insmod floppy daring two_fdc
+ modprobe floppy omnibook messages
+
+ If you need certain options enabled every time you load the floppy driver,
+you can put:
+
+ options floppy omnibook messages
 
- Some versions of insmod are buggy in one way or another. If you have
-any problems (options not being passed correctly, segfaults during
-insmod), first check whether there is a more recent version.
+in /etc/modprobe.conf.
 
- The floppy related options include:
+
+ The floppy driver related options are:
 
  floppy=asus_pci
 	Sets the bit mask to allow only units 0 and 1. (default)
@@ -99,7 +112,7 @@
 	master arbitration error" messages from your Ethernet card (or
 	from other devices) while accessing the floppy.
 
- floppy=fifo
+ floppy=usefifo
 	Enables the FIFO. (default)
 
  floppy=<threshold>,fifo_depth
@@ -110,6 +123,7 @@
 	lower, the interrupt latency should be lower too (faster
 	processor). The benefit of a lower threshold is less
 	interrupts.
+
 	To tune the fifo threshold, switch on over/underrun messages
 	using 'floppycontrol --messages'. Then access a floppy
 	disk. If you get a huge amount of "Over/Underrun - retrying"
@@ -120,6 +134,7 @@
 	fifo values without rebooting the machine for each test. Note
 	that you need to do 'floppycontrol --messages' every time you
 	re-insert the module.
+
 	Usually, tuning the fifo threshold should not be needed, as
 	the default (0xa) is reasonable.
 
@@ -128,6 +143,7 @@
 	you have more than two floppy drives (only two can be
 	described in the physical CMOS), or if your BIOS uses
 	non-standard CMOS types. The CMOS types are:
+
 		0 - Use the value of the physical CMOS
 		1 - 5 1/4 DD
 		2 - 5 1/4 HD
@@ -136,6 +152,7 @@
 		5 - 3 1/2 ED
 		6 - 3 1/2 ED
 	       16 - unknown or not installed
+
 	(Note: there are two valid types for ED drives. This is because 5 was
 	initially chosen to represent floppy *tapes*, and 6 for ED drives.
 	AMI ignored this, and used 5 for ED drives. That's why the floppy
@@ -188,7 +205,6 @@
 	   in some more extreme cases."
 
 
-
 Supporting utilities and additional documentation:
 ==================================================
 
@@ -219,3 +235,11 @@
  Be sure to read the FAQ before mailing/posting any bug reports!
 
  Alain
+
+Changelog
+=========
+
+10-30-2004 :	Cleanup, updating, add reference to module configuration.
+		James Nelson <james4765@gmail.com>
+
+6-3-2000 :	Original Document
