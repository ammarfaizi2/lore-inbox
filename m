Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262376AbVBCB6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262376AbVBCB6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 20:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbVBCB5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 20:57:36 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:37156 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S262706AbVBCB47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 20:56:59 -0500
Message-ID: <42018498.6030305@spirentcom.com>
Date: Wed, 02 Feb 2005 17:55:36 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-scsi@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.29] sym53c8xx.c - Add ULL suffix to fix warning
Content-Type: multipart/mixed;
 boundary="------------080608090808010303070402"
X-OriginalArrivalTime: 03 Feb 2005 01:56:48.0084 (UTC) FILETIME=[9EE90140:01C50993]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080608090808010303070402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Noticed that in drivers/scsi/sym53c8xx.c:

sym53c8xx.c:13185: warning: integer constant is too large for "long" type

Since we're not dealing with C99 (yet), this 64 bit integer constant
needs to be suffixed with ULL.  Patch included.


Mark F. Haigh
Mark.Haigh@spirentcom.com


--------------080608090808010303070402
Content-Type: text/plain;
 name="sym53c8xx-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx-patch"

--- drivers/scsi/sym53c8xx.c.orig	2005-02-02 14:35:52.981929312 -0800
+++ drivers/scsi/sym53c8xx.c	2005-02-02 14:38:38.496767232 -0800
@@ -13182,7 +13182,7 @@
 	** descriptors.
 	*/
 	if (chip && (chip->features & FE_DAC)) {
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
+		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffULL))
 			chip->features &= ~FE_DAC_IN_USE;
 		else
 			chip->features |= FE_DAC_IN_USE;


--------------080608090808010303070402--
