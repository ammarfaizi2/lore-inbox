Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbVCYB0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbVCYB0i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVCYBY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:24:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30225 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261369AbVCYBLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:11:02 -0500
Date: Fri, 25 Mar 2005 02:11:00 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: paulsch@us.ibm.com, sullivam@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/mwave/tp3780i.c: remove kernel 2.2 #if's
Message-ID: <20050325011100.GS3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes #if's for kernel 2.2 .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 12 Mar 2005

 drivers/char/mwave/tp3780i.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.11-mm2-full/drivers/char/mwave/tp3780i.c.old	2005-03-12 12:19:55.000000000 +0100
+++ linux-2.6.11-mm2-full/drivers/char/mwave/tp3780i.c	2005-03-12 12:20:32.000000000 +0100
@@ -242,20 +242,14 @@
 {
 	int retval = 0;
 	DSP_3780I_CONFIG_SETTINGS *pSettings = &pBDData->rDspSettings;
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	struct resource *pres;
-#endif
 
 	PRINTK_2(TRACE_TP3780I,
 		"tp3780i::tp3780I_ClaimResources entry pBDData %p\n", pBDData);
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,0)
 	pres = request_region(pSettings->usDspBaseIO, 16, "mwave_3780i");
 	if ( pres == NULL ) retval = -EIO;
-#else
-	retval = check_region(pSettings->usDspBaseIO, 16);
-	if (!retval) request_region(pSettings->usDspBaseIO, 16, "mwave_3780i");
-#endif
+
 	if (retval) {
 		PRINTK_ERROR(KERN_ERR_MWAVE "tp3780i::tp3780I_ClaimResources: Error: Could not claim I/O region starting at %x\n", pSettings->usDspBaseIO);
 		retval = -EIO;

