Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319414AbSH2V4X>; Thu, 29 Aug 2002 17:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319406AbSH2Vzh>; Thu, 29 Aug 2002 17:55:37 -0400
Received: from smtpout.mac.com ([204.179.120.86]:64980 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319355AbSH2VyR>;
	Thu, 29 Aug 2002 17:54:17 -0400
Message-Id: <200208292158.g7TLwe72021895@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 37/41 sound/oss/vwsnd.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/vwsnd.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/vwsnd.c	Sat Aug 10 19:52:00 2002
@@ -2917,7 +2917,7 @@
 static int vwsnd_audio_open(struct inode *inode, struct file *file)
 {
 	vwsnd_dev_t *devc;
-	dev_t minor = MINOR(inode->i_rdev);
+	dev_t minor = minor(inode->i_rdev);
 	int sw_samplefmt;
 
 	DBGE("(inode=0x%p, file=0x%p)\n", inode, file);
@@ -3064,7 +3064,7 @@
 
 	INC_USE_COUNT;
 	for (devc = vwsnd_dev_list; devc; devc = devc->next_dev)
-		if (devc->mixer_minor == MINOR(inode->i_rdev))
+		if (devc->mixer_minor == minor(inode->i_rdev))
 			break;
 
 	if (devc == NULL) {

