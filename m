Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753070AbWKFOVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070AbWKFOVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbWKFOVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:21:42 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17936 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1753068AbWKFOVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:21:41 -0500
Date: Mon, 6 Nov 2006 15:21:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/psi240i.c: fix an array overrun
Message-ID: <20061106142142.GM5778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an array overrun spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/scsi/psi240i.c.old	2006-11-06 15:18:08.000000000 +0100
+++ linux-2.6/drivers/scsi/psi240i.c	2006-11-06 15:18:43.000000000 +0100
@@ -328,7 +328,7 @@ static void Irq_Handler (int irq, void *
 				pinquiryData->AdditionalLength = 35 - 4;
 
 				// Fill in vendor identification fields.
-				for ( z = 0;  z < 20;  z += 2 )
+				for ( z = 0;  z < 8;  z += 2 )
 					{
 					pinquiryData->VendorId[z]	  = ((UCHAR *)identifyData.ModelNumber)[z + 1];
 					pinquiryData->VendorId[z + 1] = ((UCHAR *)identifyData.ModelNumber)[z];
