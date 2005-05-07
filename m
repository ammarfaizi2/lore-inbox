Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVEGBlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVEGBlV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 21:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVEGBlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 21:41:21 -0400
Received: from mail.dif.dk ([193.138.115.101]:28373 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261467AbVEGBlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 21:41:02 -0400
Date: Sat, 7 May 2005 03:44:43 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: mpt_linux_developer@lsil.com, Markus.Lidel@shadowconnect.com,
       alan@redhat.com, akpm@osdl.org
Subject: [PATCH] kfree cleanup - get rid of redundant NULL checks -
 drivers/message/*
Message-ID: <Pine.LNX.4.62.0505070310290.2384@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets rid of redundant NULL checks prior to calling kfree() in 
drivers/message/*
There are also a few small whitespace changes in there.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/message/fusion/mptbase.c  |   25 ++++++++-----------------
 drivers/message/fusion/mptctl.c   |   22 +++++++++++-----------
 drivers/message/fusion/mptlan.c   |    4 ++--
 drivers/message/fusion/mptscsih.c |   15 ++++++---------
 drivers/message/i2o/device.c      |    3 +--
 drivers/message/i2o/pci.c         |    3 +--
 6 files changed, 29 insertions(+), 43 deletions(-)

diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptbase.c linux-2.6.12-rc3-mm3/drivers/message/fusion/mptbase.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptbase.c	2005-05-06 23:21:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/message/fusion/mptbase.c	2005-05-07 03:36:22.000000000 +0200
@@ -1804,15 +1804,10 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 		ioc->alloc_total -= sz;
 	}
 
-	if (ioc->spi_data.nvram != NULL) {
-		kfree(ioc->spi_data.nvram);
-		ioc->spi_data.nvram = NULL;
-	}
-
-	if (ioc->spi_data.pIocPg3 != NULL) {
-		kfree(ioc->spi_data.pIocPg3);
-		ioc->spi_data.pIocPg3 = NULL;
-	}
+	kfree(ioc->spi_data.nvram);
+	kfree(ioc->spi_data.pIocPg3);
+	ioc->spi_data.nvram = NULL;
+	ioc->spi_data.pIocPg3 = NULL;
 
 	if (ioc->spi_data.pIocPg4 != NULL) {
 		sz = ioc->spi_data.IocPg4Sz;
@@ -1829,10 +1824,8 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 		ioc->ReqToChain = NULL;
 	}
 
-	if (ioc->ChainToChain != NULL) {
-		kfree(ioc->ChainToChain);
-		ioc->ChainToChain = NULL;
-	}
+	kfree(ioc->ChainToChain);
+	ioc->ChainToChain = NULL;
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
@@ -4364,10 +4357,8 @@ mpt_read_ioc_pg_3(MPT_ADAPTER *ioc)
 
 	/* Free the old page
 	 */
-	if (ioc->spi_data.pIocPg3) {
-		kfree(ioc->spi_data.pIocPg3);
-		ioc->spi_data.pIocPg3 = NULL;
-	}
+	kfree(ioc->spi_data.pIocPg3);
+	ioc->spi_data.pIocPg3 = NULL;
 
 	/* There is at least one physical disk.
 	 * Read and save IOC Page 3
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptctl.c linux-2.6.12-rc3-mm3/drivers/message/fusion/mptctl.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptctl.c	2005-05-06 23:21:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/message/fusion/mptctl.c	2005-05-07 03:05:54.000000000 +0200
@@ -99,14 +99,14 @@ struct buflist {
  * arg contents specific to function.
  */
 static int mptctl_fw_download(unsigned long arg);
-static int mptctl_getiocinfo (unsigned long arg, unsigned int cmd);
-static int mptctl_gettargetinfo (unsigned long arg);
-static int mptctl_readtest (unsigned long arg);
-static int mptctl_mpt_command (unsigned long arg);
-static int mptctl_eventquery (unsigned long arg);
-static int mptctl_eventenable (unsigned long arg);
-static int mptctl_eventreport (unsigned long arg);
-static int mptctl_replace_fw (unsigned long arg);
+static int mptctl_getiocinfo(unsigned long arg, unsigned int cmd);
+static int mptctl_gettargetinfo(unsigned long arg);
+static int mptctl_readtest(unsigned long arg);
+static int mptctl_mpt_command(unsigned long arg);
+static int mptctl_eventquery(unsigned long arg);
+static int mptctl_eventenable(unsigned long arg);
+static int mptctl_eventreport(unsigned long arg);
+static int mptctl_replace_fw(unsigned long arg);
 
 static int mptctl_do_reset(unsigned long arg);
 static int mptctl_hp_hostinfo(unsigned long arg, unsigned int cmd);
@@ -121,11 +121,11 @@ static long compat_mpctl_ioctl(struct fi
 /*
  * Private function calls.
  */
-static int mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr);
+static int mptctl_do_mpt_command(struct mpt_ioctl_command karg, void __user *mfPtr);
 static int mptctl_do_fw_download(int ioc, char __user *ufwbuf, size_t fwlen);
-static MptSge_t *kbuf_alloc_2_sgl( int bytes, u32 dir, int sge_offset, int *frags,
+static MptSge_t *kbuf_alloc_2_sgl(int bytes, u32 dir, int sge_offset, int *frags,
 		struct buflist **blp, dma_addr_t *sglbuf_dma, MPT_ADAPTER *ioc);
-static void kfree_sgl( MptSge_t *sgl, dma_addr_t sgl_dma,
+static void kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma,
 		struct buflist *buflist, MPT_ADAPTER *ioc);
 static void mptctl_timeout_expired (MPT_IOCTL *ioctl);
 static int  mptctl_bus_reset(MPT_IOCTL *ioctl);
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptlan.c linux-2.6.12-rc3-mm3/drivers/message/fusion/mptlan.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptlan.c	2005-05-06 23:21:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/message/fusion/mptlan.c	2005-05-07 03:06:18.000000000 +0200
@@ -538,8 +538,8 @@ mpt_lan_close(struct net_device *dev)
 		}
 	}
 
-	kfree (priv->RcvCtl);
-	kfree (priv->mpt_rxfidx);
+	kfree(priv->RcvCtl);
+	kfree(priv->mpt_rxfidx);
 
 	for (i = 0; i < priv->tx_max_out; i++) {
 		if (priv->SendCtl[i].skb != NULL) {
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptscsih.c linux-2.6.12-rc3-mm3/drivers/message/fusion/mptscsih.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/fusion/mptscsih.c	2005-05-06 23:21:09.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/message/fusion/mptscsih.c	2005-05-07 03:06:52.000000000 +0200
@@ -998,20 +998,17 @@ mptscsih_remove(struct pci_dev *pdev)
 		hd->ScsiLookup = NULL;
 	}
 
-	if (hd->Targets != NULL) {
-		/*
-		 * Free pointer array.
-		 */
-		kfree(hd->Targets);
-		hd->Targets = NULL;
-	}
+	/*
+	 * Free pointer array.
+	 */
+	kfree(hd->Targets);
+	hd->Targets = NULL;
 
 	dprintk((MYIOC_s_INFO_FMT
 	    "Free'd ScsiLookup (%d) memory\n",
 	    hd->ioc->name, sz1));
 
-	if (hd->info_kbuf != NULL)
-		kfree(hd->info_kbuf);
+	kfree(hd->info_kbuf);
 
 	/* NULL the Scsi_Host pointer
 	 */
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/i2o/device.c linux-2.6.12-rc3-mm3/drivers/message/i2o/device.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/i2o/device.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.12-rc3-mm3/drivers/message/i2o/device.c	2005-05-07 03:07:07.000000000 +0200
@@ -282,8 +282,7 @@ int i2o_device_parse_lct(struct i2o_cont
 
 	down(&c->lct_lock);
 
-	if (c->lct)
-		kfree(c->lct);
+	kfree(c->lct);
 
 	lct = c->dlct.virt;
 
diff -upr linux-2.6.12-rc3-mm3-orig/drivers/message/i2o/pci.c linux-2.6.12-rc3-mm3/drivers/message/i2o/pci.c
--- linux-2.6.12-rc3-mm3-orig/drivers/message/i2o/pci.c	2005-04-30 18:25:02.000000000 +0200
+++ linux-2.6.12-rc3-mm3/drivers/message/i2o/pci.c	2005-05-07 03:08:56.000000000 +0200
@@ -91,8 +91,7 @@ static void i2o_pci_free(struct i2o_cont
 
 	i2o_dma_free(dev, &c->out_queue);
 	i2o_dma_free(dev, &c->status_block);
-	if (c->lct)
-		kfree(c->lct);
+	kfree(c->lct);
 	i2o_dma_free(dev, &c->dlct);
 	i2o_dma_free(dev, &c->hrt);
 	i2o_dma_free(dev, &c->status);



