Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSLSRgu>; Thu, 19 Dec 2002 12:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbSLSRgu>; Thu, 19 Dec 2002 12:36:50 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62401 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264940AbSLSRgt>; Thu, 19 Dec 2002 12:36:49 -0500
Message-ID: <3E0204DC.10808@BitWagon.com>
Date: Thu, 19 Dec 2002 09:41:48 -0800
From: John Reiser <jreiser@BitWagon.com>
Organization: -
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: AnonimoVeneziano <voloterreno@tin.it>,
       Patrick Petermair <black666@inode.at>,
       Roland Quast <rquast@hotshed.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: vt8235 fix, hopefully last variant
References: <20021219112640.A21164@ucw.cz>
Content-Type: multipart/mixed;
 boundary="------------080404050005070200080207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080404050005070200080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Vojtech Pavlik wrote:
> Can you guys try out this last take on a fix for your ATAPI device
> problems? Applies against clean 2.4.20.

Yes, the vt8235-atapi patch works for me; so did vt8235-dvd, but not vt8235-min.
Mitsumi FX4830T ATAPI CD-ROM, MSI KT3 Ultra2 mainboard (KT333), vt8235.

I modified the patch so that it would apply cleanly to RedHatLinux8.0
kernel-2.4.18-18.8.0 as part of "rpm -bb --target i686 kernel-2.4.18.spec".
The result is attached.

-- 
John Reiser, jreiser@BitWagon.com

--------------080404050005070200080207
Content-Type: text/plain;
 name="vt8235-atapi-jreiser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt8235-atapi-jreiser.patch"

--- linux/drivers/ide/via82cxxx.c.orig	Thu Dec 19 08:35:20 2002
+++ linux/drivers/ide/via82cxxx.c	Thu Dec 19 08:43:10 2002
@@ -1,5 +1,5 @@
 /*
- * Version 3.35
+ * Version 3.36jreiser
  *
  * VIA IDE driver for Linux. Supported southbridges:
  *
@@ -129,7 +129,7 @@
 
 	via_print("----------VIA BusMastering IDE Configuration----------------");
 
-	via_print("Driver Version:                     3.35");
+	via_print("Driver Version:                     3.36jreiser");
 	via_print("South Bridge:                       VIA %s", via_config->name);
 
 	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
@@ -295,6 +295,10 @@
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
+	/* Always use 4 address setup clocks on ATAPI devices */
+	if (drive->media != ide_disk)
+		t.setup = 4;
+ 
 	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
 
 	if (!drive->init_speed)

--------------080404050005070200080207--

