Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVBHEy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVBHEy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 23:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbVBHEy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 23:54:57 -0500
Received: from 207-105-1-25.zarak.com ([207.105.1.25]:13882 "HELO
	iceberg.Adtech-Inc.COM") by vger.kernel.org with SMTP
	id S261454AbVBHEyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 23:54:55 -0500
Message-ID: <420845CE.50908@spirentcom.com>
Date: Mon, 07 Feb 2005 20:53:34 -0800
From: "Mark F. Haigh" <Mark.Haigh@spirentcom.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marcelo.tosatti@cyclades.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.29-bk8] Resend: sym53c8xx.c: Add ULL suffix to fix warning
Content-Type: multipart/mixed;
 boundary="------------010602020509060307080604"
X-OriginalArrivalTime: 08 Feb 2005 04:54:54.0897 (UTC) FILETIME=[54D00210:01C50D9A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010602020509060307080604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Same patch, now against 2.4.29-bk8:

Noticed that in drivers/scsi/sym53c8xx.c:

sym53c8xx.c:13185: warning: integer constant is too large for "long" type

Since we're not dealing with C99 (yet), this 64 bit integer constant
needs to be suffixed with ULL.  Patch included.


Mark F. Haigh
Mark.Haigh@spirentcom.com



--------------010602020509060307080604
Content-Type: text/plain;
 name="sym53c8xx-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sym53c8xx-patch"

--- drivers/scsi/sym53c8xx.c.orig	2005-02-07 19:53:05.741527608 -0800
+++ drivers/scsi/sym53c8xx.c	2005-02-07 19:53:36.782808616 -0800
@@ -13182,7 +13182,7 @@
 	** descriptors.
 	*/
 	if (chip && (chip->features & FE_DAC)) {
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffff))
+		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffULL))
 			chip->features &= ~FE_DAC_IN_USE;
 		else
 			chip->features |= FE_DAC_IN_USE;

--------------010602020509060307080604--
