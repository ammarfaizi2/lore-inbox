Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946221AbWKAFhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946221AbWKAFhT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946111AbWKAFgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:36:47 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37831 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946171AbWKAFgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:36:18 -0500
Message-Id: <20061101053655.755958000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:52 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Karsten Wiese <annabellesgarden@yahoo.de>,
       Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 12/61] ALSA: Fix bug in snd-usb-usx2ys usX2Y_pcms_lock_check()
Content-Disposition: inline; filename=alsa-fix-bug-in-snd-usb-usx2y-s-usx2y_pcms_lock_check.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Karsten Wiese <annabellesgarden@yahoo.de>

[PATCH] ALSA: Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()

Fix bug in snd-usb-usx2y's usX2Y_pcms_lock_check()

substream can be NULL......
in mainline, bug was introduced by:
2006-06-22  [ALSA] Add O_APPEND flag support to PCM

From: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Karsten Wiese <annabellesgarden@yahoo.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 sound/usb/usx2y/usx2yhwdeppcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.18.1.orig/sound/usb/usx2y/usx2yhwdeppcm.c
+++ linux-2.6.18.1/sound/usb/usx2y/usx2yhwdeppcm.c
@@ -632,7 +632,7 @@ static int usX2Y_pcms_lock_check(struct 
 		for (s = 0; s < 2; ++s) {
 			struct snd_pcm_substream *substream;
 			substream = pcm->streams[s].substream;
-			if (SUBSTREAM_BUSY(substream))
+			if (substream && SUBSTREAM_BUSY(substream))
 				err = -EBUSY;
 		}
 	}

--
