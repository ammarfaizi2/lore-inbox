Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270862AbTG0RFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 13:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270863AbTG0RFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 13:05:12 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13767 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S270862AbTG0RFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 13:05:03 -0400
Date: Sun, 27 Jul 2003 19:20:11 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, dwmw2@redhat.com
Cc: linux-kernel@vger.kernel.org, mtd@infradead.org, trivial@rustcorp.com.au
Subject: [2.4 patch] MTD Configure.help cleanups
Message-ID: <20030727172010.GX22218@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below changes the following in Configure.help:
- remove entry for the CONFIG_MTD_BOOTLDR_PARTS option that is no longer
  present
- document the following options (all help texts stolen from 2.6):
  - CONFIG_MTD_CMDLINE_PARTS
  - CONFIG_MTD_CFI_B8
  - CONFIG_MTD_CFI_I8
  - CONFIG_MTD_CFI_STAA

Please apply
Adrian

--- linux-2.4.22-pre8-full/Documentation/Configure.help.old	2003-07-27 19:04:05.000000000 +0200
+++ linux-2.4.22-pre8-full/Documentation/Configure.help	2003-07-27 19:15:00.000000000 +0200
@@ -12967,22 +12967,40 @@
   <file:Documentation/modules.txt>. The module will be called
   redboot.o
 
-Compaq bootldr partition table parsing
-CONFIG_MTD_BOOTLDR_PARTS
-  The Compaq bootldr deals with multiple 'images' in flash devices
-  by putting a table in one of the first erase blocks of the device,
-  similar to a partition table, which gives the offsets, lengths and
-  names of all the images stored in the flash.
-
-  If you need code which can detect and parse this table, and register
-  MTD 'partitions' corresponding to each image in the table, enable
-  this option.
+CONFIG_MTD_CMDLINE_PARTS
+  Allow generic configuration of the MTD paritition tables via the kernel
+  command line. Multiple flash resources are supported for hardware where
+  different kinds of flash memory are available. 
 
   You will still need the parsing functions to be called by the driver
   for your particular device. It won't happen automatically. The 
   SA1100 map driver (CONFIG_MTD_SA1100) has an option for this, for 
   example.
 
+  The format for the command line is as follows:
+
+  mtdparts=<mtddef>[;<mtddef]
+  <mtddef>  := <mtd-id>:<partdef>[,<partdef>]
+  <partdef> := <size>[@offset][<name>][ro]
+  <mtd-id>  := unique id used in mapping driver/device
+  <size>    := standard linux memsize OR "-" to denote all 
+  remaining space
+  <name>    := (NAME)
+
+  Due to the way Linux handles the command line, no spaces are 
+  allowed in the partition definition, including mtd id's and partition 
+  names.
+
+  Examples:
+
+  1 flash resource (mtd-id "sa1100"), with 1 single writable partition:
+  mtdparts=sa1100:-
+
+  Same flash, but 2 named partitions, the first one being read-only:
+  mtdparts=sa1100:256k(ARMboot)ro,-(root)
+
+  If unsure, say 'N'.
+
 ARM Firmware Suite flash layout / partition parsing
 CONFIG_MTD_AFS_PARTS
   The ARM Firmware Suite allows the user to divide flash devices into
@@ -13150,6 +13168,10 @@
   If you wish to support CFI devices on a physical bus which is
   32 bits wide, say 'Y'.
 
+CONFIG_MTD_CFI_B8
+  If you wish to support CFI devices on a physical bus which is
+  64 bits wide, say 'Y'.
+
 Support 1-chip flash interleave
 CONFIG_MTD_CFI_I1
   If your flash chips are not interleaved - i.e. you only have one
@@ -13165,6 +13187,10 @@
   If your flash chips are interleaved in fours - i.e. you have four
   flash chips addressed by each bus cycle, then say 'Y'.
 
+CONFIG_MTD_CFI_I8
+  If your flash chips are interleaved in fours - i.e. you have eight
+  flash chips addressed by each bus cycle, then say 'Y'.
+
 # Choice: mtd_data_swap
 Flash cmd/query data swapping
 CONFIG_MTD_CFI_NOSWAP
@@ -13229,6 +13255,11 @@
   <file:Documentation/modules.txt>. The module will be called
   amd_flash.o
 
+CONFIG_MTD_CFI_STAA
+  The Common Flash Interface defines a number of different command
+  sets which a CFI-compliant chip may claim to implement. This code
+  provides support for one of those command sets.
+
 Support for RAM chips in bus mapping
 CONFIG_MTD_RAM
   This option enables basic support for RAM chips accessed through 
