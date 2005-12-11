Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVLKTer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVLKTer (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVLKTer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:34:47 -0500
Received: from uproxy.gmail.com ([66.249.92.206]:64433 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750825AbVLKTeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:34:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=lexFgcZpcW333zd0pWfYfXWWNB302dDIXfBATNz1ztOEBYNGwXPkEFgpO5TxiLkSowMzR8JF3peACFcpzDJhI7h1D0DsjwY3/sdhUyJhRWiqaasf3Scz6SSXRXVpcf4MAlefriiEE+C0VnBxLE4ryhe6YREl2kKEnVpJdDTbEvs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] sound: Remove unneeded kmalloc() return value casts
Date: Sun, 11 Dec 2005 20:35:19 +0100
User-Agent: KMail/1.9
Cc: Jaroslav Kysela <perex@suse.cz>, jgarzik@pobox.com, support@opensound.com,
       James@superbug.demon.co.uk, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512112035.19936.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Get rid of unnessesary casts of kmalloc() return value in sound/


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/core/rawmidi.c                |    6 ++++--
 sound/oss/dmasound/dmasound_awacs.c |    2 +-
 sound/oss/emu10k1/midi.c            |    9 ++++++---
 sound/oss/sh_dac_audio.c            |    2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)

--- linux-2.6.15-rc5-git1-orig/sound/core/rawmidi.c	2005-12-04 18:49:03.000000000 +0100
+++ linux-2.6.15-rc5-git1/sound/core/rawmidi.c	2005-12-11 19:33:29.000000000 +0100
@@ -619,7 +619,8 @@ int snd_rawmidi_output_params(snd_rawmid
 		return -EINVAL;
 	}
 	if (params->buffer_size != runtime->buffer_size) {
-		if ((newbuf = (char *) kmalloc(params->buffer_size, GFP_KERNEL)) == NULL)
+		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
+		if (!newbuf)
 			return -ENOMEM;
 		kfree(runtime->buffer);
 		runtime->buffer = newbuf;
@@ -644,7 +645,8 @@ int snd_rawmidi_input_params(snd_rawmidi
 		return -EINVAL;
 	}
 	if (params->buffer_size != runtime->buffer_size) {
-		if ((newbuf = (char *) kmalloc(params->buffer_size, GFP_KERNEL)) == NULL)
+		newbuf = kmalloc(params->buffer_size, GFP_KERNEL);
+		if (!newbuf)
 			return -ENOMEM;
 		kfree(runtime->buffer);
 		runtime->buffer = newbuf;
--- linux-2.6.15-rc5-git1-orig/sound/oss/dmasound/dmasound_awacs.c	2005-12-04 18:49:06.000000000 +0100
+++ linux-2.6.15-rc5-git1/sound/oss/dmasound/dmasound_awacs.c	2005-12-11 19:36:03.000000000 +0100
@@ -2796,7 +2796,7 @@ __init setup_beep(void)
 			DBDMA_ALIGN(beep_dbdma_cmd_space);
 	/* set up emergency dbdma cmd */
 	emergency_dbdma_cmd = beep_dbdma_cmd+1 ;
-	beep_buf = (short *) kmalloc(BEEP_BUFLEN * 4, GFP_KERNEL);
+	beep_buf = kmalloc(BEEP_BUFLEN * 4, GFP_KERNEL);
 	if (beep_buf == NULL) {
 		printk(KERN_ERR "dmasound_pmac: no memory for beep buffer\n");
 		kfree(beep_dbdma_cmd_space) ;
--- linux-2.6.15-rc5-git1-orig/sound/oss/sh_dac_audio.c	2005-12-04 18:49:06.000000000 +0100
+++ linux-2.6.15-rc5-git1/sound/oss/sh_dac_audio.c	2005-12-11 19:37:48.000000000 +0100
@@ -289,7 +289,7 @@ static int __init dac_audio_init(void)
 
 	in_use = 0;
 
-	data_buffer = (char *)kmalloc(BUFFER_SIZE, GFP_KERNEL);
+	data_buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
 	if (data_buffer == NULL)
 		return -ENOMEM;
 
--- linux-2.6.15-rc5-git1-orig/sound/oss/emu10k1/midi.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/sound/oss/emu10k1/midi.c	2005-12-11 19:40:12.000000000 +0100
@@ -65,7 +65,8 @@ static int midiin_add_buffer(struct emu1
 
 	init_midi_hdr(midihdr);
 
-	if ((midihdr->data = (u8 *) kmalloc(MIDIIN_BUFLEN, GFP_KERNEL)) == NULL) {
+	midihdr->data = kmalloc(MIDIIN_BUFLEN, GFP_KERNEL);
+	if (!midihdr->data) {
 		ERROR();
 		kfree(midihdr);
 		return -1;
@@ -334,7 +335,8 @@ static ssize_t emu10k1_midi_write(struct
 	midihdr->bytesrecorded = 0;
 	midihdr->flags = 0;
 
-	if ((midihdr->data = (u8 *) kmalloc(count, GFP_KERNEL)) == NULL) {
+	midihdr->data = kmalloc(count, GFP_KERNEL);
+	if (!midihdr->data) {
 		ERROR();
 		kfree(midihdr);
 		return -EINVAL;
@@ -545,7 +547,8 @@ int emu10k1_seq_midi_out(int dev, unsign
 	midihdr->bytesrecorded = 0;
 	midihdr->flags = 0;
 
-	if ((midihdr->data = (u8 *) kmalloc(1, GFP_KERNEL)) == NULL) {
+	midihdr->data = kmalloc(1, GFP_KERNEL);
+	if (!midihdr->data) {
 		ERROR();
 		kfree(midihdr);
 		return -EINVAL;


