Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWGUNsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWGUNsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 09:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWGUNsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 09:48:36 -0400
Received: from outmx005.isp.belgacom.be ([195.238.4.102]:10662 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750733AbWGUNsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 09:48:35 -0400
Date: Fri, 21 Jul 2006 15:49:19 +0200
To: linux-kernel@vger.kernel.org
Cc: James@superbug.demon.co.uk, emu10k1-devel@lists.sourceforge.net,
       perex@suse.cz, alsa-devel@alsa-project.org
Subject: [PATCH 2/4] sound: Removing useless casts
Message-ID: <20060721134919.GB27097@issaris.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: takis@issaris.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Removing useless casts

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
 sound/core/oss/mixer_oss.c       |    2 +-
 sound/oss/gus_wave.c             |    2 +-
 sound/oss/midibuf.c              |    4 ++--
 sound/oss/msnd.c                 |    2 +-
 sound/oss/pss.c                  |    6 +++---
 sound/oss/sequencer.c            |    4 ++--
 sound/oss/sscape.c               |    2 +-
 sound/pci/emu10k1/emu10k1_main.c |    4 ++--
 8 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 75a9505..bb30fe6 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1023,7 +1023,7 @@ static int snd_mixer_oss_build_input(str
 	}
 	up_read(&mixer->card->controls_rwsem);
 	if (slot.present != 0) {
-		pslot = (struct slot *)kmalloc(sizeof(slot), GFP_KERNEL);
+		pslot = kmalloc(sizeof(slot), GFP_KERNEL);
 		if (! pslot)
 			return -ENOMEM;
 		*pslot = slot;
diff --git a/sound/oss/gus_wave.c b/sound/oss/gus_wave.c
index 942d518..73665ff 100644
--- a/sound/oss/gus_wave.c
+++ b/sound/oss/gus_wave.c
@@ -3026,7 +3026,7 @@ #endif
 			 (int) gus_mem_size / 1024);
 
 
-	samples = (struct patch_info *)vmalloc((MAX_SAMPLE + 1) * sizeof(*samples));
+	samples = vmalloc((MAX_SAMPLE + 1) * sizeof(*samples));
 	if (samples == NULL)
 	{
 		printk(KERN_WARNING "gus_init: Cant allocate memory for instrument tables\n");
diff --git a/sound/oss/midibuf.c b/sound/oss/midibuf.c
index 6982556..1795105 100644
--- a/sound/oss/midibuf.c
+++ b/sound/oss/midibuf.c
@@ -177,7 +177,7 @@ int MIDIbuf_open(int dev, struct file *f
 		return err;
 
 	parms[dev].prech_timeout = MAX_SCHEDULE_TIMEOUT;
-	midi_in_buf[dev] = (struct midi_buf *) vmalloc(sizeof(struct midi_buf));
+	midi_in_buf[dev] = vmalloc(sizeof(struct midi_buf));
 
 	if (midi_in_buf[dev] == NULL)
 	{
@@ -187,7 +187,7 @@ int MIDIbuf_open(int dev, struct file *f
 	}
 	midi_in_buf[dev]->len = midi_in_buf[dev]->head = midi_in_buf[dev]->tail = 0;
 
-	midi_out_buf[dev] = (struct midi_buf *) vmalloc(sizeof(struct midi_buf));
+	midi_out_buf[dev] = vmalloc(sizeof(struct midi_buf));
 
 	if (midi_out_buf[dev] == NULL)
 	{
diff --git a/sound/oss/msnd.c b/sound/oss/msnd.c
index ba38d62..5dde7b1 100644
--- a/sound/oss/msnd.c
+++ b/sound/oss/msnd.c
@@ -102,7 +102,7 @@ void msnd_fifo_free(msnd_fifo *f)
 int msnd_fifo_alloc(msnd_fifo *f, size_t n)
 {
 	msnd_fifo_free(f);
-	f->data = (char *)vmalloc(n);
+	f->data = vmalloc(n);
 	f->n = n;
 	f->tail = 0;
 	f->head = 0;
diff --git a/sound/oss/pss.c b/sound/oss/pss.c
index 37ee234..b453233 100644
--- a/sound/oss/pss.c
+++ b/sound/oss/pss.c
@@ -872,7 +872,7 @@ static int pss_coproc_ioctl(void *dev_in
 			return 0;
 
 		case SNDCTL_COPR_LOAD:
-			buf = (copr_buffer *) vmalloc(sizeof(copr_buffer));
+			buf = vmalloc(sizeof(*buf));
 			if (buf == NULL)
 				return -ENOSPC;
 			if (copy_from_user(buf, arg, sizeof(copr_buffer))) {
@@ -884,7 +884,7 @@ static int pss_coproc_ioctl(void *dev_in
 			return err;
 		
 		case SNDCTL_COPR_SENDMSG:
-			mbuf = (copr_msg *)vmalloc(sizeof(copr_msg));
+			mbuf = vmalloc(sizeof(copr_msg));
 			if (mbuf == NULL)
 				return -ENOSPC;
 			if (copy_from_user(mbuf, arg, sizeof(copr_msg))) {
@@ -908,7 +908,7 @@ static int pss_coproc_ioctl(void *dev_in
 
 		case SNDCTL_COPR_RCVMSG:
 			err = 0;
-			mbuf = (copr_msg *)vmalloc(sizeof(copr_msg));
+			mbuf = vmalloc(sizeof(copr_msg));
 			if (mbuf == NULL)
 				return -ENOSPC;
 			data = (unsigned short *)mbuf->data;
diff --git a/sound/oss/sequencer.c b/sound/oss/sequencer.c
index 6815c30..f9a5083 100644
--- a/sound/oss/sequencer.c
+++ b/sound/oss/sequencer.c
@@ -1653,13 +1653,13 @@ void sequencer_init(void)
 	if (sequencer_ok)
 		return;
 	MIDIbuf_init();
-	queue = (unsigned char *)vmalloc(SEQ_MAX_QUEUE * EV_SZ);
+	queue = vmalloc(SEQ_MAX_QUEUE * EV_SZ);
 	if (queue == NULL)
 	{
 		printk(KERN_ERR "sequencer: Can't allocate memory for sequencer output queue\n");
 		return;
 	}
-	iqueue = (unsigned char *)vmalloc(SEQ_MAX_QUEUE * IEV_SZ);
+	iqueue = vmalloc(SEQ_MAX_QUEUE * IEV_SZ);
 	if (iqueue == NULL)
 	{
 		printk(KERN_ERR "sequencer: Can't allocate memory for sequencer input queue\n");
diff --git a/sound/oss/sscape.c b/sound/oss/sscape.c
index 9ed5211..92afbad 100644
--- a/sound/oss/sscape.c
+++ b/sound/oss/sscape.c
@@ -572,7 +572,7 @@ static int sscape_coproc_ioctl(void *dev
 			return 0;
 
 		case SNDCTL_COPR_LOAD:
-			buf = (copr_buffer *) vmalloc(sizeof(copr_buffer));
+			buf = vmalloc(sizeof(*buf));
 			if (buf == NULL)
 				return -ENOSPC;
 			if (copy_from_user(buf, arg, sizeof(copr_buffer))) 
diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index f9b5c3d..623cbde 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -1246,8 +1246,8 @@ int __devinit snd_emu10k1_create(struct 
 		goto error;
 	}
 
-	emu->page_ptr_table = (void **)vmalloc(emu->max_cache_pages * sizeof(void*));
-	emu->page_addr_table = (unsigned long*)vmalloc(emu->max_cache_pages * sizeof(unsigned long));
+	emu->page_ptr_table = vmalloc(emu->max_cache_pages * sizeof(void*));
+	emu->page_addr_table = vmalloc(emu->max_cache_pages * sizeof(unsigned long));
 	if (emu->page_ptr_table == NULL || emu->page_addr_table == NULL) {
 		err = -ENOMEM;
 		goto error;
-- 
1.4.2.rc1.ge7a0-dirty

