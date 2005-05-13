Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVEMWnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVEMWnG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVEMWli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:41:38 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:929 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262576AbVEMWKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:10:25 -0400
Message-Id: <20050513220226.069751000@abc>
References: <20050513220019.907667000@abc>
Date: Sat, 14 May 2005 00:00:28 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-flexcop-readme2.patch
X-SA-Exim-Connect-IP: 217.231.56.126
Subject: [DVB patch 09/11] flexcop: readme update
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

readme update

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 Documentation/dvb/README.flexcop |  121 ++++++---------------------------------
 1 files changed, 21 insertions(+), 100 deletions(-)

Index: linux-2.6.12-rc4/Documentation/dvb/README.flexcop
===================================================================
--- linux-2.6.12-rc4.orig/Documentation/dvb/README.flexcop	2005-05-12 01:30:22.000000000 +0200
+++ linux-2.6.12-rc4/Documentation/dvb/README.flexcop	2005-05-12 01:31:04.000000000 +0200
@@ -2,26 +2,20 @@ This README escorted the skystar2-driver
 state of the new flexcop-driver set and some internals are written down here
 too.
 
-How to do something in here?
-============================
-
-make -f Makefile.t
-make -C ../build-2.6
-./in.sh  # load the drivers
-./rm.sh  # unload the drivers
-
-Please read this file, if you want to contribute.
-
 This document hopefully describes things about the flexcop and its
-device-offsprings. Goal is to write a easy-to-write and easy-to-read set of
+device-offsprings. Goal was to write an easy-to-write and easy-to-read set of
 drivers based on the skystar2.c and other information.
 
-This directory is temporary. It is used for rewriting the skystar2.c and to
-create shared code, which then can be used by the usb box as well.
-
 Remark: flexcop-pci.c was a copy of skystar2.c, but every line has been
 touched and rewritten.
 
+History & News
+==============
+  2005-04-01 - correct USB ISOC transfers (thanks to Vadim Catana)
+
+
+
+
 General coding processing
 =========================
 
@@ -81,16 +75,15 @@ non-static where possible, moved code to
 
 2) Search for errors in the leftover of flexcop-pci.c (partially done)
 5a) add MAC address reading
+5c) feeding of ISOC data to the software demux (format of the isochronous data
+and speed optimization, no real error) (thanks to Vadim Catana)
 
 What to do in the near future?
 --------------------------------------
 (no special order here)
 
-
 5) USB driver
 5b) optimize isoc-transfer (submitting/killing isoc URBs when transfer is starting)
-5c) feeding of ISOC data to the software demux (format of the isochronous data
-and speed optimization, no real error)
 
 Testing changes
 ---------------
@@ -118,7 +111,7 @@ item   | mt352 | nxt2002 | stv0299 | mt3
 2)     |                 O                 |                 N
 5a)    |                 N                 |                 O
 5b)*   |                 N                 |
-5c)*   |                 N                 |
+5c)    |                 N                 |                 O
 
 * - not done yet
 
@@ -155,17 +148,21 @@ working)
 SOLUTION: also index 0 was affected, because net_translation is done for
 these indexes by default
 
-5b) isochronous transfer does only work in the first attempt (for the Sky2PC USB,
-Air2PC is working)
-SOLUTION: the flexcop was going asleep and never really woke up again (don't
-know if this need fixes, see flexcop-fe-tuner.c:flexcop_sleep)
+5b) isochronous transfer does only work in the first attempt (for the Sky2PC
+USB, Air2PC is working) SOLUTION: the flexcop was going asleep and never really
+woke up again (don't know if this need fixes, see
+flexcop-fe-tuner.c:flexcop_sleep)
+
+NEWS: when the driver is loaded and unloaded and loaded again (w/o doing
+anything in the while the driver is loaded the first time), no transfers take
+place anymore.
 
 Improvements when rewriting (refactoring) is done
 =================================================
 
 - split sleeping of the flexcop (misc_204.ACPI3_sig = 1;) from lnb_control
   (enable sleeping for other demods than dvb-s)
-- add support for CableStar (stv0297 Microtune 203x/ALPS)
+- add support for CableStar (stv0297 Microtune 203x/ALPS) (almost done, incompatibilities with the Nexus-CA)
 
 Debugging
 ---------
@@ -192,82 +189,6 @@ Sram destinations:         accessing reg
 Tuner/Demod:                     I2C bus
 DVB-stuff:            can be written for common use
 
-Restrictions:
-============
-
-We need to create a bus-specific-struct and a flexcop-struct.
-
-bus-specific-struct:
-
-struct flexcop_pci
-...
-
-struct flexcop_usb
-...
-
-
-struct flexcop_device {
-	void *bus_specific; /* container for bus-specific struct */
-...
-}
-
-PCI i2c can read/write max 4 bytes at a time, USB can more
-
-Functions
-=========
-
-Syntax
-------
-
-- Flexcop functions will be called "flexcop(_[a-z0-9]+)+" and exported as such
-  if needed.
-- Flexcop-device functions will be called "flexcop_device(_[a-z0-9]+)+" and
-  exported as such if needed.
-- Both will be compiled to b2c2-flexcop.ko and their source can be found in the
-  flexcop*.[hc]
-
-Callbacks and exports
----------------------
-
-Bus-specific functions will be given as callbacks (function pointers) to the
-flexcop-module. (within the flexcop_device-struct)
-
-Initialization process
-======================
-
-b2c2-flexcop.ko is loaded
-b2c2-flexcop-<bus>.ko is loaded
-
-suppose a device is found:
-malloc flexcop and the bus-specific variables (via flexcop_device_malloc)
-fill the bus-specific variable
-fill the flexcop variable (especially the bus-specific callbacks)
-bus-specific initialization
-	- ...
-do the common initialization (via flexcop_device_initialize)
-	- reset the card
-	- determine flexcop type (II, IIB, III)
-	- hw_filters (bus dependent)
-	- 0x204
-	- set sram size
-	- create the dvb-stuff
-	- create i2c stuff
-	- frontend-initialization
-done
-bus specific:
-	- media_destination (this and the following 3 are bus specific)
-	- cai_dest
-	- cao_dest
-	- net_destination
-
-Bugs fixed while rewriting the driver
-=====================================
-
-- EEPROM access (to read the MAC address) was fixed to death some time last
-  year. (fixed here and in skystar2.c) (Bjarne, this was the piece of code
-  (fix-chipaddr) we were wondering about)
-
-
 Acknowledgements (just for the rewriting part)
 ================
 
@@ -281,4 +202,4 @@ Boleslaw Ciesielski for pointing out a p
 
 Vadim Catana for correcting the USB transfer.
 
-comments, critics and ideas to linux-dvb@linuxtv.org or patrick.boettcher@desy.de
+comments, critics and ideas to linux-dvb@linuxtv.org.

--

