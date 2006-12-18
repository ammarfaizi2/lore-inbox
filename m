Return-Path: <linux-kernel-owner+w=401wt.eu-S1754494AbWLRT5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754494AbWLRT5S (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbWLRT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:57:18 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:55039 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494AbWLRT5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:57:17 -0500
X-Originating-Ip: 24.148.236.183
Date: Mon, 18 Dec 2006 14:53:05 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] OSS: replace kmalloc()+memset() combos with kzalloc()
Message-ID: <Pine.LNX.4.64.0612181447001.6439@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-14.495, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_SORBS_DUL 2.05, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Replace kmalloc() + memset() pairs with the appropriate kzalloc()
calls.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  i could have sworn i submitted this patch a while back but it
doesn't seem to have been applied.  it's possible it's still in the
queue somewhere but it seems unlikely at this point.


 ac97_codec.c    |    3 --
 ad1889.c        |    3 --
 btaudio.c       |    3 --
 cs46xx.c        |    9 ++----
 dac3550a.c      |    3 --
 es1371.c        |    3 --
 hal2.c          |    3 --
 i810_audio.c    |    9 ++----
 kahlua.c        |    3 --
 main.c          |   11 ++------
 nec_vrc5477.c   |    3 --
 opl3.c          |    3 --
 sb_card.c       |    6 +---
 swarm_cs4297a.c |   13 +++-------
 tas3001c.c      |    3 --
 tas3004.c       |    3 --
 tas_common.c    |    3 --
 trident.c       |    9 ++----
 waveartist.c    |    4 ---
 19 files changed, 32 insertions(+), 65 deletions(-)

diff --git a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
index 602db49..fef56ca 100644
--- a/sound/oss/ac97_codec.c
+++ b/sound/oss/ac97_codec.c
@@ -744,11 +744,10 @@ static int ac97_check_modem(struct ac97_

 struct ac97_codec *ac97_alloc_codec(void)
 {
-	struct ac97_codec *codec = kmalloc(sizeof(struct ac97_codec), GFP_KERNEL);
+	struct ac97_codec *codec = kzalloc(sizeof(struct ac97_codec), GFP_KERNEL);
 	if(!codec)
 		return NULL;

-	memset(codec, 0, sizeof(*codec));
 	spin_lock_init(&codec->lock);
 	INIT_LIST_HEAD(&codec->list);
 	return codec;
diff --git a/sound/oss/ad1889.c b/sound/oss/ad1889.c
index 09263d7..75ffacd 100644
--- a/sound/oss/ad1889.c
+++ b/sound/oss/ad1889.c
@@ -230,9 +230,8 @@ static ad1889_dev_t *ad1889_alloc_dev(st
 	struct dmabuf *dmabuf;
 	int i;

-	if ((dev = kmalloc(sizeof(ad1889_dev_t), GFP_KERNEL)) == NULL)
+	if ((dev = kzalloc(sizeof(ad1889_dev_t), GFP_KERNEL)) == NULL)
 		return NULL;
-	memset(dev, 0, sizeof(ad1889_dev_t));
 	spin_lock_init(&dev->lock);
 	dev->pci = pci;

diff --git a/sound/oss/btaudio.c b/sound/oss/btaudio.c
index ad7210a..ca9ccf6 100644
--- a/sound/oss/btaudio.c
+++ b/sound/oss/btaudio.c
@@ -915,12 +915,11 @@ static int __devinit btaudio_probe(struc
 		return -EBUSY;
 	}

-	bta = kmalloc(sizeof(*bta),GFP_ATOMIC);
+	bta = kzalloc(sizeof(*bta),GFP_ATOMIC);
 	if (!bta) {
 		rc = -ENOMEM;
 		goto fail0;
 	}
-	memset(bta,0,sizeof(*bta));

 	bta->pci  = pci_dev;
 	bta->irq  = pci_dev->irq;
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index 147c8a9..2a1f0d9 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -3048,10 +3048,9 @@ static int cs_open(struct inode *inode,
 		CS_DBGOUT(CS_WAVE_READ, 2, printk("cs46xx: cs_open() FMODE_READ\n") );
 		if (card->states[0] == NULL) {
 			state = card->states[0] =
-				kmalloc(sizeof(struct cs_state), GFP_KERNEL);
+				kzalloc(sizeof(struct cs_state), GFP_KERNEL);
 			if (state == NULL)
 				return -ENOMEM;
-			memset(state, 0, sizeof(struct cs_state));
 			mutex_init(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
@@ -3114,10 +3113,9 @@ static int cs_open(struct inode *inode,
 		CS_DBGOUT(CS_OPEN, 2, printk("cs46xx: cs_open() FMODE_WRITE\n") );
 		if (card->states[1] == NULL) {
 			state = card->states[1] =
-				kmalloc(sizeof(struct cs_state), GFP_KERNEL);
+				kzalloc(sizeof(struct cs_state), GFP_KERNEL);
 			if (state == NULL)
 				return -ENOMEM;
-			memset(state, 0, sizeof(struct cs_state));
 			mutex_init(&state->sem);
 			dmabuf = &state->dmabuf;
 			dmabuf->pbuf = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
@@ -5075,11 +5073,10 @@ static int __devinit cs46xx_probe(struct
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &ss_vendor);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &ss_card);

-	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "cs46xx: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 	card->ba0_addr = RSRCADDRESS(pci_dev, 0);
 	card->ba1_addr = RSRCADDRESS(pci_dev, 1);
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/dmasound/dac3550a.c b/sound/oss/dmasound/dac3550a.c
index 7360d89..0f0d03a 100644
--- a/sound/oss/dmasound/dac3550a.c
+++ b/sound/oss/dmasound/dac3550a.c
@@ -163,10 +163,9 @@ static int daca_detect_client(struct i2c
 	struct i2c_client *new_client;
 	int rc = -ENODEV;

-	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
 	if (!new_client)
 		return -ENOMEM;
-	memset(new_client, 0, sizeof(*new_client));

 	new_client->addr = address;
 	new_client->adapter = adapter;
diff --git a/sound/oss/dmasound/tas3001c.c b/sound/oss/dmasound/tas3001c.c
index f227c9f..4aa25b7 100644
--- a/sound/oss/dmasound/tas3001c.c
+++ b/sound/oss/dmasound/tas3001c.c
@@ -807,10 +807,9 @@ tas3001c_init(struct i2c_client *client)
 	size_t sz = sizeof(*self) + (TAS3001C_REG_MAX*sizeof(tas_shadow_t));
 	int i, j;

-	self = kmalloc(sz, GFP_KERNEL);
+	self = kzalloc(sz, GFP_KERNEL);
 	if (!self)
 		return -ENOMEM;
-	memset(self, 0, sz);

 	self->super.client = client;
 	self->super.shadow = (tas_shadow_t *)(self+1);
diff --git a/sound/oss/dmasound/tas3004.c b/sound/oss/dmasound/tas3004.c
index 82eaaca..7101a29 100644
--- a/sound/oss/dmasound/tas3004.c
+++ b/sound/oss/dmasound/tas3004.c
@@ -1093,10 +1093,9 @@ tas3004_init(struct i2c_client *client)
 	char mcr2 = 0;
 	int i, j;

-	self = kmalloc(sz, GFP_KERNEL);
+	self = kzalloc(sz, GFP_KERNEL);
 	if (!self)
 		return -ENOMEM;
-	memset(self, 0, sz);

 	self->super.client = client;
 	self->super.shadow = (tas_shadow_t *)(self+1);
diff --git a/sound/oss/dmasound/tas_common.c b/sound/oss/dmasound/tas_common.c
index 882ae98..665e85b 100644
--- a/sound/oss/dmasound/tas_common.c
+++ b/sound/oss/dmasound/tas_common.c
@@ -135,10 +135,9 @@ tas_detect_client(struct i2c_adapter *ad
 		return -ENODEV;
 	}

-	new_client = kmalloc(sizeof(*new_client), GFP_KERNEL);
+	new_client = kzalloc(sizeof(*new_client), GFP_KERNEL);
 	if (!new_client)
 		return -ENOMEM;
-	memset(new_client, 0, sizeof(*new_client));

 	new_client->addr = address;
 	new_client->adapter = adapter;
diff --git a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
index 6c59df7..16ac025 100644
--- a/sound/oss/emu10k1/main.c
+++ b/sound/oss/emu10k1/main.c
@@ -455,15 +455,13 @@ static int __devinit emu10k1_midi_init(s
 {
 	int ret;

-	card->mpuout = kmalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL);
+	card->mpuout = kzalloc(sizeof(struct emu10k1_mpuout), GFP_KERNEL);
 	if (card->mpuout == NULL) {
 		printk(KERN_WARNING "emu10k1: Unable to allocate emu10k1_mpuout: out of memory\n");
 		ret = -ENOMEM;
 		goto err_out1;
 	}

-	memset(card->mpuout, 0, sizeof(struct emu10k1_mpuout));
-
 	card->mpuout->intr = 1;
 	card->mpuout->status = FLAGS_AVAILABLE;
 	card->mpuout->state = CARDMIDIOUT_STATE_DEFAULT;
@@ -472,15 +470,13 @@ static int __devinit emu10k1_midi_init(s

 	spin_lock_init(&card->mpuout->lock);

-	card->mpuin = kmalloc(sizeof(struct emu10k1_mpuin), GFP_KERNEL);
+	card->mpuin = kzalloc(sizeof(struct emu10k1_mpuin), GFP_KERNEL);
 	if (card->mpuin == NULL) {
 		printk(KERN_WARNING "emu10k1: Unable to allocate emu10k1_mpuin: out of memory\n");
 		ret = -ENOMEM;
                 goto err_out2;
 	}

-	memset(card->mpuin, 0, sizeof(struct emu10k1_mpuin));
-
 	card->mpuin->status = FLAGS_AVAILABLE;

 	tasklet_init(&card->mpuin->tasklet, emu10k1_mpuin_bh, (unsigned long) card->mpuin);
@@ -1280,11 +1276,10 @@ static int __devinit emu10k1_probe(struc

 	pci_set_master(pci_dev);

-	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
                 printk(KERN_ERR "emu10k1: out of memory\n");
                 return -ENOMEM;
         }
-        memset(card, 0, sizeof(struct emu10k1_card));

 	card->iobase = pci_resource_start(pci_dev, 0);
 	card->length = pci_resource_len(pci_dev, 0);
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index cc282a0..88daae0 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -2870,11 +2870,10 @@ static int __devinit es1371_probe(struct
 		printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
 		printk(KERN_WARNING PFX "out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct es1371_state));

 	s->codec = ac97_alloc_codec();
 	if(s->codec == NULL)
diff --git a/sound/oss/hal2.c b/sound/oss/hal2.c
index 784bdd7..8647c40 100644
--- a/sound/oss/hal2.c
+++ b/sound/oss/hal2.c
@@ -1435,10 +1435,9 @@ static int hal2_init_card(struct hal2_ca
 	int ret = 0;
 	struct hal2_card *hal2;

-	hal2 = kmalloc(sizeof(struct hal2_card), GFP_KERNEL);
+	hal2 = kzalloc(sizeof(struct hal2_card), GFP_KERNEL);
 	if (!hal2)
 		return -ENOMEM;
-	memset(hal2, 0, sizeof(struct hal2_card));

 	hal2->ctl_regs = (struct hal2_ctl_regs *)hpc3->pbus_extregs[0];
 	hal2->aes_regs = (struct hal2_aes_regs *)hpc3->pbus_extregs[1];
diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index c3c8a72..f5e31f1 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -2580,10 +2580,9 @@ static int i810_open(struct inode *inode
 		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+					kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 				if (state == NULL)
 					return -ENOMEM;
-				memset(state, 0, sizeof(struct i810_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -3205,10 +3204,9 @@ static void __devinit i810_configure_clo
 	 */
 	if(card != NULL) {
 		state = card->states[0] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+					kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 		if (state == NULL)
 			return;
-		memset(state, 0, sizeof(struct i810_state));
 		dmabuf = &state->dmabuf;

 		dmabuf->write_channel = card->alloc_pcm_channel(card);
@@ -3273,11 +3271,10 @@ static int __devinit i810_probe(struct p
 		return -ENODEV;
 	}

-	if ((card = kmalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "i810_audio: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));

 	card->initializing = 1;
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/kahlua.c b/sound/oss/kahlua.c
index 12e7b30..dfe670f 100644
--- a/sound/oss/kahlua.c
+++ b/sound/oss/kahlua.c
@@ -139,13 +139,12 @@ static int __devinit probe_one(struct pc
 	printk(KERN_INFO "kahlua: XpressAudio on IRQ %d, DMA %d, %d\n",
 		irq, dma8, dma16);

-	hw_config = kmalloc(sizeof(struct address_info), GFP_KERNEL);
+	hw_config = kzalloc(sizeof(struct address_info), GFP_KERNEL);
 	if(hw_config == NULL)
 	{
 		printk(KERN_ERR "kahlua: out of memory.\n");
 		return 1;
 	}
-	memset(hw_config, 0, sizeof(*hw_config));

 	pci_set_drvdata(pdev, hw_config);

diff --git a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
index da9728e..89e0338 100644
--- a/sound/oss/nec_vrc5477.c
+++ b/sound/oss/nec_vrc5477.c
@@ -1860,11 +1860,10 @@ #endif
 	if (pcidev->irq == 0)
 		return -1;

-	if (!(s = kmalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL))) {
 		printk(KERN_ERR PFX "alloc of device struct failed\n");
 		return -1;
 	}
-	memset(s, 0, sizeof(struct vrc5477_ac97_state));

 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/opl3.c b/sound/oss/opl3.c
index 4799bc7..8196b93 100644
--- a/sound/oss/opl3.c
+++ b/sound/oss/opl3.c
@@ -166,7 +166,7 @@ int opl3_detect(int ioaddr, int *osp)
 		return 0;
 	}

-	devc = kmalloc(sizeof(*devc), GFP_KERNEL);
+	devc = kzalloc(sizeof(*devc), GFP_KERNEL);

 	if (devc == NULL)
 	{
@@ -175,7 +175,6 @@ int opl3_detect(int ioaddr, int *osp)
 		return 0;
 	}

-	memset(devc, 0, sizeof(*devc));
 	strcpy(devc->fm_info.name, "OPL2");

 	if (!request_region(ioaddr, 4, devc->fm_info.name)) {
diff --git a/sound/oss/sb_card.c b/sound/oss/sb_card.c
index 8666291..27acd6f 100644
--- a/sound/oss/sb_card.c
+++ b/sound/oss/sb_card.c
@@ -137,11 +137,10 @@ static int __init sb_init_legacy(void)
 {
 	struct sb_module_options sbmo = {0};

-	if((legacy = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	if((legacy = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(legacy, 0, sizeof(struct sb_card_config));

 	legacy->conf.io_base      = io;
 	legacy->conf.irq          = irq;
@@ -247,11 +246,10 @@ static int sb_pnp_probe(struct pnp_card_
 		return -EBUSY;
 	}

-	if((scc = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	if((scc = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(scc, 0, sizeof(struct sb_card_config));

 	printk(KERN_INFO "sb: PnP: Found Card Named = \"%s\", Card PnP id = " \
 	       "%s, Device PnP id = %s\n", card->card->name, card_id->id,
diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
index 471c274..87c1d54 100644
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -615,25 +615,23 @@ static int init_serdma(serdma_t *dma)

         /* Descriptors */
         dma->ringsz = DMA_DESCR;
-        dma->descrtab = kmalloc(dma->ringsz * sizeof(serdma_descr_t), GFP_KERNEL);
+        dma->descrtab = kzalloc(dma->ringsz * sizeof(serdma_descr_t), GFP_KERNEL);
         if (!dma->descrtab) {
-                printk(KERN_ERR "cs4297a: kmalloc descrtab failed\n");
+                printk(KERN_ERR "cs4297a: kzalloc descrtab failed\n");
                 return -1;
         }
-        memset(dma->descrtab, 0, dma->ringsz * sizeof(serdma_descr_t));
         dma->descrtab_end = dma->descrtab + dma->ringsz;
 	/* XXX bloddy mess, use proper DMA API here ...  */
 	dma->descrtab_phys = CPHYSADDR((long)dma->descrtab);
         dma->descr_add = dma->descr_rem = dma->descrtab;

         /* Frame buffer area */
-        dma->dma_buf = kmalloc(DMA_BUF_SIZE, GFP_KERNEL);
+        dma->dma_buf = kzalloc(DMA_BUF_SIZE, GFP_KERNEL);
         if (!dma->dma_buf) {
-                printk(KERN_ERR "cs4297a: kmalloc dma_buf failed\n");
+                printk(KERN_ERR "cs4297a: kzalloc dma_buf failed\n");
                 kfree(dma->descrtab);
                 return -1;
         }
-        memset(dma->dma_buf, 0, DMA_BUF_SIZE);
         dma->dma_buf_phys = CPHYSADDR((long)dma->dma_buf);

         /* Samples buffer area */
@@ -2618,12 +2616,11 @@ #ifndef CONFIG_BCM_CS4297A_CSWARM
         udelay(100);
 #endif

-	if (!(s = kmalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
+	if (!(s = kzalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
 		      "cs4297a: probe() no memory for state struct.\n"));
 		return -1;
 	}
-	memset(s, 0, sizeof(struct cs4297a_state));
         s->magic = CS4297a_MAGIC;
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/trident.c b/sound/oss/trident.c
index 6b1f8c9..72a8a0e 100644
--- a/sound/oss/trident.c
+++ b/sound/oss/trident.c
@@ -2729,12 +2729,11 @@ trident_open(struct inode *inode, struct
 		}
 		for (i = 0; i < NR_HW_CH; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+				state = card->states[i] = kzalloc(sizeof(*state), GFP_KERNEL);
 				if (state == NULL) {
 					mutex_unlock(&card->open_mutex);
 					return -ENOMEM;
 				}
-				memset(state, 0, sizeof(*state));
 				mutex_init(&state->sem);
 				dmabuf = &state->dmabuf;
 				goto found_virt;
@@ -3618,7 +3617,7 @@ ali_allocate_other_states_resources(stru
 			}
 			return -EBUSY;
 		}
-		s = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+		s = card->states[i] = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!s) {
 			num = ali_multi_channels_5_1[state_count];
 			ali_free_pcm_channel(card, num);
@@ -3630,7 +3629,6 @@ ali_allocate_other_states_resources(stru
 			}
 			return -ENOMEM;
 		}
-		memset(s, 0, sizeof(*state));

 		s->dmabuf.channel = channel;
 		s->dmabuf.ossfragshift = s->dmabuf.ossmaxfrags =
@@ -4399,11 +4397,10 @@ trident_probe(struct pci_dev *pci_dev, c
 	}

 	rc = -ENOMEM;
-	if ((card = kmalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
+	if ((card = kzalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "trident: out of memory\n");
 		goto out_release_region;
 	}
-	memset(card, 0, sizeof (*card));

 	init_timer(&card->timer);
 	card->iobase = iobase;
diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index c5bf363..da08e03 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1267,12 +1267,10 @@ static int __init waveartist_init(wavnc_
 	conf_printf2(dev_name, devc->hw.io_base, devc->hw.irq,
 		     devc->hw.dma, devc->hw.dma2);

-	portc = kmalloc(sizeof(wavnc_port_info), GFP_KERNEL);
+	portc = kzalloc(sizeof(wavnc_port_info), GFP_KERNEL);
 	if (portc == NULL)
 		goto nomem;

-	memset(portc, 0, sizeof(wavnc_port_info));
-
 	my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION, dev_name,
 			&waveartist_audio_driver, sizeof(struct audio_driver),
 			devc->audio_flags, AFMT_U8 | AFMT_S16_LE | AFMT_S8,
