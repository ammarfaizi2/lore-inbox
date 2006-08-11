Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWHKV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWHKV7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 17:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbWHKV7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 17:59:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:40874 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750831AbWHKV7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 17:59:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=QR5tNzblqR5x6rhlW5sQrrfG5UEFXy+gp09nBzM6RYYn6Y569aMIrBsQu85mrjIISmzyFfPU/dMdvnR7JbTj+nXy62mDymJFzQqN6nysMOD9xeCMxdhrZ3JR6Qutr4jSQ4vEbekMcAqZaV1h25HpgLx6qtepKLBCB5U1cqn0Q8k=
Date: Sat, 12 Aug 2006 01:59:50 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] CONFIG_PM=n slim: drivers/char/agp/efficeon-agp.c
Message-ID: <20060811215950.GA6847@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/agp/efficeon-agp.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/drivers/char/agp/efficeon-agp.c
+++ b/drivers/char/agp/efficeon-agp.c
@@ -337,13 +337,6 @@ static struct agp_bridge_driver efficeon
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-
-static int agp_efficeon_resume(struct pci_dev *pdev)
-{
-	printk(KERN_DEBUG PFX "agp_efficeon_resume()\n");
-	return efficeon_configure();
-}
-
 static int __devinit agp_efficeon_probe(struct pci_dev *pdev,
 				     const struct pci_device_id *ent)
 {
@@ -414,11 +407,18 @@ static void __devexit agp_efficeon_remov
 	agp_put_bridge(bridge);
 }
 
+#ifdef CONFIG_PM
 static int agp_efficeon_suspend(struct pci_dev *dev, pm_message_t state)
 {
 	return 0;
 }
 
+static int agp_efficeon_resume(struct pci_dev *pdev)
+{
+	printk(KERN_DEBUG PFX "agp_efficeon_resume()\n");
+	return efficeon_configure();
+}
+#endif
 
 static struct pci_device_id agp_efficeon_pci_table[] = {
 	{
@@ -439,8 +439,10 @@ static struct pci_driver agp_efficeon_pc
 	.id_table	= agp_efficeon_pci_table,
 	.probe		= agp_efficeon_probe,
 	.remove		= agp_efficeon_remove,
+#ifdef CONFIG_PM
 	.suspend	= agp_efficeon_suspend,
 	.resume		= agp_efficeon_resume,
+#endif
 };
 
 static int __init agp_efficeon_init(void)

