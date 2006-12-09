Return-Path: <linux-kernel-owner+w=401wt.eu-S936686AbWLIO6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936686AbWLIO6y (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 09:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936786AbWLIO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 09:58:54 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:53301 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936686AbWLIO6x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 09:58:53 -0500
X-Originating-Ip: 74.102.209.62
Date: Sat, 9 Dec 2006 09:54:45 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: akpm@osdl.org
Subject: [PATCH] Fix numerous kcalloc() calls, convert to kzalloc().
Message-ID: <Pine.LNX.4.64.0612090950580.14897@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.31, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26, TW_DB 0.08, TW_NM 0.08,
	TW_OC 0.08)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  All kcalloc() calls of the form "kcalloc(1,...)" are converted to
the equivalent kzalloc() calls, and a few kcalloc() calls with the
incorrect ordering of the first two arguments are fixed.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

 drivers/ata/pdc_adma.c              |    4 ++--
 drivers/macintosh/smu.c             |    2 +-
 drivers/mtd/rfd_ftl.c               |    2 +-
 drivers/net/phy/phy_device.c        |    2 +-
 drivers/net/skge.c                  |    2 +-
 drivers/pcmcia/at91_cf.c            |    2 +-
 drivers/pcmcia/omap_cf.c            |    2 +-
 drivers/pnp/isapnp/core.c           |   22 +++++++++++-----------
 drivers/pnp/pnpacpi/core.c          |    6 +++---
 drivers/pnp/pnpacpi/rsparser.c      |   22 +++++++++++-----------
 drivers/pnp/pnpbios/core.c          |   14 +++++++-------
 drivers/pnp/pnpbios/proc.c          |    8 ++++----
 drivers/pnp/pnpbios/rsparser.c      |   16 ++++++++--------
 drivers/scsi/sym53c8xx_2/sym_hipd.c |    2 +-
 drivers/usb/gadget/at91_udc.c       |    2 +-
 drivers/usb/misc/uss720.c           |    2 +-
 drivers/usb/net/rndis_host.c        |    2 +-
 fs/ocfs2/alloc.c                    |    2 +-
 fs/ocfs2/cluster/heartbeat.c        |    4 ++--
 fs/ocfs2/cluster/nodemanager.c      |    6 +++---
 fs/ocfs2/cluster/tcp.c              |   10 +++++-----
 fs/ocfs2/dlm/dlmdomain.c            |    4 ++--
 fs/ocfs2/dlm/dlmlock.c              |    4 ++--
 fs/ocfs2/dlm/dlmmaster.c            |    2 +-
 fs/ocfs2/dlm/dlmrecovery.c          |    6 +++---
 fs/ocfs2/localalloc.c               |    2 +-
 fs/ocfs2/slot_map.c                 |    2 +-
 fs/ocfs2/suballoc.c                 |    6 +++---
 fs/ocfs2/super.c                    |    6 +++---
 fs/ocfs2/vote.c                     |    4 ++--
 include/linux/gameport.h            |    2 +-
 kernel/relay.c                      |    4 ++--
 net/sunrpc/svc.c                    |    2 +-
 sound/pci/hda/patch_realtek.c       |    4 ++--
 34 files changed, 91 insertions(+), 91 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 9021e34..90786d7 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -551,7 +551,7 @@ static int adma_port_start(struct ata_po
 		return rc;
 	adma_enter_reg_mode(ap);
 	rc = -ENOMEM;
-	pp = kcalloc(1, sizeof(*pp), GFP_KERNEL);
+	pp = kzalloc(sizeof(*pp), GFP_KERNEL);
 	if (!pp)
 		goto err_out;
 	pp->pkt = dma_alloc_coherent(dev, ADMA_PKT_BYTES, &pp->pkt_dma,
@@ -672,7 +672,7 @@ static int adma_ata_init_one(struct pci_
 	if (rc)
 		goto err_out_iounmap;

-	probe_ent = kcalloc(1, sizeof(*probe_ent), GFP_KERNEL);
+	probe_ent = kzalloc(sizeof(*probe_ent), GFP_KERNEL);
 	if (probe_ent == NULL) {
 		rc = -ENOMEM;
 		goto err_out_iounmap;
diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 6dde27a..6f30459 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -945,7 +945,7 @@ static struct smu_sdbp_header *smu_creat
 	 */
 	tlen = sizeof(struct property) + len + 18;

-	prop = kcalloc(tlen, 1, GFP_KERNEL);
+	prop = kzalloc(tlen, GFP_KERNEL);
 	if (prop == NULL)
 		return NULL;
 	hdr = (struct smu_sdbp_header *)(prop + 1);
diff --git a/drivers/mtd/rfd_ftl.c b/drivers/mtd/rfd_ftl.c
index fa4362f..0f3baa5 100644
--- a/drivers/mtd/rfd_ftl.c
+++ b/drivers/mtd/rfd_ftl.c
@@ -768,7 +768,7 @@ static void rfd_ftl_add_mtd(struct mtd_b
 	if (mtd->type != MTD_NORFLASH)
 		return;

-	part = kcalloc(1, sizeof(struct partition), GFP_KERNEL);
+	part = kzalloc(sizeof(struct partition), GFP_KERNEL);
 	if (!part)
 		return;

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index b01fc70..a4d7529 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -50,7 +50,7 @@ struct phy_device* phy_device_create(str
 	struct phy_device *dev;
 	/* We allocate the device, and initialize the
 	 * default values */
-	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);

 	if (NULL == dev)
 		return (struct phy_device*) PTR_ERR((void*)-ENOMEM);
diff --git a/drivers/net/skge.c b/drivers/net/skge.c
index b60f045..8a39376 100644
--- a/drivers/net/skge.c
+++ b/drivers/net/skge.c
@@ -749,7 +749,7 @@ static int skge_ring_alloc(struct skge_r
 	struct skge_element *e;
 	int i;

-	ring->start = kcalloc(sizeof(*e), ring->count, GFP_KERNEL);
+	ring->start = kcalloc(ring->count, sizeof(*e), GFP_KERNEL);
 	if (!ring->start)
 		return -ENOMEM;

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 52d4a38..3334f22 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -230,7 +230,7 @@ static int __init at91_cf_probe(struct p
 	if (!io)
 		return -ENODEV;

-	cf = kcalloc(1, sizeof *cf, GFP_KERNEL);
+	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
 		return -ENOMEM;

diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 06bf7f4..e65a6b8 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -220,7 +220,7 @@ static int __devinit omap_cf_probe(struc
 	if (irq < 0)
 		return -EINVAL;

-	cf = kcalloc(1, sizeof *cf, GFP_KERNEL);
+	cf = kzalloc(sizeof *cf, GFP_KERNEL);
 	if (!cf)
 		return -ENOMEM;
 	init_timer(&cf->timer);
diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 3ac5b12..a0b1587 100644
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
@@ -829,7 +829,7 @@ static unsigned char __init isapnp_check

 static void isapnp_parse_card_id(struct pnp_card * card, unsigned short vendor, unsigned short device)
 {
-	struct pnp_id * id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	struct pnp_id * id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!id)
 		return;
 	sprintf(id->id, "%c%c%c%x%x%x%x",
@@ -865,7 +865,7 @@ #if 0
 			header[4], header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		if ((card = kcalloc(1, sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
+		if ((card = kzalloc(sizeof(struct pnp_card), GFP_KERNEL)) == NULL)
 			continue;

 		card->number = csn;
diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 6cf34a6..62eda5d 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -139,7 +139,7 @@ static int __init pnpacpi_add_device(str
 		return 0;

 	pnp_dbg("ACPI device : hid %s", acpi_device_hid(device));
-	dev =  kcalloc(1, sizeof(struct pnp_dev), GFP_KERNEL);
+	dev =  kzalloc(sizeof(struct pnp_dev), GFP_KERNEL);
 	if (!dev) {
 		pnp_err("Out of memory");
 		return -ENOMEM;
@@ -169,7 +169,7 @@ static int __init pnpacpi_add_device(str
 	dev->number = num;

 	/* set the initial values for the PnP device */
-	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		goto err;
 	pnpidacpi_to_pnpid(acpi_device_hid(device), dev_id->id);
@@ -201,7 +201,7 @@ static int __init pnpacpi_add_device(str
 		for (i = 0; i < cid_list->count; i++) {
 			if (!ispnpidacpi(cid_list->id[i].value))
 				continue;
-			dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+			dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				continue;

diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
index 379048f..7a53554 100644
--- a/drivers/pnp/pnpacpi/rsparser.c
+++ b/drivers/pnp/pnpacpi/rsparser.c
@@ -298,7 +298,7 @@ static void pnpacpi_parse_dma_option(str

 	if (p->channel_count == 0)
 		return;
-	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;

@@ -354,7 +354,7 @@ static void pnpacpi_parse_irq_option(str

 	if (p->interrupt_count == 0)
 		return;
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;

@@ -375,7 +375,7 @@ static void pnpacpi_parse_ext_irq_option

 	if (p->interrupt_count == 0)
 		return;
-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;

@@ -396,7 +396,7 @@ pnpacpi_parse_port_option(struct pnp_opt

 	if (io->address_length == 0)
 		return;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = io->minimum;
@@ -417,7 +417,7 @@ pnpacpi_parse_fixed_port_option(struct p

 	if (io->address_length == 0)
 		return;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = io->address;
@@ -436,7 +436,7 @@ pnpacpi_parse_mem24_option(struct pnp_op

 	if (p->address_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->minimum;
@@ -459,7 +459,7 @@ pnpacpi_parse_mem32_option(struct pnp_op

 	if (p->address_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = p->minimum;
@@ -482,7 +482,7 @@ pnpacpi_parse_fixed_mem32_option(struct

 	if (p->address_length == 0)
 		return;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = p->address;
@@ -514,7 +514,7 @@ pnpacpi_parse_address_option(struct pnp_
 		return;

 	if (p->resource_type == ACPI_MEMORY_RANGE) {
-		mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+		mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 		if (!mem)
 			return;
 		mem->min = mem->max = p->minimum;
@@ -524,7 +524,7 @@ pnpacpi_parse_address_option(struct pnp_
 		    ACPI_READ_WRITE_MEMORY) ? IORESOURCE_MEM_WRITEABLE : 0;
 		pnp_register_mem_resource(option, mem);
 	} else if (p->resource_type == ACPI_IO_RANGE) {
-		port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+		port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 		if (!port)
 			return;
 		port->min = port->max = p->minimum;
@@ -721,7 +721,7 @@ int pnpacpi_build_resource_template(acpi
 	if (!res_cnt)
 		return -EINVAL;
 	buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
-	buffer->pointer = kcalloc(1, buffer->length - 1, GFP_KERNEL);
+	buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
 	if (!buffer->pointer)
 		return -ENOMEM;
 	pnp_dbg("Res cnt %d", res_cnt);
diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
index 33adeba..b7fdb4d 100644
--- a/drivers/pnp/pnpbios/core.c
+++ b/drivers/pnp/pnpbios/core.c
@@ -112,7 +112,7 @@ static int pnp_dock_event(int dock, stru
 	if (!(envp = (char **) kcalloc (20, sizeof (char *), GFP_KERNEL))) {
 		return -ENOMEM;
 	}
-	if (!(buf = kcalloc (1, 256, GFP_KERNEL))) {
+	if (!(buf = kzalloc(256, GFP_KERNEL))) {
 		kfree (envp);
 		return -ENOMEM;
 	}
@@ -220,7 +220,7 @@ static int pnpbios_get_resources(struct
 	if(!pnpbios_is_dynamic(dev))
 		return -EPERM;

-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -243,7 +243,7 @@ static int pnpbios_set_resources(struct
 	if (!pnpbios_is_dynamic(dev))
 		return -EPERM;

-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -1;
 	if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node)) {
@@ -294,7 +294,7 @@ static int pnpbios_disable_resources(str
 	if(dev->flags & PNPBIOS_NO_DISABLE || !pnpbios_is_dynamic(dev))
 		return -EPERM;

-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;

@@ -336,7 +336,7 @@ static int insert_device(struct pnp_dev
 	}

 	/* set the initial values for the PnP device */
-	dev_id = kcalloc(1, sizeof(struct pnp_id), GFP_KERNEL);
+	dev_id = kzalloc(sizeof(struct pnp_id), GFP_KERNEL);
 	if (!dev_id)
 		return -1;
 	pnpid32_to_pnpid(node->eisa_id,id);
@@ -374,7 +374,7 @@ static void __init build_devlist(void)
 	struct pnp_bios_node *node;
 	struct pnp_dev *dev;

-	node = kcalloc(1, node_info.max_node_size, GFP_KERNEL);
+	node = kzalloc(node_info.max_node_size, GFP_KERNEL);
 	if (!node)
 		return;

@@ -391,7 +391,7 @@ static void __init build_devlist(void)
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
index ef508a4..95b7968 100644
--- a/drivers/pnp/pnpbios/rsparser.c
+++ b/drivers/pnp/pnpbios/rsparser.c
@@ -248,7 +248,7 @@ static void
 pnpbios_parse_mem_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = ((p[5] << 8) | p[4]) << 8;
@@ -264,7 +264,7 @@ static void
 pnpbios_parse_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -280,7 +280,7 @@ static void
 pnpbios_parse_fixed_mem32_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_mem * mem;
-	mem = kcalloc(1, sizeof(struct pnp_mem), GFP_KERNEL);
+	mem = kzalloc(sizeof(struct pnp_mem), GFP_KERNEL);
 	if (!mem)
 		return;
 	mem->min = mem->max = (p[7] << 24) | (p[6] << 16) | (p[5] << 8) | p[4];
@@ -297,7 +297,7 @@ pnpbios_parse_irq_option(unsigned char *
 	struct pnp_irq * irq;
 	unsigned long bits;

-	irq = kcalloc(1, sizeof(struct pnp_irq), GFP_KERNEL);
+	irq = kzalloc(sizeof(struct pnp_irq), GFP_KERNEL);
 	if (!irq)
 		return;
 	bits = (p[2] << 8) | p[1];
@@ -314,7 +314,7 @@ static void
 pnpbios_parse_dma_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_dma * dma;
-	dma = kcalloc(1, sizeof(struct pnp_dma), GFP_KERNEL);
+	dma = kzalloc(sizeof(struct pnp_dma), GFP_KERNEL);
 	if (!dma)
 		return;
 	dma->map = p[1];
@@ -327,7 +327,7 @@ static void
 pnpbios_parse_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = (p[3] << 8) | p[2];
@@ -343,7 +343,7 @@ static void
 pnpbios_parse_fixed_port_option(unsigned char *p, int size, struct pnp_option *option)
 {
 	struct pnp_port * port;
-	port = kcalloc(1, sizeof(struct pnp_port), GFP_KERNEL);
+	port = kzalloc(sizeof(struct pnp_port), GFP_KERNEL);
 	if (!port)
 		return;
 	port->min = port->max = (p[2] << 8) | p[1];
@@ -527,7 +527,7 @@ pnpbios_parse_compatible_ids(unsigned ch
 		case SMALL_TAG_COMPATDEVID: /* compatible ID */
 			if (len != 4)
 				goto len_err;
-			dev_id =  kcalloc(1, sizeof (struct pnp_id), GFP_KERNEL);
+			dev_id =  kzalloc(sizeof (struct pnp_id), GFP_KERNEL);
 			if (!dev_id)
 				return NULL;
 			memset(dev_id, 0, sizeof(struct pnp_id));
diff --git a/drivers/scsi/sym53c8xx_2/sym_hipd.c b/drivers/scsi/sym53c8xx_2/sym_hipd.c
index 940fa1e..21cd4c7 100644
--- a/drivers/scsi/sym53c8xx_2/sym_hipd.c
+++ b/drivers/scsi/sym53c8xx_2/sym_hipd.c
@@ -5545,7 +5545,7 @@ int sym_hcb_attach(struct Scsi_Host *sho
 	/*
 	 *  Allocate the array of lists of CCBs hashed by DSA.
 	 */
-	np->ccbh = kcalloc(sizeof(struct sym_ccb **), CCB_HASH_SIZE, GFP_KERNEL);
+	np->ccbh = kcalloc(CCB_HASH_SIZE, sizeof(struct sym_ccb **), GFP_KERNEL);
 	if (!np->ccbh)
 		goto attach_failed;

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index 72f3db9..3e0abbb 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -598,7 +598,7 @@ at91_ep_alloc_request(struct usb_ep *_ep
 {
 	struct at91_request *req;

-	req = kcalloc(1, sizeof (struct at91_request), gfp_flags);
+	req = kzalloc(sizeof (struct at91_request), gfp_flags);
 	if (!req)
 		return NULL;

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 7e8a0ac..7025025 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -705,7 +705,7 @@ static int uss720_probe(struct usb_inter
 	/*
 	 * Allocate parport interface
 	 */
-	if (!(priv = kcalloc(sizeof(struct parport_uss720_private), 1, GFP_KERNEL))) {
+	if (!(priv = kzalloc(sizeof(struct parport_uss720_private), GFP_KERNEL))) {
 		usb_put_dev(usbdev);
 		return -ENOMEM;
 	}
diff --git a/drivers/usb/net/rndis_host.c b/drivers/usb/net/rndis_host.c
index 99f26b3..ea5f44d 100644
--- a/drivers/usb/net/rndis_host.c
+++ b/drivers/usb/net/rndis_host.c
@@ -469,7 +469,7 @@ static void rndis_unbind(struct usbnet *
 	struct rndis_halt	*halt;

 	/* try to clear any rndis state/activity (no i/o from stack!) */
-	halt = kcalloc(1, sizeof *halt, GFP_KERNEL);
+	halt = kzalloc(sizeof *halt, GFP_KERNEL);
 	if (halt) {
 		halt->msg_type = RNDIS_MSG_HALT;
 		halt->msg_len = ccpu2(sizeof *halt);
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index edc91ca..f27e537 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -1959,7 +1959,7 @@ int ocfs2_prepare_truncate(struct ocfs2_
 		goto bail;
 	}

-	*tc = kcalloc(1, sizeof(struct ocfs2_truncate_context), GFP_KERNEL);
+	*tc = kzalloc(sizeof(struct ocfs2_truncate_context), GFP_KERNEL);
 	if (!(*tc)) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 4cd9a95..a25ef5a 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -1553,7 +1553,7 @@ static struct config_item *o2hb_heartbea
 	struct o2hb_region *reg = NULL;
 	struct config_item *ret = NULL;

-	reg = kcalloc(1, sizeof(struct o2hb_region), GFP_KERNEL);
+	reg = kzalloc(sizeof(struct o2hb_region), GFP_KERNEL);
 	if (reg == NULL)
 		goto out; /* ENOMEM */

@@ -1679,7 +1679,7 @@ struct config_group *o2hb_alloc_hb_set(v
 	struct o2hb_heartbeat_group *hs = NULL;
 	struct config_group *ret = NULL;

-	hs = kcalloc(1, sizeof(struct o2hb_heartbeat_group), GFP_KERNEL);
+	hs = kzalloc(sizeof(struct o2hb_heartbeat_group), GFP_KERNEL);
 	if (hs == NULL)
 		goto out;

diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index d11753c..7c5f104 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -552,7 +552,7 @@ static struct config_item *o2nm_node_gro
 	if (strlen(name) > O2NM_MAX_NAME_LEN)
 		goto out; /* ENAMETOOLONG */

-	node = kcalloc(1, sizeof(struct o2nm_node), GFP_KERNEL);
+	node = kzalloc(sizeof(struct o2nm_node), GFP_KERNEL);
 	if (node == NULL)
 		goto out; /* ENOMEM */

@@ -660,8 +660,8 @@ static struct config_group *o2nm_cluster
 	if (o2nm_single_cluster)
 		goto out; /* ENOSPC */

-	cluster = kcalloc(1, sizeof(struct o2nm_cluster), GFP_KERNEL);
-	ns = kcalloc(1, sizeof(struct o2nm_node_group), GFP_KERNEL);
+	cluster = kzalloc(sizeof(struct o2nm_cluster), GFP_KERNEL);
+	ns = kzalloc(sizeof(struct o2nm_node_group), GFP_KERNEL);
 	defs = kcalloc(3, sizeof(struct config_group *), GFP_KERNEL);
 	o2hb_group = o2hb_alloc_hb_set();
 	if (cluster == NULL || ns == NULL || o2hb_group == NULL || defs == NULL)
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index 9b3209d..7ec1265 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -300,7 +300,7 @@ static struct o2net_sock_container *sc_a
 	struct page *page = NULL;

 	page = alloc_page(GFP_NOFS);
-	sc = kcalloc(1, sizeof(*sc), GFP_NOFS);
+	sc = kzalloc(sizeof(*sc), GFP_NOFS);
 	if (sc == NULL || page == NULL)
 		goto out;

@@ -678,7 +678,7 @@ int o2net_register_handler(u32 msg_type,
 		goto out;
 	}

-       	nmh = kcalloc(1, sizeof(struct o2net_msg_handler), GFP_NOFS);
+       	nmh = kzalloc(sizeof(struct o2net_msg_handler), GFP_NOFS);
 	if (nmh == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -1808,9 +1808,9 @@ int o2net_init(void)

 	o2quo_init();

-	o2net_hand = kcalloc(1, sizeof(struct o2net_handshake), GFP_KERNEL);
-	o2net_keep_req = kcalloc(1, sizeof(struct o2net_msg), GFP_KERNEL);
-	o2net_keep_resp = kcalloc(1, sizeof(struct o2net_msg), GFP_KERNEL);
+	o2net_hand = kzalloc(sizeof(struct o2net_handshake), GFP_KERNEL);
+	o2net_keep_req = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
+	o2net_keep_resp = kzalloc(sizeof(struct o2net_msg), GFP_KERNEL);
 	if (!o2net_hand || !o2net_keep_req || !o2net_keep_resp) {
 		kfree(o2net_hand);
 		kfree(o2net_keep_req);
diff --git a/fs/ocfs2/dlm/dlmdomain.c b/fs/ocfs2/dlm/dlmdomain.c
index 420a375..f0b25f2 100644
--- a/fs/ocfs2/dlm/dlmdomain.c
+++ b/fs/ocfs2/dlm/dlmdomain.c
@@ -920,7 +920,7 @@ static int dlm_try_to_join_domain(struct

 	mlog_entry("%p", dlm);

-	ctxt = kcalloc(1, sizeof(*ctxt), GFP_KERNEL);
+	ctxt = kzalloc(sizeof(*ctxt), GFP_KERNEL);
 	if (!ctxt) {
 		status = -ENOMEM;
 		mlog_errno(status);
@@ -1223,7 +1223,7 @@ static struct dlm_ctxt *dlm_alloc_ctxt(c
 	int i;
 	struct dlm_ctxt *dlm = NULL;

-	dlm = kcalloc(1, sizeof(*dlm), GFP_KERNEL);
+	dlm = kzalloc(sizeof(*dlm), GFP_KERNEL);
 	if (!dlm) {
 		mlog_errno(-ENOMEM);
 		goto leave;
diff --git a/fs/ocfs2/dlm/dlmlock.c b/fs/ocfs2/dlm/dlmlock.c
index 42a1b91..e5ca3db 100644
--- a/fs/ocfs2/dlm/dlmlock.c
+++ b/fs/ocfs2/dlm/dlmlock.c
@@ -408,13 +408,13 @@ struct dlm_lock * dlm_new_lock(int type,
 	struct dlm_lock *lock;
 	int kernel_allocated = 0;

-	lock = kcalloc(1, sizeof(*lock), GFP_NOFS);
+	lock = kzalloc(sizeof(*lock), GFP_NOFS);
 	if (!lock)
 		return NULL;

 	if (!lksb) {
 		/* zero memory only if kernel-allocated */
-		lksb = kcalloc(1, sizeof(*lksb), GFP_NOFS);
+		lksb = kzalloc(sizeof(*lksb), GFP_NOFS);
 		if (!lksb) {
 			kfree(lock);
 			return NULL;
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 856012b..0ad8720 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -1939,7 +1939,7 @@ int dlm_dispatch_assert_master(struct dl
 			       int ignore_higher, u8 request_from, u32 flags)
 {
 	struct dlm_work_item *item;
-	item = kcalloc(1, sizeof(*item), GFP_NOFS);
+	item = kzalloc(sizeof(*item), GFP_NOFS);
 	if (!item)
 		return -ENOMEM;

diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index fb3e2b0..367a11e 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -757,7 +757,7 @@ static int dlm_init_recovery_area(struct
 		}
 		BUG_ON(num == dead_node);

-		ndata = kcalloc(1, sizeof(*ndata), GFP_NOFS);
+		ndata = kzalloc(sizeof(*ndata), GFP_NOFS);
 		if (!ndata) {
 			dlm_destroy_recovery_area(dlm, dead_node);
 			return -ENOMEM;
@@ -842,7 +842,7 @@ int dlm_request_all_locks_handler(struct
 	}
 	BUG_ON(lr->dead_node != dlm->reco.dead_node);

-	item = kcalloc(1, sizeof(*item), GFP_NOFS);
+	item = kzalloc(sizeof(*item), GFP_NOFS);
 	if (!item) {
 		dlm_put(dlm);
 		return -ENOMEM;
@@ -1323,7 +1323,7 @@ int dlm_mig_lockres_handler(struct o2net

 	ret = -ENOMEM;
 	buf = kmalloc(be16_to_cpu(msg->data_len), GFP_NOFS);
-	item = kcalloc(1, sizeof(*item), GFP_NOFS);
+	item = kzalloc(sizeof(*item), GFP_NOFS);
 	if (!buf || !item)
 		goto leave;

diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index 698d79a..4dedd97 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -776,7 +776,7 @@ static int ocfs2_local_alloc_reserve_for
 {
 	int status;

-	*ac = kcalloc(1, sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
+	*ac = kzalloc(sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
 	if (!(*ac)) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/slot_map.c b/fs/ocfs2/slot_map.c
index aa6f5aa..2d3ac32 100644
--- a/fs/ocfs2/slot_map.c
+++ b/fs/ocfs2/slot_map.c
@@ -175,7 +175,7 @@ int ocfs2_init_slot_info(struct ocfs2_su
 	struct buffer_head *bh = NULL;
 	struct ocfs2_slot_info *si;

-	si = kcalloc(1, sizeof(struct ocfs2_slot_info), GFP_KERNEL);
+	si = kzalloc(sizeof(struct ocfs2_slot_info), GFP_KERNEL);
 	if (!si) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 000d71c..6dbb117 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -488,7 +488,7 @@ int ocfs2_reserve_new_metadata(struct oc
 	int status;
 	u32 slot;

-	*ac = kcalloc(1, sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
+	*ac = kzalloc(sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
 	if (!(*ac)) {
 		status = -ENOMEM;
 		mlog_errno(status);
@@ -530,7 +530,7 @@ int ocfs2_reserve_new_inode(struct ocfs2
 {
 	int status;

-	*ac = kcalloc(1, sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
+	*ac = kzalloc(sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
 	if (!(*ac)) {
 		status = -ENOMEM;
 		mlog_errno(status);
@@ -595,7 +595,7 @@ int ocfs2_reserve_clusters(struct ocfs2_

 	mlog_entry_void();

-	*ac = kcalloc(1, sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
+	*ac = kzalloc(sizeof(struct ocfs2_alloc_context), GFP_KERNEL);
 	if (!(*ac)) {
 		status = -ENOMEM;
 		mlog_errno(status);
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 4bf3954..1d5890f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1194,7 +1194,7 @@ static int ocfs2_setup_osb_uuid(struct o

 	BUG_ON(uuid_bytes != OCFS2_VOL_UUID_LEN);

-	osb->uuid_str = kcalloc(1, OCFS2_VOL_UUID_LEN * 2 + 1, GFP_KERNEL);
+	osb->uuid_str = kzalloc(OCFS2_VOL_UUID_LEN * 2 + 1, GFP_KERNEL);
 	if (osb->uuid_str == NULL)
 		return -ENOMEM;

@@ -1225,7 +1225,7 @@ static int ocfs2_initialize_super(struct

 	mlog_entry_void();

-	osb = kcalloc(1, sizeof(struct ocfs2_super), GFP_KERNEL);
+	osb = kzalloc(sizeof(struct ocfs2_super), GFP_KERNEL);
 	if (!osb) {
 		status = -ENOMEM;
 		mlog_errno(status);
@@ -1350,7 +1350,7 @@ static int ocfs2_initialize_super(struct
 	 */
 	/* initialize our journal structure */

-	journal = kcalloc(1, sizeof(struct ocfs2_journal), GFP_KERNEL);
+	journal = kzalloc(sizeof(struct ocfs2_journal), GFP_KERNEL);
 	if (!journal) {
 		mlog(ML_ERROR, "unable to alloc journal\n");
 		status = -ENOMEM;
diff --git a/fs/ocfs2/vote.c b/fs/ocfs2/vote.c
index 5b4dca7..5a6ba78 100644
--- a/fs/ocfs2/vote.c
+++ b/fs/ocfs2/vote.c
@@ -479,7 +479,7 @@ static struct ocfs2_net_wait_ctxt *ocfs2
 {
 	struct ocfs2_net_wait_ctxt *w;

-	w = kcalloc(1, sizeof(*w), GFP_NOFS);
+	w = kzalloc(sizeof(*w), GFP_NOFS);
 	if (!w) {
 		mlog_errno(-ENOMEM);
 		goto bail;
@@ -642,7 +642,7 @@ static struct ocfs2_vote_msg * ocfs2_new

 	BUG_ON(!ocfs2_is_valid_vote_request(type));

-	request = kcalloc(1, sizeof(*request), GFP_NOFS);
+	request = kzalloc(sizeof(*request), GFP_NOFS);
 	if (!request) {
 		mlog_errno(-ENOMEM);
 	} else {
diff --git a/include/linux/gameport.h b/include/linux/gameport.h
index 2cdba0c..afad952 100644
--- a/include/linux/gameport.h
+++ b/include/linux/gameport.h
@@ -105,7 +105,7 @@ #endif

 static inline struct gameport *gameport_allocate_port(void)
 {
-	struct gameport *gameport = kcalloc(1, sizeof(struct gameport), GFP_KERNEL);
+	struct gameport *gameport = kzalloc(sizeof(struct gameport), GFP_KERNEL);

 	return gameport;
 }
diff --git a/kernel/relay.c b/kernel/relay.c
index 818e514..a4701e7 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -138,7 +138,7 @@ depopulate:
  */
 struct rchan_buf *relay_create_buf(struct rchan *chan)
 {
-	struct rchan_buf *buf = kcalloc(1, sizeof(struct rchan_buf), GFP_KERNEL);
+	struct rchan_buf *buf = kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
 	if (!buf)
 		return NULL;

@@ -479,7 +479,7 @@ struct rchan *relay_open(const char *bas
 	if (!(subbuf_size && n_subbufs))
 		return NULL;

-	chan = kcalloc(1, sizeof(struct rchan), GFP_KERNEL);
+	chan = kzalloc(sizeof(struct rchan), GFP_KERNEL);
 	if (!chan)
 		return NULL;

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index eb44ec9..1ae79a8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -308,7 +308,7 @@ __svc_create(struct svc_program *prog, u

 	serv->sv_nrpools = npools;
 	serv->sv_pools =
-		kcalloc(sizeof(struct svc_pool), serv->sv_nrpools,
+		kcalloc(serv->sv_nrpools, sizeof(struct svc_pool),
 			GFP_KERNEL);
 	if (!serv->sv_pools) {
 		kfree(serv);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fb96144..5ebdd8a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5936,7 +5936,7 @@ static int patch_alc262(struct hda_codec
 	int board_config;
 	int err;

-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;

@@ -6795,7 +6795,7 @@ static int patch_alc861(struct hda_codec
 	int board_config;
 	int err;

-	spec = kcalloc(1, sizeof(*spec), GFP_KERNEL);
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
 		return -ENOMEM;

