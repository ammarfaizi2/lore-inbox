Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293510AbSEIMnW>; Thu, 9 May 2002 08:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293632AbSEIMnV>; Thu, 9 May 2002 08:43:21 -0400
Received: from www.swazicraftsmarket.com ([196.28.7.66]:8121 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S293510AbSEIMnU>; Thu, 9 May 2002 08:43:20 -0400
Date: Thu, 9 May 2002 14:21:32 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Jaroslav Kysela <perex@perex.cz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] opl3 OSS emulation compile fixes
Message-ID: <Pine.LNX.4.44.0205091419590.6271-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not so sure wether the ifeq change is what you want though...

--- linux-2.5/sound/drivers/opl3/Makefile.orig	Thu May  9 12:38:42 2002
+++ linux-2.5/sound/drivers/opl3/Makefile	Thu May  9 12:39:20 2002
@@ -9,7 +9,7 @@
 
 snd-opl3-lib-objs := opl3_lib.o opl3_synth.o
 snd-opl3-synth-objs := opl3_seq.o opl3_midi.o opl3_drums.o
-ifeq ($(subst m,y,$(CONFIG_SND_SEQUENCER)),y)
+ifeq ($(subst m,y,$(CONFIG_SND_OSSEMUL)),y)
 snd-opl3-synth-objs += opl3_oss.o
 endif
 
--- linux-2.5/include/sound/opl3.h.orig	Thu May  9 12:34:10 2002
+++ linux-2.5/include/sound/opl3.h	Thu May  9 12:34:18 2002
@@ -287,8 +287,10 @@
 	snd_seq_device_t *seq_dev;	/* sequencer device */
 	snd_midi_channel_set_t * chset;
 
+#ifdef CONFIG_SND_OSSEMUL
 	snd_seq_device_t *oss_seq_dev;	/* OSS sequencer device, WIP */
 	snd_midi_channel_set_t * oss_chset;
+#endif
  
 	snd_seq_kinstr_ops_t fm_ops;
 	snd_seq_kinstr_list_t *ilist;

-- 
http://function.linuxpower.ca
		

