Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTJOSv7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264050AbTJOSvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:51:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:62641 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263926AbTJOS03 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:29 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10662422891492@kroah.com>
Subject: [PATCH] PCI fixes for 2.6.0-test7
In-Reply-To: <20031015182321.GA22284@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:24:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.1, 2003/10/13 11:05:52-07:00, greg@kroah.com

PCI: fix up probe functions for agp drivers

Can not be marked __init, must be marked __devinit or not at all.
If it is marked __init, then oops can happen by a user writing to the
"new_id" file from sysfs.


 drivers/char/agp/ali-agp.c      |    4 ++--
 drivers/char/agp/amd-k7-agp.c   |    6 +++---
 drivers/char/agp/amd64-agp.c    |   10 +++++-----
 drivers/char/agp/ati-agp.c      |    6 +++---
 drivers/char/agp/i460-agp.c     |    4 ++--
 drivers/char/agp/intel-agp.c    |    4 ++--
 drivers/char/agp/nvidia-agp.c   |    4 ++--
 drivers/char/agp/sis-agp.c      |    6 +++---
 drivers/char/agp/sworks-agp.c   |    4 ++--
 drivers/char/agp/uninorth-agp.c |    6 +++---
 drivers/char/agp/via-agp.c      |    6 +++---
 11 files changed, 30 insertions(+), 30 deletions(-)


diff -Nru a/drivers/char/agp/ali-agp.c b/drivers/char/agp/ali-agp.c
--- a/drivers/char/agp/ali-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/ali-agp.c	Wed Oct 15 11:18:51 2003
@@ -231,7 +231,7 @@
 };
 
 
-static struct agp_device_ids ali_agp_device_ids[] __initdata =
+static struct agp_device_ids ali_agp_device_ids[] __devinitdata =
 {
 	{
 		.device_id	= PCI_DEVICE_ID_AL_M1541,
@@ -272,7 +272,7 @@
 	{ }, /* dummy final entry, always present */
 };
 
-static int __init agp_ali_probe(struct pci_dev *pdev,
+static int __devinit agp_ali_probe(struct pci_dev *pdev,
 				const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = ali_agp_device_ids;
diff -Nru a/drivers/char/agp/amd-k7-agp.c b/drivers/char/agp/amd-k7-agp.c
--- a/drivers/char/agp/amd-k7-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/amd-k7-agp.c	Wed Oct 15 11:18:51 2003
@@ -365,7 +365,7 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-static struct agp_device_ids amd_agp_device_ids[] __initdata =
+static struct agp_device_ids amd_agp_device_ids[] __devinitdata =
 {
 	{
 		.device_id	= PCI_DEVICE_ID_AMD_FE_GATE_7006,
@@ -382,8 +382,8 @@
 	{ }, /* dummy final entry, always present */
 };
 
-static int __init agp_amdk7_probe(struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int __devinit agp_amdk7_probe(struct pci_dev *pdev,
+				     const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = amd_agp_device_ids;
 	struct agp_bridge_data *bridge;
diff -Nru a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
--- a/drivers/char/agp/amd64-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/amd64-agp.c	Wed Oct 15 11:18:51 2003
@@ -248,7 +248,7 @@
 };
 
 /* Some basic sanity checks for the aperture. */
-static int __init aperture_valid(u64 aper, u32 size)
+static int __devinit aperture_valid(u64 aper, u32 size)
 { 
 	static int not_first_call; 
 	u32 pfn, c;
@@ -297,7 +297,7 @@
  * to allocate that much memory. But at least error out cleanly instead of
  * crashing.
  */ 
-static __init int fix_northbridge(struct pci_dev *nb, struct pci_dev *agp, 
+static __devinit int fix_northbridge(struct pci_dev *nb, struct pci_dev *agp, 
 								 u16 cap)
 {
 	u32 aper_low, aper_hi;
@@ -339,7 +339,7 @@
 	return 0;
 } 
 
-static __init int cache_nbs (struct pci_dev *pdev, u32 cap_ptr)
+static __devinit int cache_nbs (struct pci_dev *pdev, u32 cap_ptr)
 {
 	struct pci_dev *loop_dev = NULL;
 	int i = 0;
@@ -365,8 +365,8 @@
 	return i == 0 ? -1 : 0;
 }
 
-static int __init agp_amd64_probe(struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int __devinit agp_amd64_probe(struct pci_dev *pdev,
+				     const struct pci_device_id *ent)
 {
 	struct agp_bridge_data *bridge;
 	u8 rev_id;
diff -Nru a/drivers/char/agp/ati-agp.c b/drivers/char/agp/ati-agp.c
--- a/drivers/char/agp/ati-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/ati-agp.c	Wed Oct 15 11:18:51 2003
@@ -403,7 +403,7 @@
 };
 
 
-static struct agp_device_ids ati_agp_device_ids[] __initdata =
+static struct agp_device_ids ati_agp_device_ids[] __devinitdata =
 {
 	{
 		.device_id	= PCI_DEVICE_ID_ATI_RS100,
@@ -436,8 +436,8 @@
 	{ }, /* dummy final entry, always present */
 };
 
-static int __init agp_ati_probe(struct pci_dev *pdev,
-				const struct pci_device_id *ent)
+static int __devinit agp_ati_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = ati_agp_device_ids;
 	struct agp_bridge_data *bridge;
diff -Nru a/drivers/char/agp/i460-agp.c b/drivers/char/agp/i460-agp.c
--- a/drivers/char/agp/i460-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/i460-agp.c	Wed Oct 15 11:18:51 2003
@@ -560,8 +560,8 @@
 	.cant_use_aperture	= 1,
 };
 
-static int __init agp_intel_i460_probe(struct pci_dev *pdev,
-				       const struct pci_device_id *ent)
+static int __devinit agp_intel_i460_probe(struct pci_dev *pdev,
+					  const struct pci_device_id *ent)
 {
 	struct agp_bridge_data *bridge;
 	u8 cap_ptr;
diff -Nru a/drivers/char/agp/intel-agp.c b/drivers/char/agp/intel-agp.c
--- a/drivers/char/agp/intel-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/intel-agp.c	Wed Oct 15 11:18:51 2003
@@ -1232,8 +1232,8 @@
 	return 1;
 }
 
-static int __init agp_intel_probe(struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int __devinit agp_intel_probe(struct pci_dev *pdev,
+				     const struct pci_device_id *ent)
 {
 	struct agp_bridge_data *bridge;
 	char *name = "(unknown)";
diff -Nru a/drivers/char/agp/nvidia-agp.c b/drivers/char/agp/nvidia-agp.c
--- a/drivers/char/agp/nvidia-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/nvidia-agp.c	Wed Oct 15 11:18:51 2003
@@ -250,8 +250,8 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-static int __init agp_nvidia_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *ent)
+static int __devinit agp_nvidia_probe(struct pci_dev *pdev,
+				      const struct pci_device_id *ent)
 {
 	struct agp_bridge_data *bridge;
 	u8 cap_ptr;
diff -Nru a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
--- a/drivers/char/agp/sis-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/sis-agp.c	Wed Oct 15 11:18:51 2003
@@ -95,7 +95,7 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-static struct agp_device_ids sis_agp_device_ids[] __initdata =
+static struct agp_device_ids sis_agp_device_ids[] __devinitdata =
 {
 	{
 		.device_id	= PCI_DEVICE_ID_SI_530,
@@ -164,8 +164,8 @@
 	{ }, /* dummy final entry, always present */
 };
 
-static int __init agp_sis_probe(struct pci_dev *pdev,
-				const struct pci_device_id *ent)
+static int __devinit agp_sis_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = sis_agp_device_ids;
 	struct agp_bridge_data *bridge;
diff -Nru a/drivers/char/agp/sworks-agp.c b/drivers/char/agp/sworks-agp.c
--- a/drivers/char/agp/sworks-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/sworks-agp.c	Wed Oct 15 11:18:51 2003
@@ -437,8 +437,8 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-static int __init agp_serverworks_probe(struct pci_dev *pdev,
-					const struct pci_device_id *ent)
+static int __devinit agp_serverworks_probe(struct pci_dev *pdev,
+					   const struct pci_device_id *ent)
 {
 	struct agp_bridge_data *bridge;
 	struct pci_dev *bridge_dev;
diff -Nru a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
--- a/drivers/char/agp/uninorth-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/uninorth-agp.c	Wed Oct 15 11:18:51 2003
@@ -282,7 +282,7 @@
 	.cant_use_aperture	= 1,
 };
 
-static struct agp_device_ids uninorth_agp_device_ids[] __initdata = {
+static struct agp_device_ids uninorth_agp_device_ids[] __devinitdata = {
 	{
 		.device_id	= PCI_DEVICE_ID_APPLE_UNI_N_AGP,
 		.chipset_name	= "UniNorth",
@@ -301,8 +301,8 @@
 	},
 };
 
-static int __init agp_uninorth_probe(struct pci_dev *pdev,
-				     const struct pci_device_id *ent)
+static int __devinit agp_uninorth_probe(struct pci_dev *pdev,
+					const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = uninorth_agp_device_ids;
 	struct agp_bridge_data *bridge;
diff -Nru a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
--- a/drivers/char/agp/via-agp.c	Wed Oct 15 11:18:51 2003
+++ b/drivers/char/agp/via-agp.c	Wed Oct 15 11:18:51 2003
@@ -211,7 +211,7 @@
 	.agp_destroy_page	= agp_generic_destroy_page,
 };
 
-static struct agp_device_ids via_agp_device_ids[] __initdata =
+static struct agp_device_ids via_agp_device_ids[] __devinitdata =
 {
 	{
 		.device_id	= PCI_DEVICE_ID_VIA_82C597_0,
@@ -371,8 +371,8 @@
 }
 
 
-static int __init agp_via_probe(struct pci_dev *pdev,
-				const struct pci_device_id *ent)
+static int __devinit agp_via_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
 	struct agp_device_ids *devs = via_agp_device_ids;
 	struct agp_bridge_data *bridge;

