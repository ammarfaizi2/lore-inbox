Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264111AbUKZUnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264111AbUKZUnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 15:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbUKZUmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 15:42:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24076 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S264005AbUKZUZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 15:25:00 -0500
Date: Fri, 26 Nov 2004 01:24:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA core: misc cleanups
Message-ID: <20041126002448.GM3537@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does the following cleanups under sound/core/ :
- make needlessly global code static
- remove the following stale prototypes from pcm.h
  (the functions are not or no longer present):
  - snd_pcm_capture_ready_jiffies
  - snd_pcm_playback_ready_jiffies
- remove the following unused global funxtions:
  - oss/pcm_plugin.c: snd_pcm_plug_capture_channels_mask
  - pcm_lib.c: snd_pcm_playback_ready
  - pcm_lib.c: snd_pcm_capture_ready
  - pcm_lib.c: snd_pcm_capture_empty
  - pcm_misc.c: snd_pcm_format_cpu_endian
  - pcm_misc.c: snd_pcm_format_size
  - seq/seq_instr.c: snd_seq_cluster_new
  - seq/seq_instr.c: snd_seq_cluster_free
  - seq/seq_midi_event.c: snd_midi_event_init
  - seq/seq_midi_event.c: snd_midi_event_resize_buffer
  - seq/seq_virmidi.c: snd_virmidi_receive
- remove the following unused EXPORT_SYMBOL's:
  - snd_create_proc_entry
  - snd_interval_ratden
  - snd_midi_channel_init
  - snd_midi_channel_init_set
  - snd_midi_event_init
  - snd_midi_event_resize_buffer
  - snd_pcm_capture_empty
  - snd_pcm_capture_poll
  - snd_pcm_capture_ready
  - snd_pcm_format_size
  - snd_pcm_lib_preallocate_free
  - snd_pcm_open
  - snd_pcm_playback_poll
  - snd_pcm_playback_ready
  - snd_pcm_release
  - snd_pcm_subformat_name
  - snd_pcm_suspend
  - snd_rawmidi_drain_input
  - snd_rawmidi_drop_output
  - snd_rawmidi_info
  - snd_remove_proc_entry
  - snd_timer_continue
  - snd_timer_system_resolution
  - snd_virmidi_receive

Please review which of these changes are correct and which conflict with 
pending patches.


diffstat output:
 include/sound/core.h                |    1 
 include/sound/info.h                |    9 ---
 include/sound/pcm.h                 |   18 -------
 include/sound/rawmidi.h             |    9 ---
 include/sound/seq_midi_emul.h       |    2 
 include/sound/seq_midi_event.h      |    2 
 include/sound/seq_virmidi.h         |    1 
 include/sound/timer.h               |    3 -
 sound/core/device.c                 |    2 
 sound/core/hwdep.c                  |    2 
 sound/core/info.c                   |    6 +-
 sound/core/memory.c                 |    2 
 sound/core/oss/mixer_oss.c          |    4 -
 sound/core/oss/pcm_oss.c            |    4 -
 sound/core/oss/pcm_plugin.c         |   31 -------------
 sound/core/oss/route.c              |   12 ++---
 sound/core/pcm.c                    |   31 +++++--------
 sound/core/pcm_lib.c                |   65 +++-------------------------
 sound/core/pcm_memory.c             |    2 
 sound/core/pcm_misc.c               |   31 -------------
 sound/core/pcm_native.c             |   20 ++++----
 sound/core/rawmidi.c                |   17 +++----
 sound/core/seq/oss/seq_oss_device.h |    1 
 sound/core/seq/oss/seq_oss_init.c   |   39 ++++++++--------
 sound/core/seq/seq_clientmgr.c      |    4 -
 sound/core/seq/seq_clientmgr.h      |    1 
 sound/core/seq/seq_instr.c          |   18 +------
 sound/core/seq/seq_memory.c         |    2 
 sound/core/seq/seq_memory.h         |    1 
 sound/core/seq/seq_midi.c           |    8 +--
 sound/core/seq/seq_midi_emul.c      |   10 +---
 sound/core/seq/seq_midi_event.c     |   32 -------------
 sound/core/seq/seq_queue.c          |    2 
 sound/core/seq/seq_queue.h          |    1 
 sound/core/seq/seq_timer.c          |    2 
 sound/core/seq/seq_timer.h          |    2 
 sound/core/seq/seq_virmidi.c        |   17 -------
 sound/core/sound.c                  |    4 -
 sound/core/timer.c                  |   11 ----
 39 files changed, 97 insertions(+), 332 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/include/sound/core.h.old	2004-11-25 18:25:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/core.h	2004-11-25 18:25:47.000000000 +0100
@@ -344,7 +344,6 @@
 		   void *device_data, snd_device_ops_t *ops);
 int snd_device_register(snd_card_t *card, void *device_data);
 int snd_device_register_all(snd_card_t *card);
-int snd_device_disconnect(snd_card_t *card, void *device_data);
 int snd_device_disconnect_all(snd_card_t *card);
 int snd_device_free(snd_card_t *card, void *device_data);
 int snd_device_free_all(snd_card_t *card, snd_device_cmd_t cmd);
--- linux-2.6.10-rc2-mm3-full/sound/core/device.c.old	2004-11-25 18:25:58.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/device.c	2004-11-25 18:26:08.000000000 +0100
@@ -114,7 +114,7 @@
  * Returns zero if successful, or a negative error code on failure or if the
  * device not found.
  */
-int snd_device_disconnect(snd_card_t *card, void *device_data)
+static int snd_device_disconnect(snd_card_t *card, void *device_data)
 {
 	struct list_head *list;
 	snd_device_t *dev;
--- linux-2.6.10-rc2-mm3-full/sound/core/hwdep.c.old	2004-11-25 18:26:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/hwdep.c	2004-11-25 18:26:31.000000000 +0100
@@ -35,7 +35,7 @@
 MODULE_DESCRIPTION("Hardware dependent layer");
 MODULE_LICENSE("GPL");
 
-snd_hwdep_t *snd_hwdep_devices[SNDRV_CARDS * SNDRV_MINOR_HWDEPS];
+static snd_hwdep_t *snd_hwdep_devices[SNDRV_CARDS * SNDRV_MINOR_HWDEPS];
 
 static DECLARE_MUTEX(register_mutex);
 
--- linux-2.6.10-rc2-mm3-full/include/sound/info.h.old	2004-11-25 18:27:34.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/info.h	2004-11-25 18:28:10.000000000 +0100
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
 
@@ -171,10 +166,6 @@
 static inline int snd_info_register(snd_info_entry_t * entry) { return 0; }
 static inline int snd_info_unregister(snd_info_entry_t * entry) { return 0; }
 
-static inline struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode, struct proc_dir_entry *parent) { return NULL; }
-static inline void snd_remove_proc_entry(struct proc_dir_entry *parent,
-					 struct proc_dir_entry *de) { ; }
-
 #define snd_card_proc_new(card,name,entryp)  0 /* always success */
 #define snd_info_set_text_ops(entry,private_data,read_size,read) /*NOP*/
 
--- linux-2.6.10-rc2-mm3-full/sound/core/sound.c.old	2004-11-25 20:00:55.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/sound.c	2004-11-25 19:49:01.000000000 +0100
@@ -159,7 +159,7 @@
 	return err;
 }
 
-struct file_operations snd_fops =
+static struct file_operations snd_fops =
 {
 	.owner =	THIS_MODULE,
 	.open =		snd_open
@@ -446,8 +446,6 @@
   /* info.c */
 #ifdef CONFIG_PROC_FS
 EXPORT_SYMBOL(snd_seq_root);
-EXPORT_SYMBOL(snd_create_proc_entry);
-EXPORT_SYMBOL(snd_remove_proc_entry);
 EXPORT_SYMBOL(snd_iprintf);
 EXPORT_SYMBOL(snd_info_get_line);
 EXPORT_SYMBOL(snd_info_get_str);
--- linux-2.6.10-rc2-mm3-full/sound/core/info.c.old	2004-11-25 18:28:39.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/info.c	2004-11-25 18:31:26.000000000 +0100
@@ -125,8 +125,8 @@
 	de->owner = THIS_MODULE;
 }
 
-void snd_remove_proc_entry(struct proc_dir_entry *parent,
-			   struct proc_dir_entry *de)
+static void snd_remove_proc_entry(struct proc_dir_entry *parent,
+				  struct proc_dir_entry *de)
 {
 	if (de)
 		remove_proc_entry(de->name, parent);
@@ -521,7 +521,7 @@
  *
  * Returns the pointer of new instance or NULL on failure.
  */
-struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode,
+static struct proc_dir_entry *snd_create_proc_entry(const char *name, mode_t mode,
 					     struct proc_dir_entry *parent)
 {
 	struct proc_dir_entry *p;
--- linux-2.6.10-rc2-mm3-full/sound/core/memory.c.old	2004-11-25 18:34:05.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/memory.c	2004-11-25 18:34:17.000000000 +0100
@@ -89,7 +89,7 @@
 	}
 }
 
-void *__snd_kmalloc(size_t size, int flags, void *caller)
+static void *__snd_kmalloc(size_t size, int flags, void *caller)
 {
 	unsigned long cpu_flags;
 	struct snd_alloc_track *t;
--- linux-2.6.10-rc2-mm3-full/sound/core/oss/mixer_oss.c.old	2004-11-25 18:34:54.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/oss/mixer_oss.c	2004-11-25 18:35:24.000000000 +0100
@@ -360,8 +360,8 @@
 }
 
 /* FIXME: need to unlock BKL to allow preemption */
-int snd_mixer_oss_ioctl(struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg)
+static int snd_mixer_oss_ioctl(struct inode *inode, struct file *file,
+			       unsigned int cmd, unsigned long arg)
 {
 	int err;
 	/* FIXME: need to unlock BKL to allow preemption */
--- linux-2.6.10-rc2-mm3-full/sound/core/oss/pcm_oss.c.old	2004-11-25 18:35:49.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/oss/pcm_oss.c	2004-11-25 18:36:06.000000000 +0100
@@ -77,7 +77,7 @@
 	set_fs(fs);
 }
 
-int snd_pcm_oss_plugin_clear(snd_pcm_substream_t *substream)
+static int snd_pcm_oss_plugin_clear(snd_pcm_substream_t *substream)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_plugin_t *plugin, *next;
@@ -92,7 +92,7 @@
 	return 0;
 }
 
-int snd_pcm_plugin_insert(snd_pcm_plugin_t *plugin)
+static int snd_pcm_plugin_insert(snd_pcm_plugin_t *plugin)
 {
 	snd_pcm_runtime_t *runtime = plugin->plug->runtime;
 	plugin->next = runtime->oss.plugin_first;
--- linux-2.6.10-rc2-mm3-full/sound/core/oss/pcm_plugin.c.old	2004-11-25 18:36:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/oss/pcm_plugin.c	2004-11-25 18:37:11.000000000 +0100
@@ -656,8 +656,8 @@
 	return count;
 }
 
-int snd_pcm_plug_playback_channels_mask(snd_pcm_plug_t *plug,
-					bitset_t *client_vmask)
+static int snd_pcm_plug_playback_channels_mask(snd_pcm_plug_t *plug,
+					       bitset_t *client_vmask)
 {
 	snd_pcm_plugin_t *plugin = snd_pcm_plug_last(plug);
 	if (plugin == NULL) {
@@ -687,33 +687,6 @@
 	}
 }
 
-int snd_pcm_plug_capture_channels_mask(snd_pcm_plug_t *plug,
-				       bitset_t *client_vmask)
-{
-	snd_pcm_plugin_t *plugin = snd_pcm_plug_first(plug);
-	if (plugin == NULL) {
-		return 0;
-	} else {
-		int schannels = plugin->src_format.channels;
-		bitset_t bs[bitset_size(schannels)];
-		bitset_t *srcmask = bs;
-		bitset_t *dstmask;
-		int err;
-		bitset_one(srcmask, schannels);
-		while (1) {
-			err = plugin->dst_channels_mask(plugin, srcmask, &dstmask);
-			if (err < 0)
-				return err;
-			srcmask = dstmask;
-			if (plugin->next == NULL)
-				break;
-			plugin = plugin->next;
-		}
-		bitset_and(client_vmask, srcmask, plugin->dst_format.channels);
-		return 0;
-	}
-}
-
 static int snd_pcm_plug_playback_disable_useless_channels(snd_pcm_plug_t *plug,
 							  snd_pcm_plugin_channel_t *src_channels)
 {
--- linux-2.6.10-rc2-mm3-full/sound/core/oss/route.c.old	2004-11-25 18:37:39.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/oss/route.c	2004-11-25 18:38:03.000000000 +0100
@@ -353,9 +353,9 @@
 	}
 }
 
-int route_src_channels_mask(snd_pcm_plugin_t *plugin,
-			  bitset_t *dst_vmask,
-			  bitset_t **src_vmask)
+static int route_src_channels_mask(snd_pcm_plugin_t *plugin,
+				   bitset_t *dst_vmask,
+				   bitset_t **src_vmask)
 {
 	route_t *data = (route_t *)plugin->extra_data;
 	int schannels = plugin->src_format.channels;
@@ -377,9 +377,9 @@
 	return 0;
 }
 
-int route_dst_channels_mask(snd_pcm_plugin_t *plugin,
-			  bitset_t *src_vmask,
-			  bitset_t **dst_vmask)
+static int route_dst_channels_mask(snd_pcm_plugin_t *plugin,
+				   bitset_t *src_vmask,
+				   bitset_t **dst_vmask)
 {
 	route_t *data = (route_t *)plugin->extra_data;
 	int dchannels = plugin->dst_format.channels;
--- linux-2.6.10-rc2-mm3-full/include/sound/pcm.h.old	2004-11-25 18:40:56.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/pcm.h	2004-11-25 19:22:26.000000000 +0100
@@ -486,21 +486,15 @@
 int snd_pcm_info(snd_pcm_substream_t * substream, snd_pcm_info_t *info);
 int snd_pcm_info_user(snd_pcm_substream_t * substream, snd_pcm_info_t __user *info);
 int snd_pcm_status(snd_pcm_substream_t * substream, snd_pcm_status_t *status);
-int snd_pcm_prepare(snd_pcm_substream_t *substream);
 int snd_pcm_start(snd_pcm_substream_t *substream);
 int snd_pcm_stop(snd_pcm_substream_t *substream, int status);
 int snd_pcm_drain_done(snd_pcm_substream_t *substream);
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
@@ -772,13 +766,9 @@
 void snd_interval_mulkdiv(const snd_interval_t *a, unsigned int k,
 			  const snd_interval_t *b, snd_interval_t *c);
 int snd_interval_list(snd_interval_t *i, unsigned int count, unsigned int *list, unsigned int mask);
-int snd_interval_step(snd_interval_t *i, unsigned int min, unsigned int step);
 int snd_interval_ratnum(snd_interval_t *i,
 			unsigned int rats_count, ratnum_t *rats,
 			unsigned int *nump, unsigned int *denp);
-int snd_interval_ratden(snd_interval_t *i,
-			unsigned int rats_count, ratden_t *rats,
-			unsigned int *nump, unsigned int *denp);
 
 void _snd_pcm_hw_params_any(snd_pcm_hw_params_t *params);
 void _snd_pcm_hw_param_setempty(snd_pcm_hw_params_t *params, snd_pcm_hw_param_t var);
@@ -860,9 +850,7 @@
 const unsigned char *snd_pcm_format_silence_64(snd_pcm_format_t format);
 int snd_pcm_format_set_silence(snd_pcm_format_t format, void *buf, unsigned int frames);
 snd_pcm_format_t snd_pcm_build_linear_format(int width, int unsignd, int big_endian);
-ssize_t snd_pcm_format_size(snd_pcm_format_t format, size_t samples);
 const char *snd_pcm_format_name(snd_pcm_format_t format);
-const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat);
 
 void snd_pcm_set_ops(snd_pcm_t * pcm, int direction, snd_pcm_ops_t *ops);
 void snd_pcm_set_sync(snd_pcm_substream_t * substream);
@@ -875,13 +863,8 @@
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
@@ -927,7 +910,6 @@
  *  Memory
  */
 
-int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream);
 int snd_pcm_lib_preallocate_free_for_all(snd_pcm_t *pcm);
 int snd_pcm_lib_preallocate_pages(snd_pcm_substream_t *substream,
 				  int type, struct device *data,
--- linux-2.6.10-rc2-mm3-full/sound/core/pcm.c.old	2004-11-25 18:38:27.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/pcm.c	2004-11-25 19:22:30.000000000 +0100
@@ -126,12 +126,12 @@
 #define FORMAT(v) [SNDRV_PCM_FORMAT_##v] = #v
 #define SUBFORMAT(v) [SNDRV_PCM_SUBFORMAT_##v] = #v 
 
-char *snd_pcm_stream_names[] = {
+static char *snd_pcm_stream_names[] = {
 	STREAM(PLAYBACK),
 	STREAM(CAPTURE),
 };
 
-char *snd_pcm_state_names[] = {
+static char *snd_pcm_state_names[] = {
 	STATE(OPEN),
 	STATE(SETUP),
 	STATE(PREPARED),
@@ -142,7 +142,7 @@
 	STATE(SUSPENDED),
 };
 
-char *snd_pcm_access_names[] = {
+static char *snd_pcm_access_names[] = {
 	ACCESS(MMAP_INTERLEAVED), 
 	ACCESS(MMAP_NONINTERLEAVED),
 	ACCESS(MMAP_COMPLEX),
@@ -150,7 +150,7 @@
 	ACCESS(RW_NONINTERLEAVED),
 };
 
-char *snd_pcm_format_names[] = {
+static char *snd_pcm_format_names[] = {
 	FORMAT(S8),
 	FORMAT(U8),
 	FORMAT(S16_LE),
@@ -191,22 +191,22 @@
 	FORMAT(U18_3BE),
 };
 
-char *snd_pcm_subformat_names[] = {
+static char *snd_pcm_subformat_names[] = {
 	SUBFORMAT(STD), 
 };
 
-char *snd_pcm_tstamp_mode_names[] = {
+static char *snd_pcm_tstamp_mode_names[] = {
 	TSTAMP(NONE),
 	TSTAMP(MMAP),
 };
 
-const char *snd_pcm_stream_name(snd_pcm_stream_t stream)
+static const char *snd_pcm_stream_name(snd_pcm_stream_t stream)
 {
 	snd_assert(stream <= SNDRV_PCM_STREAM_LAST, return NULL);
 	return snd_pcm_stream_names[stream];
 }
 
-const char *snd_pcm_access_name(snd_pcm_access_t access)
+static const char *snd_pcm_access_name(snd_pcm_access_t access)
 {
 	snd_assert(access <= SNDRV_PCM_ACCESS_LAST, return NULL);
 	return snd_pcm_access_names[access];
@@ -218,19 +218,19 @@
 	return snd_pcm_format_names[format];
 }
 
-const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat)
+static const char *snd_pcm_subformat_name(snd_pcm_subformat_t subformat)
 {
 	snd_assert(subformat <= SNDRV_PCM_SUBFORMAT_LAST, return NULL);
 	return snd_pcm_subformat_names[subformat];
 }
 
-const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
+static const char *snd_pcm_tstamp_mode_name(snd_pcm_tstamp_t mode)
 {
 	snd_assert(mode <= SNDRV_PCM_TSTAMP_LAST, return NULL);
 	return snd_pcm_tstamp_mode_names[mode];
 }
 
-const char *snd_pcm_state_name(snd_pcm_state_t state)
+static const char *snd_pcm_state_name(snd_pcm_state_t state)
 {
 	snd_assert(state <= SNDRV_PCM_STATE_LAST, return NULL);
 	return snd_pcm_state_names[state];
@@ -238,7 +238,7 @@
 
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 #include <linux/soundcard.h>
-const char *snd_pcm_oss_format_name(int format)
+static const char *snd_pcm_oss_format_name(int format)
 {
 	switch (format) {
 	case AFMT_MU_LAW:
@@ -1035,21 +1035,15 @@
 EXPORT_SYMBOL(snd_pcm_open_substream);
 EXPORT_SYMBOL(snd_pcm_release_substream);
 EXPORT_SYMBOL(snd_pcm_format_name);
-EXPORT_SYMBOL(snd_pcm_subformat_name);
   /* pcm_native.c */
 EXPORT_SYMBOL(snd_pcm_link_rwlock);
 EXPORT_SYMBOL(snd_pcm_start);
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
@@ -1062,7 +1056,6 @@
 EXPORT_SYMBOL(snd_pcm_format_big_endian);
 EXPORT_SYMBOL(snd_pcm_format_width);
 EXPORT_SYMBOL(snd_pcm_format_physical_width);
-EXPORT_SYMBOL(snd_pcm_format_size);
 EXPORT_SYMBOL(snd_pcm_format_silence_64);
 EXPORT_SYMBOL(snd_pcm_format_set_silence);
 EXPORT_SYMBOL(snd_pcm_build_linear_format);
--- linux-2.6.10-rc2-mm3-full/sound/core/pcm_lib.c.old	2004-11-25 18:42:20.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/pcm_lib.c	2004-11-25 19:14:59.000000000 +0100
@@ -371,7 +371,7 @@
 	return n;
 }
 
-int snd_interval_refine_min(snd_interval_t *i, unsigned int min, int openmin)
+static int snd_interval_refine_min(snd_interval_t *i, unsigned int min, int openmin)
 {
 	int changed = 0;
 	assert(!snd_interval_empty(i));
@@ -396,7 +396,7 @@
 	return changed;
 }
 
-int snd_interval_refine_max(snd_interval_t *i, unsigned int max, int openmax)
+static int snd_interval_refine_max(snd_interval_t *i, unsigned int max, int openmax)
 {
 	int changed = 0;
 	assert(!snd_interval_empty(i));
@@ -474,7 +474,7 @@
 	return changed;
 }
 
-int snd_interval_refine_first(snd_interval_t *i)
+static int snd_interval_refine_first(snd_interval_t *i)
 {
 	assert(!snd_interval_empty(i));
 	if (snd_interval_single(i))
@@ -486,7 +486,7 @@
 	return 1;
 }
 
-int snd_interval_refine_last(snd_interval_t *i)
+static int snd_interval_refine_last(snd_interval_t *i)
 {
 	assert(!snd_interval_empty(i));
 	if (snd_interval_single(i))
@@ -498,7 +498,7 @@
 	return 1;
 }
 
-int snd_interval_refine_set(snd_interval_t *i, unsigned int val)
+static int snd_interval_refine_set(snd_interval_t *i, unsigned int val)
 {
 	snd_interval_t t;
 	t.empty = 0;
@@ -718,9 +718,9 @@
  *
  * Returns non-zero if the value is changed, zero if not changed.
  */
-int snd_interval_ratden(snd_interval_t *i,
-		    unsigned int rats_count, ratden_t *rats,
-		    unsigned int *nump, unsigned int *denp)
+static int snd_interval_ratden(snd_interval_t *i,
+			       unsigned int rats_count, ratden_t *rats,
+			       unsigned int *nump, unsigned int *denp)
 {
 	unsigned int best_num, best_diff, best_den;
 	unsigned int k;
@@ -858,7 +858,7 @@
         return changed;
 }
 
-int snd_interval_step(snd_interval_t *i, unsigned int min, unsigned int step)
+static int snd_interval_step(snd_interval_t *i, unsigned int min, unsigned int step)
 {
 	unsigned int n;
 	int changed = 0;
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
@@ -2643,7 +2601,6 @@
 EXPORT_SYMBOL(snd_interval_refine);
 EXPORT_SYMBOL(snd_interval_list);
 EXPORT_SYMBOL(snd_interval_ratnum);
-EXPORT_SYMBOL(snd_interval_ratden);
 EXPORT_SYMBOL(snd_interval_muldivk);
 EXPORT_SYMBOL(snd_interval_mulkdiv);
 EXPORT_SYMBOL(snd_interval_div);
@@ -2674,10 +2631,7 @@
 EXPORT_SYMBOL(snd_pcm_set_ops);
 EXPORT_SYMBOL(snd_pcm_set_sync);
 EXPORT_SYMBOL(snd_pcm_lib_ioctl);
-EXPORT_SYMBOL(snd_pcm_playback_ready);
-EXPORT_SYMBOL(snd_pcm_capture_ready);
 EXPORT_SYMBOL(snd_pcm_playback_data);
-EXPORT_SYMBOL(snd_pcm_capture_empty);
 EXPORT_SYMBOL(snd_pcm_stop);
 EXPORT_SYMBOL(snd_pcm_period_elapsed);
 EXPORT_SYMBOL(snd_pcm_lib_write);
@@ -2687,7 +2641,6 @@
 EXPORT_SYMBOL(snd_pcm_lib_buffer_bytes);
 EXPORT_SYMBOL(snd_pcm_lib_period_bytes);
 /* pcm_memory.c */
-EXPORT_SYMBOL(snd_pcm_lib_preallocate_free);
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_free_for_all);
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages);
 EXPORT_SYMBOL(snd_pcm_lib_preallocate_pages_for_all);
--- linux-2.6.10-rc2-mm3-full/sound/core/pcm_memory.c.old	2004-11-25 19:15:11.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/pcm_memory.c	2004-11-25 19:15:22.000000000 +0100
@@ -97,7 +97,7 @@
  *
  * Returns zero if successful, or a negative error code on failure.
  */
-int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream)
+static int snd_pcm_lib_preallocate_free(snd_pcm_substream_t *substream)
 {
 	snd_pcm_lib_preallocate_dma_free(substream);
 	if (substream->proc_prealloc_entry) {
--- linux-2.6.10-rc2-mm3-full/sound/core/pcm_misc.c.old	2004-11-25 19:15:43.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/pcm_misc.c	2004-11-25 19:16:24.000000000 +0100
@@ -267,22 +267,6 @@
 }
 
 /**
- * snd_pcm_format_cpu_endian - Check the PCM format is CPU-endian
- * @format: the format to check
- *
- * Returns 1 if the given PCM format is CPU-endian, 0 if
- * opposite, or a negative error code if endian not specified.
- */
-int snd_pcm_format_cpu_endian(snd_pcm_format_t format)
-{
-#ifdef SNDRV_LITTLE_ENDIAN
-	return snd_pcm_format_little_endian(format);
-#else
-	return snd_pcm_format_big_endian(format);
-#endif
-}
-
-/**
  * snd_pcm_format_width - return the bit-width of the format
  * @format: the format to check
  *
@@ -317,21 +301,6 @@
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
--- linux-2.6.10-rc2-mm3-full/sound/core/pcm_native.c.old	2004-11-25 19:17:39.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/pcm_native.c	2004-11-25 19:22:37.000000000 +0100
@@ -1030,7 +1030,7 @@
  * Trigger SUSPEND to all linked streams.
  * After this call, all streams are changed to SUSPENDED state.
  */
-int snd_pcm_suspend(snd_pcm_substream_t *substream)
+static int snd_pcm_suspend(snd_pcm_substream_t *substream)
 {
 	return snd_pcm_action(&snd_pcm_action_suspend, substream, 0);
 }
@@ -1256,7 +1256,7 @@
 /**
  * snd_pcm_prepare
  */
-int snd_pcm_prepare(snd_pcm_substream_t *substream)
+static int snd_pcm_prepare(snd_pcm_substream_t *substream)
 {
 	int res;
 	snd_card_t *card = substream->pcm->card;
@@ -2020,7 +2020,7 @@
 	return 0;
 }
 
-int snd_pcm_open(struct inode *inode, struct file *file)
+static int snd_pcm_open(struct inode *inode, struct file *file)
 {
 	int cardnum = SNDRV_MINOR_CARD(iminor(inode));
 	int device = SNDRV_MINOR_DEVICE(iminor(inode));
@@ -2079,7 +2079,7 @@
       	return err;
 }
 
-int snd_pcm_release(struct inode *inode, struct file *file)
+static int snd_pcm_release(struct inode *inode, struct file *file)
 {
 	snd_pcm_t *pcm;
 	snd_pcm_substream_t *substream;
@@ -2101,7 +2101,7 @@
 	return 0;
 }
 
-snd_pcm_sframes_t snd_pcm_playback_rewind(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
+static snd_pcm_sframes_t snd_pcm_playback_rewind(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
@@ -2150,7 +2150,7 @@
 	return ret;
 }
 
-snd_pcm_sframes_t snd_pcm_capture_rewind(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
+static snd_pcm_sframes_t snd_pcm_capture_rewind(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
@@ -2199,7 +2199,7 @@
 	return ret;
 }
 
-snd_pcm_sframes_t snd_pcm_playback_forward(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
+static snd_pcm_sframes_t snd_pcm_playback_forward(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
@@ -2249,7 +2249,7 @@
 	return ret;
 }
 
-snd_pcm_sframes_t snd_pcm_capture_forward(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
+static snd_pcm_sframes_t snd_pcm_capture_forward(snd_pcm_substream_t *substream, snd_pcm_uframes_t frames)
 {
 	snd_pcm_runtime_t *runtime = substream->runtime;
 	snd_pcm_sframes_t appl_ptr;
@@ -2835,7 +2835,7 @@
 	return result;
 }
 
-unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
+static unsigned int snd_pcm_playback_poll(struct file *file, poll_table * wait)
 {
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
@@ -2873,7 +2873,7 @@
 	return mask;
 }
 
-unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
+static unsigned int snd_pcm_capture_poll(struct file *file, poll_table * wait)
 {
 	snd_pcm_file_t *pcm_file;
 	snd_pcm_substream_t *substream;
--- linux-2.6.10-rc2-mm3-full/include/sound/rawmidi.h.old	2004-11-25 19:23:00.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/rawmidi.h	2004-11-25 19:25:11.000000000 +0100
@@ -152,13 +152,6 @@
 		    snd_rawmidi_t ** rmidi);
 void snd_rawmidi_set_ops(snd_rawmidi_t * rmidi, int stream, snd_rawmidi_ops_t * ops);
 
-/* control functions */
-
-int snd_rawmidi_control_ioctl(snd_card_t * card,
-			      snd_ctl_file_t * control,
-			      unsigned int cmd,
-			      unsigned long arg);
-
 /* callbacks */
 
 void snd_rawmidi_receive_reset(snd_rawmidi_substream_t * substream);
@@ -176,9 +169,7 @@
 int snd_rawmidi_kernel_release(snd_rawmidi_file_t * rfile);
 int snd_rawmidi_output_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
 int snd_rawmidi_input_params(snd_rawmidi_substream_t * substream, snd_rawmidi_params_t * params);
-int snd_rawmidi_drop_output(snd_rawmidi_substream_t * substream);
 int snd_rawmidi_drain_output(snd_rawmidi_substream_t * substream);
-int snd_rawmidi_drain_input(snd_rawmidi_substream_t * substream);
 long snd_rawmidi_kernel_read(snd_rawmidi_substream_t * substream, unsigned char *buf, long count);
 long snd_rawmidi_kernel_write(snd_rawmidi_substream_t * substream, const unsigned char *buf, long count);
 
--- linux-2.6.10-rc2-mm3-full/sound/core/rawmidi.c.old	2004-11-25 19:23:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/rawmidi.c	2004-11-25 19:26:24.000000000 +0100
@@ -54,7 +54,7 @@
 static int snd_rawmidi_dev_disconnect(snd_device_t *device);
 static int snd_rawmidi_dev_unregister(snd_device_t *device);
 
-snd_rawmidi_t *snd_rawmidi_devices[SNDRV_CARDS * SNDRV_RAWMIDI_DEVICES];
+static snd_rawmidi_t *snd_rawmidi_devices[SNDRV_CARDS * SNDRV_RAWMIDI_DEVICES];
 
 static DECLARE_MUTEX(register_mutex);
 
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
 
@@ -519,7 +519,7 @@
 	return err;
 }
 
-int snd_rawmidi_info(snd_rawmidi_substream_t *substream, snd_rawmidi_info_t *info)
+static int snd_rawmidi_info(snd_rawmidi_substream_t *substream, snd_rawmidi_info_t *info)
 {
 	snd_rawmidi_t *rmidi;
 	
@@ -795,8 +795,10 @@
 	return err;
 }
 
-int snd_rawmidi_control_ioctl(snd_card_t * card, snd_ctl_file_t * control,
-			      unsigned int cmd, unsigned long arg)
+static int snd_rawmidi_control_ioctl(snd_card_t * card,
+				     snd_ctl_file_t * control,
+				     unsigned int cmd,
+				     unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	unsigned int tmp;
@@ -1654,9 +1656,7 @@
 
 EXPORT_SYMBOL(snd_rawmidi_output_params);
 EXPORT_SYMBOL(snd_rawmidi_input_params);
-EXPORT_SYMBOL(snd_rawmidi_drop_output);
 EXPORT_SYMBOL(snd_rawmidi_drain_output);
-EXPORT_SYMBOL(snd_rawmidi_drain_input);
 EXPORT_SYMBOL(snd_rawmidi_receive);
 EXPORT_SYMBOL(snd_rawmidi_transmit_empty);
 EXPORT_SYMBOL(snd_rawmidi_transmit_peek);
@@ -1664,7 +1664,6 @@
 EXPORT_SYMBOL(snd_rawmidi_transmit);
 EXPORT_SYMBOL(snd_rawmidi_new);
 EXPORT_SYMBOL(snd_rawmidi_set_ops);
-EXPORT_SYMBOL(snd_rawmidi_info);
 EXPORT_SYMBOL(snd_rawmidi_info_select);
 EXPORT_SYMBOL(snd_rawmidi_kernel_open);
 EXPORT_SYMBOL(snd_rawmidi_kernel_release);
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/oss/seq_oss_device.h.old	2004-11-25 19:26:40.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/oss/seq_oss_device.h	2004-11-25 19:26:49.000000000 +0100
@@ -185,7 +185,6 @@
 
 /* misc. functions for proc interface */
 char *enabled_str(int bool);
-char *filemode_str(int fmode);
 
 
 /* for debug */
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/oss/seq_oss_init.c.old	2004-11-25 19:26:56.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/oss/seq_oss_init.c	2004-11-25 19:27:31.000000000 +0100
@@ -491,6 +491,26 @@
 	snd_seq_oss_timer_stop(dp->timer);
 }
 
+
+/*
+ * misc. functions for proc interface
+ */
+char *
+enabled_str(int bool)
+{
+	return bool ? "enabled" : "disabled";
+}
+
+static char *
+filemode_str(int val)
+{
+	static char *str[] = {
+		"none", "read", "write", "read/write",
+	};
+	return str[val & SNDRV_SEQ_OSS_FILE_ACMODE];
+}
+
+
 /*
  * proc interface
  */
@@ -523,22 +543,3 @@
 	}
 }
 
-/*
- * misc. functions for proc interface
- */
-char *
-enabled_str(int bool)
-{
-	return bool ? "enabled" : "disabled";
-}
-
-char *
-filemode_str(int val)
-{
-	static char *str[] = {
-		"none", "read", "write", "read/write",
-	};
-	return str[val & SNDRV_SEQ_OSS_FILE_ACMODE];
-}
-
-
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_clientmgr.h.old	2004-11-25 19:28:12.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_clientmgr.h	2004-11-25 19:28:17.000000000 +0100
@@ -100,6 +100,5 @@
 int snd_seq_kernel_client_enqueue_blocking(int client, snd_seq_event_t * ev, struct file *file, int atomic, int hop);
 int snd_seq_kernel_client_write_poll(int clientid, struct file *file, poll_table *wait);
 int snd_seq_client_notify_subscription(int client, int port, snd_seq_port_subscribe_t *info, int evtype);
-int snd_seq_deliver_event(client_t *client, snd_seq_event_t *event, int atomic, int hop);
 
 #endif
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_clientmgr.c.old	2004-11-25 19:28:23.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_clientmgr.c	2004-11-25 19:28:36.000000000 +0100
@@ -751,8 +751,8 @@
  *               n == 0 : the event was not passed to any client.
  *               n < 0  : error - event was not processed.
  */
-int snd_seq_deliver_event(client_t *client, snd_seq_event_t *event,
-			  int atomic, int hop)
+static int snd_seq_deliver_event(client_t *client, snd_seq_event_t *event,
+				 int atomic, int hop)
 {
 	int result;
 
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_instr.c.old	2004-11-25 19:29:08.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_instr.c	2004-11-25 19:31:46.000000000 +0100
@@ -49,19 +49,7 @@
 	}
 }
 
-snd_seq_kcluster_t *snd_seq_cluster_new(int atomic)
-{
-	return kcalloc(1, sizeof(snd_seq_kcluster_t), atomic ? GFP_ATOMIC : GFP_KERNEL);
-}
-
-void snd_seq_cluster_free(snd_seq_kcluster_t *cluster, int atomic)
-{
-	if (cluster == NULL)
-		return;
-	kfree(cluster);
-}
-
-snd_seq_kinstr_t *snd_seq_instr_new(int add_len, int atomic)
+static snd_seq_kinstr_t *snd_seq_instr_new(int add_len, int atomic)
 {
 	snd_seq_kinstr_t *instr;
 	
@@ -72,7 +60,7 @@
 	return instr;
 }
 
-int snd_seq_instr_free(snd_seq_kinstr_t *instr, int atomic)
+static int snd_seq_instr_free(snd_seq_kinstr_t *instr, int atomic)
 {
 	int result = 0;
 
@@ -132,7 +120,7 @@
 		while ((cluster = list->chash[idx]) != NULL) {
 			list->chash[idx] = cluster->next;
 			list->ccount--;
-			snd_seq_cluster_free(cluster, 0);
+			kfree(cluster);
 		}
 	}
 	kfree(list);
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_memory.h.old	2004-11-25 19:32:02.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_memory.h	2004-11-25 19:32:14.000000000 +0100
@@ -64,7 +64,6 @@
 };
 
 extern void snd_seq_cell_free(snd_seq_event_cell_t* cell);
-int snd_seq_cell_alloc(pool_t *pool, snd_seq_event_cell_t **cellp, int nonblock, struct file *file);
 
 int snd_seq_event_dup(pool_t *pool, snd_seq_event_t *event, snd_seq_event_cell_t **cellp, int nonblock, struct file *file);
 
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_memory.c.old	2004-11-25 19:32:22.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_memory.c	2004-11-25 19:32:28.000000000 +0100
@@ -215,7 +215,7 @@
 /*
  * allocate an event cell.
  */
-int snd_seq_cell_alloc(pool_t *pool, snd_seq_event_cell_t **cellp, int nonblock, struct file *file)
+static int snd_seq_cell_alloc(pool_t *pool, snd_seq_event_cell_t **cellp, int nonblock, struct file *file)
 {
 	snd_seq_event_cell_t *cell;
 	unsigned long flags;
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi.c.old	2004-11-25 19:32:46.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi.c	2004-11-25 19:33:33.000000000 +0100
@@ -43,10 +43,10 @@
 MODULE_AUTHOR("Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer MIDI synth.");
 MODULE_LICENSE("GPL");
-int output_buffer_size = PAGE_SIZE;
+static int output_buffer_size = PAGE_SIZE;
 module_param(output_buffer_size, int, 0644);
 MODULE_PARM_DESC(output_buffer_size, "Output buffer size in bytes.");
-int input_buffer_size = PAGE_SIZE;
+static int input_buffer_size = PAGE_SIZE;
 module_param(input_buffer_size, int, 0644);
 MODULE_PARM_DESC(input_buffer_size, "Input buffer size in bytes.");
 
@@ -284,7 +284,7 @@
 }
 
 /* register new midi synth port */
-int
+static int
 snd_seq_midisynth_register_port(snd_seq_device_t *dev)
 {
 	seq_midisynth_client_t *client;
@@ -423,7 +423,7 @@
 }
 
 /* release midi synth port */
-int
+static int
 snd_seq_midisynth_unregister_port(snd_seq_device_t *dev)
 {
 	seq_midisynth_client_t *client;
--- linux-2.6.10-rc2-mm3-full/include/sound/seq_midi_emul.h.old	2004-11-25 19:44:12.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/seq_midi_emul.h	2004-11-25 19:44:19.000000000 +0100
@@ -189,8 +189,6 @@
 void snd_midi_process_event(snd_midi_op_t *ops, snd_seq_event_t *ev,
 			    snd_midi_channel_set_t *chanset);
 void snd_midi_channel_set_clear(snd_midi_channel_set_t *chset);
-void snd_midi_channel_init(snd_midi_channel_t *p, int n);
-snd_midi_channel_t *snd_midi_channel_init_set(int n);
 snd_midi_channel_set_t *snd_midi_channel_alloc_set(int n);
 void snd_midi_channel_free_set(snd_midi_channel_set_t *chset);
 
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi_emul.c.old	2004-11-25 19:44:26.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi_emul.c	2004-11-25 19:45:02.000000000 +0100
@@ -53,7 +53,7 @@
 static void sysex(snd_midi_op_t *ops, void *private, unsigned char *sysex, int len, snd_midi_channel_set_t *chset);
 static void all_sounds_off(snd_midi_op_t *ops, void *private, snd_midi_channel_t *chan);
 static void all_notes_off(snd_midi_op_t *ops, void *private, snd_midi_channel_t *chan);
-void snd_midi_reset_controllers(snd_midi_channel_t *chan);
+static void snd_midi_reset_controllers(snd_midi_channel_t *chan);
 static void reset_all_channels(snd_midi_channel_set_t *chset);
 
 
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
@@ -697,7 +697,7 @@
 /*
  * Reset the midi controllers on a particular channel to default values.
  */
-void snd_midi_reset_controllers(snd_midi_channel_t *chan)
+static void snd_midi_reset_controllers(snd_midi_channel_t *chan)
 {
 	memset(chan->control, 0, sizeof(chan->control));
 	chan->gm_volume = 127;
@@ -732,7 +732,5 @@
 
 EXPORT_SYMBOL(snd_midi_process_event);
 EXPORT_SYMBOL(snd_midi_channel_set_clear);
-EXPORT_SYMBOL(snd_midi_channel_init);
-EXPORT_SYMBOL(snd_midi_channel_init_set);
 EXPORT_SYMBOL(snd_midi_channel_alloc_set);
 EXPORT_SYMBOL(snd_midi_channel_free_set);
--- linux-2.6.10-rc2-mm3-full/include/sound/seq_midi_event.h.old	2004-11-25 19:45:19.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/seq_midi_event.h	2004-11-25 19:46:07.000000000 +0100
@@ -41,9 +41,7 @@
 };
 
 int snd_midi_event_new(int bufsize, snd_midi_event_t **rdev);
-int snd_midi_event_resize_buffer(snd_midi_event_t *dev, int bufsize);
 void snd_midi_event_free(snd_midi_event_t *dev);
-void snd_midi_event_init(snd_midi_event_t *dev);
 void snd_midi_event_reset_encode(snd_midi_event_t *dev);
 void snd_midi_event_reset_decode(snd_midi_event_t *dev);
 void snd_midi_event_no_status(snd_midi_event_t *dev, int on);
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi_event.c.old	2004-11-25 19:46:02.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_midi_event.c	2004-11-25 19:46:17.000000000 +0100
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
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_queue.h.old	2004-11-25 19:46:39.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_queue.h	2004-11-25 19:46:46.000000000 +0100
@@ -111,7 +111,6 @@
 int snd_seq_queue_is_used(int queueid, int client);
 
 int snd_seq_control_queue(snd_seq_event_t *ev, int atomic, int hop);
-void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev, int from_timer_port, int atomic, int hop);
 
 /*
  * 64bit division - for sync stuff..
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_queue.c.old	2004-11-25 19:46:53.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_queue.c	2004-11-25 19:47:01.000000000 +0100
@@ -674,7 +674,7 @@
  * process a received queue-control event.
  * this function is exported for seq_sync.c.
  */
-void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev, int from_timer_port, int atomic, int hop)
+static void snd_seq_queue_process_event(queue_t *q, snd_seq_event_t *ev, int from_timer_port, int atomic, int hop)
 {
 	switch (ev->type) {
 	case SNDRV_SEQ_EVENT_START:
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_timer.h.old	2004-11-25 19:47:20.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_timer.h	2004-11-25 19:47:28.000000000 +0100
@@ -64,8 +64,6 @@
 /* delete timer (destructor) */
 extern void snd_seq_timer_delete(seq_timer_t **tmr);
 
-void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick, int tempo, int ppq, int nticks);
-
 /* */
 static inline void snd_seq_timer_update_tick(seq_timer_tick_t *tick, unsigned long resolution)
 {
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_timer.c.old	2004-11-25 19:47:36.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_timer.c	2004-11-25 19:47:41.000000000 +0100
@@ -36,7 +36,7 @@
 
 #define SKEW_BASE	0x10000	/* 16bit shift */
 
-void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick, int tempo, int ppq, int nticks)
+static void snd_seq_timer_set_tick_resolution(seq_timer_tick_t *tick, int tempo, int ppq, int nticks)
 {
 	if (tempo < 1000000)
 		tick->resolution = (tempo * 1000) / ppq;
--- linux-2.6.10-rc2-mm3-full/include/sound/seq_virmidi.h.old	2004-11-25 19:47:59.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/seq_virmidi.h	2004-11-25 19:48:21.000000000 +0100
@@ -79,6 +79,5 @@
 #define SNDRV_VIRMIDI_SEQ_DISPATCH	2
 
 int snd_virmidi_new(snd_card_t *card, int device, snd_rawmidi_t **rrmidi);
-int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev);
 
 #endif /* __SOUND_SEQ_VIRMIDI */
--- linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_virmidi.c.old	2004-11-25 19:48:29.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/seq/seq_virmidi.c	2004-11-25 19:48:39.000000000 +0100
@@ -104,22 +104,6 @@
 }
 
 /*
- * receive an event from the remote virmidi port
- *
- * for rawmidi inputs, you can call this function from the event
- * handler of a remote port which is attached to the virmidi via
- * SNDRV_VIRMIDI_SEQ_ATTACH.
- */
-/* exported */
-int snd_virmidi_receive(snd_rawmidi_t *rmidi, snd_seq_event_t *ev)
-{
-	snd_virmidi_dev_t *rdev;
-
-	rdev = rmidi->private_data;
-	return snd_virmidi_dev_receive_event(rdev, ev);
-}
-
-/*
  * event handler of virmidi port
  */
 static int snd_virmidi_event_input(snd_seq_event_t *ev, int direct,
@@ -534,4 +518,3 @@
 module_exit(alsa_virmidi_exit)
 
 EXPORT_SYMBOL(snd_virmidi_new);
-EXPORT_SYMBOL(snd_virmidi_receive);
--- linux-2.6.10-rc2-mm3-full/include/sound/timer.h.old	2004-11-25 19:49:14.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/include/sound/timer.h	2004-11-25 19:49:57.000000000 +0100
@@ -147,11 +147,8 @@
 extern unsigned long snd_timer_resolution(snd_timer_instance_t * timeri);
 extern int snd_timer_start(snd_timer_instance_t * timeri, unsigned int ticks);
 extern int snd_timer_stop(snd_timer_instance_t * timeri);
-extern int snd_timer_continue(snd_timer_instance_t * timeri);
 extern int snd_timer_pause(snd_timer_instance_t * timeri);
 
 extern void snd_timer_interrupt(snd_timer_t * timer, unsigned long ticks_left);
 
-extern unsigned int snd_timer_system_resolution(void);
-
 #endif /* __SOUND_TIMER_H */
--- linux-2.6.10-rc2-mm3-full/sound/core/timer.c.old	2004-11-25 19:49:31.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/sound/core/timer.c	2004-11-25 19:50:16.000000000 +0100
@@ -531,7 +531,7 @@
 /*
  * start again..  the tick is kept.
  */
-int snd_timer_continue(snd_timer_instance_t * timeri)
+static int snd_timer_continue(snd_timer_instance_t * timeri)
 {
 	snd_timer_t *timer;
 	int result = -EINVAL;
@@ -843,7 +843,7 @@
 	return 0;
 }
 
-int snd_timer_unregister(snd_timer_t *timer)
+static int snd_timer_unregister(snd_timer_t *timer)
 {
 	struct list_head *p, *n;
 	snd_timer_instance_t *ti;
@@ -944,11 +944,6 @@
 	unsigned long correction;
 };
 
-unsigned int snd_timer_system_resolution(void)
-{
-	return 1000000000L / HZ;
-}
-
 static void snd_timer_s_function(unsigned long data)
 {
 	snd_timer_t *timer = (snd_timer_t *)data;
@@ -1882,7 +1877,6 @@
 EXPORT_SYMBOL(snd_timer_resolution);
 EXPORT_SYMBOL(snd_timer_start);
 EXPORT_SYMBOL(snd_timer_stop);
-EXPORT_SYMBOL(snd_timer_continue);
 EXPORT_SYMBOL(snd_timer_pause);
 EXPORT_SYMBOL(snd_timer_new);
 EXPORT_SYMBOL(snd_timer_notify);
@@ -1891,4 +1885,3 @@
 EXPORT_SYMBOL(snd_timer_global_register);
 EXPORT_SYMBOL(snd_timer_global_unregister);
 EXPORT_SYMBOL(snd_timer_interrupt);
-EXPORT_SYMBOL(snd_timer_system_resolution);

