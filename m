Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUEQRFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUEQRFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUEQRFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:05:50 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:56780 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S261904AbUEQRFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:05:45 -0400
Message-ID: <40A8F0E7.4000807@superonline.com>
Date: Mon, 17 May 2004 20:05:43 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] decrypt/update ide help entries
Content-Type: multipart/mixed;
 boundary="------------050401090602040101020605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050401090602040101020605
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

This has been in Alan's tree for ages, why not merge
in mainline? Patch below, happily stolen from -ac/-pac.

Özkan Sezer

--------------050401090602040101020605
Content-Type: text/plain;
 name="ide_help_update.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_help_update.patch"

--- 27p2/Documentation/Configure.help~
+++ 27p2/Documentation/Configure.help
@@ -1309,20 +1309,23 @@
 
   If unsure, say N.
 
-PROMISE PDC20246/PDC20262/PDC20265/PDC20267/PDC20268 support
+PROMISE PDC20246/PDC20262/PDC20265/PDC20267 support
 CONFIG_BLK_DEV_PDC202XX_OLD
-  Promise Ultra33 or PDC20246
-  Promise Ultra66 or PDC20262
-  Promise Ultra100 or PDC20265/PDC20267/PDC20268
+  Promise Ultra 33 [PDC20246]
+  Promise Ultra 66 [PDC20262]
+  Promise FastTrak 66 [PDC20263]
+  Promise MB Ultra 100 [PDC20265]
+  Promise Ultra 100 [PDC20267]
 
   This driver adds up to 4 more EIDE devices sharing a single
-  interrupt. This add-on card is a bootable PCI UDMA controller. Since
+  interrupt. This device is a bootable PCI UDMA controller. Since
   multiple cards can be installed and there are BIOS ROM problems that
-  happen if the BIOS revisions of all installed cards (three-max) do
+  happen if the BIOS revisions of all installed cards (max of three) do
   not match, the driver attempts to do dynamic tuning of the chipset
-  at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
+  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
   for more than one card. This card may require that you say Y to
-  "Special UDMA Feature".
+  "Override-Enable UDMA for Promise Contr." (or "Special UDMA Feature")
+  to force UDMA mode for connected UDMA capable disk drives.
 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.
@@ -1355,7 +1358,30 @@
 
   If unsure, say N.
 
-Special UDMA Feature
+PROMISE PDC202{68|69|70|71|75|76|77} support
+CONFIG_BLK_DEV_PDC202XX_NEW
+  Promise Ultra 100 TX2 [PDC20268]
+  Promise Ultra 133 PTX2 [PDC20269]
+  Promise FastTrak LP/TX2/TX4 [PDC20270]
+  Promise FastTrak TX2000 [PDC20271]
+  Promise MB Ultra 133 [PDC20275]
+  Promise MB FastTrak 133 [PDC20276]
+  Promise FastTrak 133 [PDC20277]
+
+  This driver adds up to 4 more EIDE devices sharing a single
+  interrupt. This device is a bootable PCI UDMA controller. Since
+  multiple cards can be installed and there are BIOS ROM problems that
+  happen if the BIOS revisions of all installed cards (max of five) do
+  not match, the driver attempts to do dynamic tuning of the chipset
+  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
+  for more than one card. 
+
+  If you say Y here, you need to say Y to "Use DMA by default when
+  available" as well.
+
+  If unsure, say N.
+
+Override-Enable UDMA for Promise Controllers
 CONFIG_PDC202XX_BURST
   This option causes the pdc202xx driver to enable UDMA modes on the
   PDC202xx even when the PDC202xx BIOS has not done so.
@@ -1365,14 +1391,24 @@
   used successfully on a PDC20265/Ultra100, allowing use of UDMA modes
   when the PDC20265 BIOS has been disabled (for faster boot up).
 
-  Please read the comments at the top of
-  <file:drivers/ide/pci/pdc202xx_old.c>.
-
   If unsure, say N.
 
-Special FastTrak Feature
+Use FastTrak RAID capable device as plain IDE controller
 CONFIG_PDC202XX_FORCE
-  For FastTrak enable overriding BIOS.
+  Setting this option causes the kernel to use your Promise IDE disk
+  controller as an ordinary IDE controller, rather than as a FastTrak
+  RAID controller. RAID is a system for using multiple physical disks
+  as one virtual disk.
+
+  You need to say Y here if you have a PDC20276 IDE interface but either
+  you do not have a RAID disk array, or you wish to use the Linux
+  internal RAID software (/dev/mdX).
+
+  You need to say N here if you wish to use your Promise controller to
+  control a FastTrak RAID disk array, and you you must also say Y to
+  CONFIG_BLK_DEV_ATARAID_PDC.
+
+  If unsure, say Y.
 
 SiS5513 chipset support
 CONFIG_BLK_DEV_SIS5513


--------------050401090602040101020605--

