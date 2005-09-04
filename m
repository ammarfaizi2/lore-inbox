Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVIDXhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVIDXhO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbVIDXg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:36:58 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:55169 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932143AbVIDXbD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:03 -0400
Message-Id: <20050904232333.007545000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:42 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-doc-update.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 43/54] dst: Updated Documentation
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Updated Documentation

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 Documentation/dvb/bt8xx.txt |   95 ++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 38 deletions(-)

--- linux-2.6.13-git4.orig/Documentation/dvb/bt8xx.txt	2005-09-04 22:30:50.000000000 +0200
+++ linux-2.6.13-git4/Documentation/dvb/bt8xx.txt	2005-09-04 22:30:51.000000000 +0200
@@ -1,55 +1,74 @@
-How to get the Nebula Electronics DigiTV, Pinnacle PCTV Sat, Twinhan DST + clones working
-=========================================================================================
+How to get the Nebula, PCTV and Twinhan DST cards working
+=========================================================
 
-1) General information
-======================
+This class of cards has a bt878a as the PCI interface, and
+require the bttv driver.
 
-This class of cards has a bt878a chip as the PCI interface.
-The different card drivers require the bttv driver to provide the means
-to access the i2c bus and the gpio pins of the bt8xx chipset.
+Please pay close attention to the warning about the bttv module
+options below for the DST card.
 
-2) Compilation rules for Kernel >= 2.6.12
-=========================================
+1) General informations
+=======================
 
-Enable the following options:
+These drivers require the bttv driver to provide the means to access
+the i2c bus and the gpio pins of the bt8xx chipset.
 
+Because of this, you need to enable
 "Device drivers" => "Multimedia devices"
- => "Video For Linux" => "BT848 Video For Linux"
+  => "Video For Linux" => "BT848 Video For Linux"
+
+Furthermore you need to enable
 "Device drivers" => "Multimedia devices" => "Digital Video Broadcasting Devices"
- => "DVB for Linux" "DVB Core Support" "BT8xx based PCI cards"
+  => "DVB for Linux" "DVB Core Support" "BT8xx based PCI cards"
 
-3) Loading Modules, described by two approaches
-===============================================
+2) Loading Modules
+==================
 
 In general you need to load the bttv driver, which will handle the gpio and
-i2c communication for us, plus the common dvb-bt8xx device driver,
-which is called the backend.
-The frontends for Nebula DigiTV (nxt6000), Pinnacle PCTV Sat (cx24110),
-TwinHan DST + clones (dst and dst-ca) are loaded automatically by the backend.
-For further details about TwinHan DST + clones see /Documentation/dvb/ci.txt.
-
-3a) The manual approach
------------------------
-
-Loading modules:
-modprobe bttv
-modprobe dvb-bt8xx
-
-Unloading modules:
-modprobe -r dvb-bt8xx
-modprobe -r bttv
+i2c communication for us, plus the common dvb-bt8xx device driver.
+The frontends for Nebula (nxt6000), Pinnacle PCTV (cx24110) and
+TwinHan (dst) are loaded automatically by the dvb-bt8xx device driver.
+
+3a) Nebula / Pinnacle PCTV
+--------------------------
 
-3b) The automatic approach
+   $ modprobe bttv (normally bttv is being loaded automatically by kmod)
+   $ modprobe dvb-bt8xx (or just place dvb-bt8xx in /etc/modules for automatic loading)
+
+
+3b) TwinHan and Clones
 --------------------------
 
-If not already done by installation, place a line either in
-/etc/modules.conf or in /etc/modprobe.conf containing this text:
-alias char-major-81	bttv
+   $ modprobe bttv i2c_hw=1 card=0x71
+   $ modprobe dvb-bt8xx
+   $ modprobe dst
+
+The value 0x71 will override the PCI type detection for dvb-bt8xx,
+which  is necessary for TwinHan cards.
+
+If you're having an older card (blue color circuit) and card=0x71 locks
+your machine, try using 0x68, too. If that does not work, ask on the
+mailing list.
+
+The DST module takes a couple of useful parameters.
+
+verbose takes values 0 to 4. These values control the verbosity level,
+and can be used to debug also.
+
+verbose=0 means complete disabling of messages
+	1 only error messages are displayed
+	2 notifications are also displayed
+	3 informational messages are also displayed
+	4 debug setting
+
+dst_addons takes values 0 and 0x20. A value of 0 means it is a FTA card.
+0x20 means it has a Conditional Access slot.
+
+The autodected values are determined bythe cards 'response
+string' which you can see in your logs e.g.
 
-Then place a line in /etc/modules containing this text:
-dvb-bt8xx
+dst_get_device_id: Recognise [DSTMCI]
 
-Reboot your system and have fun!
 
 --
-Authors: Richard Walker, Jamie Honan, Michael Hunold, Manu Abraham, Uwe Bugla
+Authors: Richard Walker, Jamie Honan, Michael Hunold, Manu Abraham

--

