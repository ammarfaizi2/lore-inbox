Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291834AbSBTNJx>; Wed, 20 Feb 2002 08:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291835AbSBTNJn>; Wed, 20 Feb 2002 08:09:43 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:56081 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291834AbSBTNJc>; Wed, 20 Feb 2002 08:09:32 -0500
Date: Wed, 20 Feb 2002 14:09:29 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.5] ALSA + YMFPCI compile fixes.
Message-ID: <20020220130929.GD8539@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch is necessary to compile ALSA with YMFPCI support
on 2.5.5, at least in the following configuration:
	CONFIG_SOUND=m
	CONFIG_SND=m
	CONFIG_SND_SEQUENCER=m
	CONFIG_SND_OSSEMUL=y
	CONFIG_SND_MIXER_OSS=m
	CONFIG_SND_PCM_OSS=m
	CONFIG_SND_SEQUENCER_OSS=m
	CONFIG_SND_YMFPCI=m

Even if my soundcard appears to work properly (using oss emulation), ALSA 
people will probably want to double-check this fix however... 

Stelian.

===== sound/core/seq/Makefile 1.1 vs edited =====
--- 1.1/sound/core/seq/Makefile	Wed Feb 13 20:32:02 2002
+++ edited/sound/core/seq/Makefile	Wed Feb 20 12:18:36 2002
@@ -76,7 +76,7 @@
 obj-$(CONFIG_SND_CS46XX) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
 obj-$(CONFIG_SND_EMU10K1) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-virmidi.o
 obj-$(CONFIG_SND_TRIDENT) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
-obj-$(CONFIG_SND_YMFPCI) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o
+obj-$(CONFIG_SND_YMFPCI) += snd-seq-midi.o snd-seq.o snd-seq-device.o snd-seq-midi-event.o snd-seq-midi-emul.o snd-seq-instr.o
 
 include $(TOPDIR)/Rules.make
 
===== sound/core/seq/instr/Makefile 1.1 vs edited =====
--- 1.1/sound/core/seq/instr/Makefile	Wed Feb 13 20:32:02 2002
+++ edited/sound/core/seq/instr/Makefile	Wed Feb 20 12:22:24 2002
@@ -44,6 +44,7 @@
 obj-$(CONFIG_SND_FM801) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_SONICVIBES) += snd-ainstr-fm.o
 obj-$(CONFIG_SND_TRIDENT) += snd-ainstr-simple.o
+obj-$(CONFIG_SND_YMFPCI) += snd-ainstr-fm.o
 
 include $(TOPDIR)/Rules.make
 
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
