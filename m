Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932565AbVLPXNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVLPXNZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 18:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbVLPXNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 18:13:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35292 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932563AbVLPXNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 18:13:24 -0500
Date: Fri, 16 Dec 2005 23:13:08 GMT
Message-Id: <200512162313.jBGND8jx019641@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Fcc: outgoing
Subject: [PATCH 10/12]: MUTEX: Rename DECLARE_MUTEX for sound/ dir
In-Reply-To: <dhowells1134774786@warthog.cambridge.redhat.com>
References: <dhowells1134774786@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch renames DECLARE_MUTEX*() to DECLARE_SEM_MUTEX*() for the
sound/ directory.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 mutex-sound-2615rc5-2.diff
 sound/arm/pxa2xx-ac97.c             |    2 +-
 sound/core/hwdep.c                  |    2 +-
 sound/core/info.c                   |    2 +-
 sound/core/info_oss.c               |    2 +-
 sound/core/memalloc.c               |    2 +-
 sound/core/pcm.c                    |    2 +-
 sound/core/rawmidi.c                |    2 +-
 sound/core/seq/oss/seq_oss.c        |    2 +-
 sound/core/seq/seq_clientmgr.c      |    2 +-
 sound/core/seq/seq_device.c         |    2 +-
 sound/core/seq/seq_midi.c           |    2 +-
 sound/core/sound.c                  |    2 +-
 sound/core/sound_oss.c              |    2 +-
 sound/core/timer.c                  |    2 +-
 sound/oss/ac97_codec.c              |    2 +-
 sound/oss/dmasound/dmasound_awacs.c |    2 +-
 sound/usb/usbaudio.c                |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff -uNrp linux-2.6.15-rc5/sound/arm/pxa2xx-ac97.c linux-2.6.15-rc5-mutex/sound/arm/pxa2xx-ac97.c
--- linux-2.6.15-rc5/sound/arm/pxa2xx-ac97.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/arm/pxa2xx-ac97.c	2005-12-15 17:14:56.000000000 +0000
@@ -33,7 +33,7 @@
 #include "pxa2xx-pcm.h"
 
 
-static DECLARE_MUTEX(car_mutex);
+static DECLARE_SEM_MUTEX(car_mutex);
 static DECLARE_WAIT_QUEUE_HEAD(gsr_wq);
 static volatile long gsr_bits;
 
diff -uNrp linux-2.6.15-rc5/sound/core/hwdep.c linux-2.6.15-rc5-mutex/sound/core/hwdep.c
--- linux-2.6.15-rc5/sound/core/hwdep.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/hwdep.c	2005-12-15 17:14:56.000000000 +0000
@@ -37,7 +37,7 @@ MODULE_LICENSE("GPL");
 
 static snd_hwdep_t *snd_hwdep_devices[SNDRV_CARDS * SNDRV_MINOR_HWDEPS];
 
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 static int snd_hwdep_free(snd_hwdep_t *hwdep);
 static int snd_hwdep_dev_free(snd_device_t *device);
diff -uNrp linux-2.6.15-rc5/sound/core/info.c linux-2.6.15-rc5-mutex/sound/core/info.c
--- linux-2.6.15-rc5/sound/core/info.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/info.c	2005-12-15 17:14:56.000000000 +0000
@@ -68,7 +68,7 @@ int snd_info_check_reserved_words(const 
 
 #ifdef CONFIG_PROC_FS
 
-static DECLARE_MUTEX(info_mutex);
+static DECLARE_SEM_MUTEX(info_mutex);
 
 typedef struct _snd_info_private_data {
 	snd_info_buffer_t *rbuffer;
diff -uNrp linux-2.6.15-rc5/sound/core/info_oss.c linux-2.6.15-rc5-mutex/sound/core/info_oss.c
--- linux-2.6.15-rc5/sound/core/info_oss.c	2005-08-30 13:56:44.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/core/info_oss.c	2005-12-15 17:14:56.000000000 +0000
@@ -35,7 +35,7 @@
  *  OSS compatible part
  */
 
-static DECLARE_MUTEX(strings);
+static DECLARE_SEM_MUTEX(strings);
 static char *snd_sndstat_strings[SNDRV_CARDS][SNDRV_OSS_INFO_DEV_COUNT];
 static snd_info_entry_t *snd_sndstat_proc_entry;
 
diff -uNrp linux-2.6.15-rc5/sound/core/memalloc.c linux-2.6.15-rc5-mutex/sound/core/memalloc.c
--- linux-2.6.15-rc5/sound/core/memalloc.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/memalloc.c	2005-12-15 17:14:56.000000000 +0000
@@ -58,7 +58,7 @@ int snd_free_sgbuf_pages(struct snd_dma_
 /*
  */
 
-static DECLARE_MUTEX(list_mutex);
+static DECLARE_SEM_MUTEX(list_mutex);
 static LIST_HEAD(mem_list_head);
 
 /* buffer preservation list */
diff -uNrp linux-2.6.15-rc5/sound/core/pcm.c linux-2.6.15-rc5-mutex/sound/core/pcm.c
--- linux-2.6.15-rc5/sound/core/pcm.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/pcm.c	2005-12-15 17:14:56.000000000 +0000
@@ -35,7 +35,7 @@ MODULE_LICENSE("GPL");
 
 snd_pcm_t *snd_pcm_devices[SNDRV_CARDS * SNDRV_PCM_DEVICES];
 static LIST_HEAD(snd_pcm_notify_list);
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 static int snd_pcm_free(snd_pcm_t *pcm);
 static int snd_pcm_dev_free(snd_device_t *device);
diff -uNrp linux-2.6.15-rc5/sound/core/rawmidi.c linux-2.6.15-rc5-mutex/sound/core/rawmidi.c
--- linux-2.6.15-rc5/sound/core/rawmidi.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/rawmidi.c	2005-12-15 17:14:56.000000000 +0000
@@ -58,7 +58,7 @@ static int snd_rawmidi_dev_unregister(sn
 
 static snd_rawmidi_t *snd_rawmidi_devices[SNDRV_CARDS * SNDRV_RAWMIDI_DEVICES];
 
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 static inline unsigned short snd_rawmidi_file_flags(struct file *file)
 {
diff -uNrp linux-2.6.15-rc5/sound/core/seq/oss/seq_oss.c linux-2.6.15-rc5-mutex/sound/core/seq/oss/seq_oss.c
--- linux-2.6.15-rc5/sound/core/seq/oss/seq_oss.c	2005-06-22 13:52:38.000000000 +0100
+++ linux-2.6.15-rc5-mutex/sound/core/seq/oss/seq_oss.c	2005-12-15 17:14:56.000000000 +0000
@@ -122,7 +122,7 @@ module_exit(alsa_seq_oss_exit)
  * ALSA minor device interface
  */
 
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 static int
 odev_open(struct inode *inode, struct file *file)
diff -uNrp linux-2.6.15-rc5/sound/core/seq/seq_clientmgr.c linux-2.6.15-rc5-mutex/sound/core/seq/seq_clientmgr.c
--- linux-2.6.15-rc5/sound/core/seq/seq_clientmgr.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_clientmgr.c	2005-12-15 17:14:56.000000000 +0000
@@ -52,7 +52,7 @@
 #define SNDRV_SEQ_LFLG_OPEN	(SNDRV_SEQ_LFLG_INPUT|SNDRV_SEQ_LFLG_OUTPUT)
 
 static DEFINE_SPINLOCK(clients_lock);
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 /*
  * client table
diff -uNrp linux-2.6.15-rc5/sound/core/seq/seq_device.c linux-2.6.15-rc5-mutex/sound/core/seq/seq_device.c
--- linux-2.6.15-rc5/sound/core/seq/seq_device.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_device.c	2005-12-15 17:14:56.000000000 +0000
@@ -82,7 +82,7 @@ struct ops_list {
 
 static LIST_HEAD(opslist);
 static int num_ops;
-static DECLARE_MUTEX(ops_mutex);
+static DECLARE_SEM_MUTEX(ops_mutex);
 static snd_info_entry_t *info_entry = NULL;
 
 /*
diff -uNrp linux-2.6.15-rc5/sound/core/seq/seq_midi.c linux-2.6.15-rc5-mutex/sound/core/seq/seq_midi.c
--- linux-2.6.15-rc5/sound/core/seq/seq_midi.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/seq/seq_midi.c	2005-12-15 17:14:56.000000000 +0000
@@ -70,7 +70,7 @@ typedef struct {
 } seq_midisynth_client_t;
 
 static seq_midisynth_client_t *synths[SNDRV_CARDS];
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 /* handle rawmidi input event (MIDI v1.0 stream) */
 static void snd_midi_input_event(snd_rawmidi_substream_t * substream)
diff -uNrp linux-2.6.15-rc5/sound/core/sound.c linux-2.6.15-rc5-mutex/sound/core/sound.c
--- linux-2.6.15-rc5/sound/core/sound.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/sound.c	2005-12-15 17:14:56.000000000 +0000
@@ -62,7 +62,7 @@ int snd_ecards_limit;
 
 static struct list_head snd_minors_hash[SNDRV_CARDS];
 
-static DECLARE_MUTEX(sound_mutex);
+static DECLARE_SEM_MUTEX(sound_mutex);
 
 extern struct class *sound_class;
 
diff -uNrp linux-2.6.15-rc5/sound/core/sound_oss.c linux-2.6.15-rc5-mutex/sound/core/sound_oss.c
--- linux-2.6.15-rc5/sound/core/sound_oss.c	2005-11-01 13:19:27.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/sound_oss.c	2005-12-15 17:14:56.000000000 +0000
@@ -39,7 +39,7 @@
 
 static struct list_head snd_oss_minors_hash[SNDRV_CARDS];
 
-static DECLARE_MUTEX(sound_oss_mutex);
+static DECLARE_SEM_MUTEX(sound_oss_mutex);
 
 static snd_minor_t *snd_oss_minor_search(int minor)
 {
diff -uNrp linux-2.6.15-rc5/sound/core/timer.c linux-2.6.15-rc5-mutex/sound/core/timer.c
--- linux-2.6.15-rc5/sound/core/timer.c	2005-12-08 16:23:57.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/core/timer.c	2005-12-15 17:14:56.000000000 +0000
@@ -82,7 +82,7 @@ static LIST_HEAD(snd_timer_slave_list);
 /* lock for slave active lists */
 static DEFINE_SPINLOCK(slave_active_lock);
 
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 
 static int snd_timer_free(snd_timer_t *timer);
 static int snd_timer_dev_free(snd_device_t *device);
diff -uNrp linux-2.6.15-rc5/sound/oss/ac97_codec.c linux-2.6.15-rc5-mutex/sound/oss/ac97_codec.c
--- linux-2.6.15-rc5/sound/oss/ac97_codec.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/ac97_codec.c	2005-12-15 17:14:56.000000000 +0000
@@ -304,7 +304,7 @@ static const unsigned int ac97_oss_rm[] 
 
 static LIST_HEAD(codecs);
 static LIST_HEAD(codec_drivers);
-static DECLARE_MUTEX(codec_sem);
+static DECLARE_SEM_MUTEX(codec_sem);
 
 /* reads the given OSS mixer from the ac97 the caller must have insured that the ac97 knows
    about that given mixer, and should be holding a spinlock for the card */
diff -uNrp linux-2.6.15-rc5/sound/oss/dmasound/dmasound_awacs.c linux-2.6.15-rc5-mutex/sound/oss/dmasound/dmasound_awacs.c
--- linux-2.6.15-rc5/sound/oss/dmasound/dmasound_awacs.c	2005-12-08 16:23:58.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/oss/dmasound/dmasound_awacs.c	2005-12-15 17:14:56.000000000 +0000
@@ -129,7 +129,7 @@ static struct device_node* i2s_node;
 static char awacs_name[64];
 static int awacs_revision;
 static int awacs_sleeping;
-static DECLARE_MUTEX(dmasound_sem);
+static DECLARE_SEM_MUTEX(dmasound_sem);
 
 static int sound_device_id;		/* exists after iMac revA */
 static int hw_can_byteswap = 1 ;	/* most pmac sound h/w can */
diff -uNrp linux-2.6.15-rc5/sound/usb/usbaudio.c linux-2.6.15-rc5-mutex/sound/usb/usbaudio.c
--- linux-2.6.15-rc5/sound/usb/usbaudio.c	2005-12-08 16:23:59.000000000 +0000
+++ linux-2.6.15-rc5-mutex/sound/usb/usbaudio.c	2005-12-15 17:14:56.000000000 +0000
@@ -204,7 +204,7 @@ struct snd_usb_stream {
  * the all interfaces on the same card as one sound device.
  */
 
-static DECLARE_MUTEX(register_mutex);
+static DECLARE_SEM_MUTEX(register_mutex);
 static snd_usb_audio_t *usb_chip[SNDRV_CARDS];
 
 
