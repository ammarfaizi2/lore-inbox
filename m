Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbUKVABp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbUKVABp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 19:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbUKUX7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 18:59:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57351 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261860AbUKUX6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 18:58:54 -0500
Date: Mon, 22 Nov 2004 00:58:53 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ALSA sound/pcmcia/pdaudiocf/pdaudiocf_core.c: make some code static
Message-ID: <20041121235853.GH13254@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.


diffstat output:
 sound/pcmcia/pdaudiocf/pdaudiocf.h      |    2 --
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |    4 ++--
 2 files changed, 2 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.h.old	2004-11-21 23:57:28.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf.h	2004-11-21 23:57:46.000000000 +0100
@@ -130,8 +130,6 @@
 	return inw(chip->port + reg);
 }
 
-unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg);
-void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val);
 pdacf_t *snd_pdacf_create(snd_card_t *card);
 int snd_pdacf_ak4117_create(pdacf_t *pdacf);
 void snd_pdacf_powerdown(pdacf_t *chip);
--- linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c.old	2004-11-21 23:57:54.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/sound/pcmcia/pdaudiocf/pdaudiocf_core.c	2004-11-21 23:58:10.000000000 +0100
@@ -28,7 +28,7 @@
 /*
  *
  */
-unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg)
+static unsigned char pdacf_ak4117_read(void *private_data, unsigned char reg)
 {
 	pdacf_t *chip = private_data;
 	unsigned long timeout;
@@ -60,7 +60,7 @@
 	return res;
 }
 
-void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val)
+static void pdacf_ak4117_write(void *private_data, unsigned char reg, unsigned char val)
 {
 	pdacf_t *chip = private_data;
 	unsigned long timeout;

