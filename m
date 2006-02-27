Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWB0Whn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWB0Whn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWB0Wg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:36:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:55169 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932365AbWB0Wby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:31:54 -0500
Message-Id: <20060227223354.034065000@sorel.sous-sol.org>
References: <20060227223200.865548000@sorel.sous-sol.org>
Date: Mon, 27 Feb 2006 14:32:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, tiwai@suse.de, perex@suse.cz
Subject: [patch 22/39] [PATCH] alsa: fix bogus snd_device_free() in opl3-oss.c
Content-Disposition: inline; filename=alsa-fix-bogus-snd_device_free-in-opl3-oss.c.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Remove snd_device_free() for an opl3-oss instance which should have been
released.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 sound/drivers/opl3/opl3_oss.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.15.4.orig/sound/drivers/opl3/opl3_oss.c
+++ linux-2.6.15.4/sound/drivers/opl3/opl3_oss.c
@@ -146,7 +146,7 @@ void snd_opl3_init_seq_oss(opl3_t *opl3,
 void snd_opl3_free_seq_oss(opl3_t *opl3)
 {
 	if (opl3->oss_seq_dev) {
-		snd_device_free(opl3->card, opl3->oss_seq_dev);
+		/* The instance should have been released in prior */
 		opl3->oss_seq_dev = NULL;
 	}
 }

--
