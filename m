Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbUERNnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbUERNnE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 09:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUERNnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 09:43:04 -0400
Received: from qfep05.superonline.com ([212.252.122.161]:11718 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S262060AbUERNmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 09:42:55 -0400
Message-ID: <40AA12E2.1070900@superonline.com>
Date: Tue, 18 May 2004 16:42:58 +0300
From: "O.Sezer" <sezero@superonline.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] decrypt/update ide help entries
References: <40A8F0E7.4000807@superonline.com> <200405172020.36892.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200405172020.36892.bzolnier@elka.pw.edu.pl>
Content-Type: multipart/mixed;
 boundary="------------040900000308060507050708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040900000308060507050708
Content-Type: text/plain; charset=iso-8859-9; format=flowed
Content-Transfer-Encoding: 8bit

Bartlomiej Zolnierkiewicz wrote:
> This patch was disccussed long time ago and nobody cared to correct it.

Hmm.. too many errors, careless duplicate entries.. ...
too many trust in trusted trees.. Me embarassed ;)

> +  "Override-Enable UDMA for Promise Contr." (or "Special UDMA Feature")
> +  to force UDMA mode for connected UDMA capable disk drives.
> 
>  It is about forcing burst UDMA transfers not UDMA mode.

Fixed

> +PROMISE PDC202{68|69|70|71|75|76|77} support
> +CONFIG_BLK_DEV_PDC202XX_NEW
[...]
> This is just copied from CONFIG_BLK_DEV_PDC202XX_OLD
> ('Ultra33') and probably is incorrect for newer Promise controllers.

Removed the old copied one wrote something generic

> +  You need to say Y here if you have a PDC20276 IDE interface but either
> +  you do not have a RAID disk array, or you wish to use the Linux
> +  internal RAID software (/dev/mdX).
> 
> This is needed not only for PDC20276.

I think this time I took the correct chipset names upon reading
pdc202XX_old.h and pdc202XX_new.h. Please check.

> +  You need to say N here if you wish to use your Promise controller to
> +  control a FastTrak RAID disk array, and you you must also say Y to
> +  CONFIG_BLK_DEV_ATARAID_PDC.
> 
> This is incorrect.
> 
> You must say Y to this option and to CONFIG_BLK_DEV_ATARAID_PDC.

Whoops, sorry. Fixed.

> If you want to correct Promise IDE help entries, do it for 2.6 first.
> 

Don't know much about 2.6; if you can review this one, I can make
similar changes for 2.6 (in case options didn't change much).

Thanks,
Özkan Sezer

--------------040900000308060507050708
Content-Type: text/plain;
 name="ide_help_update2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_help_update2.patch"

--- 27p2/Documentation/Configure.help.orig
+++ 27p2/Documentation/Configure.help
@@ -1309,20 +1309,22 @@
 
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
+  interrupt. These devices are bootable PCI UDMA controllers. Since
   multiple cards can be installed and there are BIOS ROM problems that
-  happen if the BIOS revisions of all installed cards (three-max) do
+  happen if the BIOS revisions of all installed cards (max of three) do
   not match, the driver attempts to do dynamic tuning of the chipset
   at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
   for more than one card. This card may require that you say Y to
-  "Special UDMA Feature".
+  "Force Burst UDMA transfers" (old name: "Special UDMA Feature").
 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.
@@ -1342,22 +1344,18 @@
   Promise MB FastTrak 133 [PDC20276]
   Promise FastTrak 133 [PDC20277]
 
-  This driver adds up to 4 more EIDE devices sharing a single
-  interrupt. This device is a bootable PCI UDMA controller. Since
-  multiple cards can be installed and there are BIOS ROM problems that
-  happen if the BIOS revisions of all installed cards (max of five) do
-  not match, the driver attempts to do dynamic tuning of the chipset
-  at boot-time for max speed.  Ultra33 BIOS 1.25 or newer is required
-  for more than one card.
+  This driver adds support for the newer Udma100/133 Promise chipsets
+  listed above. These chipsets are not driven by the pdc202XX_old,
+  but by this pdc202XX_new driver.
 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.
 
   If unsure, say N.
 
-Special UDMA Feature
+Force Burst UDMA transfers
 CONFIG_PDC202XX_BURST
-  This option causes the pdc202xx driver to enable UDMA modes on the
+  This option causes "pdc202xx_old" driver to enable UDMA modes on the
   PDC202xx even when the PDC202xx BIOS has not done so.
 
   It was originally designed for the PDC20246/Ultra33, whose BIOS will
@@ -1365,14 +1363,33 @@
   used successfully on a PDC20265/Ultra100, allowing use of UDMA modes
   when the PDC20265 BIOS has been disabled (for faster boot up).
 
-  Please read the comments at the top of
-  <file:drivers/ide/pci/pdc202xx_old.c>.
+  (Please read the comments in <file:drivers/ide/pci/pdc202xx_old.c>
+   about this option.)
 
   If unsure, say N.
 
-Special FastTrak Feature
+Use FastTrak RAID capable device as plain IDE controller
 CONFIG_PDC202XX_FORCE
-  For FastTrak enable overriding BIOS.
+  This option has effect on Promise chipsets PDC20270 and PDC20276
+  while using the pdc202xx_new driver.
+
+  Setting this option causes the kernel to use your Promise IDE disk
+  controller as an ordinary IDE controller, rather than as a FastTrak
+  RAID controller (RAID is a system for using multiple physical disks
+  as one virtual disk).
+
+  You need to say Y here if you have one of the above mentioned IDE
+  interfaces,  but either you do not have a RAID disk array,  or you
+  wish to use the Linux internal RAID software (/dev/mdX).
+
+  If you wish to use your Promise controller to control a FastTrak
+  RAID disk array, you need to say Y here AND you you must also say Y
+  to CONFIG_BLK_DEV_ATARAID_PDC.
+
+  This option also has effect on the chipsets run by the pdc202xx_old
+  driver ( PDC202{46|62|63|65|67} ).
+
+  If unsure, say Y.
 
 SiS5513 chipset support
 CONFIG_BLK_DEV_SIS5513
--- 27p2/drivers/ide/Config.in.orig
+++ 27p2/drivers/ide/Config.in
@@ -64,10 +64,10 @@
 	    dep_tristate '    NS87415 chipset support' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
 	    dep_tristate '    PROMISE PDC202{46|62|65|67} support' CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool     '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_mbool     '      Force Burst UDMA transfers' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX_OLD $CONFIG_BLK_DEV_IDEDMA_PCI
 	    dep_tristate '    PROMISE PDC202{68|69|70|71|75|76|77} support' CONFIG_BLK_DEV_PDC202XX_NEW $CONFIG_BLK_DEV_IDEDMA_PCI
 	    if [ "$CONFIG_BLK_DEV_PDC202XX_OLD" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_OLD" = "m" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "y" -o "$CONFIG_BLK_DEV_PDC202XX_NEW" = "m" ]; then
-	        bool     '    Special FastTrak Feature' CONFIG_PDC202XX_FORCE
+	        bool     '    Use FastTrak RAID capable device as plain IDE controller' CONFIG_PDC202XX_FORCE
 	    fi
 	    dep_tristate '    RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
 	    dep_tristate '    SCx200 chipset support' CONFIG_BLK_DEV_SC1200 $CONFIG_BLK_DEV_IDEDMA_PCI

--------------040900000308060507050708--

