Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbVCXDNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbVCXDNL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVCXDMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:12:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:48913 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262996AbVCXDJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:09:14 -0500
Date: Thu, 24 Mar 2005 04:09:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/oss/: cleanups
Message-ID: <20050324030906.GO1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains cleanups including the following:
- make needlessly global code static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 6 Mar 2005

 sound/oss/ad1816.c      |    2 +-
 sound/oss/nm256.h       |    2 +-
 sound/oss/nm256_audio.c |    4 ++--
 sound/oss/nm256_coeff.h |    2 +-
 sound/oss/v_midi.c      |    2 --
 sound/oss/wavfront.c    |   12 ++++++------
 6 files changed, 11 insertions(+), 13 deletions(-)

--- linux-2.6.11-mm1-full/sound/oss/ad1816.c.old	2005-03-06 22:13:46.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/ad1816.c	2005-03-06 22:22:52.000000000 +0100
@@ -592,7 +592,7 @@
   {{reg_l, pola_l, pos_l, len_l}, {reg_r, pola_r, pos_r, len_r}}
 
 
-mixer_ent mix_devices[SOUND_MIXER_NRDEVICES][2] = {
+static mixer_ent mix_devices[SOUND_MIXER_NRDEVICES][2] = {
 MIX_ENT(SOUND_MIXER_VOLUME,	14, 1, 8, 5,	14, 1, 0, 5),
 MIX_ENT(SOUND_MIXER_BASS,	 0, 0, 0, 0,	 0, 0, 0, 0),
 MIX_ENT(SOUND_MIXER_TREBLE,	 0, 0, 0, 0,	 0, 0, 0, 0),
--- linux-2.6.11-mm1-full/sound/oss/nm256.h.old	2005-03-06 22:14:23.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/nm256.h	2005-03-06 22:24:47.000000000 +0100
@@ -284,7 +284,7 @@
 }
 
 /* Returns a non-zero value if we should use the coefficient cache. */
-extern int nm256_cachedCoefficients (struct nm256_info *card);
+static int nm256_cachedCoefficients (struct nm256_info *card);
 
 #endif
 
--- linux-2.6.11-mm1-full/sound/oss/nm256_coeff.h.old	2005-03-06 22:16:18.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/nm256_coeff.h	2005-03-06 22:22:52.000000000 +0100
@@ -4650,7 +4650,7 @@
     card->coeffsCurrent = 1;
 }
 
-void
+static void
 nm256_loadCoefficient (struct nm256_info *card, int which, int number)
 {
     static u16 addrs[3] = { 0x1c, 0x21c, 0x408 };
--- linux-2.6.11-mm1-full/sound/oss/nm256_audio.c.old	2005-03-06 22:14:42.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/nm256_audio.c	2005-03-06 22:22:52.000000000 +0100
@@ -31,7 +31,7 @@
 #include "nm256.h"
 #include "nm256_coeff.h"
 
-int nm256_debug;
+static int nm256_debug;
 static int force_load;
 
 /* 
@@ -138,7 +138,7 @@
 static int buffertop;
 
 /* Check to see if we're using the bank of cached coefficients. */
-int
+static int
 nm256_cachedCoefficients (struct nm256_info *card)
 {
     return usecache;
--- linux-2.6.11-mm1-full/sound/oss/v_midi.c.old	2005-03-06 22:17:55.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/v_midi.c	2005-03-06 22:22:52.000000000 +0100
@@ -39,8 +39,6 @@
  */
 
 
-void            (*midi_input_intr) (int dev, unsigned char data);
-
 static int v_midi_open (int dev, int mode,
 	      void            (*input) (int dev, unsigned char data),
 	      void            (*output) (int dev)
--- linux-2.6.11-mm1-full/sound/oss/wavfront.c.old	2005-03-06 22:18:52.000000000 +0100
+++ linux-2.6.11-mm1-full/sound/oss/wavfront.c	2005-03-06 22:22:52.000000000 +0100
@@ -151,11 +151,11 @@
 
 /*** Module-accessible parameters ***************************************/
 
-int wf_raw;     /* we normally check for "raw state" to firmware
-		   loading. if set, then during driver loading, the
-		   state of the board is ignored, and we reset the
-		   board and load the firmware anyway.
-		*/
+static int wf_raw;     /* we normally check for "raw state" to firmware
+			   loading. if set, then during driver loading, the
+			   state of the board is ignored, and we reset the
+			   board and load the firmware anyway.
+			*/
 		   
 static int fx_raw = 1; /* if this is zero, we'll leave the FX processor in
 		          whatever state it is when the driver is loaded.
@@ -2911,7 +2911,7 @@
 	return 0;
 }	
 
-void
+static void
 wffx_mute (int onoff)
     
 {

