Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVLaQRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVLaQRB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 11:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbVLaQQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 11:16:59 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:52688 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S965001AbVLaQQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 11:16:57 -0500
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Sat, 31 Dec 2005 17:16:35 +0100
In-reply-to: <200500919343.923456789ble@anxur.fi.muni.cz>
Subject: [PATCH 4/4] media-radio: Maestro avoid accessing private structures directly
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, atlka@pg.gda.pl
Message-Id: <20051231161634.825FA1E3344@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maestro avoid accessing private structures directly

video_device.priv is not allowed to touch and it will be actually removed
in near future. Use video_get_drvdata() instead.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit 7f0d24a69ec1df36ce01b8969217fa108fe2e92f
tree daefeb7b65d6b1a9794b57bea5b34ac39bbced21
parent a6bf47a35d16fad6207effb37532466c57d20b28
author <ku@bellona.(none)> Sat, 31 Dec 2005 17:04:14 +0100
committer <ku@bellona.(none)> Sat, 31 Dec 2005 17:04:14 +0100

 drivers/media/radio/radio-maestro.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/radio/radio-maestro.c b/drivers/media/radio/radio-maestro.c
--- a/drivers/media/radio/radio-maestro.c
+++ b/drivers/media/radio/radio-maestro.c
@@ -182,7 +182,7 @@ static inline int radio_function(struct 
 	unsigned int cmd, void *arg)
 {
 	struct video_device *dev = video_devdata(file);
-	struct radio_device *card = dev->priv;
+	struct radio_device *card = video_get_drvdata(dev);
 
 	switch (cmd) {
 	case VIDIOCGCAP: {
@@ -258,7 +258,7 @@ static int radio_ioctl(struct inode *ino
 	unsigned int cmd, unsigned long arg)
 {
 	struct video_device *dev = video_devdata(file);
-	struct radio_device *card = dev->priv;
+	struct radio_device *card = video_get_drvdata(dev);
 	int ret;
 
 	down(&card->lock);
