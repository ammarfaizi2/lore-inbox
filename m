Return-Path: <linux-kernel-owner+w=401wt.eu-S1752731AbWLRDru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbWLRDru (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbWLRDqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:46:46 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4291 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752731AbWLRDqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:46:40 -0500
Date: Mon, 18 Dec 2006 04:46:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] sound/: possible cleanups
Message-ID: <20061218034639.GC10316@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- core/memory.c should #include <sound/core.h> for getting the
  prototypes of all of its global functions
- proper prototypes for the following functions:
  - core/init.c: snd_card_info_read_oss()
  - core/oss/mixer_oss.c: snd_mixer_oss_ioctl_card()
  - core/seq/seq_memory.c: snd_seq_info_pool()
  - sound/core/sgbuf.c: snd_free_sgbuf_pages()
  - sound/core/sgbuf.c: snd_malloc_sgbuf_pages()
  - isa/gus/gus_timer.c: snd_gf1_timers_init()
  - isa/gus/gus_timer.c: snd_gf1_timers_done()
- make the following needlessly global functions static:
  - core/device.c: snd_device_disconnect()
  - core/pcm_memory.c: snd_pcm_lib_preallocate_free()
  - core/pcm_native.c: snd_pcm_suspend()
  - core/pcm_native.c: snd_pcm_hw_constraints_init()
  - core/pcm_native.c: snd_pcm_hw_constraints_complete()
  - pci/ca0106/ca0106_main.c: snd_ca0106_spi_write()
  - pci/hda/hda_codec.c: snd_hda_query_supported_pcm()
  - pci/hda/hda_codec.c: snd_hda_is_supported_format()
- #if 0 the following unused global functions:
  - pci/ac97/ac97_codec.c: snd_ac97_remove_ctl()
  - pci/ac97/ac97_codec.c: snd_ac97_rename_ctl()
  - pci/ac97/ac97_codec.c: snd_ac97_swap_ctl()
  - pci/cs46xx/dsp_spos.c: cs46xx_dsp_set_iec958_volume()
  - pci/emu10k1/io.c: snd_emu10k1_voice_half_loop_intr_enable()
  - pci/emu10k1/io.c: snd_emu10k1_voice_set_loop_stop()
- remove the following unused EXPORT_SYMBOL's:
  - core/pcm_memory.c: snd_pcm_lib_preallocate_free_for_all
  - pci/ac97/ac97_codec.c: snd_ac97_update
  - pci/hda/hda_codec.c: snd_hda_codec_read
  - pci/hda/hda_codec.c: snd_hda_codec_write
  - pci/hda/hda_codec.c: snd_hda_sequence_write
  - pci/hda/hda_codec.c: snd_hda_get_sub_nodes
  - pci/hda/hda_codec.c: snd_hda_codec_setup_stream

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 5 Dec 2006

 Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl |    3 -
 include/sound/core.h                                         |    5 ++
 include/sound/emu10k1.h                                      |    2 -
 include/sound/gus.h                                          |    3 +
 include/sound/memalloc.h                                     |    5 ++
 include/sound/mixer_oss.h                                    |    3 +
 include/sound/pcm.h                                          |    7 ---
 sound/core/device.c                                          |    2 -
 sound/core/info_oss.c                                        |    2 -
 sound/core/memalloc.c                                        |   11 -----
 sound/core/memory.c                                          |    1 
 sound/core/oss/pcm_oss.c                                     |    2 -
 sound/core/pcm_memory.c                                      |    4 --
 sound/core/pcm_native.c                                      |    8 +---
 sound/core/seq/seq_clientmgr.c                               |    3 -
 sound/core/seq/seq_memory.h                                  |    2 +
 sound/isa/gus/gus_reset.c                                    |    5 --
 sound/pci/ac97/ac97_codec.c                                  |   11 +++--
 sound/pci/ac97/ac97_local.h                                  |    3 -
 sound/pci/ca0106/ca0106_main.c                               |    4 +-
 sound/pci/cs46xx/cs46xx_lib.h                                |    1 
 sound/pci/cs46xx/dsp_spos.c                                  |    2 +
 sound/pci/emu10k1/io.c                                       |    4 ++
 sound/pci/hda/hda_codec.c                                    |   19 ++--------
 sound/pci/hda/hda_codec.h                                    |    4 --
 25 files changed, 44 insertions(+), 72 deletions(-)

--- linux-2.6.19-rc6-mm2/sound/core/memory.c.old	2006-12-04 17:48:05.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/memory.c	2006-12-04 17:30:23.000000000 +0100
@@ -20,6 +20,7 @@
  *
  */
 
+#include <sound/core.h>
 #include <linux/module.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
--- linux-2.6.19-rc6-mm2/include/sound/gus.h.old	2006-12-04 17:33:13.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/gus.h	2006-12-04 17:34:22.000000000 +0100
@@ -661,6 +661,9 @@
 int snd_gus_dram_read(struct snd_gus_card *gus, char __user *ptr,
 		      unsigned int addr, unsigned int size, int rom);
 
+void snd_gf1_timers_init(struct snd_gus_card * gus);
+void snd_gf1_timers_done(struct snd_gus_card * gus);
+
 #if defined(CONFIG_SND_SEQUENCER) || defined(CONFIG_SND_SEQUENCER_MODULE)
 
 /* gus_sample.c */
--- linux-2.6.19-rc6-mm2/sound/isa/gus/gus_reset.c.old	2006-12-04 17:34:37.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/isa/gus/gus_reset.c	2006-12-04 17:35:00.000000000 +0100
@@ -25,11 +25,6 @@
 #include <sound/core.h>
 #include <sound/gus.h>
 
-extern void snd_gf1_timers_init(struct snd_gus_card * gus);
-extern void snd_gf1_timers_done(struct snd_gus_card * gus);
-extern int snd_gf1_synth_init(struct snd_gus_card * gus);
-extern void snd_gf1_synth_done(struct snd_gus_card * gus);
-
 /*
  *  ok.. default interrupt handlers...
  */
--- linux-2.6.19-rc6-mm2/include/sound/mixer_oss.h.old	2006-12-04 17:31:27.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/mixer_oss.h	2006-12-04 17:31:52.000000000 +0100
@@ -73,6 +73,9 @@
 	struct snd_mixer_oss *mixer;
 };
 
+int snd_mixer_oss_ioctl_card(struct snd_card *card, unsigned int cmd,
+			     unsigned long arg);
+
 #endif /* CONFIG_SND_MIXER_OSS */
 
 #endif /* __SOUND_MIXER_OSS_H */
--- linux-2.6.19-rc6-mm2/sound/core/oss/pcm_oss.c.old	2006-12-04 17:32:09.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/oss/pcm_oss.c	2006-12-04 17:53:34.000000000 +0100
@@ -42,6 +42,7 @@
 #include <sound/info.h>
 #include <linux/soundcard.h>
 #include <sound/initval.h>
+#include <sound/mixer_oss.h>
 
 #define OSS_ALSAEMULVER		_SIOR ('M', 249, int)
 
@@ -61,7 +62,6 @@
 MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM);
 MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_PCM1);
 
-extern int snd_mixer_oss_ioctl_card(struct snd_card *card, unsigned int cmd, unsigned long arg);
 static int snd_pcm_oss_get_rate(struct snd_pcm_oss_file *pcm_oss_file);
 static int snd_pcm_oss_get_channels(struct snd_pcm_oss_file *pcm_oss_file);
 static int snd_pcm_oss_get_format(struct snd_pcm_oss_file *pcm_oss_file);
--- linux-2.6.19-rc6-mm2/sound/core/seq/seq_memory.h.old	2006-12-04 17:23:50.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/seq/seq_memory.h	2006-12-04 17:24:56.000000000 +0100
@@ -99,5 +99,7 @@
 /* polling */
 int snd_seq_pool_poll_wait(struct snd_seq_pool *pool, struct file *file, poll_table *wait);
 
+void snd_seq_info_pool(struct snd_info_buffer *buffer,
+		       struct snd_seq_pool *pool, char *space);
 
 #endif
--- linux-2.6.19-rc6-mm2/sound/core/seq/seq_clientmgr.c.old	2006-12-04 17:24:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/seq/seq_clientmgr.c	2006-12-04 17:24:55.000000000 +0100
@@ -2487,9 +2487,6 @@
 }
 
 
-void snd_seq_info_pool(struct snd_info_buffer *buffer,
-		       struct snd_seq_pool *pool, char *space);
-
 /* exported to seq_info.c */
 void snd_seq_info_clients_read(struct snd_info_entry *entry, 
 			       struct snd_info_buffer *buffer)
--- linux-2.6.19-rc6-mm2/include/sound/memalloc.h.old	2006-12-04 17:26:03.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/memalloc.h	2006-12-04 17:27:28.000000000 +0100
@@ -114,5 +114,10 @@
 void *snd_malloc_pages(size_t size, gfp_t gfp_flags);
 void snd_free_pages(void *ptr, size_t size);
 
+int snd_free_sgbuf_pages(struct snd_dma_buffer *dmab);
+void *snd_malloc_sgbuf_pages(struct device *device,
+                             size_t size, struct snd_dma_buffer *dmab,
+			     size_t *res_size);
+
 #endif /* __SOUND_MEMALLOC_H */
 
--- linux-2.6.19-rc6-mm2/sound/core/memalloc.c.old	2006-12-04 17:26:51.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/memalloc.c	2006-12-04 17:27:33.000000000 +0100
@@ -42,17 +42,6 @@
 MODULE_LICENSE("GPL");
 
 
-/*
- */
-
-void *snd_malloc_sgbuf_pages(struct device *device,
-                             size_t size, struct snd_dma_buffer *dmab,
-			     size_t *res_size);
-int snd_free_sgbuf_pages(struct snd_dma_buffer *dmab);
-
-/*
- */
-
 static DEFINE_MUTEX(list_mutex);
 static LIST_HEAD(mem_list_head);
 
--- linux-2.6.19-rc6-mm2/sound/pci/hda/hda_codec.h.old	2006-12-04 17:03:15.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/hda/hda_codec.h	2006-12-04 17:03:23.000000000 +0100
@@ -614,10 +614,6 @@
 				int channel_id, int format);
 unsigned int snd_hda_calc_stream_format(unsigned int rate, unsigned int channels,
 					unsigned int format, unsigned int maxbps);
-int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
-				u32 *ratesp, u64 *formatsp, unsigned int *bpsp);
-int snd_hda_is_supported_format(struct hda_codec *codec, hda_nid_t nid,
-				unsigned int format);
 
 /*
  * Misc
--- linux-2.6.19-rc6-mm2/sound/pci/hda/hda_codec.c.old	2006-12-04 16:43:13.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/hda/hda_codec.c	2006-12-04 16:46:23.000000000 +0100
@@ -89,8 +89,6 @@
 	return res;
 }
 
-EXPORT_SYMBOL(snd_hda_codec_read);
-
 /**
  * snd_hda_codec_write - send a single command without waiting for response
  * @codec: the HDA codec
@@ -113,8 +111,6 @@
 	return err;
 }
 
-EXPORT_SYMBOL(snd_hda_codec_write);
-
 /**
  * snd_hda_sequence_write - sequence writes
  * @codec: the HDA codec
@@ -129,8 +125,6 @@
 		snd_hda_codec_write(codec, seq->nid, 0, seq->verb, seq->param);
 }
 
-EXPORT_SYMBOL(snd_hda_sequence_write);
-
 /**
  * snd_hda_get_sub_nodes - get the range of sub nodes
  * @codec: the HDA codec
@@ -149,8 +143,6 @@
 	return (int)(parm & 0x7fff);
 }
 
-EXPORT_SYMBOL(snd_hda_get_sub_nodes);
-
 /**
  * snd_hda_get_connections - get connection list
  * @codec: the HDA codec
@@ -627,8 +619,6 @@
 	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_STREAM_FORMAT, format);
 }
 
-EXPORT_SYMBOL(snd_hda_codec_setup_stream);
-
 /*
  * amp access functions
  */
@@ -1439,8 +1429,9 @@
  *
  * Returns 0 if successful, otherwise a negative error code.
  */
-int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
-				u32 *ratesp, u64 *formatsp, unsigned int *bpsp)
+static int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
+				       u32 *ratesp, u64 *formatsp,
+				       unsigned int *bpsp)
 {
 	int i;
 	unsigned int val, streams;
@@ -1532,8 +1523,8 @@
  *
  * Returns 1 if supported, 0 if not.
  */
-int snd_hda_is_supported_format(struct hda_codec *codec, hda_nid_t nid,
-				unsigned int format)
+static int snd_hda_is_supported_format(struct hda_codec *codec, hda_nid_t nid,
+				       unsigned int format)
 {
 	int i;
 	unsigned int val = 0, rate, stream;
--- linux-2.6.19-rc6-mm2/include/sound/emu10k1.h.old	2006-12-04 16:47:03.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/emu10k1.h	2006-12-04 16:47:53.000000000 +0100
@@ -1541,10 +1541,8 @@
 void snd_emu10k1_voice_intr_enable(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_disable(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_voice_intr_ack(struct snd_emu10k1 *emu, unsigned int voicenum);
-void snd_emu10k1_voice_half_loop_intr_enable(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_voice_half_loop_intr_disable(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_voice_half_loop_intr_ack(struct snd_emu10k1 *emu, unsigned int voicenum);
-void snd_emu10k1_voice_set_loop_stop(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_voice_clear_loop_stop(struct snd_emu10k1 *emu, unsigned int voicenum);
 void snd_emu10k1_wait(struct snd_emu10k1 *emu, unsigned int wait);
 static inline unsigned int snd_emu10k1_wc(struct snd_emu10k1 *emu) { return (inl(emu->port + WC) >> 6) & 0xfffff; }
--- linux-2.6.19-rc6-mm2/sound/pci/emu10k1/io.c.old	2006-12-04 16:47:11.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/emu10k1/io.c	2006-12-04 16:48:05.000000000 +0100
@@ -291,6 +291,7 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
+#if 0
 void snd_emu10k1_voice_half_loop_intr_enable(struct snd_emu10k1 *emu, unsigned int voicenum)
 {
 	unsigned long flags;
@@ -310,6 +311,7 @@
 	outl(val, emu->port + DATA);
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
+#endif  /*  0  */
 
 void snd_emu10k1_voice_half_loop_intr_disable(struct snd_emu10k1 *emu, unsigned int voicenum)
 {
@@ -348,6 +350,7 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
+#if 0
 void snd_emu10k1_voice_set_loop_stop(struct snd_emu10k1 *emu, unsigned int voicenum)
 {
 	unsigned long flags;
@@ -367,6 +370,7 @@
 	outl(sol, emu->port + DATA);
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
+#endif  /*  0  */
 
 void snd_emu10k1_voice_clear_loop_stop(struct snd_emu10k1 *emu, unsigned int voicenum)
 {
--- linux-2.6.19-rc6-mm2/sound/pci/cs46xx/cs46xx_lib.h.old	2006-12-04 16:49:09.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/cs46xx/cs46xx_lib.h	2006-12-04 16:49:18.000000000 +0100
@@ -199,5 +199,4 @@
 				       int period_size);
 int cs46xx_dsp_pcm_ostream_set_period (struct snd_cs46xx * chip, int period_size);
 int cs46xx_dsp_set_dac_volume (struct snd_cs46xx * chip, u16 left, u16 right);
-int cs46xx_dsp_set_iec958_volume (struct snd_cs46xx * chip, u16 left, u16 right);
 #endif /* __CS46XX_LIB_H__ */
--- linux-2.6.19-rc6-mm2/sound/pci/cs46xx/dsp_spos.c.old	2006-12-04 16:49:29.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/cs46xx/dsp_spos.c	2006-12-04 16:49:44.000000000 +0100
@@ -1878,6 +1878,7 @@
 	return 0;
 }
 
+#if 0
 int cs46xx_dsp_set_iec958_volume (struct snd_cs46xx * chip, u16 left, u16 right)
 {
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
@@ -1895,3 +1896,4 @@
 
 	return 0;
 }
+#endif  /*  0  */
--- linux-2.6.19-rc6-mm2/sound/pci/ac97/ac97_local.h.old	2006-12-04 16:53:59.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/ac97/ac97_local.h	2006-12-04 16:54:52.000000000 +0100
@@ -65,9 +65,6 @@
 int snd_ac97_get_volsw(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
 int snd_ac97_put_volsw(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol);
 int snd_ac97_try_bit(struct snd_ac97 * ac97, int reg, int bit);
-int snd_ac97_remove_ctl(struct snd_ac97 *ac97, const char *name, const char *suffix);
-int snd_ac97_rename_ctl(struct snd_ac97 *ac97, const char *src, const char *dst, const char *suffix);
-int snd_ac97_swap_ctl(struct snd_ac97 *ac97, const char *s1, const char *s2, const char *suffix);
 void snd_ac97_rename_vol_ctl(struct snd_ac97 *ac97, const char *src, const char *dst);
 void snd_ac97_restore_status(struct snd_ac97 *ac97);
 void snd_ac97_restore_iec958(struct snd_ac97 *ac97);
--- linux-2.6.19-rc6-mm2/sound/pci/ac97/ac97_codec.c.old	2006-12-04 16:53:01.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/ac97/ac97_codec.c	2006-12-04 16:55:01.000000000 +0100
@@ -352,8 +352,6 @@
 	return change;
 }
 
-EXPORT_SYMBOL(snd_ac97_update);
-
 /**
  * snd_ac97_update_bits - update the bits on the given register
  * @ac97: the ac97 instance
@@ -2537,7 +2535,8 @@
 }	
 
 /* remove the control with the given name and optional suffix */
-int snd_ac97_remove_ctl(struct snd_ac97 *ac97, const char *name, const char *suffix)
+static int snd_ac97_remove_ctl(struct snd_ac97 *ac97, const char *name,
+			       const char *suffix)
 {
 	struct snd_ctl_elem_id id;
 	memset(&id, 0, sizeof(id));
@@ -2556,7 +2555,8 @@
 }
 
 /* rename the control with the given name and optional suffix */
-int snd_ac97_rename_ctl(struct snd_ac97 *ac97, const char *src, const char *dst, const char *suffix)
+static int snd_ac97_rename_ctl(struct snd_ac97 *ac97, const char *src,
+			       const char *dst, const char *suffix)
 {
 	struct snd_kcontrol *kctl = ctl_find(ac97, src, suffix);
 	if (kctl) {
@@ -2574,7 +2574,8 @@
 }
 
 /* swap controls */
-int snd_ac97_swap_ctl(struct snd_ac97 *ac97, const char *s1, const char *s2, const char *suffix)
+static int snd_ac97_swap_ctl(struct snd_ac97 *ac97, const char *s1,
+			     const char *s2, const char *suffix)
 {
 	struct snd_kcontrol *kctl1, *kctl2;
 	kctl1 = ctl_find(ac97, s1, suffix);
--- linux-2.6.19-rc6-mm2/include/sound/core.h.old	2006-12-04 17:13:39.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/core.h	2006-12-04 17:49:07.000000000 +0100
@@ -22,6 +22,7 @@
  *
  */
 
+#include <sound/driver.h>
 #include <linux/sched.h>		/* wake_up() */
 #include <linux/mutex.h>		/* struct mutex */
 #include <linux/rwsem.h>		/* struct rw_semaphore */
@@ -35,6 +36,7 @@
 #ifdef CONFIG_SBUS
 struct sbus_dev;
 #endif
+struct snd_info_buffer;
 
 /* device allocation stuff */
 
@@ -287,6 +289,8 @@
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
 
+void snd_card_info_read_oss(struct snd_info_buffer *buffer);
+
 #ifndef snd_card_set_dev
 #define snd_card_set_dev(card,devptr) ((card)->parent = (devptr))
 #endif
@@ -297,7 +301,6 @@
 		   void *device_data, struct snd_device_ops *ops);
 int snd_device_register(struct snd_card *card, void *device_data);
 int snd_device_register_all(struct snd_card *card);
-int snd_device_disconnect(struct snd_card *card, void *device_data);
 int snd_device_disconnect_all(struct snd_card *card);
 int snd_device_free(struct snd_card *card, void *device_data);
 int snd_device_free_all(struct snd_card *card, snd_device_cmd_t cmd);
--- linux-2.6.19-rc6-mm2/sound/core/info_oss.c.old	2006-12-04 17:29:38.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/info_oss.c	2006-12-04 17:29:43.000000000 +0100
@@ -66,8 +66,6 @@
 
 EXPORT_SYMBOL(snd_oss_info_register);
 
-extern void snd_card_info_read_oss(struct snd_info_buffer *buffer);
-
 static int snd_sndstat_show_strings(struct snd_info_buffer *buf, char *id, int dev)
 {
 	int idx, ok = -1;
--- linux-2.6.19-rc6-mm2/sound/core/device.c.old	2006-12-04 17:13:58.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/device.c	2006-12-04 17:14:10.000000000 +0100
@@ -120,7 +120,7 @@
  * Returns zero if successful, or a negative error code on failure or if the
  * device not found.
  */
-int snd_device_disconnect(struct snd_card *card, void *device_data)
+static int snd_device_disconnect(struct snd_card *card, void *device_data)
 {
 	struct snd_device *dev;
 
--- linux-2.6.19-rc6-mm2/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl.old	2006-12-04 17:17:34.000000000 +0100
+++ linux-2.6.19-rc6-mm2/Documentation/sound/alsa/DocBook/writing-an-alsa-driver.tmpl	2006-12-04 17:18:34.000000000 +0100
@@ -5648,8 +5648,7 @@
     <para>
 	As shown in the above, it's better to save registers after
 	suspending the PCM operations via
-	<function>snd_pcm_suspend_all()</function> or
-	<function>snd_pcm_suspend()</function>.  It means that the PCM
+	<function>snd_pcm_suspend_all()</function>.  It means that the PCM
 	streams are already stoppped when the register snapshot is
 	taken.  But, remind that you don't have to restart the PCM
 	stream in the resume callback. It'll be restarted via 
--- linux-2.6.19-rc6-mm2/include/sound/pcm.h.old	2006-12-04 17:14:50.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/sound/pcm.h	2006-12-04 17:20:10.000000000 +0100
@@ -467,10 +467,7 @@
 int snd_pcm_start(struct snd_pcm_substream *substream);
 int snd_pcm_stop(struct snd_pcm_substream *substream, int status);
 int snd_pcm_drain_done(struct snd_pcm_substream *substream);
-#ifdef CONFIG_PM
-int snd_pcm_suspend(struct snd_pcm_substream *substream);
 int snd_pcm_suspend_all(struct snd_pcm *pcm);
-#endif
 int snd_pcm_kernel_ioctl(struct snd_pcm_substream *substream, unsigned int cmd, void *arg);
 int snd_pcm_open_substream(struct snd_pcm *pcm, int stream, struct file *file,
 			   struct snd_pcm_substream **rsubstream);
@@ -831,9 +828,6 @@
 
 int snd_pcm_hw_refine(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params);
 
-int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream);
-int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream);
-
 int snd_pcm_hw_constraint_mask(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
 			       u_int32_t mask);
 int snd_pcm_hw_constraint_mask64(struct snd_pcm_runtime *runtime, snd_pcm_hw_param_t var,
@@ -953,7 +947,6 @@
  *  Memory
  */
 
-int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream);
 int snd_pcm_lib_preallocate_free_for_all(struct snd_pcm *pcm);
 int snd_pcm_lib_preallocate_pages(struct snd_pcm_substream *substream,
 				  int type, struct device *data,
--- linux-2.6.19-rc6-mm2/sound/core/pcm_memory.c.old	2006-12-04 17:15:07.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/pcm_memory.c	2006-12-04 17:16:45.000000000 +0100
@@ -97,7 +97,7 @@
  *
  * Returns zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
+static int snd_pcm_lib_preallocate_free(struct snd_pcm_substream *substream)
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
 #ifdef CONFIG_SND_VERBOSE_PROCFS
@@ -128,8 +128,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(snd_pcm_lib_preallocate_free_for_all);
-
 #ifdef CONFIG_SND_VERBOSE_PROCFS
 /*
  * read callback for prealloc proc file
--- linux-2.6.19-rc6-mm2/sound/core/pcm_native.c.old	2006-12-04 17:19:02.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/core/pcm_native.c	2006-12-04 17:20:15.000000000 +0100
@@ -1097,7 +1097,7 @@
  * Trigger SUSPEND to all linked streams.
  * After this call, all streams are changed to SUSPENDED state.
  */
-int snd_pcm_suspend(struct snd_pcm_substream *substream)
+static int snd_pcm_suspend(struct snd_pcm_substream *substream)
 {
 	int err;
 	unsigned long flags;
@@ -1111,8 +1111,6 @@
 	return err;
 }
 
-EXPORT_SYMBOL(snd_pcm_suspend);
-
 /**
  * snd_pcm_suspend_all
  * @pcm: the PCM instance
@@ -1815,7 +1813,7 @@
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }		
 
-int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
+static int snd_pcm_hw_constraints_init(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hw_constraints *constrs = &runtime->hw_constraints;
@@ -1939,7 +1937,7 @@
 	return 0;
 }
 
-int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
+static int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
--- linux-2.6.19-rc6-mm2/sound/pci/ca0106/ca0106_main.c.old	2006-12-04 17:35:43.000000000 +0100
+++ linux-2.6.19-rc6-mm2/sound/pci/ca0106/ca0106_main.c	2006-12-04 17:35:53.000000000 +0100
@@ -313,8 +313,8 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
-int snd_ca0106_spi_write(struct snd_ca0106 * emu,
-				   unsigned int data)
+static int snd_ca0106_spi_write(struct snd_ca0106 * emu,
+				unsigned int data)
 {
 	unsigned int reset, set;
 	unsigned int reg, tmp;
