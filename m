Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263510AbVCEAnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbVCEAnt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 19:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbVCEAih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 19:38:37 -0500
Received: from palrel11.hp.com ([156.153.255.246]:58852 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263399AbVCEA1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 19:27:37 -0500
Date: Fri, 4 Mar 2005 16:27:20 -0800
To: "David S. Miller" <davem@davemloft.net>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] Mark exit code properly in VIA driver
Message-ID: <20050305002720.GE23895@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_via_devexit.diff :
~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Randy Dunlap>
	o [CORRECT] Mark exit code properly in VIA driver
Signed-off-by: Randy Dunlap <rddunlap@osdl.org>
Signed-off-by: Jean Tourrilhes <jt@hpl.hp.com>



diff -Naurp ./drivers/net/irda/via-ircc.c~irda_via_devexit ./drivers/net/irda/via-ircc.c
--- ./drivers/net/irda/via-ircc.c~irda_via_devexit	2004-12-24 13:33:47.000000000 -0800
+++ ./drivers/net/irda/via-ircc.c	2005-01-06 21:18:49.742203456 -0800
@@ -83,7 +83,7 @@ static struct via_ircc_cb *dev_self[] = 
 
 /* Some prototypes */
 static int via_ircc_open(int i, chipio_t * info, unsigned int id);
-static int __exit via_ircc_close(struct via_ircc_cb *self);
+static int via_ircc_close(struct via_ircc_cb *self);
 static int via_ircc_dma_receive(struct via_ircc_cb *self);
 static int via_ircc_dma_receive_complete(struct via_ircc_cb *self,
 					 int iobase);
@@ -111,7 +111,7 @@ static void hwreset(struct via_ircc_cb *
 static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase);
 static int upload_rxdata(struct via_ircc_cb *self, int iobase);
 static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
-static void __exit via_remove_one (struct pci_dev *pdev);
+static void __devexit via_remove_one (struct pci_dev *pdev);
 
 /* FIXME : Should use udelay() instead, even if we are x86 only - Jean II */
 static void iodelay(int udelay)
@@ -140,7 +140,7 @@ static struct pci_driver via_driver = {
 	.name		= VIA_MODULE_NAME,
 	.id_table	= via_pci_tbl,
 	.probe		= via_init_one,
-	.remove		= via_remove_one,
+	.remove		= __devexit_p(via_remove_one),
 };
 
 
@@ -273,7 +273,7 @@ static int __devinit via_init_one (struc
  *    Close all configured chips
  *
  */
-static void __exit via_ircc_clean(void)
+static void via_ircc_clean(void)
 {
 	int i;
 
@@ -285,7 +285,7 @@ static void __exit via_ircc_clean(void)
 	}
 }
 
-static void __exit via_remove_one (struct pci_dev *pdev)
+static void __devexit via_remove_one (struct pci_dev *pdev)
 {
 	IRDA_DEBUG(3, "%s()\n", __FUNCTION__);
 
@@ -468,7 +468,7 @@ static __devinit int via_ircc_open(int i
  *    Close driver instance
  *
  */
-static int __exit via_ircc_close(struct via_ircc_cb *self)
+static int via_ircc_close(struct via_ircc_cb *self)
 {
 	int iobase;
 
