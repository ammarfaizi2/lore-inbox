Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbULBCoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbULBCoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 21:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbULBCoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 21:44:05 -0500
Received: from out006pub.verizon.net ([206.46.170.106]:39808 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S261576AbULBCni
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 21:43:38 -0500
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Jason.Jorgensen@comtrol.com, james4765@verizon.net
Message-Id: <20041202024400.13570.64282.90901@localhost.localdomain>
Subject: [PATCH] rocket: documentation changes
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [209.158.220.243] at Wed, 1 Dec 2004 20:43:37 -0600
Date: Wed, 1 Dec 2004 20:43:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add some configuration information to Documentation/rocket.txt that was included
with the external driver package.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-rc2-original/Documentation/rocket.txt linux-2.6.10-rc2/Documentation/rocket.txt
--- linux-2.6.10-rc2-original/Documentation/rocket.txt	2004-10-18 17:54:29.000000000 -0400
+++ linux-2.6.10-rc2/Documentation/rocket.txt	2004-12-01 17:20:04.660318196 -0500
@@ -20,8 +20,27 @@
 into them.  Installations instructions for the external module
 are in the included README and HW_INSTALL files.
 
-RocketPort ISA and RocketModem II PCI boards are also supported by this
-driver, but must use the external module driver for configuration reasons.  
+RocketPort ISA and RocketModem II PCI boards currently are only supported by
+this driver in module form.
+
+The RocketPort ISA board requires I/O ports to be configured by the DIP
+switches on the board.  See the section "ISA Rocketport Boards" below for
+information on how to set the DIP switches.
+
+You pass the I/O port to the driver using the following module parameters:
+
+board1 :	I/O port for the first ISA board
+board2 :	I/O port for the second ISA board
+board3 :	I/O port for the third ISA board
+board4 :	I/O port for the fourth ISA board
+
+There is a set of utilities and scripts provided with the external driver
+( downloadable from http://www.comtrol.com ) that ease the configuration and
+setup of the ISA cards.
+
+The RocketModem II PCI boards require firmware to be loaded into the card
+before it will function.  The driver has only been tested as a module for this
+board.
 
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 
@@ -55,12 +74,95 @@
 >mknod /dev/ttyR1 c 46 1
 >mknod /dev/ttyR2 c 46 2  
 
-The Linux script MAKEDEV will create the first 16 ttyRx device names (nodes) for you:
+The Linux script MAKEDEV will create the first 16 ttyRx device names (nodes)
+for you:
 
 >/dev/MAKEDEV ttyR
 
 =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 
+ISA Rocketport Boards
+---------------------
+
+You must assign and configure the I/O addresses used by the ISA Rocketport
+card before installing and using it.  This is done by setting a set of DIP
+switches on the Rocketport board.
+
+
+SETTING THE I/O ADDRESS
+-----------------------
+
+Before installing RocketPort(R) or RocketPort RA boards, you must find
+a range of I/O addresses for it to use. The first RocketPort card
+requires a 68-byte contiguous block of I/O addresses, starting at one
+of the following: 0x100h, 0x140h, 0x180h, 0x200h, 0x240h, 0x280h,
+0x300h, 0x340h, 0x380h.  This I/O address must be reflected in the DIP
+switiches of *all* of the Rocketport cards.
+
+The second, third, and fourth RocketPort cards require a 64-byte
+contiguous block of I/O addresses, starting at one of the following
+I/O addresses: 0x100h, 0x140h, 0x180h, 0x1C0h, 0x200h, 0x240h, 0x280h,
+0x2C0h, 0x300h, 0x340h, 0x380h, 0x3C0h.  The I/O address used by the
+second, third, and fourth Rocketport cards (if present) are set via
+software control.  The DIP switch settings for the I/O address must be
+set to the value of the first Rocketport cards.  
+
+In order to destinguish each of the card from the others, each card
+must have a unique board ID set on the dip switches.  The first
+Rocketport board must be set with the DIP switches corresponding to
+the first board, the second board must be set with the DIP switches
+corresponding to the second board, etc.  IMPORTANT: The board ID is
+the only place where the DIP switch settings should differ between the
+various Rocketport boards in a system.
+
+The I/O address range used by any of the RocketPort cards must not
+conflict with any other cards in the system, including other
+RocketPort cards.  Below, you will find a list of commonly used I/O
+address ranges which may be in use by other devices in your system.
+On a Linux system, "cat /proc/ioports" will also be helpful in
+identifying what I/O addresses are being used by devics on your
+system.
+
+Remember, the FIRST RocketPort uses 68 I/O addresses.  So, if you set it
+for 0x100, it will occupy 0x100 to 0x143.  This would mean that you
+CAN NOT set the second, third or fourth board for address 0x140 since
+the first 4 bytes of that range are used by the first board.  You would
+need to set the second, third, or fourth board to one of the next available
+blocks such as 0x180.
+
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
+
+RocketPort and RocketPort RA SW1 Settings:
+
+          +-------------------------------+
+          | 8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 |
+          +-------+-------+---------------+
+          | Unused| Card  | I/O Port Block|
+          +-------------------------------+
+
+DIP Switches                             DIP Switches
+7    8                                   6    5
+===================                      ===================
+On   On   UNUSED, MUST BE ON.            On   On   First Card    <==== Default
+                                         On   Off  Second Card
+                                         Off  On   Third Card
+                                         Off  Off  Fourth Card
+
+DIP Switches         I/O Address Range
+4    3    2    1     Used by the First Card
+=====================================
+On   Off  On   Off   100-143 
+On   Off  Off  On    140-183 
+On   Off  Off  Off   180-1C3       <==== Default
+Off  On   On   Off   200-243
+Off  On   Off  On    240-283
+Off  On   Off  Off   280-2C3
+Off  Off  On   Off   300-343
+Off  Off  Off  On    340-383
+Off  Off  Off  Off   380-3C3
+
+=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
+
 REPORTING BUGS
 --------------
 
