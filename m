Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261844AbSJNG6g>; Mon, 14 Oct 2002 02:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261849AbSJNG6g>; Mon, 14 Oct 2002 02:58:36 -0400
Received: from smtp01.iprimus.net.au ([210.50.30.70]:39689 "EHLO
	smtp01.iprimus.net.au") by vger.kernel.org with ESMTP
	id <S261844AbSJNG6f>; Mon, 14 Oct 2002 02:58:35 -0400
Message-ID: <3DAA6CA2.8090008@users.sourceforge.net>
Date: Mon, 14 Oct 2002 17:05:06 +1000
From: James Courtier-Dutton <jcdutton@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Add support for Pentax Still Camera to linux kernel.
Content-Type: multipart/mixed;
 boundary="------------080709080607010108080800"
X-OriginalArrivalTime: 14 Oct 2002 07:04:25.0324 (UTC) FILETIME=[EE0D12C0:01C2734F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080709080607010108080800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is a very low risk patch.
Attached patch to "/usr/src/linux/drivers/usb/storage/unusual_devs.h" to 
enable the "PENTAX OPTIO 430" USB Still Camera to appear as a SCSI 
/dev/sd* storage device.
This patch works for my kernel version 2.4.18, but should work just as 
well unchanged for 2.4.19.
Patching to 2.5.x has not been tested.

Please include this patch with all future kernels.

Cheers
James Courtier-Dutton


--------------080709080607010108080800
Content-Type: text/plain;
 name="unusual_devs.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unusual_devs.h.diff"

--- unusual_devs.h.org	Mon Oct 14 16:55:30 2002
+++ unusual_devs.h	Mon Oct 14 16:55:17 2002
@@ -451,6 +451,19 @@
  		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_MODE_XLATE ),
 
+/* This Pentax still camera is not conformant
+ * to the USB storage specification: -
+ * - It does not like the INQUIRY command. So we must handle this command
+ *   of the SCSI layer ourselves.
+ * Tested on Rev. 10.00 (0x1000)
+ * Submitted by James Courtier-Dutton <James@superbug.demon.co.uk>
+ */
+UNUSUAL_DEV( 0x0a17, 0x0004, 0x1000, 0x1000,
+                "ASAHI PENTAX",
+                "PENTAX OPTIO 430",
+                US_SC_8070, US_PR_CBI, NULL,
+                US_FL_FIX_INQUIRY ),
+
 #ifdef CONFIG_USB_STORAGE_ISD200
 UNUSUAL_DEV(  0x0bf6, 0xa001, 0x0100, 0x0110,
                 "ATI",

--------------080709080607010108080800--

