Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVBRUS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVBRUS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVBRURl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:17:41 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:30982 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261501AbVBRUQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:16:29 -0500
Date: Fri, 18 Feb 2005 15:16:23 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [patch libata-dev-2.6 5/5] libata: update ATA pass thru opcodes
Message-ID: <20050218201623.GF3197@tuxdriver.com>
Mail-Followup-To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com
References: <20050218195027.GB3197@tuxdriver.com> <20050218195512.GC3197@tuxdriver.com> <20050218200337.GD3197@tuxdriver.com> <20050218200637.GE3197@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050218200637.GE3197@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update ATA pass thru opcodes to match what is specified in the current
ATA pass thru spec (T10/04-262r7).

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
This part was controversial before, because these opcodes seemed to
overlap with some existing opcodes.  So I contacted the author of
the spec, Curtis Stevens: (quoted without permision)

"The command values in 04-262r7 are correct.  There was an erroneous value
published in the minutes that subsequently got published in SPC.  This has
been corrected.

Command sets are supposed to be qualified by the Inquiry Peripheral Device
Type.  I am a little concerned that some portions of linux depend on opcodes
being the same for all PDTs.  Using reusing opcodes will continue to happen
more frequently as new applications emerge and new devices are created.  The
SCSI opcoded are already overloaded to the point that Service Actions have
become necessary to extend the protocol."

Honestly, I don't know if that clears things up or not.  But, Curtis
seems pretty adamant that the values in the patch below (which match
rev 7 of the spec) are correct.  IMHO, at worst these values are no
more wrong than the ones already there.

So, apply this now, or apply it later... :-)

 include/scsi/scsi.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

--- sata-smart-2.6/include/scsi/scsi.h.orig	2005-02-01 16:22:12.390234346 -0500
+++ sata-smart-2.6/include/scsi/scsi.h	2005-02-01 16:23:02.828491161 -0500
@@ -113,9 +113,9 @@ extern const char *const scsi_device_typ
 /* values for service action in */
 #define	SAI_READ_CAPACITY_16  0x10
 
-/* Temporary values for T10/04-262 until official values are allocated */
-#define	ATA_16		      0x85	/* 16-byte pass-thru [0x85 == unused]*/
-#define	ATA_12		      0xb3	/* 12-byte pass-thru [0xb3 == obsolete set limits command] */
+/* Values for T10/04-262r7 */
+#define	ATA_16		      0x85	/* 16-byte pass-thru */
+#define	ATA_12		      0xa1	/* 12-byte pass-thru */
 
 /*
  *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft
-- 
John W. Linville
linville@tuxdriver.com
