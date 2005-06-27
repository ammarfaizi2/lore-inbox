Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVF0OPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVF0OPR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 10:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVF0OCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 10:02:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:32720 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262098AbVF0MUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:20:23 -0400
Message-ID: <42BFEEFF.4070004@pobox.com>
Date: Mon, 27 Jun 2005 08:20:15 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [git patches] 2.6.x misc dma-mask changes
Content-Type: multipart/mixed;
 boundary="------------080201030805080201060702"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080201030805080201060702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Please pull from the 'upstream' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

to obtain the changes described in the attachment.


--------------080201030805080201060702
Content-Type: text/plain;
 name="misc-2.6.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="misc-2.6.txt"

 drivers/block/sx8.c         |    7 ++++---
 sound/oss/via82cxxx_audio.c |    5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)


Tobias Klauser:
  sound/oss/via82cxxx_audio: Use the DMA_32BIT_MASK constant
  drivers/block/sx8.c: Use the DMA_{64, 32}BIT_MASK constants


diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -26,6 +26,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/hdreg.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -1582,9 +1583,9 @@ static int carm_init_one (struct pci_dev
 		goto err_out;
 
 #if IF_64BIT_DMA_IS_POSSIBLE /* grrrr... */
-	rc = pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+	rc = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
 	if (!rc) {
-		rc = pci_set_consistent_dma_mask(pdev, 0xffffffffffffffffULL);
+		rc = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): consistent DMA mask failure\n",
 				pci_name(pdev));
@@ -1593,7 +1594,7 @@ static int carm_init_one (struct pci_dev
 		pci_dac = 1;
 	} else {
 #endif
-		rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+		rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 		if (rc) {
 			printk(KERN_ERR DRV_NAME "(%s): DMA mask failure\n",
 				pci_name(pdev));
diff --git a/sound/oss/via82cxxx_audio.c b/sound/oss/via82cxxx_audio.c
--- a/sound/oss/via82cxxx_audio.c
+++ b/sound/oss/via82cxxx_audio.c
@@ -35,6 +35,7 @@
 #include <linux/smp_lock.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -3391,10 +3392,10 @@ static int __devinit via_init_one (struc
 	if (rc)
 		goto err_out_disable;
 
-	rc = pci_set_dma_mask(pdev, 0xffffffffULL);
+	rc = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_res;
-	rc = pci_set_consistent_dma_mask(pdev, 0xffffffffULL);
+	rc = pci_set_consistent_dma_mask(pdev, DMA_32BIT_MASK);
 	if (rc)
 		goto err_out_res;
 

--------------080201030805080201060702--
