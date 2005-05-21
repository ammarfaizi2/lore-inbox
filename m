Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261180AbVEUAEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbVEUAEx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 20:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVEUAEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 20:04:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:55819 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261180AbVEUAEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 20:04:09 -0400
Date: Sat, 21 May 2005 02:04:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/isa/: cleanups
Message-ID: <20050521000402.GP5112@stusta.de>
References: <20050513140053.GF16549@stusta.de> <s5hd5rvryaw.wl@alsa2.suse.de> <20050513143720.GH16549@stusta.de> <s5h7ji3rwum.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h7ji3rwum.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 05:04:17PM +0200, Takashi Iwai wrote:
> At Fri, 13 May 2005 16:37:20 +0200,
> Adrian Bunk wrote:
> > 
> > On Fri, May 13, 2005 at 04:32:55PM +0200, Takashi Iwai wrote:
> > >...
> > > The unused stuff in sound/isa/gus/* are for (everlasting :) future
> > > development, e.g. WaveTable synth support.  So I don't think it's a
> > > good idea to remove completely them.
> > >...
> > 
> > Would a patch to #if 0 them away be OK?
> 
> Yes, fine for me.

Updated patch below.

> Takashi

cu
Adrian


<--  snip  -->


This patch contains the following possible cleanups:
- make needlesly global code static
- #if 0 the following unused global functions:
  - gus/gus_volume.c: snd_gf1_gvol_to_lvol_raw
  - gus/gus_volume.c: snd_gf1_calc_ramp_rate
  - gus/gus_volume.c: snd_gf1_compute_vibrato
  - gus/gus_volume.c: snd_gf1_compute_pitchbend
  - gus/gus_volume.c: snd_gf1_compute_freq
  - gus/gus_io.c: snd_gf1_i_adlib_write
  - gus/gus_io.c: snd_gf1_i_write_addr
  - gus/gus_io.c: snd_gf1_pokew
  - gus/gus_io.c: snd_gf1_peekw
  - gus/gus_io.c: snd_gf1_dram_setmem
  - gus/gus_io.c: snd_gf1_print_global_registers
  - gus/gus_io.c: snd_gf1_print_setup_registers
  - gus/gus_io.c: snd_gf1_peek_print_block
  - gus/gus_io.c: snd_gf1_print_setup_registers
  - gus/gus_io.c: snd_gf1_peek_print_block
- #if 0 the following unused global variable:
  - gus/gus_tables.h: snd_gf1_scale_table
- remove the following unneeded EXPORT_SYMBOL's:
  - gus/gus_main.c: snd_gf1_i_write16
  - gus/gus_main.c: snd_gf1_start
  - gus/gus_main.c: snd_gf1_stop

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/sound/gus.h        |   23 -----------------------
 sound/isa/gus/gus_io.c     |   14 +++++++++++---
 sound/isa/gus/gus_main.c   |    3 ---
 sound/isa/gus/gus_mem.c    |   12 ++++++------
 sound/isa/gus/gus_reset.c  |    3 ++-
 sound/isa/gus/gus_synth.c  |    3 ++-
 sound/isa/gus/gus_tables.h |    4 ++++
 sound/isa/gus/gus_volume.c |    8 ++++++++
 8 files changed, 33 insertions(+), 37 deletions(-)

--- linux-2.6.11-mm1-full/sound/isa/gus/gus_mem.c.old	2005-03-06 23:43:49.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/gus/gus_mem.c	2005-03-06 23:44:50.000000000 +0100
@@ -39,8 +39,8 @@
 	}
 }
 
-snd_gf1_mem_block_t *snd_gf1_mem_xalloc(snd_gf1_mem_t * alloc,
-				        snd_gf1_mem_block_t * block)
+static snd_gf1_mem_block_t *snd_gf1_mem_xalloc(snd_gf1_mem_t * alloc,
+					       snd_gf1_mem_block_t * block)
 {
 	snd_gf1_mem_block_t *pblock, *nblock;
 
@@ -105,8 +105,8 @@
 	return 0;
 }
 
-snd_gf1_mem_block_t *snd_gf1_mem_look(snd_gf1_mem_t * alloc,
-				      unsigned int address)
+static snd_gf1_mem_block_t *snd_gf1_mem_look(snd_gf1_mem_t * alloc,
+					     unsigned int address)
 {
 	snd_gf1_mem_block_t *block;
 
@@ -118,8 +118,8 @@
 	return NULL;
 }
 
-snd_gf1_mem_block_t *snd_gf1_mem_share(snd_gf1_mem_t * alloc,
-				       unsigned int *share_id)
+static snd_gf1_mem_block_t *snd_gf1_mem_share(snd_gf1_mem_t * alloc,
+					      unsigned int *share_id)
 {
 	snd_gf1_mem_block_t *block;
 
--- linux-2.6.11-mm1-full/sound/isa/gus/gus_reset.c.old	2005-03-06 23:45:07.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/gus/gus_reset.c	2005-03-06 23:45:20.000000000 +0100
@@ -161,7 +161,8 @@
 #endif
 }
 
-void snd_gf1_clear_voices(snd_gus_card_t * gus, unsigned short v_min, unsigned short v_max)
+static void snd_gf1_clear_voices(snd_gus_card_t * gus, unsigned short v_min,
+				 unsigned short v_max)
 {
 	unsigned long flags;
 	unsigned int daddr;
--- linux-2.6.11-mm1-full/sound/isa/gus/gus_synth.c.old	2005-03-06 23:47:13.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/gus/gus_synth.c	2005-03-06 23:47:29.000000000 +0100
@@ -99,7 +99,8 @@
 	snd_seq_instr_list_free_cond(p->gus->gf1.ilist, &ifree, client, 0);
 }
  
-int snd_gus_synth_event_input(snd_seq_event_t *ev, int direct, void *private_data, int atomic, int hop)
+static int snd_gus_synth_event_input(snd_seq_event_t *ev, int direct,
+				     void *private_data, int atomic, int hop)
 {
 	snd_gus_port_t * p = (snd_gus_port_t *) private_data;
 	
--- linux-2.6.11-mm2-full/include/sound/gus.h.old	2005-03-09 02:56:00.000000000 +0100
+++ linux-2.6.11-mm2-full/include/sound/gus.h	2005-03-09 03:04:59.000000000 +0100
@@ -526,9 +526,6 @@
 extern void snd_gf1_dram_addr(snd_gus_card_t * gus, unsigned int addr);
 extern void snd_gf1_poke(snd_gus_card_t * gus, unsigned int addr, unsigned char data);
 extern unsigned char snd_gf1_peek(snd_gus_card_t * gus, unsigned int addr);
-extern void snd_gf1_pokew(snd_gus_card_t * gus, unsigned int addr, unsigned short data);
-extern unsigned short snd_gf1_peekw(snd_gus_card_t * gus, unsigned int addr);
-extern void snd_gf1_dram_setmem(snd_gus_card_t * gus, unsigned int addr, unsigned short value, unsigned int count);
 extern void snd_gf1_write_addr(snd_gus_card_t * gus, unsigned char reg, unsigned int addr, short w_16bit);
 extern unsigned int snd_gf1_read_addr(snd_gus_card_t * gus, unsigned char reg, short w_16bit);
 extern void snd_gf1_i_ctrl_stop(snd_gus_card_t * gus, unsigned char reg);
@@ -544,9 +541,6 @@
 {
 	return snd_gf1_i_look16(gus, reg | 0x80);
 }
-extern void snd_gf1_i_adlib_write(snd_gus_card_t * gus, unsigned char reg, unsigned char data);
-extern void snd_gf1_i_write_addr(snd_gus_card_t * gus, unsigned char reg, unsigned int addr, short w_16bit);
-extern unsigned int snd_gf1_i_read_addr(snd_gus_card_t * gus, unsigned char reg, short w_16bit);
 
 extern void snd_gf1_select_active_voices(snd_gus_card_t * gus);
 
@@ -580,10 +574,6 @@
 
 void snd_gf1_mem_lock(snd_gf1_mem_t * alloc, int xup);
 int snd_gf1_mem_xfree(snd_gf1_mem_t * alloc, snd_gf1_mem_block_t * block);
-snd_gf1_mem_block_t *snd_gf1_mem_look(snd_gf1_mem_t * alloc,
-				      unsigned int address);
-snd_gf1_mem_block_t *snd_gf1_mem_share(snd_gf1_mem_t * alloc,
-				       unsigned int *share_id);
 snd_gf1_mem_block_t *snd_gf1_mem_alloc(snd_gf1_mem_t * alloc, int owner,
 				       char *name, int size, int w_16,
 				       int align, unsigned int *share_id);
@@ -608,23 +598,13 @@
 /* gus_volume.c */
 
 unsigned short snd_gf1_lvol_to_gvol_raw(unsigned int vol);
-unsigned int snd_gf1_gvol_to_lvol_raw(unsigned short gf1_vol);
-unsigned int snd_gf1_calc_ramp_rate(snd_gus_card_t * gus,
-				    unsigned short start,
-				    unsigned short end,
-				    unsigned int us);
 unsigned short snd_gf1_translate_freq(snd_gus_card_t * gus, unsigned int freq2);
-unsigned short snd_gf1_compute_pitchbend(unsigned short pitchbend, unsigned short sens);
-unsigned short snd_gf1_compute_freq(unsigned int freq,
-				    unsigned int rate,
-				    unsigned short mix_rate);
 
 /* gus_reset.c */
 
 void snd_gf1_set_default_handlers(snd_gus_card_t * gus, unsigned int what);
 void snd_gf1_smart_stop_voice(snd_gus_card_t * gus, unsigned short voice);
 void snd_gf1_stop_voice(snd_gus_card_t * gus, unsigned short voice);
-void snd_gf1_clear_voices(snd_gus_card_t * gus, unsigned short v_min, unsigned short v_max);
 void snd_gf1_stop_voices(snd_gus_card_t * gus, unsigned short v_min, unsigned short v_max);
 snd_gus_voice_t *snd_gf1_alloc_voice(snd_gus_card_t * gus, int type, int client, int port);
 void snd_gf1_free_voice(snd_gus_card_t * gus, snd_gus_voice_t *voice);
@@ -641,9 +621,6 @@
 
 #ifdef CONFIG_SND_DEBUG
 extern void snd_gf1_print_voice_registers(snd_gus_card_t * gus);
-extern void snd_gf1_print_global_registers(snd_gus_card_t * gus);
-extern void snd_gf1_print_setup_registers(snd_gus_card_t * gus);
-extern void snd_gf1_peek_print_block(snd_gus_card_t * gus, unsigned int addr, int count, int w_16bit);
 #endif
 
 /* gus.c */
--- linux-2.6.11-mm2-full/sound/isa/gus/gus_main.c.old	2005-03-09 02:56:00.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/isa/gus/gus_main.c	2005-03-09 03:04:01.000000000 +0100
@@ -459,7 +459,6 @@
 EXPORT_SYMBOL(snd_gf1_look16);
 EXPORT_SYMBOL(snd_gf1_i_write8);
 EXPORT_SYMBOL(snd_gf1_i_look8);
-EXPORT_SYMBOL(snd_gf1_i_write16);
 EXPORT_SYMBOL(snd_gf1_i_look16);
 EXPORT_SYMBOL(snd_gf1_dram_addr);
 EXPORT_SYMBOL(snd_gf1_write_addr);
@@ -470,8 +469,6 @@
 EXPORT_SYMBOL(snd_gf1_free_voice);
 EXPORT_SYMBOL(snd_gf1_ctrl_stop);
 EXPORT_SYMBOL(snd_gf1_stop_voice);
-EXPORT_SYMBOL(snd_gf1_start);
-EXPORT_SYMBOL(snd_gf1_stop);
   /* gus_mixer.c */
 EXPORT_SYMBOL(snd_gf1_new_mixer);
   /* gus_pcm.c */

--- linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_tables.h.old	2005-05-21 01:37:27.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_tables.h	2005-05-21 01:37:59.000000000 +0200
@@ -23,6 +23,8 @@
 
 #ifdef __GUS_TABLES_ALLOC__
 
+#if 0
+
 unsigned int snd_gf1_scale_table[SNDRV_GF1_SCALE_TABLE_SIZE] =
 {
       8372,      8870,      9397,      9956,     10548,     11175,
@@ -49,6 +51,8 @@
   12123977,  12844906
 };
 
+#endif  /*  0  */
+
 unsigned short snd_gf1_atten_table[SNDRV_GF1_ATTEN_TABLE_SIZE] = {
   4095 /* 0   */,1789 /* 1   */,1533 /* 2   */,1383 /* 3   */,1277 /* 4   */,
   1195 /* 5   */,1127 /* 6   */,1070 /* 7   */,1021 /* 8   */,978  /* 9   */,
--- linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_volume.c.old	2005-05-21 01:31:05.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_volume.c	2005-05-21 01:31:53.000000000 +0200
@@ -55,6 +55,8 @@
 	return (e << 8) | m;
 }
 
+#if 0
+
 unsigned int snd_gf1_gvol_to_lvol_raw(unsigned short gf1_vol)
 {
 	unsigned int rvol;
@@ -108,6 +110,8 @@
 	return (range << 6) | (increment & 0x3f);
 }
 
+#endif  /*  0  */
+
 unsigned short snd_gf1_translate_freq(snd_gus_card_t * gus, unsigned int freq16)
 {
 	freq16 >>= 3;
@@ -120,6 +124,8 @@
 	return ((freq16 << 9) + (gus->gf1.playback_freq >> 1)) / gus->gf1.playback_freq;
 }
 
+#if 0
+
 short snd_gf1_compute_vibrato(short cents, unsigned short fc_register)
 {
 	static short vibrato_table[] =
@@ -208,3 +214,5 @@
 	}
 	return (unsigned short) fc;
 }
+
+#endif  /*  0  */
--- linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_io.c.old	2005-05-21 01:32:29.000000000 +0200
+++ linux-2.6.12-rc4-mm2-full/sound/isa/gus/gus_io.c	2005-05-21 01:36:42.000000000 +0200
@@ -244,6 +244,8 @@
 	return res;
 }
 
+#if 0
+
 void snd_gf1_i_adlib_write(snd_gus_card_t * gus,
 		           unsigned char reg,
 		           unsigned char data)
@@ -265,6 +267,8 @@
 	spin_unlock_irqrestore(&gus->reg_lock, flags);
 }
 
+#endif  /*  0  */
+
 unsigned int snd_gf1_i_read_addr(snd_gus_card_t * gus,
 				 unsigned char reg, short w_16bit)
 {
@@ -329,6 +333,8 @@
 	return res;
 }
 
+#if 0
+
 void snd_gf1_pokew(snd_gus_card_t * gus, unsigned int addr, unsigned short data)
 {
 	unsigned long flags;
@@ -405,9 +411,7 @@
 	spin_unlock_irqrestore(&gus->reg_lock, flags);
 }
 
-/*
-
- */
+#endif  /*  0  */
 
 void snd_gf1_select_active_voices(snd_gus_card_t * gus)
 {
@@ -469,6 +473,8 @@
 		printk(" -%i- GF1  pan                    = 0x%x\n", voice, snd_gf1_i_read8(gus, 0x0c));
 }
 
+#if 0
+
 void snd_gf1_print_global_registers(snd_gus_card_t * gus)
 {
 	unsigned char global_mode = 0x00;
@@ -528,4 +534,6 @@
 	}
 }
 
+#endif  /*  0  */
+
 #endif

