Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUHIRYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUHIRYR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 13:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUHIRYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 13:24:17 -0400
Received: from swordfish.cs.caltech.edu ([131.215.44.124]:9184 "EHLO
	swordfish.cs.caltech.edu") by vger.kernel.org with ESMTP
	id S266774AbUHIRYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 13:24:11 -0400
Date: Mon, 9 Aug 2004 10:24:07 -0700
From: Noah Misch <noah@cs.caltech.edu>
To: James.Bottomley@SteelEye.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@suse.de,
       schilling@fokus.fhg.de
Subject: [PATCH] Make scsi.h nominally userspace-clean
Message-ID: <20040809172406.GA1042@orchestra.cs.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Joerg Schilling, the author of cdrecord, has noted in threads such as

http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/1355.html and
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/0799.html,

scsi/scsi.h does not compile cleanly in userspace programs due to its use of
``u8''.  I have confirmed this bug and prepared and tested a fix that simply
changes all such uses to ``__u8''.  Please consider for inclusion.

I do not argue that including this header file in a program is appropriate, but
other kernel headers already take as many precautions as this patch introduces.
I chose __u8 over uint8_t as more in the style of the kernel generally.

Please keep me on cc:; I do not subscribe to the lists.

Signed-off-by: Noah Misch <noah@cs.caltech.edu>
--- pristine-linux-2.6.8-rc3/include/scsi/scsi.h	2004-06-16 01:20:25.000000000 -0400
+++ zlibstack-linux-2.6.8-rc3/include/scsi/scsi.h	2004-08-09 13:03:27.386545874 -0400
@@ -214,25 +214,25 @@
  */
 
 struct ccs_modesel_head {
-	u8 _r1;			/* reserved */
-	u8 medium;		/* device-specific medium type */
-	u8 _r2;			/* reserved */
-	u8 block_desc_length;	/* block descriptor length */
-	u8 density;		/* device-specific density code */
-	u8 number_blocks_hi;	/* number of blocks in this block desc */
-	u8 number_blocks_med;
-	u8 number_blocks_lo;
-	u8 _r3;
-	u8 block_length_hi;	/* block length for blocks in this desc */
-	u8 block_length_med;
-	u8 block_length_lo;
+	__u8 _r1;		/* reserved */
+	__u8 medium;		/* device-specific medium type */
+	__u8 _r2;		/* reserved */
+	__u8 block_desc_length;	/* block descriptor length */
+	__u8 density;		/* device-specific density code */
+	__u8 number_blocks_hi;	/* number of blocks in this block desc */
+	__u8 number_blocks_med;
+	__u8 number_blocks_lo;
+	__u8 _r3;
+	__u8 block_length_hi;	/* block length for blocks in this desc */
+	__u8 block_length_med;
+	__u8 block_length_lo;
 };
 
 /*
  * ScsiLun: 8 byte LUN.
  */
 struct scsi_lun {
-	u8 scsi_lun[8];
+	__u8 scsi_lun[8];
 };
 
 /*
