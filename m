Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbUJXNpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbUJXNpm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbUJXNpl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:45:41 -0400
Received: from verein.lst.de ([213.95.11.210]:36774 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261485AbUJXNgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:36:42 -0400
Date: Sun, 24 Oct 2004 15:36:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove dead exports in sounds/oss
Message-ID: <20041024133637.GA20149@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.11/sound/oss/aci.c	2004-07-26 20:06:53 +02:00
+++ edited/sound/oss/aci.c	2004-10-23 14:06:02 +02:00
@@ -62,11 +62,10 @@
 #include "sound_config.h"
 
 int aci_port;	/* as determined by bit 4 in the OPTi 929 MC4 register */
-int aci_idcode[2];	/* manufacturer and product ID */
+static int aci_idcode[2];	/* manufacturer and product ID */
 int aci_version;	/* ACI firmware version	*/
 
 EXPORT_SYMBOL(aci_port);
-EXPORT_SYMBOL(aci_idcode);
 EXPORT_SYMBOL(aci_version);
 
 #include "aci.h"
===== sound/oss/aci.h 1.3 vs edited =====
--- 1.3/sound/oss/aci.h	2002-02-11 03:50:17 +01:00
+++ edited/sound/oss/aci.h	2004-10-23 14:05:50 +02:00
@@ -2,7 +2,6 @@
 #define _ACI_H_
 
 extern int aci_port;
-extern int aci_idcode[2];	/* manufacturer and product ID */
 extern int aci_version;		/* ACI firmware version	*/
 extern int aci_rw_cmd(int write1, int write2, int write3);
 
===== sound/oss/audio.c 1.7 vs edited =====
--- 1.7/sound/oss/audio.c	2004-05-29 11:13:03 +02:00
+++ edited/sound/oss/audio.c	2004-10-23 14:34:38 +02:00
@@ -38,7 +38,7 @@
 #define NEUTRAL16	0x00
 
 
-int             dma_ioctl(int dev, unsigned int cmd, void __user *arg);
+static int             dma_ioctl(int dev, unsigned int cmd, void __user *arg);
 
 static int set_format(int dev, int fmt)
 {
@@ -735,7 +735,7 @@
 	return bytes | ((count - 1) << 16);
 }
 
-int dma_ioctl(int dev, unsigned int cmd, void __user *arg)
+static int dma_ioctl(int dev, unsigned int cmd, void __user *arg)
 {
 	struct dma_buffparms *dmap_out = audio_devs[dev]->dmap_out;
 	struct dma_buffparms *dmap_in = audio_devs[dev]->dmap_in;
===== sound/oss/audio_syms.c 1.3 vs edited =====
--- 1.3/sound/oss/audio_syms.c	2003-03-14 01:52:26 +01:00
+++ edited/sound/oss/audio_syms.c	2004-10-23 14:34:40 +02:00
@@ -14,6 +14,3 @@
 EXPORT_SYMBOL(DMAbuf_close_dma);
 EXPORT_SYMBOL(DMAbuf_inputintr);
 EXPORT_SYMBOL(DMAbuf_outputintr);
-EXPORT_SYMBOL(dma_ioctl);
-EXPORT_SYMBOL(audio_open);
-EXPORT_SYMBOL(audio_release);
===== sound/oss/dev_table.c 1.3 vs edited =====
--- 1.3/sound/oss/dev_table.c	2003-05-25 02:00:00 +02:00
+++ edited/sound/oss/dev_table.c	2004-10-23 13:49:17 +02:00
@@ -16,6 +16,8 @@
 #define _DEV_TABLE_C_
 #include "sound_config.h"
 
+static int sound_alloc_audiodev(void);
+
 int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
 			int driver_size, int flags, unsigned int format_mask,
 			void *devc, int dma1, int dma2)
@@ -121,7 +123,7 @@
 	}
 }
 
-int sound_alloc_audiodev(void)
+static int sound_alloc_audiodev(void)
 { 
 	int i = register_sound_dsp(&oss_sound_fops, -1);
 	if(i==-1)
===== sound/oss/dev_table.h 1.6 vs edited =====
--- 1.6/sound/oss/dev_table.h	2004-05-29 11:13:04 +02:00
+++ edited/sound/oss/dev_table.h	2004-10-23 13:49:06 +02:00
@@ -397,7 +397,6 @@
 void sound_unload_mididev(int dev);
 void sound_unload_synthdev(int dev);
 void sound_unload_timerdev(int dev);
-int sound_alloc_audiodev(void);
 int sound_alloc_mixerdev(void);
 int sound_alloc_timerdev(void);
 int sound_alloc_synthdev(void);
===== sound/oss/msnd.c 1.10 vs edited =====
--- 1.10/sound/oss/msnd.c	2004-08-26 03:59:03 +02:00
+++ edited/sound/oss/msnd.c	2004-10-23 14:23:51 +02:00
@@ -79,25 +79,6 @@
 	--num_devs;
 }
 
-int msnd_get_num_devs(void)
-{
-	return num_devs;
-}
-
-multisound_dev_t *msnd_get_dev(int j)
-{
-	int i;
-
-	for (i = 0; i < MSND_MAX_DEVS && j; ++i)
-		if (devs[i] != NULL)
-			--j;
-
-	if (i == MSND_MAX_DEVS || j != 0)
-		return NULL;
-
-	return devs[i];
-}
-
 void msnd_init_queue(unsigned long base, int start, int size)
 {
 	isa_writew(PCTODSP_BASED(start), base + JQS_wStart);
@@ -201,7 +182,7 @@
 	return count;
 }
 
-int msnd_wait_TXDE(multisound_dev_t *dev)
+static int msnd_wait_TXDE(multisound_dev_t *dev)
 {
 	register unsigned int io = dev->io;
 	register int timeout = 1000;
@@ -213,7 +194,7 @@
 	return -EIO;
 }
 
-int msnd_wait_HC0(multisound_dev_t *dev)
+static int msnd_wait_HC0(multisound_dev_t *dev)
 {
 	register unsigned int io = dev->io;
 	register int timeout = 1000;
@@ -338,7 +319,6 @@
 EXPORT_SYMBOL(msnd_register);
 EXPORT_SYMBOL(msnd_unregister);
 EXPORT_SYMBOL(msnd_get_num_devs);
-EXPORT_SYMBOL(msnd_get_dev);
 
 EXPORT_SYMBOL(msnd_init_queue);
 
@@ -349,8 +329,6 @@
 EXPORT_SYMBOL(msnd_fifo_write);
 EXPORT_SYMBOL(msnd_fifo_read);
 
-EXPORT_SYMBOL(msnd_wait_TXDE);
-EXPORT_SYMBOL(msnd_wait_HC0);
 EXPORT_SYMBOL(msnd_send_dsp_cmd);
 EXPORT_SYMBOL(msnd_send_word);
 EXPORT_SYMBOL(msnd_upload_host);
===== sound/oss/msnd.h 1.4 vs edited =====
--- 1.4/sound/oss/msnd.h	2004-08-26 03:59:10 +02:00
+++ edited/sound/oss/msnd.h	2004-10-23 14:23:42 +02:00
@@ -258,8 +258,6 @@
 
 int				msnd_register(multisound_dev_t *dev);
 void				msnd_unregister(multisound_dev_t *dev);
-int				msnd_get_num_devs(void);
-multisound_dev_t *		msnd_get_dev(int i);
 
 void				msnd_init_queue(unsigned long, int start, int size);
 
@@ -270,8 +268,6 @@
 int				msnd_fifo_write(msnd_fifo *f, const char *buf, size_t len);
 int				msnd_fifo_read(msnd_fifo *f, char *buf, size_t len);
 
-int				msnd_wait_TXDE(multisound_dev_t *dev);
-int				msnd_wait_HC0(multisound_dev_t *dev);
 int				msnd_send_dsp_cmd(multisound_dev_t *dev, BYTE cmd);
 int				msnd_send_word(multisound_dev_t *dev, unsigned char high,
 					       unsigned char mid, unsigned char low);
===== sound/oss/sound_calls.h 1.3 vs edited =====
--- 1.3/sound/oss/sound_calls.h	2004-05-29 11:13:04 +02:00
+++ edited/sound/oss/sound_calls.h	2004-10-23 14:34:42 +02:00
@@ -39,7 +39,6 @@
 	   unsigned int cmd, void __user *arg);
 void audio_init_devices (void);
 void reorganize_buffers (int dev, struct dma_buffparms *dmap, int recording);
-int dma_ioctl (int dev, unsigned int cmd, void __user *arg);
 
 /*
  *	System calls for the /dev/sequencer
===== sound/oss/sound_syms.c 1.2 vs edited =====
--- 1.2/sound/oss/sound_syms.c	2002-02-11 03:50:15 +01:00
+++ edited/sound/oss/sound_syms.c	2004-10-23 14:26:53 +02:00
@@ -22,10 +22,8 @@
 EXPORT_SYMBOL(midi_devs);
 EXPORT_SYMBOL(num_midis);
 EXPORT_SYMBOL(synth_devs);
-EXPORT_SYMBOL(num_synths);
 
 EXPORT_SYMBOL(sound_timer_devs);
-EXPORT_SYMBOL(num_sound_timers);
 
 EXPORT_SYMBOL(sound_install_audiodrv);
 EXPORT_SYMBOL(sound_install_mixer);
@@ -33,7 +31,6 @@
 EXPORT_SYMBOL(sound_free_dma);
 EXPORT_SYMBOL(sound_open_dma);
 EXPORT_SYMBOL(sound_close_dma);
-EXPORT_SYMBOL(sound_alloc_audiodev);
 EXPORT_SYMBOL(sound_alloc_mididev);
 EXPORT_SYMBOL(sound_alloc_mixerdev);
 EXPORT_SYMBOL(sound_alloc_timerdev);
