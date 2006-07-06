Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWGFUhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWGFUhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 16:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWGFUhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 16:37:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17157 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750822AbWGFUhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 16:37:00 -0400
Date: Thu, 6 Jul 2006 22:36:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, norsk5@xmission.com
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
Subject: [-mm patch] drivers/edac/: make code static
Message-ID: <20060706203659.GP26941@stusta.de>
References: <20060703030355.420c7155.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703030355.420c7155.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/edac/edac_mc.c |   25 +++++++++++--------------
 drivers/edac/edac_mc.h |    8 --------
 drivers/edac/k8_edac.c |    2 +-
 3 files changed, 12 insertions(+), 23 deletions(-)

--- linux-2.6.17-mm6-full/drivers/edac/edac_mc.h.old	2006-07-06 19:31:37.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/edac/edac_mc.h	2006-07-06 19:32:43.000000000 +0200
@@ -406,19 +406,11 @@
 
 #endif /* CONFIG_PCI */
 
-#ifdef CONFIG_EDAC_DEBUG
-void edac_mc_dump_channel(struct channel_info *chan);
-void edac_mc_dump_mci(struct mem_ctl_info *mci);
-void edac_mc_dump_csrow(struct csrow_info *csrow);
-#endif  /* CONFIG_EDAC_DEBUG */
-
 extern struct mem_ctl_info * edac_mc_find(int idx);
 extern int edac_mc_add_mc(struct mem_ctl_info *mci,int mc_idx);
 extern struct mem_ctl_info * edac_mc_del_mc(struct device *dev);
 extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
 					unsigned long page);
-extern void edac_mc_scrub_block(unsigned long page, unsigned long offset,
-		u32 size);
 
 /*
  * The no info errors are used when error overflows are reported.
--- linux-2.6.17-mm6-full/drivers/edac/edac_mc.c.old	2006-07-06 18:43:39.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/edac/edac_mc.c	2006-07-06 19:33:01.000000000 +0200
@@ -177,7 +177,7 @@
 };
 
 #define MEMCTRL_ATTR(_name,_mode,_show,_store)			\
-struct memctrl_dev_attribute attr_##_name = {			\
+static struct memctrl_dev_attribute attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.value  = &_name,					\
 	.show   = _show,					\
@@ -185,7 +185,7 @@
 };
 
 #define MEMCTRL_STRING_ATTR(_name,_data,_mode,_show,_store)	\
-struct memctrl_dev_attribute attr_##_name = {			\
+static struct memctrl_dev_attribute attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.value  = _data,					\
 	.show   = _show,					\
@@ -333,7 +333,7 @@
 };
 
 #define EDAC_PCI_ATTR(_name,_mode,_show,_store)			\
-struct edac_pci_dev_attribute edac_pci_attr_##_name = {		\
+static struct edac_pci_dev_attribute edac_pci_attr_##_name = {		\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.value  = &_name,					\
 	.show   = _show,					\
@@ -341,7 +341,7 @@
 };
 
 #define EDAC_PCI_STRING_ATTR(_name,_data,_mode,_show,_store)	\
-struct edac_pci_dev_attribute edac_pci_attr_##_name = {		\
+static struct edac_pci_dev_attribute edac_pci_attr_##_name = {		\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.value  = _data,					\
 	.show   = _show,					\
@@ -712,7 +712,7 @@
 };
 
 #define CSROWDEV_ATTR(_name,_mode,_show,_store,_private)	\
-struct csrowdev_attribute attr_##_name = {			\
+static struct csrowdev_attribute attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show   = _show,					\
 	.store  = _store,					\
@@ -1005,7 +1005,7 @@
 };
 
 #define MCIDEV_ATTR(_name,_mode,_show,_store)			\
-struct mcidev_attribute mci_attr_##_name = {			\
+static struct mcidev_attribute mci_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show   = _show,					\
 	.store  = _store,					\
@@ -1155,7 +1155,7 @@
 
 #ifdef CONFIG_EDAC_DEBUG
 
-void edac_mc_dump_channel(struct channel_info *chan)
+static void edac_mc_dump_channel(struct channel_info *chan)
 {
 	debugf4("\tchannel = %p\n", chan);
 	debugf4("\tchannel->chan_idx = %d\n", chan->chan_idx);
@@ -1163,9 +1163,8 @@
 	debugf4("\tchannel->label = '%s'\n", chan->label);
 	debugf4("\tchannel->csrow = %p\n\n", chan->csrow);
 }
-EXPORT_SYMBOL_GPL(edac_mc_dump_channel);
 
-void edac_mc_dump_csrow(struct csrow_info *csrow)
+static void edac_mc_dump_csrow(struct csrow_info *csrow)
 {
 	debugf4("\tcsrow = %p\n", csrow);
 	debugf4("\tcsrow->csrow_idx = %d\n", csrow->csrow_idx);
@@ -1179,9 +1178,8 @@
 	debugf4("\tcsrow->channels = %p\n", csrow->channels);
 	debugf4("\tcsrow->mci = %p\n\n", csrow->mci);
 }
-EXPORT_SYMBOL_GPL(edac_mc_dump_csrow);
 
-void edac_mc_dump_mci(struct mem_ctl_info *mci)
+static void edac_mc_dump_mci(struct mem_ctl_info *mci)
 {
 	debugf3("\tmci = %p\n", mci);
 	debugf3("\tmci->mtype_cap = %lx\n", mci->mtype_cap);
@@ -1195,7 +1193,6 @@
 		mci->mod_name, mci->ctl_name);
 	debugf3("\tpvt_info = %p\n\n", mci->pvt_info);
 }
-EXPORT_SYMBOL_GPL(edac_mc_dump_mci);
 
 #endif  /* CONFIG_EDAC_DEBUG */
 
@@ -1511,7 +1508,8 @@
 }
 EXPORT_SYMBOL_GPL(edac_mc_del_mc);
 
-void edac_mc_scrub_block(unsigned long page, unsigned long offset, u32 size)
+static void edac_mc_scrub_block(unsigned long page, unsigned long offset,
+				u32 size)
 {
 	struct page *pg;
 	void *virt_addr;
@@ -1540,7 +1538,6 @@
 	if (PageHighMem(pg))
 		local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(edac_mc_scrub_block);
 
 /* FIXME - should return -1 */
 int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci, unsigned long page)
--- linux-2.6.17-mm6-full/drivers/edac/k8_edac.c.old	2006-07-06 19:33:15.000000000 +0200
+++ linux-2.6.17-mm6-full/drivers/edac/k8_edac.c	2006-07-06 19:33:39.000000000 +0200
@@ -1864,7 +1864,7 @@
 	.id_table = k8_pci_tbl,
 };
 
-int __init k8_init(void)
+static int __init k8_init(void)
 {
 	return pci_module_init(&k8_driver);
 }

