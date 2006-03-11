Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWCKDnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWCKDnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 22:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWCKDnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 22:43:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:50949 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932373AbWCKDnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 22:43:10 -0500
Date: Sat, 11 Mar 2006 04:43:10 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/: fix 3 off-by-one errors
Message-ID: <20060311034310.GK21864@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes three off-by-one errors found by the Coverity checker.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 sound/core/sound.c     |    4 ++--
 sound/core/sound_oss.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.16-rc5-mm3-full/sound/core/sound.c.old	2006-03-11 03:03:04.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/core/sound.c	2006-03-11 03:04:59.000000000 +0100
@@ -121,7 +121,7 @@ void *snd_lookup_minor_data(unsigned int
 	struct snd_minor *mreg;
 	void *private_data;
 
-	if (minor > ARRAY_SIZE(snd_minors))
+	if (minor >= ARRAY_SIZE(snd_minors))
 		return NULL;
 	mutex_lock(&sound_mutex);
 	mreg = snd_minors[minor];
@@ -140,7 +140,7 @@ static int snd_open(struct inode *inode,
 	const struct file_operations *old_fops;
 	int err = 0;
 
-	if (minor > ARRAY_SIZE(snd_minors))
+	if (minor >= ARRAY_SIZE(snd_minors))
 		return -ENODEV;
 	mptr = snd_minors[minor];
 	if (mptr == NULL) {
--- linux-2.6.16-rc5-mm3-full/sound/core/sound_oss.c.old	2006-03-11 03:05:48.000000000 +0100
+++ linux-2.6.16-rc5-mm3-full/sound/core/sound_oss.c	2006-03-11 03:06:01.000000000 +0100
@@ -46,7 +46,7 @@ void *snd_lookup_oss_minor_data(unsigned
 	struct snd_minor *mreg;
 	void *private_data;
 
-	if (minor > ARRAY_SIZE(snd_oss_minors))
+	if (minor >= ARRAY_SIZE(snd_oss_minors))
 		return NULL;
 	mutex_lock(&sound_oss_mutex);
 	mreg = snd_oss_minors[minor];

