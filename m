Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWGTS6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWGTS6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 14:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWGTS6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 14:58:16 -0400
Received: from student.uhasselt.be ([193.190.2.1]:61707 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S964794AbWGTS6P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 14:58:15 -0400
Date: Thu, 20 Jul 2006 20:58:12 +0200
To: linux-kernel@vger.kernel.org
Cc: kyle@parisc-linux.org, James@superbug.demon.co.uk, zab@zabbo.net,
       sailer@ife.ee.ethz.ch, perex@suse.cz, muli@il.ibm.com
Subject: [PATCH] sound/oss: Conversions from kmalloc+memset to k(c|z)alloc.
Message-ID: <20060720185812.GB7643@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Changes in sound/oss:
- Conversions from kmalloc+memset to k(c|z)alloc
- Kill useless type casts

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 sound/oss/ac97_codec.c          |    3 +--
 sound/oss/ad1848.c              |    4 ++--
 sound/oss/ad1889.c              |    4 ++--
 sound/oss/ali5455.c             |   11 ++++-------
 sound/oss/awe_wave.c            |    4 ++--
 sound/oss/btaudio.c             |    3 +--
 sound/oss/cs4232.c              |    2 +-
 sound/oss/cs4281/cs4281m.c      |    4 ++--
 sound/oss/cs46xx.c              |   10 ++++------
 sound/oss/dmasound/dac3550a.c   |    3 +--
 sound/oss/dmasound/tas3001c.c   |    3 +--
 sound/oss/dmasound/tas3004.c    |    3 +--
 sound/oss/dmasound/tas_common.c |    3 +--
 sound/oss/emu10k1/audio.c       |    8 +++++---
 sound/oss/emu10k1/cardmi.c      |    3 ++-
 sound/oss/emu10k1/cardmo.c      |    3 ++-
 sound/oss/emu10k1/main.c        |   16 +++++-----------
 sound/oss/emu10k1/midi.c        |   15 ++++++++++-----
 sound/oss/emu10k1/mixer.c       |    2 +-
 sound/oss/es1370.c              |    4 ++--
 sound/oss/es1371.c              |    4 ++--
 sound/oss/esssolo1.c            |    4 ++--
 sound/oss/hal2.c                |    3 +--
 sound/oss/i810_audio.c          |   13 +++++--------
 sound/oss/ite8172.c             |    4 ++--
 sound/oss/kahlua.c              |    3 +--
 sound/oss/maestro.c             |    3 ++-
 sound/oss/maestro3.c            |    4 ++--
 sound/oss/mpu401.c              |    2 +-
 sound/oss/nec_vrc5477.c         |    4 ++--
 sound/oss/opl3.c                |    2 +-
 sound/oss/rme96xx.c             |    4 ++--
 sound/oss/sb_card.c             |    8 ++++----
 sound/oss/sb_common.c           |    2 +-
 sound/oss/sb_midi.c             |    4 ++--
 sound/oss/sb_mixer.c            |    2 +-
 sound/oss/sonicvibes.c          |    7 ++++---
 sound/oss/swarm_cs4297a.c       |   14 ++++++--------
 sound/oss/trident.c             |   10 ++++------
 sound/oss/v_midi.c              |    2 +-
 sound/oss/waveartist.c          |    4 +---
 sound/oss/ymfpci.c              |    9 ++++-----
 42 files changed, 101 insertions(+), 119 deletions(-)

diff --git a/sound/oss/ac97_codec.c b/sound/oss/ac97_codec.c
index 972327c..a233f0a 100644
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
diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 3b45e11..0b13f1e 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -1991,8 +1991,8 @@ int ad1848_init (char *name, struct reso
 			devc->audio_flags |= DMA_DUPLEX;
 	}
 
-	portc = (ad1848_port_info *) kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
-	if(portc==NULL) {
+	portc = kmalloc(sizeof(ad1848_port_info), GFP_KERNEL);
+	if (!portc) {
 		release_region(devc->base, 4);
 		return -1;
 	}
diff --git a/sound/oss/ad1889.c b/sound/oss/ad1889.c
index f56f870..d0b8b86 100644
--- a/sound/oss/ad1889.c
+++ b/sound/oss/ad1889.c
@@ -230,9 +230,9 @@ static ad1889_dev_t *ad1889_alloc_dev(st
 	struct dmabuf *dmabuf;
 	int i;
 
-	if ((dev = kmalloc(sizeof(ad1889_dev_t), GFP_KERNEL)) == NULL) 
+	dev = kzalloc(sizeof(ad1889_dev_t), GFP_KERNEL);
+	if (!dev)
 		return NULL;
-	memset(dev, 0, sizeof(ad1889_dev_t));
 	spin_lock_init(&dev->lock);
 	dev->pci = pci;
 
diff --git a/sound/oss/ali5455.c b/sound/oss/ali5455.c
index 70dcd70..a43c4e8 100644
--- a/sound/oss/ali5455.c
+++ b/sound/oss/ali5455.c
@@ -2788,10 +2788,9 @@ static int ali_open(struct inode *inode,
 
 		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = (struct ali_state *) kmalloc(sizeof(struct ali_state), GFP_KERNEL);
+				state = card->states[i] = kzalloc(sizeof(struct ali_state), GFP_KERNEL);
 				if (state == NULL)
 					return -ENOMEM;
-				memset(state, 0, sizeof(struct ali_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -3350,11 +3349,9 @@ static void __devinit ali_configure_cloc
 	 * is a waste of time.
 	 */
 	if (card != NULL) {
-		state = card->states[0] = (struct ali_state *)
-		    kmalloc(sizeof(struct ali_state), GFP_KERNEL);
+		state = card->states[0] = kzalloc(sizeof(struct ali_state), GFP_KERNEL);
 		if (state == NULL)
 			return;
-		memset(state, 0, sizeof(struct ali_state));
 		dmabuf = &state->dmabuf;
 		dmabuf->write_channel = card->alloc_pcm_channel(card);
 		state->virt = 0;
@@ -3416,11 +3413,11 @@ static int __devinit ali_probe(struct pc
 		return -ENODEV;
 	}
 
-	if ((card = kmalloc(sizeof(struct ali_card), GFP_KERNEL)) == NULL) {
+	card = kzalloc(sizeof(struct ali_card), GFP_KERNEL);
+	if (!card) {
 		printk(KERN_ERR "ali_audio: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 	card->initializing = 1;
 	card->iobase = pci_resource_start(pci_dev, 0);
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/awe_wave.c b/sound/oss/awe_wave.c
index d1a0eb2..0210bc6 100644
--- a/sound/oss/awe_wave.c
+++ b/sound/oss/awe_wave.c
@@ -2746,7 +2746,7 @@ awe_create_sf(int type, char *name)
 
 	/* terminate sounds */
 	awe_reset(0);
-	rec = (sf_list *)kmalloc(sizeof(*rec), GFP_KERNEL);
+	rec = kmalloc(sizeof(*rec), GFP_KERNEL);
 	if (rec == NULL)
 		return 1; /* no memory */
 	rec->sf_id = current_sf_id + 1;
@@ -2958,7 +2958,7 @@ alloc_new_sample(void)
 {
 	awe_sample_list *newlist;
 	
-	newlist = (awe_sample_list *)kmalloc(sizeof(*newlist), GFP_KERNEL);
+	newlist = kmalloc(sizeof(*newlist), GFP_KERNEL);
 	if (newlist == NULL) {
 		printk(KERN_ERR "AWE32: can't alloc sample table\n");
 		return NULL;
diff --git a/sound/oss/btaudio.c b/sound/oss/btaudio.c
index 324a81f..5418934 100644
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
diff --git a/sound/oss/cs4232.c b/sound/oss/cs4232.c
index b6924c7..de40e21 100644
--- a/sound/oss/cs4232.c
+++ b/sound/oss/cs4232.c
@@ -408,7 +408,7 @@ static int __init cs4232_pnp_probe(struc
 {
 	struct address_info *isapnpcfg;
 
-	isapnpcfg=(struct address_info*)kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);
+	isapnpcfg = kmalloc(sizeof(*isapnpcfg),GFP_KERNEL);
 	if (!isapnpcfg)
 		return -ENOMEM;
 
diff --git a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
index 0400a41..5b4b8c8 100644
--- a/sound/oss/cs4281/cs4281m.c
+++ b/sound/oss/cs4281/cs4281m.c
@@ -4287,12 +4287,12 @@ static int __devinit cs4281_probe(struct
 		      "cs4281: probe() architecture does not support 32bit PCI busmaster DMA\n"));
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct cs4281_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct cs4281_state), GFP_KERNEL);
+	if (!s) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
 		      "cs4281: probe() no memory for state struct.\n"));
 		return -1;
 	}
-	memset(s, 0, sizeof(struct cs4281_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
index 5195bf9..34922a0 100644
--- a/sound/oss/cs46xx.c
+++ b/sound/oss/cs46xx.c
@@ -3044,10 +3044,9 @@ static int cs_open(struct inode *inode, 
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
@@ -3110,10 +3109,9 @@ static int cs_open(struct inode *inode, 
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
@@ -5071,11 +5069,11 @@ static int __devinit cs46xx_probe(struct
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &ss_vendor);
 	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &ss_card);
 
-	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
+	card = kzalloc(sizeof(struct cs_card), GFP_KERNEL);
+	if (!card) {
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
diff --git a/sound/oss/emu10k1/audio.c b/sound/oss/emu10k1/audio.c
index cde4d59..36de393 100644
--- a/sound/oss/emu10k1/audio.c
+++ b/sound/oss/emu10k1/audio.c
@@ -1132,7 +1132,7 @@ static int emu10k1_audio_open(struct ino
 
 match:
 
-	wave_dev = (struct emu10k1_wavedevice *) kmalloc(sizeof(struct emu10k1_wavedevice), GFP_KERNEL);
+	wave_dev = kmalloc(sizeof(struct emu10k1_wavedevice), GFP_KERNEL);
 
 	if (wave_dev == NULL) { 
 		ERROR();
@@ -1148,7 +1148,8 @@ match:
 		/* Recording */
 		struct wiinst *wiinst;
 
-		if ((wiinst = (struct wiinst *) kmalloc(sizeof(struct wiinst), GFP_KERNEL)) == NULL) {
+		wiinst = kmalloc(sizeof(struct wiinst), GFP_KERNEL);
+		if (!wiinst) {
 			ERROR();
 			kfree(wave_dev);
 			return -ENOMEM;
@@ -1204,7 +1205,8 @@ match:
 		struct woinst *woinst;
 		int i;
 
-		if ((woinst = (struct woinst *) kmalloc(sizeof(struct woinst), GFP_KERNEL)) == NULL) {
+		woinst = kmalloc(sizeof(struct woinst), GFP_KERNEL);
+		if (!woinst) {
 			ERROR();
 			kfree(wave_dev);
 			return -ENOMEM;
diff --git a/sound/oss/emu10k1/cardmi.c b/sound/oss/emu10k1/cardmi.c
index 0545814..1d2d4d5 100644
--- a/sound/oss/emu10k1/cardmi.c
+++ b/sound/oss/emu10k1/cardmi.c
@@ -157,7 +157,8 @@ int emu10k1_mpuin_add_buffer(struct emu1
 	midihdr->flags |= MIDIBUF_INQUEUE;	/* set */
 	midihdr->flags &= ~MIDIBUF_DONE;	/* clear */
 
-	if ((midiq = (struct midi_queue *) kmalloc(sizeof(struct midi_queue), GFP_ATOMIC)) == NULL) {
+	midiq = kmalloc(sizeof(struct midi_queue), GFP_ATOMIC);
+	if (!midiq) {
 		/* Message lost */
 		return -1;
 	}
diff --git a/sound/oss/emu10k1/cardmo.c b/sound/oss/emu10k1/cardmo.c
index 5938d31..dec0cfb 100644
--- a/sound/oss/emu10k1/cardmo.c
+++ b/sound/oss/emu10k1/cardmo.c
@@ -117,7 +117,8 @@ int emu10k1_mpuout_add_buffer(struct emu
 	midihdr->flags |= MIDIBUF_INQUEUE;
 	midihdr->flags &= ~MIDIBUF_DONE;
 
-	if ((midiq = (struct midi_queue *) kmalloc(sizeof(struct midi_queue), GFP_KERNEL)) == NULL) {
+	midiq = kmalloc(sizeof(struct midi_queue), GFP_KERNEL);
+	if (!midiq) {
 		/* Message lost */
 		return -1;
 	}
diff --git a/sound/oss/emu10k1/main.c b/sound/oss/emu10k1/main.c
index c4ce94d..5a102de 100644
--- a/sound/oss/emu10k1/main.c
+++ b/sound/oss/emu10k1/main.c
@@ -262,9 +262,7 @@ #ifdef EMU10K1_SEQUENCER
 		printk(KERN_WARNING "emu10k1: unable to register sequencer device!");
 	else {
 		std_midi_synth.midi_dev = card->seq_dev;
-		midi_devs[card->seq_dev] = 
-			(struct midi_operations *)
-			kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
+		midi_devs[card->seq_dev] = kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
 
 		if (midi_devs[card->seq_dev] == NULL) {
 			printk(KERN_ERR "emu10k1: unable to allocate memory!");
@@ -455,15 +453,13 @@ static int __devinit emu10k1_midi_init(s
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
@@ -472,15 +468,13 @@ static int __devinit emu10k1_midi_init(s
 
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
@@ -1280,11 +1274,11 @@ static int __devinit emu10k1_probe(struc
 
 	pci_set_master(pci_dev);
 
-	if ((card = kmalloc(sizeof(struct emu10k1_card), GFP_KERNEL)) == NULL) {
+	card = kzalloc(sizeof(struct emu10k1_card), GFP_KERNEL);
+	if (!card) {
                 printk(KERN_ERR "emu10k1: out of memory\n");
                 return -ENOMEM;
         }
-        memset(card, 0, sizeof(struct emu10k1_card));
 
 	card->iobase = pci_resource_start(pci_dev, 0);
 	card->length = pci_resource_len(pci_dev, 0); 
diff --git a/sound/oss/emu10k1/midi.c b/sound/oss/emu10k1/midi.c
index 8ac77df..1a1dd58 100644
--- a/sound/oss/emu10k1/midi.c
+++ b/sound/oss/emu10k1/midi.c
@@ -58,7 +58,8 @@ static int midiin_add_buffer(struct emu1
 {
 	struct midi_hdr *midihdr;
 
-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr), GFP_KERNEL)) == NULL) {
+	midihdr = kmalloc(sizeof(struct midi_hdr), GFP_KERNEL);
+	if (!midihdr) {
 		ERROR();
 		return -EINVAL;
 	}
@@ -128,7 +129,8 @@ #endif
 		mutex_lock(&card->open_sem);
 	}
 
-	if ((midi_dev = (struct emu10k1_mididevice *) kmalloc(sizeof(*midi_dev), GFP_KERNEL)) == NULL)
+	midi_dev = kmalloc(sizeof(*midi_dev), GFP_KERNEL);
+	if (!midi_dev)
 		return -EINVAL;
 
 	midi_dev->card = card;
@@ -328,7 +330,8 @@ static ssize_t emu10k1_midi_write(struct
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
 
-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr), GFP_KERNEL)) == NULL)
+	midihdr = kmalloc(sizeof(struct midi_hdr), GFP_KERNEL);
+	if (!midihdr)
 		return -EINVAL;
 
 	midihdr->bufferlength = count;
@@ -490,7 +493,8 @@ int emu10k1_seq_midi_open(int dev, int m
 			
 	DPF(2, "emu10k1_seq_midi_open()\n");
 	
-	if ((midi_dev = (struct emu10k1_mididevice *) kmalloc(sizeof(*midi_dev), GFP_KERNEL)) == NULL)
+	midi_dev = kmalloc(sizeof(*midi_dev), GFP_KERNEL);
+	if (!midi_dev)
 		return -EINVAL;
 
 	midi_dev->card = card;
@@ -540,7 +544,8 @@ int emu10k1_seq_midi_out(int dev, unsign
 
 	card = midi_devs[dev]->devc;
 
-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr), GFP_KERNEL)) == NULL)
+	midihdr = kmalloc(sizeof(struct midi_hdr), GFP_KERNEL);
+	if (!midihdr)
 		return -EINVAL;
 
 	midihdr->bufferlength = 1;
diff --git a/sound/oss/emu10k1/mixer.c b/sound/oss/emu10k1/mixer.c
index cbcaaa3..6419796 100644
--- a/sound/oss/emu10k1/mixer.c
+++ b/sound/oss/emu10k1/mixer.c
@@ -194,7 +194,7 @@ static int emu10k1_private_mixer(struct 
 
 	case SOUND_MIXER_PRIVATE3:
 
-		ctl = (struct mixer_private_ioctl *) kmalloc(sizeof(struct mixer_private_ioctl), GFP_KERNEL);
+		ctl = kmalloc(sizeof(struct mixer_private_ioctl), GFP_KERNEL);
 		if (ctl == NULL)
 			return -ENOMEM;
 
diff --git a/sound/oss/es1370.c b/sound/oss/es1370.c
index 13f4831..57b19ff 100644
--- a/sound/oss/es1370.c
+++ b/sound/oss/es1370.c
@@ -2628,11 +2628,11 @@ static int __devinit es1370_probe(struct
 		printk(KERN_WARNING "es1370: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct es1370_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct es1370_state), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_WARNING "es1370: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct es1370_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac1.wait);
 	init_waitqueue_head(&s->dma_dac2.wait);
diff --git a/sound/oss/es1371.c b/sound/oss/es1371.c
index a2ffe72..2a25f00 100644
--- a/sound/oss/es1371.c
+++ b/sound/oss/es1371.c
@@ -2869,11 +2869,11 @@ static int __devinit es1371_probe(struct
 		printk(KERN_WARNING "es1371: architecture does not support 32bit PCI busmaster DMA\n");
 		return i;
 	}
-	if (!(s = kmalloc(sizeof(struct es1371_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct es1371_state), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_WARNING PFX "out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct es1371_state));
 	
 	s->codec = ac97_alloc_codec();
 	if(s->codec == NULL)
diff --git a/sound/oss/esssolo1.c b/sound/oss/esssolo1.c
index 82f40a0..423b9de 100644
--- a/sound/oss/esssolo1.c
+++ b/sound/oss/esssolo1.c
@@ -2354,11 +2354,11 @@ static int __devinit solo1_probe(struct 
 		return -ENODEV;
 	}
 
-	if (!(s = kmalloc(sizeof(struct solo1_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct solo1_state), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_WARNING "solo1: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct solo1_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/hal2.c b/sound/oss/hal2.c
index 80ab402..a84ee1d 100644
--- a/sound/oss/hal2.c
+++ b/sound/oss/hal2.c
@@ -1435,10 +1435,9 @@ static int hal2_init_card(struct hal2_ca
 	int ret = 0;
 	struct hal2_card *hal2;
 
-	hal2 = (struct hal2_card *) kmalloc(sizeof(struct hal2_card), GFP_KERNEL);
+	hal2 = kzalloc(sizeof(struct hal2_card), GFP_KERNEL);
 	if (!hal2)
 		return -ENOMEM;
-	memset(hal2, 0, sizeof(struct hal2_card));
 
 	hal2->ctl_regs = (struct hal2_ctl_regs *)hpc3->pbus_extregs[0];
 	hal2->aes_regs = (struct hal2_aes_regs *)hpc3->pbus_extregs[1];
diff --git a/sound/oss/i810_audio.c b/sound/oss/i810_audio.c
index ddcddc2..2ee7a16 100644
--- a/sound/oss/i810_audio.c
+++ b/sound/oss/i810_audio.c
@@ -2578,11 +2578,10 @@ static int i810_open(struct inode *inode
 		}
 		for (i = 0; i < NR_HW_CH && card && !card->initializing; i++) {
 			if (card->states[i] == NULL) {
-				state = card->states[i] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+				state = card->states[i] = 
+					kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 				if (state == NULL)
 					return -ENOMEM;
-				memset(state, 0, sizeof(struct i810_state));
 				dmabuf = &state->dmabuf;
 				goto found_virt;
 			}
@@ -3203,11 +3202,9 @@ static void __devinit i810_configure_clo
 	 * is a waste of time.
 	 */
 	if(card != NULL) {
-		state = card->states[0] = (struct i810_state *)
-					kmalloc(sizeof(struct i810_state), GFP_KERNEL);
+		state = card->states[0] = kzalloc(sizeof(struct i810_state), GFP_KERNEL);
 		if (state == NULL)
 			return;
-		memset(state, 0, sizeof(struct i810_state));
 		dmabuf = &state->dmabuf;
 
 		dmabuf->write_channel = card->alloc_pcm_channel(card);
@@ -3272,11 +3269,11 @@ static int __devinit i810_probe(struct p
 		return -ENODEV;
 	}
 	
-	if ((card = kmalloc(sizeof(struct i810_card), GFP_KERNEL)) == NULL) {
+	card = kzalloc(sizeof(struct i810_card), GFP_KERNEL);
+	if (!card) {
 		printk(KERN_ERR "i810_audio: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(card, 0, sizeof(*card));
 
 	card->initializing = 1;
 	card->pci_dev = pci_dev;
diff --git a/sound/oss/ite8172.c b/sound/oss/ite8172.c
index 68aab36..616d18d 100644
--- a/sound/oss/ite8172.c
+++ b/sound/oss/ite8172.c
@@ -1990,12 +1990,12 @@ static int __devinit it8172_probe(struct
 	if (pcidev->irq == 0) 
 		return -1;
 
-	if (!(s = kmalloc(sizeof(struct it8172_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct it8172_state), GFP_KERNEL);
+	if (!s) {
 		err("alloc of device struct failed");
 		return -1;
 	}
 	
-	memset(s, 0, sizeof(struct it8172_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
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
 	
diff --git a/sound/oss/maestro.c b/sound/oss/maestro.c
index 1d98d10..e439d52 100644
--- a/sound/oss/maestro.c
+++ b/sound/oss/maestro.c
@@ -2279,7 +2279,8 @@ ess_read(struct file *file, char __user 
 		return ret;
 	if (!access_ok(VERIFY_WRITE, buffer, count))
 		return -EFAULT;
-	if(!(combbuf = kmalloc(count,GFP_KERNEL)))
+	combbuf = kmalloc(count,GFP_KERNEL);
+	if(!combbuf)
 		return -ENOMEM;
 	ret = 0;
 
diff --git a/sound/oss/maestro3.c b/sound/oss/maestro3.c
index 5548e3c..82e2bf9 100644
--- a/sound/oss/maestro3.c
+++ b/sound/oss/maestro3.c
@@ -2610,11 +2610,11 @@ static int __devinit m3_probe(struct pci
         
     pci_set_master(pci_dev);
 
-    if( (card = kmalloc(sizeof(struct m3_card), GFP_KERNEL)) == NULL) {
+    card = kzalloc(sizeof(struct m3_card), GFP_KERNEL);
+    if(!card) {
         printk(KERN_WARNING PFX "out of memory\n");
         return -ENOMEM;
     }
-    memset(card, 0, sizeof(struct m3_card));
     card->pcidev = pci_dev;
     init_waitqueue_head(&card->suspend_queue);
 
diff --git a/sound/oss/mpu401.c b/sound/oss/mpu401.c
index 0aac54c..af1fed2 100644
--- a/sound/oss/mpu401.c
+++ b/sound/oss/mpu401.c
@@ -1032,7 +1032,7 @@ int attach_mpu401(struct address_info *h
 				devc->capabilities |= MPU_CAP_INTLG;	/* Supports intelligent mode */
 
 
-	mpu401_synth_operations[m] = (struct synth_operations *)kmalloc(sizeof(struct synth_operations), GFP_KERNEL);
+	mpu401_synth_operations[m] = kmalloc(sizeof(struct synth_operations), GFP_KERNEL);
 
 	if (mpu401_synth_operations[m] == NULL)
 	{
diff --git a/sound/oss/nec_vrc5477.c b/sound/oss/nec_vrc5477.c
index 6f7f2f0..81e5a76 100644
--- a/sound/oss/nec_vrc5477.c
+++ b/sound/oss/nec_vrc5477.c
@@ -1860,11 +1860,11 @@ #endif
 	if (pcidev->irq == 0) 
 		return -1;
 
-	if (!(s = kmalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct vrc5477_ac97_state), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_ERR PFX "alloc of device struct failed\n");
 		return -1;
 	}
-	memset(s, 0, sizeof(struct vrc5477_ac97_state));
 
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/opl3.c b/sound/oss/opl3.c
index a31734b..7612fe4 100644
--- a/sound/oss/opl3.c
+++ b/sound/oss/opl3.c
@@ -166,7 +166,7 @@ int opl3_detect(int ioaddr, int *osp)
 		return 0;
 	}
 
-	devc = (struct opl_devinfo *)kmalloc(sizeof(*devc), GFP_KERNEL);
+	devc = kmalloc(sizeof(*devc), GFP_KERNEL);
 
 	if (devc == NULL)
 	{
diff --git a/sound/oss/rme96xx.c b/sound/oss/rme96xx.c
index f17d25b..e6908df 100644
--- a/sound/oss/rme96xx.c
+++ b/sound/oss/rme96xx.c
@@ -980,11 +980,11 @@ static int __devinit rme96xx_probe(struc
 		printk(KERN_WARNING RME_MESS" architecture does not support 32bit PCI busmaster DMA\n");
 		return -1;
 	}
-	if (!(s = kmalloc(sizeof(rme96xx_info), GFP_KERNEL))) {
+	s = kzalloc(sizeof(rme96xx_info), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_WARNING RME_MESS" out of memory\n");
 		return -1;
 	}
-	memset(s, 0, sizeof(rme96xx_info));
 
 	s->pcidev = pcidev;
 	s->iobase = ioremap(pci_resource_start(pcidev, 0),RME96xx_IO_EXTENT);
diff --git a/sound/oss/sb_card.c b/sound/oss/sb_card.c
index 8666291..e8828a5 100644
--- a/sound/oss/sb_card.c
+++ b/sound/oss/sb_card.c
@@ -137,11 +137,11 @@ static int __init sb_init_legacy(void)
 {
 	struct sb_module_options sbmo = {0};
 
-	if((legacy = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	legacy = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL);
+	if (!legacy) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(legacy, 0, sizeof(struct sb_card_config));
 
 	legacy->conf.io_base      = io;
 	legacy->conf.irq          = irq;
@@ -247,11 +247,11 @@ static int sb_pnp_probe(struct pnp_card_
 		return -EBUSY;
 	}
 
-	if((scc = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
+	scc = kzalloc(sizeof(struct sb_card_config), GFP_KERNEL);
+	if (!scc) {
 		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(scc, 0, sizeof(struct sb_card_config));
 
 	printk(KERN_INFO "sb: PnP: Found Card Named = \"%s\", Card PnP id = " \
 	       "%s, Device PnP id = %s\n", card->card->name, card_id->id,
diff --git a/sound/oss/sb_common.c b/sound/oss/sb_common.c
index 35bab6e..d2a5a13 100644
--- a/sound/oss/sb_common.c
+++ b/sound/oss/sb_common.c
@@ -625,7 +625,7 @@ #endif
 	 */
 
 
-	detected_devc = (sb_devc *)kmalloc(sizeof(sb_devc), GFP_KERNEL);
+	detected_devc = kmalloc(sizeof(sb_devc), GFP_KERNEL);
 	if (detected_devc == NULL)
 	{
 		printk(KERN_ERR "sb: Can't allocate memory for device information\n");
diff --git a/sound/oss/sb_midi.c b/sound/oss/sb_midi.c
index ed3bd06..7585723 100644
--- a/sound/oss/sb_midi.c
+++ b/sound/oss/sb_midi.c
@@ -173,7 +173,7 @@ void sb_dsp_midi_init(sb_devc * devc, st
 		return;
 	}
 	std_midi_synth.midi_dev = devc->my_mididev = dev;
-	midi_devs[dev] = (struct midi_operations *)kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
+	midi_devs[dev] = kmalloc(sizeof(struct midi_operations), GFP_KERNEL);
 	if (midi_devs[dev] == NULL)
 	{
 		printk(KERN_WARNING "Sound Blaster:  failed to allocate MIDI memory.\n");
@@ -189,7 +189,7 @@ void sb_dsp_midi_init(sb_devc * devc, st
 	midi_devs[dev]->devc = devc;
 
 
-	midi_devs[dev]->converter = (struct synth_operations *)kmalloc(sizeof(struct synth_operations), GFP_KERNEL);
+	midi_devs[dev]->converter = kmalloc(sizeof(struct synth_operations), GFP_KERNEL);
 	if (midi_devs[dev]->converter == NULL)
 	{
 		  printk(KERN_WARNING "Sound Blaster:  failed to allocate MIDI memory.\n");
diff --git a/sound/oss/sb_mixer.c b/sound/oss/sb_mixer.c
index ccb21d4..ec07ea1 100644
--- a/sound/oss/sb_mixer.c
+++ b/sound/oss/sb_mixer.c
@@ -734,7 +734,7 @@ int sb_mixer_init(sb_devc * devc, struct
 	if (m == -1)
 		return 0;
 
-	mixer_devs[m] = (struct mixer_operations *)kmalloc(sizeof(struct mixer_operations), GFP_KERNEL);
+	mixer_devs[m] = kmalloc(sizeof(struct mixer_operations), GFP_KERNEL);
 	if (mixer_devs[m] == NULL)
 	{
 		printk(KERN_ERR "sb_mixer: Can't allocate memory\n");
diff --git a/sound/oss/sonicvibes.c b/sound/oss/sonicvibes.c
index 8ea532d..036920a 100644
--- a/sound/oss/sonicvibes.c
+++ b/sound/oss/sonicvibes.c
@@ -2546,7 +2546,8 @@ static int __devinit sv_probe(struct pci
 		pcidev->resource[RESOURCE_DDMA].end = 2*SV_EXTENT_DMA-1;
 		pcidev->resource[RESOURCE_DDMA].flags = PCI_BASE_ADDRESS_SPACE_IO | IORESOURCE_IO;
 		ddmanamelen = strlen(sv_ddma_name)+1;
-		if (!(ddmaname = kmalloc(ddmanamelen, GFP_KERNEL)))
+		ddmaname = kmalloc(ddmanamelen, GFP_KERNEL);
+		if (!ddmaname)
 			return -1;
 		memcpy(ddmaname, sv_ddma_name, ddmanamelen);
 		pcidev->resource[RESOURCE_DDMA].name = ddmaname;
@@ -2557,11 +2558,11 @@ static int __devinit sv_probe(struct pci
 			return -EBUSY;
 		}
 	}
-	if (!(s = kmalloc(sizeof(struct sv_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct sv_state), GFP_KERNEL);
+	if (!s) {
 		printk(KERN_WARNING "sv: out of memory\n");
 		return -ENOMEM;
 	}
-	memset(s, 0, sizeof(struct sv_state));
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
 	init_waitqueue_head(&s->open_wait);
diff --git a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
index eb5ea32..9da5032 100644
--- a/sound/oss/swarm_cs4297a.c
+++ b/sound/oss/swarm_cs4297a.c
@@ -615,25 +615,23 @@ static int init_serdma(serdma_t *dma)
 
         /* Descriptors */
         dma->ringsz = DMA_DESCR;
-        dma->descrtab = kmalloc(dma->ringsz * sizeof(serdma_descr_t), GFP_KERNEL);
+        dma->descrtab = kcalloc(dma->ringsz, sizeof(serdma_descr_t), GFP_KERNEL);
         if (!dma->descrtab) {
-                printk(KERN_ERR "cs4297a: kmalloc descrtab failed\n");
+                printk(KERN_ERR "cs4297a: kcalloc descrtab failed\n");
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
@@ -2618,12 +2616,12 @@ #ifndef CONFIG_BCM_CS4297A_CSWARM
         udelay(100);
 #endif
 
-	if (!(s = kmalloc(sizeof(struct cs4297a_state), GFP_KERNEL))) {
+	s = kzalloc(sizeof(struct cs4297a_state), GFP_KERNEL);
+	if (!s) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR
 		      "cs4297a: probe() no memory for state struct.\n"));
 		return -1;
 	}
-	memset(s, 0, sizeof(struct cs4297a_state));
         s->magic = CS4297a_MAGIC;
 	init_waitqueue_head(&s->dma_adc.wait);
 	init_waitqueue_head(&s->dma_dac.wait);
diff --git a/sound/oss/trident.c b/sound/oss/trident.c
index 2813e4c..3264a5b 100644
--- a/sound/oss/trident.c
+++ b/sound/oss/trident.c
@@ -2739,12 +2739,11 @@ trident_open(struct inode *inode, struct
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
@@ -3616,7 +3615,7 @@ ali_allocate_other_states_resources(stru
 			}
 			return -EBUSY;
 		}
-		s = card->states[i] = kmalloc(sizeof(*state), GFP_KERNEL);
+		s = card->states[i] = kzalloc(sizeof(*state), GFP_KERNEL);
 		if (!s) {
 			num = ali_multi_channels_5_1[state_count];
 			ali_free_pcm_channel(card, num);
@@ -3628,7 +3627,6 @@ ali_allocate_other_states_resources(stru
 			}
 			return -ENOMEM;
 		}
-		memset(s, 0, sizeof(*state));
 
 		s->dmabuf.channel = channel;
 		s->dmabuf.ossfragshift = s->dmabuf.ossmaxfrags =
@@ -4387,11 +4385,11 @@ trident_probe(struct pci_dev *pci_dev, c
 	}
 
 	rc = -ENOMEM;
-	if ((card = kmalloc(sizeof(*card), GFP_KERNEL)) == NULL) {
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card) {
 		printk(KERN_ERR "trident: out of memory\n");
 		goto out_release_region;
 	}
-	memset(card, 0, sizeof (*card));
 
 	init_timer(&card->timer);
 	card->iobase = iobase;
diff --git a/sound/oss/v_midi.c b/sound/oss/v_midi.c
index a7ef04f..95016c9 100644
--- a/sound/oss/v_midi.c
+++ b/sound/oss/v_midi.c
@@ -183,7 +183,7 @@ static void __init attach_v_midi (struct
 		return;
 	}
 	
-	m=(struct vmidi_memory *)kmalloc(sizeof(struct vmidi_memory), GFP_KERNEL);
+	m = kmalloc(sizeof(struct vmidi_memory), GFP_KERNEL);
 	if (m == NULL)
 	{
 		printk(KERN_WARNING "Loopback MIDI: Failed to allocate memory\n");
diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index 22d2662..8cbaa0a 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -1267,12 +1267,10 @@ static int __init waveartist_init(wavnc_
 	conf_printf2(dev_name, devc->hw.io_base, devc->hw.irq,
 		     devc->hw.dma, devc->hw.dma2);
 
-	portc = (wavnc_port_info *)kmalloc(sizeof(wavnc_port_info), GFP_KERNEL);
+	portc = kzalloc(sizeof(wavnc_port_info), GFP_KERNEL);
 	if (portc == NULL)
 		goto nomem;
 
-	memset(portc, 0, sizeof(wavnc_port_info));
-
 	my_dev = sound_install_audiodrv(AUDIO_DRIVER_VERSION, dev_name,
 			&waveartist_audio_driver, sizeof(struct audio_driver),
 			devc->audio_flags, AFMT_U8 | AFMT_S16_LE | AFMT_S8,
diff --git a/sound/oss/ymfpci.c b/sound/oss/ymfpci.c
index 6e22472..fc0eaee 100644
--- a/sound/oss/ymfpci.c
+++ b/sound/oss/ymfpci.c
@@ -1091,10 +1091,9 @@ static struct ymf_state *ymf_state_alloc
 	struct ymf_pcm *ypcm;
 	struct ymf_state *state;
 
-	if ((state = kmalloc(sizeof(struct ymf_state), GFP_KERNEL)) == NULL) {
+	state = kzalloc(sizeof(struct ymf_state), GFP_KERNEL);
+	if (!state)
 		goto out0;
-	}
-	memset(state, 0, sizeof(struct ymf_state));
 
 	ypcm = &state->wpcm;
 	ypcm->state = state;
@@ -2523,11 +2522,11 @@ static int __devinit ymf_probe_one(struc
 	}
 	base = pci_resource_start(pcidev, 0);
 
-	if ((codec = kmalloc(sizeof(ymfpci_t), GFP_KERNEL)) == NULL) {
+	codec = kzalloc(sizeof(ymfpci_t), GFP_KERNEL);
+	if (!codec) {
 		printk(KERN_ERR "ymfpci: no core\n");
 		return -ENOMEM;
 	}
-	memset(codec, 0, sizeof(*codec));
 
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
-- 
1.4.2.rc1.ge7a0-dirty

