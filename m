Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030500AbWASBVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030500AbWASBVY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030497AbWASBVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:21:24 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59401 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030499AbWASBVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:21:22 -0500
Date: Thu, 19 Jan 2006 02:21:20 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@brturbo.com.br
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_CX88_ALSA must select SND_PCM
Message-ID: <20060119012120.GW19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `snd_cx88_pcm_open':cx88-alsa.c:(.text+0x43f87a): undefined reference to 'snd_pcm_hw_constraint_integer'
drivers/built-in.o: In function `snd_cx88_hw_params':cx88-alsa.c:(.text+0x43f9e7): undefined reference to `snd_pcm_format_physical_width'
drivers/built-in.o: In function `cx8801_irq':cx88-alsa.c:(.text+0x43ff1f): undefined reference to `snd_pcm_period_elapsed'
drivers/built-in.o: In function `cx88_audio_initdev':cx88-alsa.c:(.text+0x440158): undefined reference to `snd_pcm_new':cx88-alsa.c:(.text+0x440194): undefined reference to `snd_pcm_set_ops'
drivers/built-in.o:(.data+0xa6f88): undefined reference to `snd_pcm_lib_ioctl'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc1-mm1-full/drivers/media/video/cx88/Kconfig.old	2006-01-19 01:58:39.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/media/video/cx88/Kconfig	2006-01-19 01:58:51.000000000 +0100
@@ -32,6 +32,7 @@
 config VIDEO_CX88_ALSA
 	tristate "ALSA DMA audio support"
 	depends on VIDEO_CX88 && SND && EXPERIMENTAL
+	select SND_PCM
 	---help---
 	  This is a video4linux driver for direct (DMA) audio on
 	  Conexant 2388x based TV cards.

