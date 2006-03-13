Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWCMW2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWCMW2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWCMW2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:28:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:46607 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964809AbWCMW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:28:42 -0500
Date: Mon, 13 Mar 2006 23:28:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: jkmaline@cc.hut.fi
Cc: hostap@shmoo.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] hostap_{pci,plx}.c: fix memory leaks
Message-ID: <20060313222841.GQ13973@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two memotry leaks spotted by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/wireless/hostap/hostap_pci.c |    6 +++---
 drivers/net/wireless/hostap/hostap_plx.c |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_pci.c.old	2006-03-13 22:34:30.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_pci.c	2006-03-13 22:37:57.000000000 +0100
@@ -301,14 +301,14 @@ static int prism2_pci_probe(struct pci_d
 	struct hostap_interface *iface;
 	struct hostap_pci_priv *hw_priv;
 
+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (hw_priv == NULL)
 		return -ENOMEM;
 	memset(hw_priv, 0, sizeof(*hw_priv));
 
-	if (pci_enable_device(pdev))
-		return -EIO;
-
 	phymem = pci_resource_start(pdev, 0);
 
 	if (!request_mem_region(phymem, pci_resource_len(pdev, 0), "Prism2")) {
--- linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_plx.c.old	2006-03-13 22:39:40.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/net/wireless/hostap/hostap_plx.c	2006-03-13 22:40:09.000000000 +0100
@@ -446,14 +446,14 @@ static int prism2_plx_probe(struct pci_d
 	int tmd7160;
 	struct hostap_plx_priv *hw_priv;
 
+	if (pci_enable_device(pdev))
+		return -EIO;
+
 	hw_priv = kmalloc(sizeof(*hw_priv), GFP_KERNEL);
 	if (hw_priv == NULL)
 		return -ENOMEM;
 	memset(hw_priv, 0, sizeof(*hw_priv));
 
-	if (pci_enable_device(pdev))
-		return -EIO;
-
 	/* National Datacomm NCP130 based on TMD7160, not PLX9052. */
 	tmd7160 = (pdev->vendor == 0x15e8) && (pdev->device == 0x0131);
 

