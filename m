Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934457AbWKXMGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934457AbWKXMGz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 07:06:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934469AbWKXMGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 07:06:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:61733 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934457AbWKXMGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 07:06:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=VPFjxOxjUJbxsdlqOpaaSnhs3LWeAY55tlTB1+5AoXHvePUCZx9bwChD8ao/ZA3dolJ3KXeZim+zSod9n34H6y4BS9jbqH4+eQt31gYqfgfxSp063fe+NcBt58VQ/JmfgSQVOHKlr1U1uloERVSNeQchbPj+gfjIsQpvKTEW2I0=
Message-ID: <4566DF79.6030004@gmail.com>
Date: Fri, 24 Nov 2006 14:03:05 +0200
From: Yan Burman <burman.yan@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, trivial@kernel.org, davem@davemloft.net
Subject: [PATCH 2.6.19-rc6] sparc64: replace kmalloc+memset with kzalloc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc+memset with kzalloc 

Signed-off-by: Yan Burman <burman.yan@gmail.com>

diff -rubp linux-2.6.19-rc5_orig/arch/sparc64/kernel/chmc.c linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/chmc.c
--- linux-2.6.19-rc5_orig/arch/sparc64/kernel/chmc.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/chmc.c	2006-11-11 22:44:04.000000000 +0200
@@ -341,7 +341,7 @@ static void fetch_decode_regs(struct mct
 
 static int init_one_mctrl(struct device_node *dp)
 {
-	struct mctrl_info *mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	struct mctrl_info *mp = kzalloc(sizeof(*mp), GFP_KERNEL);
 	int portid = of_getintprop_default(dp, "portid", -1);
 	struct linux_prom64_registers *regs;
 	void *pval;
@@ -349,7 +349,6 @@ static int init_one_mctrl(struct device_
 
 	if (!mp)
 		return -1;
-	memset(mp, 0, sizeof(*mp));
 	if (portid == -1)
 		goto fail;
 
diff -rubp linux-2.6.19-rc5_orig/arch/sparc64/kernel/isa.c linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/isa.c
--- linux-2.6.19-rc5_orig/arch/sparc64/kernel/isa.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/isa.c	2006-11-11 22:44:04.000000000 +0200
@@ -72,14 +72,12 @@ static void __init isa_fill_children(str
 		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
-		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
+		isa_dev = kzalloc(sizeof(*isa_dev), GFP_KERNEL);
 		if (!isa_dev) {
 			fatal_err("cannot allocate child isa_dev");
 			prom_halt();
 		}
 
-		memset(isa_dev, 0, sizeof(*isa_dev));
-
 		/* Link it in to parent. */
 		isa_dev->next = parent_isa_dev->child;
 		parent_isa_dev->child = isa_dev;
@@ -104,14 +102,12 @@ static void __init isa_fill_devices(stru
 		struct linux_prom_registers *regs;
 		struct sparc_isa_device *isa_dev;
 
-		isa_dev = kmalloc(sizeof(*isa_dev), GFP_KERNEL);
+		isa_dev = kzalloc(sizeof(*isa_dev), GFP_KERNEL);
 		if (!isa_dev) {
 			printk(KERN_DEBUG "ISA: cannot allocate isa_dev");
 			return;
 		}
 
-		memset(isa_dev, 0, sizeof(*isa_dev));
-
 		isa_dev->ofdev.node = dp;
 		isa_dev->ofdev.dev.parent = &isa_br->ofdev.dev;
 		isa_dev->ofdev.dev.bus = &isa_bus_type;
@@ -180,14 +176,12 @@ void __init isa_init(void)
 		pbm = pdev_cookie->pbm;
 		dp = pdev_cookie->prom_node;
 
-		isa_br = kmalloc(sizeof(*isa_br), GFP_KERNEL);
+		isa_br = kzalloc(sizeof(*isa_br), GFP_KERNEL);
 		if (!isa_br) {
 			printk(KERN_DEBUG "isa: cannot allocate sparc_isa_bridge");
 			return;
 		}
 
-		memset(isa_br, 0, sizeof(*isa_br));
-
 		isa_br->ofdev.node = dp;
 		isa_br->ofdev.dev.parent = &pdev->dev;
 		isa_br->ofdev.dev.bus = &isa_bus_type;
diff -rubp linux-2.6.19-rc5_orig/arch/sparc64/kernel/of_device.c linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/of_device.c
--- linux-2.6.19-rc5_orig/arch/sparc64/kernel/of_device.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/of_device.c	2006-11-11 22:44:04.000000000 +0200
@@ -1007,10 +1007,9 @@ struct of_device* of_platform_device_cre
 {
 	struct of_device *dev;
 
-	dev = kmalloc(sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(*dev));
 
 	dev->dev.parent = parent;
 	dev->dev.bus = bus;
diff -rubp linux-2.6.19-rc5_orig/arch/sparc64/kernel/pci_sun4v.c linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/pci_sun4v.c
--- linux-2.6.19-rc5_orig/arch/sparc64/kernel/pci_sun4v.c	2006-11-09 12:16:22.000000000 +0200
+++ linux-2.6.19-rc5_kzalloc/arch/sparc64/kernel/pci_sun4v.c	2006-11-11 22:44:04.000000000 +0200
@@ -798,7 +798,7 @@ static struct pci_ops pci_sun4v_ops = {
 static void pbm_scan_bus(struct pci_controller_info *p,
 			 struct pci_pbm_info *pbm)
 {
-	struct pcidev_cookie *cookie = kmalloc(sizeof(*cookie), GFP_KERNEL);
+	struct pcidev_cookie *cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
 
 	if (!cookie) {
 		prom_printf("%s: Critical allocation failure.\n", pbm->name);
@@ -806,7 +806,6 @@ static void pbm_scan_bus(struct pci_cont
 	}
 
 	/* All we care about is the PBM. */
-	memset(cookie, 0, sizeof(*cookie));
 	cookie->pbm = pbm;
 
 	pbm->pci_bus = pci_scan_bus(pbm->pci_first_busno, p->pci_ops, pbm);
@@ -1048,12 +1047,11 @@ static void pci_sun4v_iommu_init(struct 
 	/* Allocate and initialize the free area map.  */
 	sz = num_tsb_entries / 8;
 	sz = (sz + 7UL) & ~7UL;
-	iommu->arena.map = kmalloc(sz, GFP_KERNEL);
+	iommu->arena.map = kzalloc(sz, GFP_KERNEL);
 	if (!iommu->arena.map) {
 		prom_printf("PCI_IOMMU: Error, kmalloc(arena.map) failed.\n");
 		prom_halt();
 	}
-	memset(iommu->arena.map, 0, sz);
 	iommu->arena.limit = num_tsb_entries;
 
 	sz = probe_existing_entries(pbm, iommu);
@@ -1164,24 +1162,20 @@ void sun4v_pci_init(struct device_node *
 		per_cpu(pci_iommu_batch, i).pglist = (u64 *) page;
 	}
 
-	p = kmalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
+	p = kzalloc(sizeof(struct pci_controller_info), GFP_ATOMIC);
 	if (!p)
 		goto fatal_memory_error;
 
-	memset(p, 0, sizeof(*p));
-
-	iommu = kmalloc(sizeof(struct pci_iommu), GFP_ATOMIC);
+	iommu = kzalloc(sizeof(struct pci_iommu), GFP_ATOMIC);
 	if (!iommu)
 		goto fatal_memory_error;
 
-	memset(iommu, 0, sizeof(*iommu));
 	p->pbm_A.iommu = iommu;
 
-	iommu = kmalloc(sizeof(struct pci_iommu), GFP_ATOMIC);
+	iommu = kzalloc(sizeof(struct pci_iommu), GFP_ATOMIC);
 	if (!iommu)
 		goto fatal_memory_error;
 
-	memset(iommu, 0, sizeof(*iommu));
 	p->pbm_B.iommu = iommu;
 
 	p->next = pci_controller_root;



Regards
Yan Burman
