Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUFNAos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUFNAos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUFNAni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:43:38 -0400
Received: from holomorphy.com ([207.189.100.168]:31389 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261500AbUFNAlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:41:50 -0400
Date: Sun, 13 Jun 2004 17:41:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [8/12] fake inquiry for Sony Clie PEG-TJ25 in unusual_devs.h
Message-ID: <20040614004147.GW1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040614004034.GV1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614004034.GV1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 * Fake inquiry for Sony Clie PEG-TJ25 in drivers/usb/storage/unusual_devs.h
This fixes Debian BTS #243650.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=243650

	From: Mike Alborn <malborn@deandra.homeip.net>
	To: Debian Bug Tracking System <submit@bugs.debian.org>
	Subject: kernel-image-2.6.5-1-686: usb-storage fails to enumerate Sony Clie PEG-TJ25
	Message-Id: <E1BDet8-0000ND-00@dominique>

When I connect my Sony Clie PEG-TJ25 to my computer and run the MS
Import function, the usb-storage module reports the following error:

scsi0 : SCSI emulation for USB Mass Storage devices 
scsi scan: 56 byte inquiry failed with code 134217730. Consider
BLIST_INQUIRY_36 for this device.

lsusb shows the Clie device, but when I try to mount /dev/sda1, I get
'/dev/sda1 is not a valid block device' and cfdisk is 'unable to open
/dev/sda' I have no other SCSI hard disks installed on the system, so I
assume /dev/sda1 is where I should find my Clie.

Note that this function worked with a Debian package of a 2.4 kernel (I
believe it was 2.4.24).

Index: linux-2.5/drivers/usb/storage/unusual_devs.h
===================================================================
--- linux-2.5.orig/drivers/usb/storage/unusual_devs.h	2004-06-13 11:57:26.000000000 -0700
+++ linux-2.5/drivers/usb/storage/unusual_devs.h	2004-06-13 12:08:56.000000000 -0700
@@ -342,6 +342,13 @@
 		"PEG Mass Storage",
 		US_SC_DEVICE, US_PR_DEVICE, NULL,
 		US_FL_FIX_INQUIRY ),
+
+/* Submitted by Mike Alborn <malborn@deandra.homeip.net> */
+UNUSUAL_DEV(  0x054c, 0x016a, 0x0000, 0x9999,
+		"Sony",
+		"PEG Mass Storage",
+		US_SC_DEVICE, US_PR_DEVICE, NULL,
+		US_FL_FIX_INQUIRY ),
 		
 UNUSUAL_DEV(  0x057b, 0x0000, 0x0000, 0x0299, 
 		"Y-E Data",
