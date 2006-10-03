Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWJCMcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWJCMcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 08:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWJCMcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 08:32:55 -0400
Received: from mout2.freenet.de ([194.97.50.155]:50907 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S1750801AbWJCMcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 08:32:54 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net,
       Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()
Date: Tue, 3 Oct 2006 14:33:56 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031433.56957.annabellesgarden@yahoo.de>
X-Warning: yahoo.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()

substream can be NULL......
in mainline, bug was introduced by:
2006-06-22  [ALSA] Add O_APPEND flag support to PCM

Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>



--- alsa-kernel/usb/usx2y/usx2yhwdeppcm.c~	2006-06-29 23:25:30.000000000 +0200
+++ alsa-kernel/usb/usx2y/usx2yhwdeppcm.c	2006-10-03 14:05:12.000000000 +0200
@@ -632,7 +632,7 @@ static int usX2Y_pcms_lock_check(struct 
 		for (s = 0; s < 2; ++s) {
 			struct snd_pcm_substream *substream;
 			substream = pcm->streams[s].substream;
-			if (SUBSTREAM_BUSY(substream))
+			if (substream && SUBSTREAM_BUSY(substream))
 				err = -EBUSY;
 		}
 	}
