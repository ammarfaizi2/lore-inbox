Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbULFAMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbULFAMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 19:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbULFAMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 19:12:47 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42249 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261429AbULFAMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 19:12:24 -0500
Date: Mon, 6 Dec 2004 01:12:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA: misc cleanups
Message-ID: <20041206001221.GG2953@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below contains the following changes in ALSA code not touched 
by my previous patches:
- make some needlessly global code static
- remove the following unused global functions:
  - sound/i2c/cs84: snd_cs8427_detect
  - sound/synth/emux/emux_synth.c: snd_emux_release_voice
  - sound/synth/emux/soundfont.: snd_soundfont_mem_used
- remove the following unused EXPORT_SYMBOL's:
  - sound/i2c/cs8427.c: snd_cs8427_detect
  - sound/i2c/cs8427.c: snd_cs8427_reg_read

Please review which of these changes are correct and which conflict with 
pending patches.


diffstat output:
 include/sound/cs8427.h          |    3 ---
 include/sound/soundfont.h       |    1 -
 include/sound/vx_core.h         |    1 -
 sound/drivers/opl3/opl3_drums.c |    8 ++++----
 sound/drivers/opl3/opl3_lib.c   |    4 ++--
 sound/drivers/opl3/opl3_midi.c  |    2 +-
 sound/drivers/opl3/opl3_seq.c   |    4 ++--
 sound/drivers/vx/vx_cmd.c       |    2 +-
 sound/drivers/vx/vx_cmd.h       |    2 --
 sound/drivers/vx/vx_uer.c       |    2 +-
 sound/i2c/cs8427.c              |   18 ++++--------------
 sound/synth/emux/emux_synth.c   |   10 ----------
 sound/synth/emux/soundfont.c    |    8 --------
 13 files changed, 15 insertions(+), 50 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_drums.c.old	2004-12-05 23:33:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_drums.c	2004-12-05 23:34:13.000000000 +0100
@@ -80,7 +80,7 @@
 /*
  * set drum voice characteristics
  */
-void snd_opl3_drum_voice_set(opl3_t *opl3, snd_opl3_drum_voice_t *data)
+static void snd_opl3_drum_voice_set(opl3_t *opl3, snd_opl3_drum_voice_t *data)
 {
 	unsigned char op_offset = snd_opl3_regmap[data->voice][data->op];
 	unsigned char voice_offset = data->voice;
@@ -114,7 +114,7 @@
 /*
  * Set drum voice pitch
  */
-void snd_opl3_drum_note_set(opl3_t *opl3, snd_opl3_drum_note_t *data)
+static void snd_opl3_drum_note_set(opl3_t *opl3, snd_opl3_drum_note_t *data)
 {
 	unsigned char voice_offset = data->voice;
 	unsigned short opl3_reg;
@@ -131,8 +131,8 @@
 /*
  * Set drum voice volume and position
  */
-void snd_opl3_drum_vol_set(opl3_t *opl3, snd_opl3_drum_voice_t *data, int vel,
-			   snd_midi_channel_t *chan)
+static void snd_opl3_drum_vol_set(opl3_t *opl3, snd_opl3_drum_voice_t *data,
+				  int vel, snd_midi_channel_t *chan)
 {
 	unsigned char op_offset = snd_opl3_regmap[data->voice][data->op];
 	unsigned char voice_offset = data->voice;
--- linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_lib.c.old	2004-12-05 23:34:35.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_lib.c	2004-12-05 23:34:47.000000000 +0100
@@ -37,7 +37,7 @@
 
 extern char snd_opl3_regmap[MAX_OPL2_VOICES][4];
 
-void snd_opl2_command(opl3_t * opl3, unsigned short cmd, unsigned char val)
+static void snd_opl2_command(opl3_t * opl3, unsigned short cmd, unsigned char val)
 {
 	unsigned long flags;
 	unsigned long port;
@@ -60,7 +60,7 @@
 	spin_unlock_irqrestore(&opl3->reg_lock, flags);
 }
 
-void snd_opl3_command(opl3_t * opl3, unsigned short cmd, unsigned char val)
+static void snd_opl3_command(opl3_t * opl3, unsigned short cmd, unsigned char val)
 {
 	unsigned long flags;
 	unsigned long port;
--- linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_midi.c.old	2004-12-05 23:35:01.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_midi.c	2004-12-05 23:35:09.000000000 +0100
@@ -263,7 +263,7 @@
 /*
  * Start system timer
  */
-void snd_opl3_start_timer(opl3_t *opl3)
+static void snd_opl3_start_timer(opl3_t *opl3)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&opl3->sys_timer_lock, flags);
--- linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_seq.c.old	2004-12-05 23:36:11.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/opl3/opl3_seq.c	2004-12-05 23:36:24.000000000 +0100
@@ -96,7 +96,7 @@
 	up(&opl3->access_mutex);
 }
 
-int snd_opl3_synth_use(void *private_data, snd_seq_port_subscribe_t * info)
+static int snd_opl3_synth_use(void *private_data, snd_seq_port_subscribe_t * info)
 {
 	opl3_t *opl3 = private_data;
 	int err;
@@ -123,7 +123,7 @@
 	return 0;
 }
 
-int snd_opl3_synth_unuse(void *private_data, snd_seq_port_subscribe_t * info)
+static int snd_opl3_synth_unuse(void *private_data, snd_seq_port_subscribe_t * info)
 {
 	opl3_t *opl3 = private_data;
 
--- linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_cmd.h.old	2004-12-05 23:36:36.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_cmd.h	2004-12-05 23:36:47.000000000 +0100
@@ -209,8 +209,6 @@
 /*
  *
  */
-extern struct vx_cmd_info vx_dsp_cmds[];
-
 void vx_init_rmh(struct vx_rmh *rmh, unsigned int cmd);
 
 /**
--- linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_cmd.c.old	2004-12-05 23:37:08.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_cmd.c	2004-12-05 23:37:15.000000000 +0100
@@ -29,7 +29,7 @@
 /*
  * Array of DSP commands
  */
-struct vx_cmd_info vx_dsp_cmds[] = {
+static struct vx_cmd_info vx_dsp_cmds[] = {
 [CMD_VERSION] =			{ 0x010000, 2, RMH_SSIZE_FIXED, 1 },
 [CMD_SUPPORTED] =		{ 0x020000, 1, RMH_SSIZE_FIXED, 2 },
 [CMD_TEST_IT] =			{ 0x040000, 1, RMH_SSIZE_FIXED, 1 },
--- linux-2.6.10-rc2-mm4-full/include/sound/vx_core.h.old	2004-12-05 23:37:30.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/sound/vx_core.h	2004-12-05 23:37:38.000000000 +0100
@@ -340,7 +340,6 @@
  */
 void vx_set_iec958_status(vx_core_t *chip, unsigned int bits);
 int vx_set_clock(vx_core_t *chip, unsigned int freq);
-void vx_change_clock_source(vx_core_t *chip, int source);
 void vx_set_internal_clock(vx_core_t *chip, unsigned int freq);
 int vx_change_frequency(vx_core_t *chip);
 
--- linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_uer.c.old	2004-12-05 23:37:52.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/drivers/vx/vx_uer.c	2004-12-05 23:37:59.000000000 +0100
@@ -197,7 +197,7 @@
  * vx_change_clock_source - change the clock source
  * @source: the new source
  */
-void vx_change_clock_source(vx_core_t *chip, int source)
+static void vx_change_clock_source(vx_core_t *chip, int source)
 {
 	unsigned long flags;
 
--- linux-2.6.10-rc2-mm4-full/include/sound/cs8427.h.old	2004-12-05 23:38:27.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/sound/cs8427.h	2004-12-05 23:39:29.000000000 +0100
@@ -186,12 +186,9 @@
 #define CS8427_VERSHIFT		0
 #define CS8427_VER8427A		0x71
 
-int snd_cs8427_detect(snd_i2c_bus_t *bus, unsigned char addr);
 int snd_cs8427_create(snd_i2c_bus_t *bus, unsigned char addr,
 		      unsigned int reset_timeout, snd_i2c_device_t **r_cs8427);
-void snd_cs8427_reset(snd_i2c_device_t *cs8427);
 int snd_cs8427_reg_write(snd_i2c_device_t *device, unsigned char reg, unsigned char val);
-int snd_cs8427_reg_read(snd_i2c_device_t *device, unsigned char reg);
 int snd_cs8427_iec958_build(snd_i2c_device_t *cs8427, snd_pcm_substream_t *playback_substream, snd_pcm_substream_t *capture_substream);
 int snd_cs8427_iec958_active(snd_i2c_device_t *cs8427, int active);
 int snd_cs8427_iec958_pcm(snd_i2c_device_t *cs8427, unsigned int rate);
--- linux-2.6.10-rc2-mm4-full/sound/i2c/cs8427.c.old	2004-12-05 23:38:40.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/i2c/cs8427.c	2004-12-05 23:39:45.000000000 +0100
@@ -30,6 +30,8 @@
 #include <sound/cs8427.h>
 #include <sound/asoundef.h>
 
+static void snd_cs8427_reset(snd_i2c_device_t *cs8427);
+
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("IEC958 (S/PDIF) receiver & transmitter by Cirrus Logic");
 MODULE_LICENSE("GPL");
@@ -65,16 +67,6 @@
 	return res;
 }
 
-int snd_cs8427_detect(snd_i2c_bus_t *bus, unsigned char addr)
-{
-	int res;
-
-	snd_i2c_lock(bus);
-	res = snd_i2c_probeaddr(bus, CS8427_ADDR | (addr & 7));
-	snd_i2c_unlock(bus);
-	return res;
-}
-
 int snd_cs8427_reg_write(snd_i2c_device_t *device, unsigned char reg, unsigned char val)
 {
 	int err;
@@ -89,7 +81,7 @@
 	return 0;
 }
 
-int snd_cs8427_reg_read(snd_i2c_device_t *device, unsigned char reg)
+static int snd_cs8427_reg_read(snd_i2c_device_t *device, unsigned char reg)
 {
 	int err;
 	unsigned char buf;
@@ -288,7 +280,7 @@
  * put back AES3INPUT. This workaround is described in latest
  * CS8427 datasheet, otherwise TXDSERIAL will not work.
  */
-void snd_cs8427_reset(snd_i2c_device_t *cs8427)
+static void snd_cs8427_reset(snd_i2c_device_t *cs8427)
 {
 	cs8427_t *chip;
 	unsigned long end_time;
@@ -573,11 +565,9 @@
 module_init(alsa_cs8427_module_init)
 module_exit(alsa_cs8427_module_exit)
 
-EXPORT_SYMBOL(snd_cs8427_detect);
 EXPORT_SYMBOL(snd_cs8427_create);
 EXPORT_SYMBOL(snd_cs8427_reset);
 EXPORT_SYMBOL(snd_cs8427_reg_write);
-EXPORT_SYMBOL(snd_cs8427_reg_read);
 EXPORT_SYMBOL(snd_cs8427_iec958_build);
 EXPORT_SYMBOL(snd_cs8427_iec958_active);
 EXPORT_SYMBOL(snd_cs8427_iec958_pcm);
--- linux-2.6.10-rc2-mm4-full/sound/synth/emux/emux_synth.c.old	2004-12-05 23:40:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/synth/emux/emux_synth.c	2004-12-05 23:40:34.000000000 +0100
@@ -363,16 +363,6 @@
 
 
 /*
- * for Emu10k1 - release at least 1 voice currently using
- */
-int
-snd_emux_release_voice(snd_emux_t *emu)
-{
-	return 0;
-}
-
-
-/*
  * terminate note - if free flag is true, free the terminated voice
  */
 static void
--- linux-2.6.10-rc2-mm4-full/include/sound/soundfont.h.old	2004-12-05 23:40:49.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/sound/soundfont.h	2004-12-05 23:40:58.000000000 +0100
@@ -112,7 +112,6 @@
 
 int snd_soundfont_remove_samples(snd_sf_list_t *sflist);
 int snd_soundfont_remove_unlocked(snd_sf_list_t *sflist);
-int snd_soundfont_mem_used(snd_sf_list_t *sflist);
 
 int snd_soundfont_search_zone(snd_sf_list_t *sflist, int *notep, int vel,
 			      int preset, int bank,
--- linux-2.6.10-rc2-mm4-full/sound/synth/emux/soundfont.c.old	2004-12-05 23:41:07.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/sound/synth/emux/soundfont.c	2004-12-05 23:41:21.000000000 +0100
@@ -1460,11 +1460,3 @@
 	return 0;
 }
 
-/*
- * Return the used memory size (in words)
- */
-int
-snd_soundfont_mem_used(snd_sf_list_t *sflist)
-{
-	return sflist->mem_used;
-}


