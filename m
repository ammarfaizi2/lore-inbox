Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVKHX3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVKHX3h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbVKHX3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:29:37 -0500
Received: from outmx012.isp.belgacom.be ([195.238.3.70]:44752 "EHLO
	outmx012.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932401AbVKHX3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:29:36 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ieee1394: Conversions from kmalloc/memset to kzalloc.
Message-Id: <20051108232857.E6D9820A1A@localhost.localdomain>
Date: Wed,  9 Nov 2005 00:28:57 +0100 (CET)
From: takis@issaris.org (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ieee1394: Conversions from kmalloc/memset to kzalloc.

Signed-off-by: Panagiotis Issaris <takis@issaris.org>

---

 drivers/ieee1394/amdtp.c     |    3 +--
 drivers/ieee1394/dv1394.c    |    4 +---
 drivers/ieee1394/highlevel.c |    4 +---
 drivers/ieee1394/hosts.c     |    3 +--
 drivers/ieee1394/nodemgr.c   |    8 ++------
 drivers/ieee1394/ohci1394.c  |   18 ++++++------------
 drivers/ieee1394/raw1394.c   |    7 ++-----
 drivers/ieee1394/sbp2.c      |    7 ++-----
 drivers/ieee1394/video1394.c |   25 ++++++++-----------------
 9 files changed, 24 insertions(+), 55 deletions(-)

applies-to: 1c856cdeb0682c76f2feb48d90dd8d25b9e63ee1
bbec46ecf70c03938b2f85b91678a6e9ae16b5d0
diff --git a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
index 7589750..58aea1d 100644
--- a/drivers/ieee1394/amdtp.c
+++ b/drivers/ieee1394/amdtp.c
@@ -1014,11 +1014,10 @@ static struct stream *stream_alloc(struc
 	struct stream *s;
 	unsigned long flags;
 
-        s = kmalloc(sizeof(struct stream), SLAB_KERNEL);
+        s = kzalloc(sizeof(struct stream), SLAB_KERNEL);
         if (s == NULL)
                 return NULL;
 
-        memset(s, 0, sizeof(struct stream));
 	s->host = host;
 
 	s->input = buffer_alloc(BUFFER_SIZE);
diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
index cbbbe14..bf1f114 100644
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2218,14 +2218,12 @@ static int dv1394_init(struct ti_ohci *o
 	unsigned long flags;
 	int i;
 
-	video = kmalloc(sizeof(struct video_card), GFP_KERNEL);
+	video = kzalloc(sizeof(struct video_card), GFP_KERNEL);
 	if (!video) {
 		printk(KERN_ERR "dv1394: cannot allocate video_card\n");
 		goto err;
 	}
 
-	memset(video, 0, sizeof(struct video_card));
-
 	video->ohci = ohci;
 	/* lower 2 bits of id indicate which of four "plugs"
 	   per host */
diff --git a/drivers/ieee1394/highlevel.c b/drivers/ieee1394/highlevel.c
index 997e1bf..b4b8575 100644
--- a/drivers/ieee1394/highlevel.c
+++ b/drivers/ieee1394/highlevel.c
@@ -101,12 +101,10 @@ void *hpsb_create_hostinfo(struct hpsb_h
 		return NULL;
 	}
 
-	hi = kmalloc(sizeof(*hi) + data_size, GFP_ATOMIC);
+	hi = kzalloc(sizeof(*hi) + data_size, GFP_ATOMIC);
 	if (!hi)
 		return NULL;
 
-	memset(hi, 0, sizeof(*hi) + data_size);
-
 	if (data_size) {
 		data = hi->data = hi + 1;
 		hi->size = data_size;
diff --git a/drivers/ieee1394/hosts.c b/drivers/ieee1394/hosts.c
index aeeaeb6..be04643 100644
--- a/drivers/ieee1394/hosts.c
+++ b/drivers/ieee1394/hosts.c
@@ -114,9 +114,8 @@ struct hpsb_host *hpsb_alloc_host(struct
 	int i;
 	int hostnum = 0;
 
-        h = kmalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
+        h = kzalloc(sizeof(struct hpsb_host) + extra, SLAB_KERNEL);
         if (!h) return NULL;
-        memset(h, 0, sizeof(struct hpsb_host) + extra);
 
 	h->csr.rom = csr1212_create_csr(&csr_bus_ops, CSR_BUS_INFO_SIZE, h);
 	if (!h->csr.rom) {
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 7fff5a1..1e06850 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -745,11 +745,9 @@ static struct node_entry *nodemgr_create
 	struct hpsb_host *host = hi->host;
         struct node_entry *ne;
 
-	ne = kmalloc(sizeof(struct node_entry), GFP_KERNEL);
+	ne = kzalloc(sizeof(struct node_entry), GFP_KERNEL);
         if (!ne) return NULL;
 
-	memset(ne, 0, sizeof(struct node_entry));
-
 	ne->tpool = &host->tpool[nodeid & NODE_MASK];
 
         ne->host = host;
@@ -872,12 +870,10 @@ static struct unit_directory *nodemgr_pr
 	struct csr1212_keyval *kv;
 	u8 last_key_id = 0;
 
-	ud = kmalloc(sizeof(struct unit_directory), GFP_KERNEL);
+	ud = kzalloc(sizeof(struct unit_directory), GFP_KERNEL);
 	if (!ud)
 		goto unit_directory_error;
 
-	memset (ud, 0, sizeof(struct unit_directory));
-
 	ud->ne = ne;
 	ud->ignore_driver = ignore_drivers;
 	ud->address = ud_kv->offset + CSR1212_CONFIG_ROM_SPACE_BASE;
diff --git a/drivers/ieee1394/ohci1394.c b/drivers/ieee1394/ohci1394.c
index 4cf9b8f..7666b3d 100644
--- a/drivers/ieee1394/ohci1394.c
+++ b/drivers/ieee1394/ohci1394.c
@@ -2960,28 +2960,24 @@ alloc_dma_rcv_ctx(struct ti_ohci *ohci, 
 	d->ctrlClear = 0;
 	d->cmdPtr = 0;
 
-	d->buf_cpu = kmalloc(d->num_desc * sizeof(quadlet_t*), GFP_ATOMIC);
-	d->buf_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
+	d->buf_cpu = kzalloc(d->num_desc * sizeof(quadlet_t*), GFP_ATOMIC);
+	d->buf_bus = kzalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
 
 	if (d->buf_cpu == NULL || d->buf_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate dma buffer");
 		free_dma_rcv_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->buf_cpu, 0, d->num_desc * sizeof(quadlet_t*));
-	memset(d->buf_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
-	d->prg_cpu = kmalloc(d->num_desc * sizeof(struct dma_cmd*),
+	d->prg_cpu = kzalloc(d->num_desc * sizeof(struct dma_cmd*),
 				GFP_ATOMIC);
-	d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
+	d->prg_bus = kzalloc(d->num_desc * sizeof(dma_addr_t), GFP_ATOMIC);
 
 	if (d->prg_cpu == NULL || d->prg_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate dma prg");
 		free_dma_rcv_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->prg_cpu, 0, d->num_desc * sizeof(struct dma_cmd*));
-	memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
 	d->spb = kmalloc(d->split_buf_size, GFP_ATOMIC);
 
@@ -3093,17 +3089,15 @@ alloc_dma_trm_ctx(struct ti_ohci *ohci, 
 	d->ctrlClear = 0;
 	d->cmdPtr = 0;
 
-	d->prg_cpu = kmalloc(d->num_desc * sizeof(struct at_dma_prg*),
+	d->prg_cpu = kzalloc(d->num_desc * sizeof(struct at_dma_prg*),
 			     GFP_KERNEL);
-	d->prg_bus = kmalloc(d->num_desc * sizeof(dma_addr_t), GFP_KERNEL);
+	d->prg_bus = kzalloc(d->num_desc * sizeof(dma_addr_t), GFP_KERNEL);
 
 	if (d->prg_cpu == NULL || d->prg_bus == NULL) {
 		PRINT(KERN_ERR, "Failed to allocate at dma prg");
 		free_dma_trm_ctx(d);
 		return -ENOMEM;
 	}
-	memset(d->prg_cpu, 0, d->num_desc * sizeof(struct at_dma_prg*));
-	memset(d->prg_bus, 0, d->num_desc * sizeof(dma_addr_t));
 
 	len = sprintf(pool_name, "ohci1394_trm_prg");
 	sprintf(pool_name+len, "%d", num_allocs);
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
index 24411e6..a3d64d6 100644
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -102,10 +102,8 @@ static struct pending_request *__alloc_p
 {
 	struct pending_request *req;
 
-	req = (struct pending_request *)kmalloc(sizeof(struct pending_request),
-						flags);
+	req = kzalloc(sizeof(struct pending_request), flags);
 	if (req != NULL) {
-		memset(req, 0, sizeof(struct pending_request));
 		INIT_LIST_HEAD(&req->list);
 	}
 
@@ -2684,11 +2682,10 @@ static int raw1394_open(struct inode *in
 {
 	struct file_info *fi;
 
-	fi = kmalloc(sizeof(struct file_info), SLAB_KERNEL);
+	fi = kzalloc(sizeof(struct file_info), SLAB_KERNEL);
 	if (fi == NULL)
 		return -ENOMEM;
 
-	memset(fi, 0, sizeof(struct file_info));
 	fi->notification = (u8) RAW1394_NOTIFY_ON;	/* busreset notification */
 
 	INIT_LIST_HEAD(&fi->list);
diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index 12cec7c..b159f02 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -417,13 +417,11 @@ static int sbp2util_create_command_orb_p
 
 	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 	for (i = 0; i < orbs; i++) {
-		command = (struct sbp2_command_info *)
-		    kmalloc(sizeof(struct sbp2_command_info), GFP_ATOMIC);
+		command = kzalloc(sizeof(struct sbp2_command_info), GFP_ATOMIC);
 		if (!command) {
 			spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 			return(-ENOMEM);
 		}
-		memset(command, '\0', sizeof(struct sbp2_command_info));
 		command->command_orb_dma =
 			pci_map_single (hi->host->pdev, &command->command_orb,
 					sizeof(struct sbp2_command_orb),
@@ -719,12 +717,11 @@ static struct scsi_id_instance_data *sbp
 
 	SBP2_DEBUG("sbp2_alloc_device");
 
-	scsi_id = kmalloc(sizeof(*scsi_id), GFP_KERNEL);
+	scsi_id = kzalloc(sizeof(*scsi_id), GFP_KERNEL);
 	if (!scsi_id) {
 		SBP2_ERR("failed to create scsi_id");
 		goto failed_alloc;
 	}
-	memset(scsi_id, 0, sizeof(*scsi_id));
 
 	scsi_id->ne = ud->ne;
 	scsi_id->ud = ud;
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
index 23911da..59328b4 100644
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -206,14 +206,12 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 	struct dma_iso_ctx *d;
 	int i;
 
-	d = kmalloc(sizeof(struct dma_iso_ctx), GFP_KERNEL);
+	d = kzalloc(sizeof(struct dma_iso_ctx), GFP_KERNEL);
 	if (d == NULL) {
 		PRINT(KERN_ERR, ohci->host->id, "Failed to allocate dma_iso_ctx");
 		return NULL;
 	}
 
-	memset(d, 0, sizeof *d);
-
 	d->ohci = ohci;
 	d->type = type;
 	d->channel = channel;
@@ -268,7 +266,7 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		d->cmdPtr = OHCI1394_IsoRcvCommandPtr+32*d->ctx;
 		d->ctxMatch = OHCI1394_IsoRcvContextMatch+32*d->ctx;
 
-		d->ir_prg = kmalloc(d->num_desc * sizeof(struct dma_cmd *),
+		d->ir_prg = kzalloc(d->num_desc * sizeof(struct dma_cmd *),
 				    GFP_KERNEL);
 
 		if (d->ir_prg == NULL) {
@@ -276,7 +274,6 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 			free_dma_iso_ctx(d);
 			return NULL;
 		}
-		memset(d->ir_prg, 0, d->num_desc * sizeof(struct dma_cmd *));
 
 		d->nb_cmd = d->buf_size / PAGE_SIZE + 1;
 		d->left_size = (d->frame_size % PAGE_SIZE) ?
@@ -297,7 +294,7 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		d->ctrlClear = OHCI1394_IsoXmitContextControlClear+16*d->ctx;
 		d->cmdPtr = OHCI1394_IsoXmitCommandPtr+16*d->ctx;
 
-		d->it_prg = kmalloc(d->num_desc * sizeof(struct it_dma_prg *),
+		d->it_prg = kzalloc(d->num_desc * sizeof(struct it_dma_prg *),
 				    GFP_KERNEL);
 
 		if (d->it_prg == NULL) {
@@ -306,7 +303,6 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 			free_dma_iso_ctx(d);
 			return NULL;
 		}
-		memset(d->it_prg, 0, d->num_desc*sizeof(struct it_dma_prg *));
 
 		d->packet_size = packet_size;
 
@@ -337,13 +333,13 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		}
 	}
 
-	d->buffer_status = kmalloc(d->num_desc * sizeof(unsigned int),
+	d->buffer_status = kzalloc(d->num_desc * sizeof(unsigned int),
 				   GFP_KERNEL);
-	d->buffer_prg_assignment = kmalloc(d->num_desc * sizeof(unsigned int),
+	d->buffer_prg_assignment = kzalloc(d->num_desc * sizeof(unsigned int),
 				   GFP_KERNEL);
-	d->buffer_time = kmalloc(d->num_desc * sizeof(struct timeval),
+	d->buffer_time = kzalloc(d->num_desc * sizeof(struct timeval),
 				   GFP_KERNEL);
-	d->last_used_cmd = kmalloc(d->num_desc * sizeof(unsigned int),
+	d->last_used_cmd = kzalloc(d->num_desc * sizeof(unsigned int),
 				   GFP_KERNEL);
 	d->next_buffer = kmalloc(d->num_desc * sizeof(int),
 				 GFP_KERNEL);
@@ -373,10 +369,6 @@ alloc_dma_iso_ctx(struct ti_ohci *ohci, 
 		free_dma_iso_ctx(d);
 		return NULL;
 	}
-	memset(d->buffer_status, 0, d->num_desc * sizeof(unsigned int));
-	memset(d->buffer_prg_assignment, 0, d->num_desc * sizeof(unsigned int));
-	memset(d->buffer_time, 0, d->num_desc * sizeof(struct timeval));
-	memset(d->last_used_cmd, 0, d->num_desc * sizeof(unsigned int));
 	memset(d->next_buffer, -1, d->num_desc * sizeof(int));
 
         spin_lock_init(&d->lock);
@@ -1251,13 +1243,12 @@ static int video1394_open(struct inode *
         if (ohci == NULL)
                 return -EIO;
 
-	ctx = kmalloc(sizeof(struct file_ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(struct file_ctx), GFP_KERNEL);
 	if (ctx == NULL)  {
 		PRINT(KERN_ERR, ohci->host->id, "Cannot malloc file_ctx");
 		return -ENOMEM;
 	}
 
-	memset(ctx, 0, sizeof(struct file_ctx));
 	ctx->ohci = ohci;
 	INIT_LIST_HEAD(&ctx->context_list);
 	ctx->current_ctx = NULL;
---
0.99.9.GIT
