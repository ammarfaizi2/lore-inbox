Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVA3SOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVA3SOO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVA3SM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:12:56 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60433 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261755AbVA3SKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:10:48 -0500
Date: Sun, 30 Jan 2005 19:10:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] AGP: make some code static
Message-ID: <20050130181046.GS3185@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Yes, I've read the comment in intel-mch-agp.c my patch removes - but 
agp_intelmch_init isn't called from anywhere outside of this file.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/agp/ali-agp.c       |    4 ++--
 drivers/char/agp/amd-k7-agp.c    |    2 +-
 drivers/char/agp/amd64-agp.c     |    2 +-
 drivers/char/agp/ati-agp.c       |    2 +-
 drivers/char/agp/backend.c       |    6 +++---
 drivers/char/agp/efficeon-agp.c  |    2 +-
 drivers/char/agp/frontend.c      |    6 +++---
 drivers/char/agp/intel-mch-agp.c |    4 +---
 drivers/char/agp/nvidia-agp.c    |    2 +-
 drivers/char/agp/sis-agp.c       |    2 +-
 drivers/char/agp/sworks-agp.c    |    2 +-
 drivers/char/agp/via-agp.c       |    4 ++--
 include/linux/agp_backend.h      |    2 --
 13 files changed, 18 insertions(+), 22 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/ali-agp.c.old	2005-01-30 18:46:21.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/ali-agp.c	2005-01-30 18:46:45.000000000 +0100
@@ -192,7 +192,7 @@
 	{4, 1024, 0, 3}
 };
 
-struct agp_bridge_driver ali_generic_bridge = {
+static struct agp_bridge_driver ali_generic_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ali_generic_sizes,
 	.size_type		= U32_APER_SIZE,
@@ -215,7 +215,7 @@
 	.agp_destroy_page	= ali_destroy_page,
 };
 
-struct agp_bridge_driver ali_m1541_bridge = {
+static struct agp_bridge_driver ali_m1541_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ali_generic_sizes,
 	.size_type		= U32_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/amd-k7-agp.c.old	2005-01-30 18:46:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/amd-k7-agp.c	2005-01-30 18:47:08.000000000 +0100
@@ -358,7 +358,7 @@
 	{.mask = 1, .type = 0}
 };
 
-struct agp_bridge_driver amd_irongate_driver = {
+static struct agp_bridge_driver amd_irongate_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= amd_irongate_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/amd64-agp.c.old	2005-01-30 18:47:31.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/amd64-agp.c	2005-01-30 18:47:39.000000000 +0100
@@ -243,7 +243,7 @@
 }
 
 
-struct agp_bridge_driver amd_8151_driver = {
+static struct agp_bridge_driver amd_8151_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= amd_8151_sizes,
 	.size_type		= U32_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/ati-agp.c.old	2005-01-30 18:48:22.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/ati-agp.c	2005-01-30 18:48:30.000000000 +0100
@@ -393,7 +393,7 @@
 	return 0;
 }
 
-struct agp_bridge_driver ati_generic_bridge = {
+static struct agp_bridge_driver ati_generic_bridge = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= ati_generic_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/include/linux/agp_backend.h.old	2005-01-30 18:49:55.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/agp_backend.h	2005-01-30 18:50:02.000000000 +0100
@@ -94,8 +94,6 @@
 extern struct agp_bridge_data *agp_bridge;
 extern struct list_head agp_bridges;
 
-extern struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *);
-
 extern void agp_free_memory(struct agp_memory *);
 extern struct agp_memory *agp_allocate_memory(struct agp_bridge_data *, size_t, u32);
 extern int agp_copy_info(struct agp_bridge_data *, struct agp_kern_info *);
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/backend.c.old	2005-01-30 18:48:45.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/backend.c	2005-01-30 18:50:19.000000000 +0100
@@ -50,7 +50,7 @@
 	.minor = AGPGART_VERSION_MINOR,
 };
 
-struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
+static struct agp_bridge_data *(*agp_find_bridge)(struct pci_dev *) =
 	&agp_generic_find_bridge;
 
 struct agp_bridge_data *agp_bridge;
@@ -96,7 +96,7 @@
 EXPORT_SYMBOL(agp_backend_release);
 
 
-struct { int mem, agp; } maxes_table[] = {
+static struct { int mem, agp; } maxes_table[] = {
 	{0, 0},
 	{32, 4},
 	{64, 28},
@@ -323,7 +323,7 @@
 	return 0;
 }
 
-void __exit agp_exit(void)
+static void __exit agp_exit(void)
 {
 }
 
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/efficeon-agp.c.old	2005-01-30 18:50:32.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/efficeon-agp.c	2005-01-30 18:50:42.000000000 +0100
@@ -303,7 +303,7 @@
 }
 
 
-struct agp_bridge_driver efficeon_driver = {
+static struct agp_bridge_driver efficeon_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= efficeon_generic_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/frontend.c.old	2005-01-30 18:50:57.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/frontend.c	2005-01-30 18:51:27.000000000 +0100
@@ -235,7 +235,7 @@
 
 /* File private list routines */
 
-struct agp_file_private *agp_find_private(pid_t pid)
+static struct agp_file_private *agp_find_private(pid_t pid)
 {
 	struct agp_file_private *curr;
 
@@ -250,7 +250,7 @@
 	return NULL;
 }
 
-void agp_insert_file_private(struct agp_file_private * priv)
+static void agp_insert_file_private(struct agp_file_private * priv)
 {
 	struct agp_file_private *prev;
 
@@ -262,7 +262,7 @@
 	agp_fe.file_priv_list = priv;
 }
 
-void agp_remove_file_private(struct agp_file_private * priv)
+static void agp_remove_file_private(struct agp_file_private * priv)
 {
 	struct agp_file_private *next;
 	struct agp_file_private *prev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/intel-mch-agp.c.old	2005-01-30 18:51:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/intel-mch-agp.c	2005-01-30 18:52:02.000000000 +0100
@@ -619,9 +619,7 @@
 	.resume		= agp_intelmch_resume,
 };
 
-/* intel_agp_init() must not be declared static for explicit
-   early initialization to work (ie i810fb) */
-int __init agp_intelmch_init(void)
+static int __init agp_intelmch_init(void)
 {
 	static int agp_initialised=0;
 	if (agp_off)
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/nvidia-agp.c.old	2005-01-30 18:52:18.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/nvidia-agp.c	2005-01-30 18:52:26.000000000 +0100
@@ -288,7 +288,7 @@
 };
 
 
-struct agp_bridge_driver nvidia_driver = {
+static struct agp_bridge_driver nvidia_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= nvidia_generic_sizes,
 	.size_type		= U8_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/sis-agp.c.old	2005-01-30 18:52:39.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/sis-agp.c	2005-01-30 18:52:47.000000000 +0100
@@ -119,7 +119,7 @@
 	{4, 1024, 0, 3}
 };
 
-struct agp_bridge_driver sis_driver = {
+static struct agp_bridge_driver sis_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes 	= sis_generic_sizes,
 	.size_type		= U8_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/sworks-agp.c.old	2005-01-30 18:52:59.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/sworks-agp.c	2005-01-30 18:53:08.000000000 +0100
@@ -409,7 +409,7 @@
 	agp_device_command(command, 0);
 }
 
-struct agp_bridge_driver sworks_driver = {
+static struct agp_bridge_driver sworks_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= serverworks_sizes,
 	.size_type		= LVL2_APER_SIZE,
--- linux-2.6.11-rc2-mm2-full/drivers/char/agp/via-agp.c.old	2005-01-30 18:53:41.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/agp/via-agp.c	2005-01-30 18:54:19.000000000 +0100
@@ -162,7 +162,7 @@
 }
 
 
-struct agp_bridge_driver via_agp3_driver = {
+static struct agp_bridge_driver via_agp3_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= agp3_generic_sizes,
 	.size_type		= U8_APER_SIZE,
@@ -185,7 +185,7 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-struct agp_bridge_driver via_driver = {
+static struct agp_bridge_driver via_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= via_generic_sizes,
 	.size_type		= U8_APER_SIZE,

