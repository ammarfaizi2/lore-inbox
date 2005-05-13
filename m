Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVEMOJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVEMOJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 10:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVEMOIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 10:08:37 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11781 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262380AbVEMOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 10:00:56 -0400
Date: Fri, 13 May 2005 16:00:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/isa/: possible cleanups
Message-ID: <20050513140053.GF16549@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlesly global code static
- remove the following unused global functions:
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
- remove the following unused global variable:
  - gus/gus_tables.h: snd_gf1_scale_table
- remove the following unneeded EXPORT_SYMBOL's:
  - gus/gus_main.c: snd_gf1_i_write16
  - gus/gus_main.c: snd_gf1_start
  - gus/gus_main.c: snd_gf1_stop

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 9 Mar 2005

 sound/isa/gus/gus_mem.c            |   12 +-
 sound/isa/gus/gus_reset.c          |    3 
 sound/isa/gus/gus_synth.c          |    3 
 sound/isa/gus/gus_tables.h         |   27 ----
 sound/isa/gus/gus_volume.c         |  141 ------------------------
 sound/isa/wavefront/wavefront_fx.c |   39 +++---
 include/sound/gus.h                |   23 ----
 sound/isa/gus/gus_io.c             |  164 -----------------------------
 sound/isa/gus/gus_main.c           |    3 
 9 files changed, 34 insertions(+), 381 deletions(-)

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
 	
--- linux-2.6.11-mm1-full/sound/isa/gus/gus_volume.c.old	2005-03-06 23:47:56.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/gus/gus_volume.c	2005-03-06 23:49:10.000000000 +0100
@@ -55,59 +55,6 @@
 	return (e << 8) | m;
 }
 
-unsigned int snd_gf1_gvol_to_lvol_raw(unsigned short gf1_vol)
-{
-	unsigned int rvol;
-	unsigned short e, m;
-
-	if (!gf1_vol)
-		return 0;
-	e = gf1_vol >> 8;
-	m = (unsigned char) gf1_vol;
-	rvol = 1 << e;
-	if (e > 8)
-		return rvol | (m << (e - 8));
-	return rvol | (m >> (8 - e));
-}
-
-unsigned int snd_gf1_calc_ramp_rate(snd_gus_card_t * gus,
-				    unsigned short start,
-				    unsigned short end,
-				    unsigned int us)
-{
-	static unsigned char vol_rates[19] =
-	{
-		23, 24, 26, 28, 29, 31, 32, 34,
-		36, 37, 39, 40, 42, 44, 45, 47,
-		49, 50, 52
-	};
-	unsigned short range, increment, value, i;
-
-	start >>= 4;
-	end >>= 4;
-	if (start < end)
-		us /= end - start;
-	else
-		us /= start - end;
-	range = 4;
-	value = gus->gf1.enh_mode ?
-	    vol_rates[0] :
-	    vol_rates[gus->gf1.active_voices - 14];
-	for (i = 0; i < 3; i++) {
-		if (us < value) {
-			range = i;
-			break;
-		} else
-			value <<= 3;
-	}
-	if (range == 4) {
-		range = 3;
-		increment = 1;
-	} else
-		increment = (value + (value >> 1)) / us;
-	return (range << 6) | (increment & 0x3f);
-}
-
 unsigned short snd_gf1_translate_freq(snd_gus_card_t * gus, unsigned int freq16)
 {
 	freq16 >>= 3;
@@ -120,91 +67,3 @@
 	return ((freq16 << 9) + (gus->gf1.playback_freq >> 1)) / gus->gf1.playback_freq;
 }
 
-short snd_gf1_compute_vibrato(short cents, unsigned short fc_register)
-{
-	static short vibrato_table[] =
-	{
-		0, 0, 32, 592, 61, 1175, 93, 1808,
-		124, 2433, 152, 3007, 182, 3632, 213, 4290,
-		241, 4834, 255, 5200
-	};
-
-	long depth;
-	short *vi1, *vi2, pcents, v1;
-
-	pcents = cents < 0 ? -cents : cents;
-	for (vi1 = vibrato_table, vi2 = vi1 + 2; pcents > *vi2; vi1 = vi2, vi2 += 2);
-	v1 = *(vi1 + 1);
-	/* The FC table above is a list of pairs. The first number in the pair     */
-	/* is the cents index from 0-255 cents, and the second number in the       */
-	/* pair is the FC adjustment needed to change the pitch by the indexed     */
-	/* number of cents. The table was created for an FC of 32768.              */
-	/* The following expression does a linear interpolation against the        */
-	/* approximated log curve in the table above, and then scales the number   */
-	/* by the FC before the LFO. This calculation also adjusts the output      */
-	/* value to produce the appropriate depth for the hardware. The depth      */
-	/* is 2 * desired FC + 1.                                                  */
-	depth = (((int) (*(vi2 + 1) - *vi1) * (pcents - *vi1) / (*vi2 - *vi1)) + v1) * fc_register >> 14;
-	if (depth)
-		depth++;
-	if (depth > 255)
-		depth = 255;
-	return cents < 0 ? -(short) depth : (short) depth;
-}
-
-unsigned short snd_gf1_compute_pitchbend(unsigned short pitchbend, unsigned short sens)
-{
-	static long log_table[] = {1024, 1085, 1149, 1218, 1290, 1367, 1448, 1534, 1625, 1722, 1825, 1933};
-	int wheel, sensitivity;
-	unsigned int mantissa, f1, f2;
-	unsigned short semitones, f1_index, f2_index, f1_power, f2_power;
-	char bend_down = 0;
-	int bend;
-
-	if (!sens)
-		return 1024;
-	wheel = (int) pitchbend - 8192;
-	sensitivity = ((int) sens * wheel) / 128;
-	if (sensitivity < 0) {
-		bend_down = 1;
-		sensitivity = -sensitivity;
-	}
-	semitones = (unsigned int) (sensitivity >> 13);
-	mantissa = sensitivity % 8192;
-	f1_index = semitones % 12;
-	f2_index = (semitones + 1) % 12;
-	f1_power = semitones / 12;
-	f2_power = (semitones + 1) / 12;
-	f1 = log_table[f1_index] << f1_power;
-	f2 = log_table[f2_index] << f2_power;
-	bend = (int) ((((f2 - f1) * mantissa) >> 13) + f1);
-	if (bend_down)
-		bend = 1048576L / bend;
-	return bend;
-}
-
-unsigned short snd_gf1_compute_freq(unsigned int freq,
-				    unsigned int rate,
-				    unsigned short mix_rate)
-{
-	unsigned int fc;
-	int scale = 0;
-
-	while (freq >= 4194304L) {
-		scale++;
-		freq >>= 1;
-	}
-	fc = (freq << 10) / rate;
-	if (fc > 97391L) {
-		fc = 97391;
-		snd_printk("patch: (1) fc frequency overflow - %u\n", fc);
-	}
-	fc = (fc * 44100UL) / mix_rate;
-	while (scale--)
-		fc <<= 1;
-	if (fc > 65535L) {
-		fc = 65535;
-		snd_printk("patch: (2) fc frequency overflow - %u\n", fc);
-	}
-	return (unsigned short) fc;
-}
--- linux-2.6.11-mm1-full/sound/isa/gus/gus_tables.h.old	2005-03-06 23:49:26.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/gus/gus_tables.h	2005-03-06 23:50:07.000000000 +0100
@@ -23,32 +23,6 @@
 
 #ifdef __GUS_TABLES_ALLOC__
 
-unsigned int snd_gf1_scale_table[SNDRV_GF1_SCALE_TABLE_SIZE] =
-{
-      8372,      8870,      9397,      9956,     10548,     11175,
-     11840,     12544,     13290,     14080,     14917,     15804,
-     16744,     17740,     18795,     19912,     21096,     22351,
-     23680,     25088,     26580,     28160,     29834,     31609,
-     33488,     35479,     37589,     39824,     42192,     44701,
-     47359,     50175,     53159,     56320,     59669,     63217,
-     66976,     70959,     75178,     79649,     84385,     89402,
-     94719,    100351,    106318,    112640,    119338,    126434,
-    133952,    141918,    150356,    159297,    168769,    178805,
-    189437,    200702,    212636,    225280,    238676,    252868,
-    267905,    283835,    300713,    318594,    337539,    357610,
-    378874,    401403,    425272,    450560,    477352,    505737,
-    535809,    567670,    601425,    637188,    675077,    715219,
-    757749,    802807,    850544,    901120,    954703,   1011473,
-   1071618,   1135340,   1202851,   1274376,   1350154,   1430439,
-   1515497,   1605613,   1701088,   1802240,   1909407,   2022946,
-   2143237,   2270680,   2405702,   2548752,   2700309,   2860878,
-   3030994,   3211227,   3402176,   3604480,   3818814,   4045892,
-   4286473,   4541360,   4811404,   5097505,   5400618,   5721755,
-   6061989,   6422453,   6804352,   7208960,   7637627,   8091784,
-   8572947,   9082720,   9622807,  10195009,  10801236,  11443511,
-  12123977,  12844906
-};
-
 unsigned short snd_gf1_atten_table[SNDRV_GF1_ATTEN_TABLE_SIZE] = {
   4095 /* 0   */,1789 /* 1   */,1533 /* 2   */,1383 /* 3   */,1277 /* 4   */,
   1195 /* 5   */,1127 /* 6   */,1070 /* 7   */,1021 /* 8   */,978  /* 9   */,
@@ -80,7 +54,6 @@
 
 #else
 
-extern unsigned int snd_gf1_scale_table[SNDRV_GF1_SCALE_TABLE_SIZE];
 extern unsigned short snd_gf1_atten_table[SNDRV_GF1_ATTEN_TABLE_SIZE];
 
 #endif
--- linux-2.6.11-mm1-full/sound/isa/wavefront/wavefront_fx.c.old	2005-03-06 23:56:08.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/isa/wavefront/wavefront_fx.c	2005-03-07 00:04:09.000000000 +0100
@@ -34,7 +34,7 @@
 
 /* weird stuff, derived from port I/O tracing with dosemu */
 
-unsigned char page_zero[] __initdata = {
+static unsigned char page_zero[] __initdata = {
 0x01, 0x7c, 0x00, 0x1e, 0x00, 0x00, 0x00, 0x00, 0x00, 0xf5, 0x00,
 0x11, 0x00, 0x20, 0x00, 0x32, 0x00, 0x40, 0x00, 0x13, 0x00, 0x00,
 0x00, 0x14, 0x02, 0x76, 0x00, 0x60, 0x00, 0x80, 0x02, 0x00, 0x00,
@@ -61,7 +61,7 @@
 0x1d, 0x02, 0xdf
 };
 
-unsigned char page_one[] __initdata = {
+static unsigned char page_one[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x19, 0x00,
 0x1f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x03, 0xd8, 0x00, 0x00,
 0x02, 0x20, 0x00, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00, 0x18, 0x01,
@@ -88,7 +88,7 @@
 0x60, 0x00, 0x1b
 };
 
-unsigned char page_two[] __initdata = {
+static unsigned char page_two[] __initdata = {
 0xc4, 0x00, 0x44, 0x07, 0x44, 0x00, 0x40, 0x25, 0x01, 0x06, 0xc4,
 0x07, 0x40, 0x25, 0x01, 0x00, 0x46, 0x46, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -103,7 +103,7 @@
 0x46, 0x05, 0x46, 0x07, 0x46, 0x07, 0x44
 };
 
-unsigned char page_three[] __initdata = {
+static unsigned char page_three[] __initdata = {
 0x07, 0x40, 0x00, 0x00, 0x00, 0x47, 0x00, 0x40, 0x00, 0x40, 0x06,
 0x40, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -118,7 +118,7 @@
 0x02, 0x00, 0x42, 0x00, 0xc0, 0x00, 0x40
 };
 
-unsigned char page_four[] __initdata = {
+static unsigned char page_four[] __initdata = {
 0x63, 0x03, 0x26, 0x02, 0x2c, 0x00, 0x24, 0x00, 0x2e, 0x02, 0x02,
 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -133,7 +133,7 @@
 0x02, 0x62, 0x02, 0x20, 0x01, 0x21, 0x01
 };
 
-unsigned char page_six[] __initdata = {
+static unsigned char page_six[] __initdata = {
 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x04, 0x00, 0x00, 0x06, 0x00,
 0x00, 0x08, 0x00, 0x00, 0x0a, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x0e,
 0x00, 0x00, 0x10, 0x00, 0x00, 0x12, 0x00, 0x00, 0x14, 0x00, 0x00,
@@ -154,7 +154,7 @@
 0x80, 0x00, 0x7e, 0x80, 0x80
 };
 
-unsigned char page_seven[] __initdata = {
+static unsigned char page_seven[] __initdata = {
 0x0f, 0xff, 0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x02, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
 0x08, 0x00, 0x00, 0x00, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x0f,
@@ -181,7 +181,7 @@
 0x00, 0x02, 0x00
 };
 
-unsigned char page_zero_v2[] __initdata = {
+static unsigned char page_zero_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -193,7 +193,7 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_one_v2[] __initdata = {
+static unsigned char page_one_v2[] __initdata = {
 0x01, 0xc0, 0x01, 0xfa, 0x00, 0x1a, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -205,21 +205,23 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_two_v2[] __initdata = {
+static unsigned char page_two_v2[] __initdata = {
 0x46, 0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00
 };
-unsigned char page_three_v2[] __initdata = {
+
+static unsigned char page_three_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00
 };
-unsigned char page_four_v2[] __initdata = {
+
+static unsigned char page_four_v2[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -227,7 +229,7 @@
 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char page_seven_v2[] __initdata = {
+static unsigned char page_seven_v2[] __initdata = {
 0x0f, 0xff, 0x0f, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
@@ -239,7 +241,7 @@
 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-unsigned char mod_v2[] __initdata = {
+static unsigned char mod_v2[] __initdata = {
 0x01, 0x00, 0x02, 0x00, 0x01, 0x01, 0x02, 0x00, 0x01, 0x02, 0x02,
 0x00, 0x01, 0x03, 0x02, 0x00, 0x01, 0x04, 0x02, 0x00, 0x01, 0x05,
 0x02, 0x00, 0x01, 0x06, 0x02, 0x00, 0x01, 0x07, 0x02, 0x00, 0xb0,
@@ -269,7 +271,8 @@
 0x02, 0x01, 0x01, 0x04, 0x02, 0x01, 0x01, 0x05, 0x02, 0x01, 0x01,
 0x06, 0x02, 0x01, 0x01, 0x07, 0x02, 0x01
 };
-unsigned char coefficients[] __initdata = {
+
+static unsigned char coefficients[] __initdata = {
 0x07, 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x00, 0x4b, 0x03,
 0x11, 0x00, 0x4d, 0x01, 0x32, 0x07, 0x46, 0x00, 0x00, 0x07, 0x49,
 0x00, 0x00, 0x07, 0x40, 0x00, 0x00, 0x07, 0x41, 0x00, 0x00, 0x01,
@@ -305,14 +308,16 @@
 0x06, 0x6c, 0x4c, 0x6c, 0x06, 0x50, 0x52, 0xe2, 0x06, 0x42, 0x02,
 0xba
 };
-unsigned char coefficients2[] __initdata = {
+
+static unsigned char coefficients2[] __initdata = {
 0x07, 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x07, 0x45, 0x0f,
 0xff, 0x07, 0x48, 0x0f, 0xff, 0x07, 0x7b, 0x04, 0xcc, 0x07, 0x7d,
 0x04, 0xcc, 0x07, 0x7c, 0x00, 0x00, 0x07, 0x7e, 0x00, 0x00, 0x07,
 0x46, 0x00, 0x00, 0x07, 0x49, 0x00, 0x00, 0x07, 0x47, 0x00, 0x00,
 0x07, 0x4a, 0x00, 0x00, 0x07, 0x4c, 0x00, 0x00, 0x07, 0x4e, 0x00, 0x00
 };
-unsigned char coefficients3[] __initdata = {
+
+static unsigned char coefficients3[] __initdata = {
 0x00, 0x00, 0x00, 0x00, 0x00, 0x28, 0x00, 0x28, 0x00, 0x51, 0x00,
 0x51, 0x00, 0x7a, 0x00, 0x7a, 0x00, 0xa3, 0x00, 0xa3, 0x00, 0xcc,
 0x00, 0xcc, 0x00, 0xf5, 0x00, 0xf5, 0x01, 0x1e, 0x01, 0x1e, 0x01,
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
--- linux-2.6.11-mm2-full/sound/isa/gus/gus_io.c.old	2005-03-09 02:56:00.000000000 +0100
+++ linux-2.6.11-mm2-full/sound/isa/gus/gus_io.c	2005-03-09 03:05:06.000000000 +0100
@@ -244,29 +244,8 @@
 	return res;
 }
 
-void snd_gf1_i_adlib_write(snd_gus_card_t * gus,
-		           unsigned char reg,
-		           unsigned char data)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&gus->reg_lock, flags);
-	__snd_gf1_adlib_write(gus, reg, data);
-	spin_unlock_irqrestore(&gus->reg_lock, flags);
-}
-
-void snd_gf1_i_write_addr(snd_gus_card_t * gus, unsigned char reg,
-			  unsigned int addr, short w_16bit)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&gus->reg_lock, flags);
-	__snd_gf1_write_addr(gus, reg, addr, w_16bit);
-	spin_unlock_irqrestore(&gus->reg_lock, flags);
-}
-
-unsigned int snd_gf1_i_read_addr(snd_gus_card_t * gus,
-				 unsigned char reg, short w_16bit)
+static unsigned int snd_gf1_i_read_addr(snd_gus_card_t * gus,
+					unsigned char reg, short w_16bit)
 {
 	unsigned int res;
 	unsigned long flags;
@@ -329,86 +308,6 @@
 	return res;
 }
 
-void snd_gf1_pokew(snd_gus_card_t * gus, unsigned int addr, unsigned short data)
-{
-	unsigned long flags;
-
-#ifdef CONFIG_SND_DEBUG
-	if (!gus->interwave)
-		snd_printk("snd_gf1_pokew - GF1!!!\n");
-#endif
-	spin_lock_irqsave(&gus->reg_lock, flags);
-	outb(SNDRV_GF1_GW_DRAM_IO_LOW, gus->gf1.reg_regsel);
-	mb();
-	outw((unsigned short) addr, gus->gf1.reg_data16);
-	mb();
-	outb(SNDRV_GF1_GB_DRAM_IO_HIGH, gus->gf1.reg_regsel);
-	mb();
-	outb((unsigned char) (addr >> 16), gus->gf1.reg_data8);
-	mb();
-	outb(SNDRV_GF1_GW_DRAM_IO16, gus->gf1.reg_regsel);
-	mb();
-	outw(data, gus->gf1.reg_data16);
-	spin_unlock_irqrestore(&gus->reg_lock, flags);
-}
-
-unsigned short snd_gf1_peekw(snd_gus_card_t * gus, unsigned int addr)
-{
-	unsigned long flags;
-	unsigned short res;
-
-#ifdef CONFIG_SND_DEBUG
-	if (!gus->interwave)
-		snd_printk("snd_gf1_peekw - GF1!!!\n");
-#endif
-	spin_lock_irqsave(&gus->reg_lock, flags);
-	outb(SNDRV_GF1_GW_DRAM_IO_LOW, gus->gf1.reg_regsel);
-	mb();
-	outw((unsigned short) addr, gus->gf1.reg_data16);
-	mb();
-	outb(SNDRV_GF1_GB_DRAM_IO_HIGH, gus->gf1.reg_regsel);
-	mb();
-	outb((unsigned char) (addr >> 16), gus->gf1.reg_data8);
-	mb();
-	outb(SNDRV_GF1_GW_DRAM_IO16, gus->gf1.reg_regsel);
-	mb();
-	res = inw(gus->gf1.reg_data16);
-	spin_unlock_irqrestore(&gus->reg_lock, flags);
-	return res;
-}
-
-void snd_gf1_dram_setmem(snd_gus_card_t * gus, unsigned int addr,
-			 unsigned short value, unsigned int count)
-{
-	unsigned long port;
-	unsigned long flags;
-
-#ifdef CONFIG_SND_DEBUG
-	if (!gus->interwave)
-		snd_printk("snd_gf1_dram_setmem - GF1!!!\n");
-#endif
-	addr &= ~1;
-	count >>= 1;
-	port = GUSP(gus, GF1DATALOW);
-	spin_lock_irqsave(&gus->reg_lock, flags);
-	outb(SNDRV_GF1_GW_DRAM_IO_LOW, gus->gf1.reg_regsel);
-	mb();
-	outw((unsigned short) addr, gus->gf1.reg_data16);
-	mb();
-	outb(SNDRV_GF1_GB_DRAM_IO_HIGH, gus->gf1.reg_regsel);
-	mb();
-	outb((unsigned char) (addr >> 16), gus->gf1.reg_data8);
-	mb();
-	outb(SNDRV_GF1_GW_DRAM_IO16, gus->gf1.reg_regsel);
-	while (count--)
-		outw(value, port);
-	spin_unlock_irqrestore(&gus->reg_lock, flags);
-}
-
-/*
-
- */
-
 void snd_gf1_select_active_voices(snd_gus_card_t * gus)
 {
 	unsigned short voices;
@@ -469,63 +368,4 @@
 		printk(" -%i- GF1  pan                    = 0x%x\n", voice, snd_gf1_i_read8(gus, 0x0c));
 }
 
-void snd_gf1_print_global_registers(snd_gus_card_t * gus)
-{
-	unsigned char global_mode = 0x00;
-
-	printk(" -G- GF1 active voices            = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_ACTIVE_VOICES));
-	if (gus->interwave) {
-		global_mode = snd_gf1_i_read8(gus, SNDRV_GF1_GB_GLOBAL_MODE);
-		printk(" -G- GF1 global mode              = 0x%x\n", global_mode);
-	}
-	if (global_mode & 0x02)	/* LFO enabled? */
-		printk(" -G- GF1 LFO base                 = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_LFO_BASE));
-	printk(" -G- GF1 voices IRQ read          = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_VOICES_IRQ_READ));
-	printk(" -G- GF1 DRAM DMA control         = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_DRAM_DMA_CONTROL));
-	printk(" -G- GF1 DRAM DMA high/low        = 0x%x/0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_DRAM_DMA_HIGH), snd_gf1_i_read16(gus, SNDRV_GF1_GW_DRAM_DMA_LOW));
-	printk(" -G- GF1 DRAM IO high/low         = 0x%x/0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_DRAM_IO_HIGH), snd_gf1_i_read16(gus, SNDRV_GF1_GW_DRAM_IO_LOW));
-	if (!gus->interwave)
-		printk(" -G- GF1 record DMA control       = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_REC_DMA_CONTROL));
-	printk(" -G- GF1 DRAM IO 16               = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_DRAM_IO16));
-	if (gus->gf1.enh_mode) {
-		printk(" -G- GFA1 memory config           = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_MEMORY_CONFIG));
-		printk(" -G- GFA1 memory control          = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_MEMORY_CONTROL));
-		printk(" -G- GFA1 FIFO record base        = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_FIFO_RECORD_BASE_ADDR));
-		printk(" -G- GFA1 FIFO playback base      = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_FIFO_PLAY_BASE_ADDR));
-		printk(" -G- GFA1 interleave control      = 0x%x\n", snd_gf1_i_look16(gus, SNDRV_GF1_GW_INTERLEAVE));
-	}
-}
-
-void snd_gf1_print_setup_registers(snd_gus_card_t * gus)
-{
-	printk(" -S- mix control                  = 0x%x\n", inb(GUSP(gus, MIXCNTRLREG)));
-	printk(" -S- IRQ status                   = 0x%x\n", inb(GUSP(gus, IRQSTAT)));
-	printk(" -S- timer control                = 0x%x\n", inb(GUSP(gus, TIMERCNTRL)));
-	printk(" -S- timer data                   = 0x%x\n", inb(GUSP(gus, TIMERDATA)));
-	printk(" -S- status read                  = 0x%x\n", inb(GUSP(gus, REGCNTRLS)));
-	printk(" -S- Sound Blaster control        = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_SOUND_BLASTER_CONTROL));
-	printk(" -S- AdLib timer 1/2              = 0x%x/0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_ADLIB_TIMER_1), snd_gf1_i_look8(gus, SNDRV_GF1_GB_ADLIB_TIMER_2));
-	printk(" -S- reset                        = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_RESET));
-	if (gus->interwave) {
-		printk(" -S- compatibility                = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_COMPATIBILITY));
-		printk(" -S- decode control               = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_DECODE_CONTROL));
-		printk(" -S- version number               = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_VERSION_NUMBER));
-		printk(" -S- MPU-401 emul. control A/B    = 0x%x/0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_MPU401_CONTROL_A), snd_gf1_i_look8(gus, SNDRV_GF1_GB_MPU401_CONTROL_B));
-		printk(" -S- emulation IRQ                = 0x%x\n", snd_gf1_i_look8(gus, SNDRV_GF1_GB_EMULATION_IRQ));
-	}
-}
-
-void snd_gf1_peek_print_block(snd_gus_card_t * gus, unsigned int addr, int count, int w_16bit)
-{
-	if (!w_16bit) {
-		while (count-- > 0)
-			printk(count > 0 ? "%02x:" : "%02x", snd_gf1_peek(gus, addr++));
-	} else {
-		while (count-- > 0) {
-			printk(count > 0 ? "%04x:" : "%04x", snd_gf1_peek(gus, addr) | (snd_gf1_peek(gus, addr + 1) << 8));
-			addr += 2;
-		}
-	}
-}
-
 #endif
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

