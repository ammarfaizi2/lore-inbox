Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261559AbVCIDVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVCIDVA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 22:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCIDVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 22:21:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27406 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261559AbVCIDUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 22:20:41 -0500
Date: Wed, 9 Mar 2005 04:20:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/pci/: make code static
Message-ID: <20050309032040.GJ3146@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/pci/ac97/ac97_codec.c    |    9 ++++++---
 sound/pci/ac97/ac97_local.h    |    3 ---
 sound/pci/ca0106/ca0106_proc.c |    2 +-
 sound/pci/hda/hda_codec.c      |    6 ++++--
 sound/pci/hda/patch_realtek.c  |    2 +-
 5 files changed, 12 insertions(+), 10 deletions(-)

--- linux-2.6.11-mm2-full/sound/pci/ac97/ac97_local.h.old	2005-03-09 03:11:25.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/pci/ac97/ac97_local.h	2005-03-09 03:12:41.000000000 +0100
@@ -43,9 +43,6 @@
 int snd_ac97_get_volsw(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 int snd_ac97_put_volsw(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 int snd_ac97_try_bit(ac97_t * ac97, int reg, int bit);
-int snd_ac97_remove_ctl(ac97_t *ac97, const char *name, const char *suffix);
-int snd_ac97_rename_ctl(ac97_t *ac97, const char *src, const char *dst, const char *suffix);
-int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1, const char *s2, const char *suffix);
 void snd_ac97_rename_vol_ctl(ac97_t *ac97, const char *src, const char *dst);
 void snd_ac97_restore_status(ac97_t *ac97);
 void snd_ac97_restore_iec958(ac97_t *ac97);
--- linux-2.6.11-mm2-full/sound/pci/ac97/ac97_codec.c.old	2005-03-09 03:11:47.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/pci/ac97/ac97_codec.c	2005-03-09 03:12:55.000000000 +0100
@@ -2280,7 +2280,8 @@
 }	
 
 /* remove the control with the given name and optional suffix */
-int snd_ac97_remove_ctl(ac97_t *ac97, const char *name, const char *suffix)
+static int snd_ac97_remove_ctl(ac97_t *ac97, const char *name,
+			       const char *suffix)
 {
 	snd_ctl_elem_id_t id;
 	memset(&id, 0, sizeof(id));
@@ -2299,7 +2300,8 @@
 }
 
 /* rename the control with the given name and optional suffix */
-int snd_ac97_rename_ctl(ac97_t *ac97, const char *src, const char *dst, const char *suffix)
+static int snd_ac97_rename_ctl(ac97_t *ac97, const char *src,
+			       const char *dst, const char *suffix)
 {
 	snd_kcontrol_t *kctl = ctl_find(ac97, src, suffix);
 	if (kctl) {
@@ -2317,7 +2319,8 @@
 }
 
 /* swap controls */
-int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1, const char *s2, const char *suffix)
+static int snd_ac97_swap_ctl(ac97_t *ac97, const char *s1,
+			     const char *s2, const char *suffix)
 {
 	snd_kcontrol_t *kctl1, *kctl2;
 	kctl1 = ctl_find(ac97, s1, suffix);
--- linux-2.6.11-mm2-full/sound/pci/ca0106/ca0106_proc.c.old	2005-03-09 03:13:05.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/pci/ca0106/ca0106_proc.c	2005-03-09 03:13:15.000000000 +0100
@@ -95,7 +95,7 @@
 };
 
 
-void snd_ca0106_proc_dump_iec958( snd_info_buffer_t *buffer, u32 value)
+static void snd_ca0106_proc_dump_iec958( snd_info_buffer_t *buffer, u32 value)
 {
 	int i;
 	u32 status[4];
--- linux-2.6.11-mm2-full/sound/pci/hda/hda_codec.c.old	2005-03-09 03:19:28.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/pci/hda/hda_codec.c	2005-03-09 03:21:48.000000000 +0100
@@ -655,7 +655,8 @@
 /*
  * read/write AMP value.  The volume is between 0 to 0x7f, 0x80 = mute bit.
  */
-int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid, int ch, int direction, int index)
+static int snd_hda_codec_amp_read(struct hda_codec *codec, hda_nid_t nid,
+				  int ch, int direction, int index)
 {
 	struct hda_amp_info *info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, index));
 	if (! info)
@@ -664,7 +665,8 @@
 	return info->vol[ch];
 }
 
-int snd_hda_codec_amp_write(struct hda_codec *codec, hda_nid_t nid, int ch, int direction, int idx, int val)
+static int snd_hda_codec_amp_write(struct hda_codec *codec, hda_nid_t nid,
+				   int ch, int direction, int idx, int val)
 {
 	struct hda_amp_info *info = get_alloc_amp_hash(codec, HDA_HASH_KEY(nid, direction, idx));
 	if (! info)
--- linux-2.6.11-mm2-full/sound/pci/hda/patch_realtek.c.old	2005-03-09 03:22:02.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/pci/hda/patch_realtek.c	2005-03-09 03:22:26.000000000 +0100
@@ -1115,7 +1115,7 @@
 	{ 2, NULL },
 };
 
-snd_kcontrol_new_t alc260_base_mixer[] = {
+static snd_kcontrol_new_t alc260_base_mixer[] = {
 	HDA_CODEC_VOLUME("PCM Playback Volume", 0x08, 0x0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("PCM Playback Switch", 0x0f, 0x0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x07, 0x04, HDA_INPUT),

