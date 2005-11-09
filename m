Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbVKIA6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbVKIA6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 19:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKIA6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 19:58:30 -0500
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:11993 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932403AbVKIA63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 19:58:29 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: Replace kcalloc(1, with kzalloc.
Message-Id: <20051109005748.5D58420A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 01:57:48 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Conversion from kcalloc(1, to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/input/mouse/trackpoint.c |    2 +-
 drivers/mtd/rfd_ftl.c            |    2 +-
 drivers/net/phy/phy_device.c     |    2 +-
 drivers/pcmcia/omap_cf.c         |    2 +-
 drivers/pnp/isapnp/core.c        |   22 +++++++++++-----------
 drivers/pnp/pnpacpi/core.c       |    6 +++---
 drivers/pnp/pnpacpi/rsparser.c   |   18 +++++++++---------
 drivers/pnp/pnpbios/core.c       |   12 ++++++------
 drivers/pnp/pnpbios/proc.c       |    8 ++++----
 drivers/pnp/pnpbios/rsparser.c   |   16 ++++++++--------
 drivers/scsi/pdc_adma.c          |    4 ++--
 drivers/usb/net/rndis_host.c     |    2 +-
 12 files changed, 48 insertions(+), 48 deletions(-)

applies-to: 9b6a639946d02350f36a93bd62aef32961f7f55e
952f35457f4d9ada594b3347e6807ca69999dc27
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index b4898d8..de63f92 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -281,7 +281,7 @@ int trackpoint_detect(struct psmouse *ps
 		button_info = 0;
 	}
 
-	psmouse->private = priv = kcalloc(1, sizeof(struct trackpoint_data), GFP_KERNEL);
+	psmouse->private = priv = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
 	if (!priv)
 		return -1;
 
diff --git a/drivers/mtd/rfd_ftl.c b/drivers/mtd/rfd_ftl.c
index 041ee59..f71a42c 100644
--- a/drivers/mtd/rfd_ftl.c
+++ b/drivers/mtd/rfd_ftl.c
@@ -766,7 +766,7 @@ static void rfd_ftl_add_mtd(struct mtd_b
 	if (mtd->type != MTD_NORFLASH)
 		return;
 
-	part = kcalloc(1, sizeof(struct partition), GFP_KERNEL);
+	part = kzalloc(sizeof(struct partition), GFP_KERNEL);
 	if (!part)
 		return;
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 16bebe7..33d31e0 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -77,7 +77,7 @@ struct phy_device * get_phy_device(struc
 
 	/* Otherwise, we allocate the device, and initialize the
 	 * default values */
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 
 	if (NULL == dev)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 47b5ade..f61daf1 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -221,7 +221,7 @@ static int __init omap_cf_probe(struct d
 	if (!irq)
 		return -EINVAL;
 
-	cf = kcalloc(1, sizeof *cf, GFP_KERNEL);
+	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
 		return -ENOMEM;
 	init_timer(&cf->timer);
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 57fd603..86741d3 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -395,7 +395,7 @@ static void isapnp_parse_id(struct pnp_d
 	struct pnp_id * id;
 	if (!dev)
 		return;
-	id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
@@ -419,7 +419,7 @@ static struct pnp_dev * __init isapnp_pa
 	struct pnp_dev *dev;
 
 	isapnp_peek(tmp, size);
-	dev = kcalloc(1, sizeof(struct pnp_dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev)
 		return NULL;
 	dev->number = number;
@@ -450,7 +450,7 @@ static void __init isapnp_parse_irq_reso
 	unsigned long bits;
 
 	isapnp_peek(tmp, size);
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 	bits = (tmp[1] << 8) | tmp[0];
@@ -474,7 +474,7 @@ static void __init isapnp_parse_dma_reso
 	struct pnp_dma *dma;
 
 	isapnp_peek(tmp, size);
-	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 	dma->map = tmp[0];
@@ -494,7 +494,7 @@ static void __init isapnp_parse_port_res
 	struct pnp_port *port;
 
 	isapnp_peek(tmp, size);
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = (tmp[2] << 8) | tmp[1];
@@ -517,7 +517,7 @@ static void __init isapnp_parse_fixed_po
 	struct pnp_port *port;
 
 	isapnp_peek(tmp, size);
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = (tmp[1] << 8) | tmp[0];
@@ -539,7 +539,7 @@ static void __init isapnp_parse_mem_reso
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = ((tmp[2] << 8) | tmp[1]) << 8;
@@ -562,7 +562,7 @@ static void __init isapnp_parse_mem32_re
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
@@ -584,7 +584,7 @@ static void __init isapnp_parse_fixed_me
 	struct pnp_mem *mem;
 
 	isapnp_peek(tmp, size);
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = (tmp[4] << 24) | (tmp[3] << 16) | (tmp[2] << 8) | tmp[1];
@@ -827,7 +827,7 @@ static unsigned char __init isapnp_check
 
 static void isapnp_parse_card_id(struct pnp_card * card, unsigned short vendor, unsigned short device)
 {
-	struct pnp_id * id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	struct pnp_id * id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
@@ -863,7 +863,7 @@ static int __init isapnp_build_device_li
 			header[4], header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		if ((card = kcalloc(1, sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
+		if ((card = kzalloc(sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
 			continue;
 
 		card->number = csn;
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 816479a..8ac8112 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -136,7 +136,7 @@ static int __init pnpacpi_add_device(str
 		return 0;
 
 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
-	dev =  kcalloc(1, sizeof(struct pnp_dev), GFP_KERNEL);
+	dev =  kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");
 		return -ENOMEM;
@@ -166,7 +166,7 @@ static int __init pnpacpi_add_device(str
 	dev->number = num;
 	
 	/* set the initial values for the PnP device */
-	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		goto err;
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
@@ -198,7 +198,7 @@ static int __init pnpacpi_add_device(str
 		for (i = 0; i < cid_list->count; i++) {
 			if (!ispnpidacpi(cid_list->id[i].value))
 				continue;
-			dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+			dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				continue;
 
diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 416d30d..2c9ed7f 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -255,7 +255,7 @@ static void pnpacpi_parse_dma_option(str
 
 	if (p->number_of_channels == 0)
 		return;
-	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 
@@ -311,7 +311,7 @@ static void pnpacpi_parse_irq_option(str
 	
 	if (p->number_of_interrupts == 0)
 		return;
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 
@@ -332,7 +332,7 @@ static void pnpacpi_parse_ext_irq_option
 
 	if (p->number_of_interrupts == 0)
 		return;
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 
@@ -353,7 +353,7 @@ pnpacpi_parse_port_option(struct pnp_opt
 
 	if (io->range_length == 0)
 		return;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = io->min_base_address;
@@ -374,7 +374,7 @@ pnpacpi_parse_fixed_port_option(struct p
 
 	if (io->range_length == 0)
 		return;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = io->base_address;
@@ -393,7 +393,7 @@ pnpacpi_parse_mem24_option(struct pnp_op
 
 	if (p->range_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->min_base_address;
@@ -416,7 +416,7 @@ pnpacpi_parse_mem32_option(struct pnp_op
 
 	if (p->range_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->min_base_address;
@@ -439,7 +439,7 @@ pnpacpi_parse_fixed_mem32_option(struct 
 
 	if (p->range_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = p->range_base_address;
@@ -623,7 +623,7 @@ int pnpacpi_build_resource_template(acpi
 	if (!res_cnt)
 		return -EINVAL;
 	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
-	buffer->pointer = kcalloc(1, buffer->length - 1, GFP_KERNEL);
+	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
 	if (!buffer->pointer)
 		return -ENOMEM;
 	pnp_dbg("Res cnt %d", res_cnt);
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index f49674f..c2f6083 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -221,7 +221,7 @@ static int pnpbios_get_resources(struct 
 	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -244,7 +244,7 @@ static int pnpbios_set_resources(struct 
 	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -295,7 +295,7 @@ static int pnpbios_disable_resources(str
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
@@ -337,7 +337,7 @@ static int insert_device(struct pnp_dev 
 	}
 
 	/* set the initial values for the PnP device */
-	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		return -1;
 	pnpid32_to_pnpid(node->eisa_id,id);
@@ -375,7 +375,7 @@ static void __init build_devlist(void)
 	struct pnp_bios_node *node;
 	struct pnp_dev *dev;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;
 
@@ -392,7 +392,7 @@ static void __init build_devlist(void)
 				break;
 		}
 		nodes_got++;
-		dev =  kcalloc(1, sizeof (struct pnp_dev), GFP_KERNEL);
+		dev =  kzalloc(sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)
 			break;
 		if(insert_device(dev,node)<0)
diff --git a/drivers/pnp/pnpbios/proc.c b/drivers/pnp/pnpbios/proc.c
index 5a3dfc9..8027073 100644
--- a/drivers/pnp/pnpbios/proc.c
+++ b/drivers/pnp/pnpbios/proc.c
@@ -87,7 +87,7 @@ static int proc_read_escd(char *buf, cha
 		return -EFBIG;
 	}
 
-	tmpbuf = kcalloc(1, escd.escd_size, GFP_KERNEL);
+	tmpbuf = kzalloc(escd.escd_size, GFP_KERNEL);
 	if (!tmpbuf) return -ENOMEM;
 
 	if (pnp_bios_read_escd(tmpbuf, escd.nv_storage_base)) {
@@ -133,7 +133,7 @@ static int proc_read_devices(char *buf, 
 	if (pos >= 0xff)
 		return 0;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 
 	for (nodenum=pos; nodenum<0xff; ) {
@@ -168,7 +168,7 @@ static int proc_read_node(char *buf, cha
 	u8 nodenum = (long)data;
 	int len;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node) return -ENOMEM;
 	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
 		kfree(node);
@@ -188,7 +188,7 @@ static int proc_write_node(struct file *
 	u8 nodenum = (long)data;
 	int ret = count;
 
-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 	if (pnp_bios_get_dev_node(&nodenum, boot, node)) {
diff --git a/drivers/pnp/pnpbios/rsparser.c b/drivers/pnp/pnpbios/rsparser.c
index 5e38cd7..1b65fb2 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -249,7 +249,7 @@ static void
 pnpbios_parse_mem_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = ((p[5] << 8) | p[4]) << 8;
@@ -265,7 +265,7 @@ static void
 pnpbios_parse_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -281,7 +281,7 @@ static void
 pnpbios_parse_fixed_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -298,7 +298,7 @@ pnpbios_parse_irq_option(unsigned char *
 	struct pnp_irq * irq;
 	unsigned long bits;
 
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 	bits = (p[2] << 8) | p[1];
@@ -315,7 +315,7 @@ static void
 pnpbios_parse_dma_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_dma * dma;
-	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 	dma->map = p[1];
@@ -328,7 +328,7 @@ static void
 pnpbios_parse_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = (p[3] << 8) | p[2];
@@ -344,7 +344,7 @@ static void
 pnpbios_parse_fixed_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = (p[2] << 8) | p[1];
@@ -532,7 +532,7 @@ pnpbios_parse_compatible_ids(unsigned ch
 		case SMALL_TAG_COMPATDEVID: /* compatible ID */
 			if (len != 4)
 				goto len_err;
-			dev_id =  kcalloc(1, sizeof (struct pnp_id), GFP_KERNEL);
+			dev_id =  kzalloc(sizeof (struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				return NULL;
 			memset(dev_id, 0, sizeof(struct pnp_id));
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index a50588c..7ad7649 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -554,7 +554,7 @@ static int adma_port_start(struct ata_po
 		return rc;
 	adma_enter_reg_mode(ap);
 	rc = -ENOMEM;
-	pp = kcalloc(1, sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		goto err_out;
 	pp->pkt = dma_alloc_coherent(dev, ADMA_PKT_BYTES, &pp->pkt_dma,
@@ -675,7 +675,7 @@ static int adma_ata_init_one(struct pci_
 	if (rc)
 		goto err_out_iounmap;
 
-	probe_ent = kcalloc(1, sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
diff --git a/drivers/usb/net/rndis_host.c b/drivers/usb/net/rndis_host.c
index b5a925d..60243f8 100644
--- a/drivers/usb/net/rndis_host.c
+++ b/drivers/usb/net/rndis_host.c
@@ -459,7 +459,7 @@ static void rndis_unbind(struct usbnet *
 	struct rndis_halt	*halt;
 
 	/* try to clear any rndis state/activity (no i/o from stack!) */
-	halt = kcalloc(1, sizeof *halt, SLAB_KERNEL);
+	halt = kzalloc(sizeof *halt, SLAB_KERNEL);
 	if (halt) {
 		halt->msg_type = RNDIS_MSG_HALT;
 		halt->msg_len = ccpu2(sizeof *halt);
---
0.99.9.GIT
