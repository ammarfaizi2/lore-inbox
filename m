Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVCWXlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVCWXlw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVCWXlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:41:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50959 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262388AbVCWXlg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:41:36 -0500
Date: Thu, 24 Mar 2005 00:41:28 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/oss/pcm_plugin.c: kill dead code
Message-ID: <20050323234128.GF1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found this obviously dead code.

I'mnot sure which of the if (plugin == NULL) is correct - this patch 
removes the one that couldn't be true.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/sound/core/oss/pcm_plugin.c.old	2005-03-23 01:06:58.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/sound/core/oss/pcm_plugin.c	2005-03-23 01:07:41.000000000 +0100
@@ -657,22 +657,19 @@ static int snd_pcm_plug_playback_channel
 	if (plugin == NULL) {
 		return 0;
 	} else {
 		int schannels = plugin->dst_format.channels;
 		bitset_t bs[bitset_size(schannels)];
 		bitset_t *srcmask;
 		bitset_t *dstmask = bs;
 		int err;
 		bitset_one(dstmask, schannels);
-		if (plugin == NULL) {
-			bitset_and(client_vmask, dstmask, schannels);
-			return 0;
-		}
+
 		while (1) {
 			err = plugin->src_channels_mask(plugin, dstmask, &srcmask);
 			if (err < 0)
 				return err;
 			dstmask = srcmask;
 			if (plugin->prev == NULL)
 				break;
 			plugin = plugin->prev;
 		}

