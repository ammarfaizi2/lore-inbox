Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbUJXNos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUJXNos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUJXNor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 09:44:47 -0400
Received: from verein.lst.de ([213.95.11.210]:43430 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261370AbUJXNiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 09:38:22 -0400
Date: Sun, 24 Oct 2004 15:38:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: perex@suse.cz
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH, RFC] remove dead code an exports from alsa
Message-ID: <20041024133813.GA20174@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alsa currently has tons of dead exports, often with totally unused
functions behind them.  Care to look over the huge patch below and
see what makes sense?


===== include/sound/ad1848.h 1.7 vs edited =====
--- 1.7/include/sound/ad1848.h	2004-04-08 11:34:59 +02:00
+++ edited/include/sound/ad1848.h	2004-10-23 15:56:31 +02:00
@@ -157,10 +157,6 @@
 /* exported functions */
 
 void snd_ad1848_out(ad1848_t *chip, unsigned char reg, unsigned char value);
-void snd_ad1848_dout(ad1848_t *chip, unsigned char reg, unsigned char value);
-unsigned char snd_ad1848_in(ad1848_t *chip, unsigned char reg);
-void snd_ad1848_mce_up(ad1848_t *chip);
-void snd_ad1848_mce_down(ad1848_t *chip);
 
 int snd_ad1848_create(snd_card_t * card,
 		      unsigned long port,
@@ -171,7 +167,6 @@
 int snd_ad1848_pcm(ad1848_t * chip, int device, snd_pcm_t **rpcm);
 const snd_pcm_ops_t *snd_ad1848_get_pcm_ops(int direction);
 int snd_ad1848_mixer(ad1848_t * chip);
-irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 /* exported mixer stuffs */
 enum { AD1848_MIX_SINGLE, AD1848_MIX_DOUBLE, AD1848_MIX_CAPTURE };
===== include/sound/ainstr_fm.h 1.1 vs edited =====
--- 1.1/include/sound/ainstr_fm.h	2002-02-13 20:32:01 +01:00
+++ edited/include/sound/ainstr_fm.h	2004-10-23 15:47:48 +02:00
@@ -122,8 +122,6 @@
 
 #include "seq_instr.h"
 
-extern char *snd_seq_fm_id;
-
 int snd_seq_fm_init(snd_seq_kinstr_ops_t * ops,
 		    snd_seq_kinstr_ops_t * next);
 
===== include/sound/ainstr_gf1.h 1.2 vs edited =====
--- 1.2/include/sound/ainstr_gf1.h	2004-06-03 21:29:23 +02:00
+++ edited/include/sound/ainstr_gf1.h	2004-10-23 15:48:44 +02:00
@@ -203,8 +203,6 @@
 
 #include "seq_instr.h"
 
-extern char *snd_seq_gf1_id;
-
 typedef struct {
 	void *private_data;
 	int (*info)(void *private_data, gf1_info_t *info);
===== include/sound/ainstr_iw.h 1.2 vs edited =====
--- 1.2/include/sound/ainstr_iw.h	2004-06-03 21:29:32 +02:00
+++ edited/include/sound/ainstr_iw.h	2004-10-23 15:49:18 +02:00
@@ -351,8 +351,6 @@
 
 #include "seq_instr.h"
 
-extern char *snd_seq_iwffff_id;
-
 typedef struct {
 	void *private_data;
 	int (*info)(void *private_data, iwffff_info_t *info);
===== include/sound/core.h 1.37 vs edited =====
--- 1.37/include/sound/core.h	2004-07-27 07:27:18 +02:00
+++ edited/include/sound/core.h	2004-10-23 15:56:59 +02:00
@@ -312,7 +312,6 @@
 
 /* init.c */
 
-extern int snd_cards_count;
 extern unsigned int snd_cards_lock;
 extern snd_card_t *snd_cards[SNDRV_CARDS];
 extern rwlock_t snd_card_rwlock;
===== include/sound/es1688.h 1.4 vs edited =====
--- 1.4/include/sound/es1688.h	2004-06-29 11:12:23 +02:00
+++ edited/include/sound/es1688.h	2004-10-23 16:00:30 +02:00
@@ -108,9 +108,6 @@
  */
 
 void snd_es1688_mixer_write(es1688_t *chip, unsigned char reg, unsigned char data);
-unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg);
-
-irqreturn_t snd_es1688_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 
 int snd_es1688_create(snd_card_t * card,
 		      unsigned long port,
===== include/sound/info.h 1.15 vs edited =====
--- 1.15/include/sound/info.h	2004-08-15 11:03:10 +02:00
+++ edited/include/sound/info.h	2004-10-23 15:58:43 +02:00
@@ -131,11 +131,6 @@
 int snd_info_register(snd_info_entry_t * entry);
 int snd_info_unregister(snd_info_entry_t * entry);
 
-struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode,
-					     struct proc_dir_entry *parent);
-void snd_remove_proc_entry(struct proc_dir_entry *parent,
-			   struct proc_dir_entry *de);
-
 /* for card drivers */
 int snd_card_proc_new(snd_card_t *card, const char *name, snd_info_entry_t **entryp);
 
@@ -170,10 +165,6 @@
 static inline int snd_info_card_free(snd_card_t * card) { return 0; }
 static inline int snd_info_register(snd_info_entry_t * entry) { return 0; }
 static inline int snd_info_unregister(snd_info_entry_t * entry) { return 0; }
-
-static inline struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode, struct proc_dir_entry *parent) { return NULL; }
-static inline void snd_remove_proc_entry(struct proc_dir_entry *parent,
-					 struct proc_dir_entry *de) { ; }
 
 #define snd_card_proc_new(card,name,entryp)  0 /* always success */
 #define snd_info_set_text_ops(entry,private_data,read_size,read) /*NOP*/
===== include/sound/pcm.h 1.30 vs edited =====
--- 1.30/include/sound/pcm.h	2004-10-06 18:46:43 +02:00
+++ edited/include/sound/pcm.h	2004-10-23 15:43:23 +02:00
@@ -487,16 +487,11 @@
 int snd_pcm_start(snd_pcm_substream_t *substream);
 int snd_pcm_stop(snd_pcm_substream_t *substream, int status);
 #ifdef CONFIG_PM
-int snd_pcm_suspend(snd_pcm_substream_t *substream);
 int snd_pcm_suspend_all(snd_pcm_t *pcm);
 #endif
 int snd_pcm_kernel_playback_ioctl(snd_pcm_substream_t *substream, unsigned int cmd, void *arg);
 int snd_pcm_kernel_capture_ioctl(snd_pcm_substream_t *substream, unsigned int cmd, void *arg);
 int snd_pcm_kernel_ioctl(snd_pcm_substream_t *substream, unsigned int cmd, void *arg);
-int snd_pcm_open(struct inode *inode, struct file *file);
-int snd_pcm_release(struct inode *inode, struct file *file);
-unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait);
-unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait);
 int snd_pcm_open_substream(snd_pcm_t *pcm, int stream, snd_pcm_substream_t **rsubstream);
 void snd_pcm_release_substream(snd_pcm_substream_t *substream);
 void snd_pcm_vma_notify_data(void *client, void *data);
@@ -789,9 +784,6 @@
 int snd_pcm_hw_param_setinteger(snd_pcm_substream_t *substream, 
 				snd_pcm_hw_params_t *params,
 				snd_pcm_hw_param_t var);
-int snd_pcm_hw_param_first(snd_pcm_substream_t *substream, 
-			   snd_pcm_hw_params_t *params,
-			   snd_pcm_hw_param_t var, int *dir);
 int snd_pcm_hw_param_last(snd_pcm_substream_t *substream, 
 			  snd_pcm_hw_params_t *params,
 			  snd_pcm_hw_param_t var, int *dir);
@@ -856,9 +848,7 @@
 const unsigned char *snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int frames);
 snd_pcm_format_t snd_pcm_build_linear_format(int width, int unsignd, int big_endian);
-ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples);
 const char *snd_pcm_format_name(snd_pcm_format_t format);
-const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat);
 
 void snd_pcm_set_ops(snd_pcm_t * pcm, int direction, snd_pcm_ops_t *ops);
 void snd_pcm_set_sync(snd_pcm_substream_t * substream);
@@ -871,13 +861,8 @@
 int snd_pcm_playback_xrun_asap(snd_pcm_substream_t *substream);
 int snd_pcm_capture_xrun_asap(snd_pcm_substream_t *substream);
 void snd_pcm_playback_silence(snd_pcm_substream_t *substream, snd_pcm_uframes_t new_hw_ptr);
-int snd_pcm_playback_ready(snd_pcm_substream_t *substream);
-int snd_pcm_capture_ready(snd_pcm_substream_t *substream);
-long snd_pcm_playback_ready_jiffies(snd_pcm_substream_t *substream);
-long snd_pcm_capture_ready_jiffies(snd_pcm_substream_t *substream);
 int snd_pcm_playback_data(snd_pcm_substream_t *substream);
 int snd_pcm_playback_empty(snd_pcm_substream_t *substream);
-int snd_pcm_capture_empty(snd_pcm_substream_t *substream);
 void snd_pcm_tick_prepare(snd_pcm_substream_t *substream);
 void snd_pcm_tick_set(snd_pcm_substream_t *substream, unsigned long ticks);
 void snd_pcm_tick_elapsed(snd_pcm_substream_t *substream);
===== include/sound/rawmidi.h 1.5 vs edited =====
--- 1.5/include/sound/rawmidi.h	2003-09-30 04:28:27 +02:00
+++ edited/include/sound/rawmidi.h	2004-10-23 15:44:21 +02:00
@@ -176,9 +176,7 @@
 int snd_rawmidi_kernel_release(snd_rawmidi_file_t * rfile);
 int snd_rawmidi_output_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
 int snd_rawmidi_input_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
-int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream);
 int snd_rawmidi_drain_output(snd_rawmidi_substream_t * substream);
-int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream);
 long snd_rawmidi_kernel_read(snd_rawmidi_substream_t * substream, unsigned char *buf, long count);
 long snd_rawmidi_kernel_write(snd_rawmidi_substream_t * substream, const unsigned char *buf, long count);
 
===== include/sound/seq_midi_emul.h 1.1 vs edited =====
--- 1.1/include/sound/seq_midi_emul.h	2002-02-13 20:32:01 +01:00
+++ edited/include/sound/seq_midi_emul.h	2004-10-23 16:02:15 +02:00
@@ -189,8 +189,6 @@
 void snd_midi_process_event(snd_midi_op_t *ops, snd_seq_event_t *ev,
 			    snd_midi_channel_set_t *chanset);
 void snd_midi_channel_set_clear(snd_midi_channel_set_t *chset);
-void snd_midi_channel_init(snd_midi_channel_t *p, int n);
-snd_midi_channel_t *snd_midi_channel_init_set(int n);
 snd_midi_channel_set_t *snd_midi_channel_alloc_set(int n);
 void snd_midi_channel_free_set(snd_midi_channel_set_t *chset);
 
===== include/sound/seq_midi_event.h 1.3 vs edited =====
--- 1.3/include/sound/seq_midi_event.h	2003-07-21 11:29:40 +02:00
+++ edited/include/sound/seq_midi_event.h	2004-10-23 16:04:22 +02:00
@@ -41,9 +41,7 @@
 };
 
 int snd_midi_event_new(int bufsize, snd_midi_event_t **rdev);
-int snd_midi_event_resize_buffer(snd_midi_event_t *dev, int bufsize);
 void snd_midi_event_free(snd_midi_event_t *dev);
-void snd_midi_event_init(snd_midi_event_t *dev);
 void snd_midi_event_reset_encode(snd_midi_event_t *dev);
 void snd_midi_event_reset_decode(snd_midi_event_t *dev);
 void snd_midi_event_no_status(snd_midi_event_t *dev, int on);
===== include/sound/seq_virmidi.h 1.2 vs edited =====
--- 1.2/include/sound/seq_virmidi.h	2002-09-29 22:20:47 +02:00
+++ edited/include/sound/seq_virmidi.h	2004-10-23 15:53:37 +02:00
@@ -79,6 +79,5 @@
 #define SNDRV_VIRMIDI_SEQ_DISPATCH	2
 
 int snd_virmidi_new(snd_card_t *card, int device, snd_rawmidi_t **rrmidi);
-int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev);
 
 #endif /* __SOUND_SEQ_VIRMIDI */
===== include/sound/timer.h 1.7 vs edited =====
--- 1.7/include/sound/timer.h	2004-06-29 11:09:19 +02:00
+++ edited/include/sound/timer.h	2004-10-23 15:50:47 +02:00
@@ -147,11 +147,8 @@
 extern unsigned long snd_timer_resolution(snd_timer_instance_t * timeri);
 extern int snd_timer_start(snd_timer_instance_t * timeri, unsigned int ticks);
 extern int snd_timer_stop(snd_timer_instance_t * timeri);
-extern int snd_timer_continue(snd_timer_instance_t * timeri);
 extern int snd_timer_pause(snd_timer_instance_t * timeri);
 
 extern void snd_timer_interrupt(snd_timer_t * timer, unsigned long ticks_left);
-
-extern unsigned int snd_timer_system_resolution(void);
 
 #endif /* __SOUND_TIMER_H */
===== include/sound/trident.h 1.15 vs edited =====
--- 1.15/include/sound/trident.h	2004-07-15 08:43:26 +02:00
+++ edited/include/sound/trident.h	2004-10-23 15:52:13 +02:00
@@ -470,14 +470,12 @@
 void snd_trident_start_voice(trident_t * trident, unsigned int voice);
 void snd_trident_stop_voice(trident_t * trident, unsigned int voice);
 void snd_trident_write_voice_regs(trident_t * trident, snd_trident_voice_t *voice);
-void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max);
 
 /* TLB memory allocation */
 snd_util_memblk_t *snd_trident_alloc_pages(trident_t *trident, snd_pcm_substream_t *substream);
 int snd_trident_free_pages(trident_t *trident, snd_util_memblk_t *blk);
 snd_util_memblk_t *snd_trident_synth_alloc(trident_t *trident, unsigned int size);
 int snd_trident_synth_free(trident_t *trident, snd_util_memblk_t *blk);
-int snd_trident_synth_bzero(trident_t *trident, snd_util_memblk_t *blk, int offset, int size);
 int snd_trident_synth_copy_from_user(trident_t *trident, snd_util_memblk_t *blk, int offset, const char __user *data, int size);
 
 #endif /* __SOUND_TRIDENT_H */
--- 1.37/sound/core/info.c	2004-08-15 11:03:10 +02:00
+++ edited/sound/core/info.c	2004-10-23 15:58:41 +02:00
@@ -126,12 +126,19 @@
 	de->owner = THIS_MODULE;
 }
 
+#ifdef CONFIG_PROC_FS
 void snd_remove_proc_entry(struct proc_dir_entry *parent,
 			   struct proc_dir_entry *de)
 {
 	if (de)
 		remove_proc_entry(de->name, parent);
 }
+#else
+static inline void snd_remove_proc_entry(struct proc_dir_entry *parent,
+					 struct proc_dir_entry *de)
+{
+}
+#endif
 
 static loff_t snd_info_entry_llseek(struct file *file, loff_t offset, int orig)
 {
@@ -511,6 +518,7 @@
 	.release =	snd_info_entry_release,
 };
 
+#ifdef CONFIG_PROC_FS
 /**
  * snd_create_proc_entry - create a procfs entry
  * @name: the name of the proc file
@@ -531,6 +539,14 @@
 		snd_info_entry_prepare(p);
 	return p;
 }
+#else
+static inline struct proc_dir_entry *
+snd_create_proc_entry(const char *name, mode_t mode,
+		struct proc_dir_entry *parent)
+{
+	return NULL;
+}
+#endif
 
 int __init snd_info_init(void)
 {
===== sound/core/init.c 1.31 vs edited =====
--- 1.31/sound/core/init.c	2004-10-06 18:42:55 +02:00
+++ edited/sound/core/init.c	2004-10-23 15:57:16 +02:00
@@ -37,7 +37,6 @@
 	struct snd_shutdown_f_ops *next;
 };
 
-int snd_cards_count = 0;
 unsigned int snd_cards_lock = 0;	/* locked for registering/using */
 snd_card_t *snd_cards[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = NULL};
 rwlock_t snd_card_rwlock = RW_LOCK_UNLOCKED;
@@ -251,7 +250,6 @@
 		return -EINVAL;
 	write_lock(&snd_card_rwlock);
 	snd_cards[card->number] = NULL;
-	snd_cards_count--;
 	write_unlock(&snd_card_rwlock);
 
 #ifdef CONFIG_PM
@@ -441,7 +439,6 @@
 	if (card->id[0] == '\0')
 		choose_default_id(card);
 	snd_cards[card->number] = card;
-	snd_cards_count++;
 	write_unlock(&snd_card_rwlock);
 	if ((err = snd_info_card_register(card)) < 0) {
 		snd_printd("unable to create card info\n");
===== sound/core/pcm.c 1.30 vs edited =====
--- 1.30/sound/core/pcm.c	2004-09-03 11:08:15 +02:00
+++ edited/sound/core/pcm.c	2004-10-23 15:42:36 +02:00
@@ -191,7 +191,7 @@
 	FORMAT(U18_3BE),
 };
 
-char *snd_pcm_subformat_names[] = {
+static char *snd_pcm_subformat_names[] = {
 	SUBFORMAT(STD), 
 };
 
@@ -218,12 +218,6 @@
 	return snd_pcm_format_names[format];
 }
 
-const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat)
-{
-	snd_assert(subformat <= SNDRV_PCM_SUBFORMAT_LAST, return NULL);
-	return snd_pcm_subformat_names[subformat];
-}
-
 const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
 {
 	snd_assert(mode <= SNDRV_PCM_TSTAMP_LAST, return NULL);
@@ -317,7 +311,7 @@
 	}
 	snd_iprintf(buffer, "access: %s\n", snd_pcm_access_name(runtime->access));
 	snd_iprintf(buffer, "format: %s\n", snd_pcm_format_name(runtime->format));
-	snd_iprintf(buffer, "subformat: %s\n", snd_pcm_subformat_name(runtime->subformat));
+	snd_iprintf(buffer, "subformat: %s\n", snd_pcm_subformat_names[runtime->subformat]);
 	snd_iprintf(buffer, "channels: %u\n", runtime->channels);	
 	snd_iprintf(buffer, "rate: %u (%u/%u)\n", runtime->rate, runtime->rate_num, runtime->rate_den);	
 	snd_iprintf(buffer, "period_size: %lu\n", runtime->period_size);	
@@ -1034,21 +1028,14 @@
 EXPORT_SYMBOL(snd_pcm_open_substream);
 EXPORT_SYMBOL(snd_pcm_release_substream);
 EXPORT_SYMBOL(snd_pcm_format_name);
-EXPORT_SYMBOL(snd_pcm_subformat_name);
   /* pcm_native.c */
 EXPORT_SYMBOL(snd_pcm_link_rwlock);
-EXPORT_SYMBOL(snd_pcm_start);
 #ifdef CONFIG_PM
-EXPORT_SYMBOL(snd_pcm_suspend);
 EXPORT_SYMBOL(snd_pcm_suspend_all);
 #endif
 EXPORT_SYMBOL(snd_pcm_kernel_playback_ioctl);
 EXPORT_SYMBOL(snd_pcm_kernel_capture_ioctl);
 EXPORT_SYMBOL(snd_pcm_kernel_ioctl);
-EXPORT_SYMBOL(snd_pcm_open);
-EXPORT_SYMBOL(snd_pcm_release);
-EXPORT_SYMBOL(snd_pcm_playback_poll);
-EXPORT_SYMBOL(snd_pcm_capture_poll);
 EXPORT_SYMBOL(snd_pcm_mmap_data);
 #if SNDRV_PCM_INFO_MMAP_IOMEM
 EXPORT_SYMBOL(snd_pcm_lib_mmap_iomem);
@@ -1061,7 +1048,6 @@
 EXPORT_SYMBOL(snd_pcm_format_big_endian);
 EXPORT_SYMBOL(snd_pcm_format_width);
 EXPORT_SYMBOL(snd_pcm_format_physical_width);
-EXPORT_SYMBOL(snd_pcm_format_size);
 EXPORT_SYMBOL(snd_pcm_format_silence_64);
 EXPORT_SYMBOL(snd_pcm_format_set_silence);
 EXPORT_SYMBOL(snd_pcm_build_linear_format);
===== sound/core/pcm_lib.c 1.37 vs edited =====
--- 1.37/sound/core/pcm_lib.c	2004-07-27 07:31:03 +02:00
+++ edited/sound/core/pcm_lib.c	2004-10-23 16:01:48 +02:00
@@ -1318,7 +1318,7 @@
 	return 0;
 }
 
-int _snd_pcm_hw_param_first(snd_pcm_hw_params_t *params,
+static int _snd_pcm_hw_param_first(snd_pcm_hw_params_t *params,
 			    snd_pcm_hw_param_t var)
 {
 	int changed;
@@ -1345,7 +1345,7 @@
  * values > minimum. Reduce configuration space accordingly.
  * Return the minimum.
  */
-int snd_pcm_hw_param_first(snd_pcm_t *pcm, 
+static int snd_pcm_hw_param_first(snd_pcm_t *pcm, 
 			   snd_pcm_hw_params_t *params, 
 			   snd_pcm_hw_param_t var, int *dir)
 {
@@ -1359,7 +1359,7 @@
 	return snd_pcm_hw_param_value(params, var, dir);
 }
 
-int _snd_pcm_hw_param_last(snd_pcm_hw_params_t *params,
+static int _snd_pcm_hw_param_last(snd_pcm_hw_params_t *params,
 			   snd_pcm_hw_param_t var)
 {
 	int changed;
@@ -1386,7 +1386,7 @@
  * values < maximum. Reduce configuration space accordingly.
  * Return the maximum.
  */
-int snd_pcm_hw_param_last(snd_pcm_t *pcm, 
+static int snd_pcm_hw_param_last(snd_pcm_t *pcm, 
 			  snd_pcm_hw_params_t *params,
 			  snd_pcm_hw_param_t var, int *dir)
 {
@@ -1857,34 +1857,6 @@
  */
 
 /**
- * snd_pcm_playback_ready - check whether the playback buffer is available
- * @substream: the pcm substream instance
- *
- * Checks whether enough free space is available on the playback buffer.
- *
- * Returns non-zero if available, or zero if not.
- */
-int snd_pcm_playback_ready(snd_pcm_substream_t *substream)
-{
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	return snd_pcm_playback_avail(runtime) >= runtime->control->avail_min;
-}
-
-/**
- * snd_pcm_capture_ready - check whether the capture buffer is available
- * @substream: the pcm substream instance
- *
- * Checks whether enough capture data is available on the capture buffer.
- *
- * Returns non-zero if available, or zero if not.
- */
-int snd_pcm_capture_ready(snd_pcm_substream_t *substream)
-{
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	return snd_pcm_capture_avail(runtime) >= runtime->control->avail_min;
-}
-
-/**
  * snd_pcm_playback_data - check whether any data exists on the playback buffer
  * @substream: the pcm substream instance
  *
@@ -1916,20 +1888,6 @@
 	return snd_pcm_playback_avail(runtime) >= runtime->buffer_size;
 }
 
-/**
- * snd_pcm_capture_empty - check whether the capture buffer is empty
- * @substream: the pcm substream instance
- *
- * Checks whether the capture buffer is empty.
- *
- * Returns non-zero if empty, or zero if not.
- */
-int snd_pcm_capture_empty(snd_pcm_substream_t *substream)
-{
-	snd_pcm_runtime_t *runtime = substream->runtime;
-	return snd_pcm_capture_avail(runtime) == 0;
-}
-
 static void snd_pcm_system_tick_set(snd_pcm_substream_t *substream, 
 				    unsigned long ticks)
 {
@@ -2643,10 +2601,6 @@
 EXPORT_SYMBOL(snd_interval_refine);
 EXPORT_SYMBOL(snd_interval_list);
 EXPORT_SYMBOL(snd_interval_ratnum);
-EXPORT_SYMBOL(snd_interval_ratden);
-EXPORT_SYMBOL(snd_interval_muldivk);
-EXPORT_SYMBOL(snd_interval_mulkdiv);
-EXPORT_SYMBOL(snd_interval_div);
 EXPORT_SYMBOL(_snd_pcm_hw_params_any);
 EXPORT_SYMBOL(_snd_pcm_hw_param_min);
 EXPORT_SYMBOL(_snd_pcm_hw_param_set);
@@ -2655,8 +2609,6 @@
 EXPORT_SYMBOL(snd_pcm_hw_param_value_min);
 EXPORT_SYMBOL(snd_pcm_hw_param_value_max);
 EXPORT_SYMBOL(snd_pcm_hw_param_mask);
-EXPORT_SYMBOL(snd_pcm_hw_param_first);
-EXPORT_SYMBOL(snd_pcm_hw_param_last);
 EXPORT_SYMBOL(snd_pcm_hw_param_near);
 EXPORT_SYMBOL(snd_pcm_hw_param_set);
 EXPORT_SYMBOL(snd_pcm_hw_refine);
@@ -2674,10 +2626,6 @@
 EXPORT_SYMBOL(snd_pcm_set_ops);
 EXPORT_SYMBOL(snd_pcm_set_sync);
 EXPORT_SYMBOL(snd_pcm_lib_ioctl);
-EXPORT_SYMBOL(snd_pcm_playback_ready);
-EXPORT_SYMBOL(snd_pcm_capture_ready);
-EXPORT_SYMBOL(snd_pcm_playback_data);
-EXPORT_SYMBOL(snd_pcm_capture_empty);
 EXPORT_SYMBOL(snd_pcm_stop);
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
 EXPORT_SYMBOL(snd_pcm_lib_write);
===== sound/core/pcm_misc.c 1.12 vs edited =====
--- 1.12/sound/core/pcm_misc.c	2004-06-09 12:36:14 +02:00
+++ edited/sound/core/pcm_misc.c	2004-10-23 15:35:03 +02:00
@@ -317,21 +317,6 @@
 }
 
 /**
- * snd_pcm_format_size - return the byte size of samples on the given format
- * @format: the format to check
- *
- * Returns the byte size of the given samples for the format, or a
- * negative error code if unknown format.
- */
-ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples)
-{
-	int phys_width = snd_pcm_format_physical_width(format);
-	if (phys_width < 0)
-		return -EINVAL;
-	return samples * phys_width / 8;
-}
-
-/**
  * snd_pcm_format_silence_64 - return the silent data in 8 bytes array
  * @format: the format to check
  *
===== sound/core/pcm_native.c 1.63 vs edited =====
--- 1.63/sound/core/pcm_native.c	2004-09-03 11:08:15 +02:00
+++ edited/sound/core/pcm_native.c	2004-10-23 15:43:05 +02:00
@@ -971,14 +971,6 @@
 };
 
 /**
- * snd_pcm_suspend
- */
-int snd_pcm_suspend(snd_pcm_substream_t *substream)
-{
-	return snd_pcm_action(&snd_pcm_action_suspend, substream, 0);
-}
-
-/**
  * snd_pcm_suspend_all
  */
 int snd_pcm_suspend_all(snd_pcm_t *pcm)
@@ -996,7 +988,7 @@
 				snd_pcm_stream_unlock(substream);
 				continue;
 			}
-			if ((err = snd_pcm_suspend(substream)) < 0) {
+			if ((err = snd_pcm_action(&snd_pcm_action_suspend, &substream, 0)) < 0) {
 				snd_pcm_stream_unlock(substream);
 				return err;
 			}
@@ -2006,7 +1998,7 @@
 	return 0;
 }
 
-int snd_pcm_open(struct inode *inode, struct file *file)
+static int snd_pcm_open(struct inode *inode, struct file *file)
 {
 	int cardnum = SNDRV_MINOR_CARD(iminor(inode));
 	int device = SNDRV_MINOR_DEVICE(iminor(inode));
@@ -2065,7 +2057,7 @@
       	return err;
 }
 
-int snd_pcm_release(struct inode *inode, struct file *file)
+static int snd_pcm_release(struct inode *inode, struct file *file)
 {
 	snd_pcm_t *pcm;
 	snd_pcm_substream_t *substream;
@@ -2828,7 +2820,7 @@
 	return result;
 }
 
-unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
+static unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 {
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
@@ -2866,7 +2858,7 @@
 	return mask;
 }
 
-unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
+static unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
 {
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
===== sound/core/rawmidi.c 1.42 vs edited =====
--- 1.42/sound/core/rawmidi.c	2004-10-20 10:12:05 +02:00
+++ edited/sound/core/rawmidi.c	2004-10-23 15:44:18 +02:00
@@ -110,7 +110,7 @@
 	return 0;
 }
 
-int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream)
+static int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream)
 {
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
 
@@ -158,7 +158,7 @@
 	return err;
 }
 
-int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream)
+static int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream)
 {
 	snd_rawmidi_runtime_t *runtime = substream->runtime;
 
@@ -1654,9 +1654,7 @@
 
 EXPORT_SYMBOL(snd_rawmidi_output_params);
 EXPORT_SYMBOL(snd_rawmidi_input_params);
-EXPORT_SYMBOL(snd_rawmidi_drop_output);
 EXPORT_SYMBOL(snd_rawmidi_drain_output);
-EXPORT_SYMBOL(snd_rawmidi_drain_input);
 EXPORT_SYMBOL(snd_rawmidi_receive);
 EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
 EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
===== sound/core/sound.c 1.48 vs edited =====
--- 1.48/sound/core/sound.c	2004-07-27 07:27:18 +02:00
+++ edited/sound/core/sound.c	2004-10-23 15:59:14 +02:00
@@ -411,7 +411,6 @@
 EXPORT_SYMBOL(copy_to_user_fromio);
 EXPORT_SYMBOL(copy_from_user_toio);
   /* init.c */
-EXPORT_SYMBOL(snd_cards_count);
 EXPORT_SYMBOL(snd_cards);
 #if defined(CONFIG_SND_MIXER_OSS) || defined(CONFIG_SND_MIXER_OSS_MODULE)
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
@@ -437,7 +436,6 @@
 EXPORT_SYMBOL(snd_device_new);
 EXPORT_SYMBOL(snd_device_register);
 EXPORT_SYMBOL(snd_device_free);
-EXPORT_SYMBOL(snd_device_free_all);
   /* isadma.c */
 #ifdef CONFIG_ISA
 EXPORT_SYMBOL(snd_dma_program);
@@ -447,8 +445,6 @@
   /* info.c */
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(snd_seq_root);
-EXPORT_SYMBOL(snd_create_proc_entry);
-EXPORT_SYMBOL(snd_remove_proc_entry);
 EXPORT_SYMBOL(snd_iprintf);
 EXPORT_SYMBOL(snd_info_get_line);
 EXPORT_SYMBOL(snd_info_get_str);
===== sound/core/timer.c 1.36 vs edited =====
--- 1.36/sound/core/timer.c	2004-07-27 07:28:36 +02:00
+++ edited/sound/core/timer.c	2004-10-23 15:50:43 +02:00
@@ -531,7 +531,7 @@
 /*
  * start again..  the tick is kept.
  */
-int snd_timer_continue(snd_timer_instance_t * timeri)
+static int snd_timer_continue(snd_timer_instance_t * timeri)
 {
 	snd_timer_t *timer;
 	int result = -EINVAL;
@@ -944,7 +944,7 @@
 	unsigned long correction;
 };
 
-unsigned int snd_timer_system_resolution(void)
+static unsigned int snd_timer_system_resolution(void)
 {
 	return 1000000000L / HZ;
 }
@@ -1882,7 +1882,6 @@
 EXPORT_SYMBOL(snd_timer_resolution);
 EXPORT_SYMBOL(snd_timer_start);
 EXPORT_SYMBOL(snd_timer_stop);
-EXPORT_SYMBOL(snd_timer_continue);
 EXPORT_SYMBOL(snd_timer_pause);
 EXPORT_SYMBOL(snd_timer_new);
 EXPORT_SYMBOL(snd_timer_notify);
@@ -1891,4 +1890,3 @@
 EXPORT_SYMBOL(snd_timer_global_register);
 EXPORT_SYMBOL(snd_timer_global_unregister);
 EXPORT_SYMBOL(snd_timer_interrupt);
-EXPORT_SYMBOL(snd_timer_system_resolution);
===== sound/core/seq/seq_midi_emul.c 1.9 vs edited =====
--- 1.9/sound/core/seq/seq_midi_emul.c	2004-07-01 03:28:49 +02:00
+++ edited/sound/core/seq/seq_midi_emul.c	2004-10-23 16:02:46 +02:00
@@ -621,7 +621,7 @@
 /*
  * Initialise a single midi channel control block.
  */
-void snd_midi_channel_init(snd_midi_channel_t *p, int n)
+static void snd_midi_channel_init(snd_midi_channel_t *p, int n)
 {
 	if (p == NULL)
 		return;
@@ -642,7 +642,7 @@
 /*
  * Allocate and initialise a set of midi channel control blocks.
  */
-snd_midi_channel_t *snd_midi_channel_init_set(int n)
+static snd_midi_channel_t *snd_midi_channel_init_set(int n)
 {
 	snd_midi_channel_t *chan;
 	int  i;
@@ -732,7 +732,5 @@
 
 EXPORT_SYMBOL(snd_midi_process_event);
 EXPORT_SYMBOL(snd_midi_channel_set_clear);
-EXPORT_SYMBOL(snd_midi_channel_init);
-EXPORT_SYMBOL(snd_midi_channel_init_set);
 EXPORT_SYMBOL(snd_midi_channel_alloc_set);
 EXPORT_SYMBOL(snd_midi_channel_free_set);
===== sound/core/seq/seq_midi_event.c 1.10 vs edited =====
--- 1.10/sound/core/seq/seq_midi_event.c	2004-06-29 10:55:10 +02:00
+++ edited/sound/core/seq/seq_midi_event.c	2004-10-23 16:04:09 +02:00
@@ -172,42 +172,12 @@
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
-void snd_midi_event_init(snd_midi_event_t *dev)
-{
-	snd_midi_event_reset_encode(dev);
-	snd_midi_event_reset_decode(dev);
-}
-
 void snd_midi_event_no_status(snd_midi_event_t *dev, int on)
 {
 	dev->nostat = on ? 1 : 0;
 }
 
 /*
- * resize buffer
- */
-int snd_midi_event_resize_buffer(snd_midi_event_t *dev, int bufsize)
-{
-	unsigned char *new_buf, *old_buf;
-	unsigned long flags;
-
-	if (bufsize == dev->bufsize)
-		return 0;
-	new_buf = kmalloc(bufsize, GFP_KERNEL);
-	if (new_buf == NULL)
-		return -ENOMEM;
-	spin_lock_irqsave(&dev->lock, flags);
-	old_buf = dev->buf;
-	dev->buf = new_buf;
-	dev->bufsize = bufsize;
-	reset_encode(dev);
-	spin_unlock_irqrestore(&dev->lock, flags);
-	if (old_buf)
-		kfree(old_buf);
-	return 0;
-}
-
-/*
  *  read bytes and encode to sequencer event if finished
  *  return the size of encoded bytes
  */
@@ -519,8 +489,6 @@
  
 EXPORT_SYMBOL(snd_midi_event_new);
 EXPORT_SYMBOL(snd_midi_event_free);
-EXPORT_SYMBOL(snd_midi_event_resize_buffer);
-EXPORT_SYMBOL(snd_midi_event_init);
 EXPORT_SYMBOL(snd_midi_event_reset_encode);
 EXPORT_SYMBOL(snd_midi_event_reset_decode);
 EXPORT_SYMBOL(snd_midi_event_no_status);
===== sound/core/seq/seq_virmidi.c 1.10 vs edited =====
--- 1.10/sound/core/seq/seq_virmidi.c	2004-06-29 11:09:19 +02:00
+++ edited/sound/core/seq/seq_virmidi.c	2004-10-23 15:53:26 +02:00
@@ -110,14 +110,6 @@
  * handler of a remote port which is attached to the virmidi via
  * SNDRV_VIRMIDI_SEQ_ATTACH.
  */
-/* exported */
-int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev)
-{
-	snd_virmidi_dev_t *rdev;
-
-	rdev = rmidi->private_data;
-	return snd_virmidi_dev_receive_event(rdev, ev);
-}
 
 /*
  * event handler of virmidi port
@@ -534,4 +526,3 @@
 module_exit(alsa_virmidi_exit)
 
 EXPORT_SYMBOL(snd_virmidi_new);
-EXPORT_SYMBOL(snd_virmidi_receive);
===== sound/core/seq/instr/ainstr_fm.c 1.5 vs edited =====
--- 1.5/sound/core/seq/instr/ainstr_fm.c	2004-07-01 03:28:49 +02:00
+++ edited/sound/core/seq/instr/ainstr_fm.c	2004-10-23 15:48:09 +02:00
@@ -30,7 +30,7 @@
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture FM Instrument support.");
 MODULE_LICENSE("GPL");
 
-char *snd_seq_fm_id = SNDRV_SEQ_INSTR_ID_OPL2_3;
+static char *snd_seq_fm_id = SNDRV_SEQ_INSTR_ID_OPL2_3;
 
 static int snd_seq_fm_put(void *private_data, snd_seq_kinstr_t *instr,
 			  char __user *instr_data, long len, int atomic, int cmd)
@@ -155,5 +155,4 @@
 module_init(alsa_ainstr_fm_init)
 module_exit(alsa_ainstr_fm_exit)
 
-EXPORT_SYMBOL(snd_seq_fm_id);
 EXPORT_SYMBOL(snd_seq_fm_init);
===== sound/core/seq/instr/ainstr_gf1.c 1.6 vs edited =====
--- 1.6/sound/core/seq/instr/ainstr_gf1.c	2004-07-01 03:28:49 +02:00
+++ edited/sound/core/seq/instr/ainstr_gf1.c	2004-10-23 15:48:59 +02:00
@@ -31,7 +31,7 @@
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture GF1 (GUS) Patch support.");
 MODULE_LICENSE("GPL");
 
-char *snd_seq_gf1_id = SNDRV_SEQ_INSTR_ID_GUS_PATCH;
+static char *snd_seq_gf1_id = SNDRV_SEQ_INSTR_ID_GUS_PATCH;
 
 static unsigned int snd_seq_gf1_size(unsigned int size, unsigned int format)
 {
@@ -357,5 +357,4 @@
 module_init(alsa_ainstr_gf1_init)
 module_exit(alsa_ainstr_gf1_exit)
 
-EXPORT_SYMBOL(snd_seq_gf1_id);
 EXPORT_SYMBOL(snd_seq_gf1_init);
===== sound/core/seq/instr/ainstr_iw.c 1.7 vs edited =====
--- 1.7/sound/core/seq/instr/ainstr_iw.c	2004-07-01 03:28:49 +02:00
+++ edited/sound/core/seq/instr/ainstr_iw.c	2004-10-23 15:49:29 +02:00
@@ -31,7 +31,7 @@
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture IWFFFF support.");
 MODULE_LICENSE("GPL");
 
-char *snd_seq_iwffff_id = SNDRV_SEQ_INSTR_ID_INTERWAVE;
+static char *snd_seq_iwffff_id = SNDRV_SEQ_INSTR_ID_INTERWAVE;
 
 static unsigned int snd_seq_iwffff_size(unsigned int size, unsigned int format)
 {
@@ -621,5 +621,4 @@
 module_init(alsa_ainstr_iw_init)
 module_exit(alsa_ainstr_iw_exit)
 
-EXPORT_SYMBOL(snd_seq_iwffff_id);
 EXPORT_SYMBOL(snd_seq_iwffff_init);
===== sound/isa/ad1848/ad1848_lib.c 1.23 vs edited =====
--- 1.23/sound/isa/ad1848/ad1848_lib.c	2004-06-29 11:12:25 +02:00
+++ edited/sound/isa/ad1848/ad1848_lib.c	2004-10-23 15:56:28 +02:00
@@ -119,7 +119,7 @@
 #endif
 }
 
-void snd_ad1848_dout(ad1848_t *chip,
+static void snd_ad1848_dout(ad1848_t *chip,
 		     unsigned char reg,
 		     unsigned char value)
 {
@@ -132,7 +132,7 @@
 	mb();
 }
 
-unsigned char snd_ad1848_in(ad1848_t *chip, unsigned char reg)
+static unsigned char snd_ad1848_in(ad1848_t *chip, unsigned char reg)
 {
 	int timeout;
 
@@ -177,7 +177,7 @@
  *  AD1848 detection / MCE routines
  */
 
-void snd_ad1848_mce_up(ad1848_t *chip)
+static void snd_ad1848_mce_up(ad1848_t *chip)
 {
 	unsigned long flags;
 	int timeout;
@@ -198,7 +198,7 @@
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
-void snd_ad1848_mce_down(ad1848_t *chip)
+static void snd_ad1848_mce_down(ad1848_t *chip)
 {
 	unsigned long flags;
 	int timeout;
@@ -584,7 +584,7 @@
 	return 0;
 }
 
-irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t snd_ad1848_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	ad1848_t *chip = dev_id;
 
@@ -1266,10 +1266,6 @@
 
 EXPORT_SYMBOL(snd_ad1848_in);
 EXPORT_SYMBOL(snd_ad1848_out);
-EXPORT_SYMBOL(snd_ad1848_dout);
-EXPORT_SYMBOL(snd_ad1848_mce_up);
-EXPORT_SYMBOL(snd_ad1848_mce_down);
-EXPORT_SYMBOL(snd_ad1848_interrupt);
 EXPORT_SYMBOL(snd_ad1848_create);
 EXPORT_SYMBOL(snd_ad1848_pcm);
 EXPORT_SYMBOL(snd_ad1848_get_pcm_ops);
===== sound/isa/es1688/es1688_lib.c 1.17 vs edited =====
--- 1.17/sound/isa/es1688/es1688_lib.c	2004-07-20 10:54:22 +02:00
+++ edited/sound/isa/es1688/es1688_lib.c	2004-10-23 16:00:26 +02:00
@@ -89,7 +89,7 @@
 	udelay(10);
 }
 
-unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg)
+static unsigned char snd_es1688_mixer_read(es1688_t *chip, unsigned char reg)
 {
 	unsigned char result;
 
@@ -479,7 +479,7 @@
 	return snd_es1688_trigger(chip, cmd, 0x0f);
 }
 
-irqreturn_t snd_es1688_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t snd_es1688_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	es1688_t *chip = dev_id;
 
@@ -1041,8 +1041,6 @@
 }
 
 EXPORT_SYMBOL(snd_es1688_mixer_write);
-EXPORT_SYMBOL(snd_es1688_mixer_read);
-EXPORT_SYMBOL(snd_es1688_interrupt);
 EXPORT_SYMBOL(snd_es1688_create);
 EXPORT_SYMBOL(snd_es1688_pcm);
 EXPORT_SYMBOL(snd_es1688_mixer);
--- 1.40/sound/pci/trident/trident_main.c	2004-07-30 07:57:26 +02:00
+++ edited/sound/pci/trident/trident_main.c	2004-10-23 15:52:21 +02:00
@@ -52,6 +52,8 @@
 static int snd_trident_resume(snd_card_t *card, unsigned int state);
 #endif
 static int snd_trident_sis_reset(trident_t *trident);
+static void snd_trident_clear_voices(trident_t * trident,
+		unsigned short v_min, unsigned short v_max);
 
 /*
  *  common I/O routines
@@ -3906,7 +3908,8 @@
 		private_free(voice);
 }
 
-void snd_trident_clear_voices(trident_t * trident, unsigned short v_min, unsigned short v_max)
+static void snd_trident_clear_voices(trident_t * trident,
+		unsigned short v_min, unsigned short v_max)
 {
 	unsigned int i, val, mask[2] = { 0, 0 };
 
@@ -3995,9 +3998,7 @@
 EXPORT_SYMBOL(snd_trident_start_voice);
 EXPORT_SYMBOL(snd_trident_stop_voice);
 EXPORT_SYMBOL(snd_trident_write_voice_regs);
-EXPORT_SYMBOL(snd_trident_clear_voices);
 /* trident_memory.c symbols */
 EXPORT_SYMBOL(snd_trident_synth_alloc);
 EXPORT_SYMBOL(snd_trident_synth_free);
-EXPORT_SYMBOL(snd_trident_synth_bzero);
 EXPORT_SYMBOL(snd_trident_synth_copy_from_user);
===== sound/pci/trident/trident_memory.c 1.12 vs edited =====
--- 1.12/sound/pci/trident/trident_memory.c	2004-07-30 07:57:27 +02:00
+++ edited/sound/pci/trident/trident_memory.c	2004-10-23 15:52:31 +02:00
@@ -450,29 +450,6 @@
 }
 
 /*
- * bzero(blk + offset, size)
- */
-int snd_trident_synth_bzero(trident_t *trident, snd_util_memblk_t *blk, int offset, int size)
-{
-	int page, nextofs, end_offset, temp, temp1;
-
-	offset += blk->offset;
-	end_offset = offset + size;
-	page = get_aligned_page(offset) + 1;
-	do {
-		nextofs = aligned_page_offset(page);
-		temp = nextofs - offset;
-		temp1 = end_offset - offset;
-		if (temp1 < temp)
-			temp = temp1;
-		memset(offset_ptr(trident, offset), 0, temp);
-		offset = nextofs;
-		page++;
-	} while (offset < end_offset);
-	return 0;
-}
-
-/*
  * copy_from_user(blk + offset, data, size)
  */
 int snd_trident_synth_copy_from_user(trident_t *trident, snd_util_memblk_t *blk, int offset, const char __user *data, int size)
