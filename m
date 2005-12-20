Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbVLTDJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbVLTDJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 22:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVLTDJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 22:09:42 -0500
Received: from mail19.bluewin.ch ([195.186.18.65]:21737 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S1750733AbVLTDJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 22:09:41 -0500
Date: Mon, 19 Dec 2005 22:07:49 -0500
To: akpm@osdl.org
Cc: philb@gnu.org, linux-kernel@vger.kernel.org
Subject: [PATCH] v4l: don't ignore return from i2c_add_driver() for tuner-3036
Message-ID: <20051220030749.GA24700@krypton>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The call to i2c_add_driver() may actually fail, but tuner-3036 ignores
this and always returns 0, regardless.

Fix it up so it returns what i2c_add_driver() does, instead.

Signed-off-by: Arthur Othieno <a.othieno@bluewin.ch>

---

 drivers/media/video/tuner-3036.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

b0a7aec914298ce1ceda98c730c950a08d8f0a99
diff --git a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
index 7920359..05e4ee2 100644
--- a/drivers/media/video/tuner-3036.c
+++ b/drivers/media/video/tuner-3036.c
@@ -193,8 +193,7 @@ static struct i2c_client client_template
 static int __init
 tuner3036_init(void)
 {
-	i2c_add_driver(&i2c_driver_tuner);
-	return 0;
+	return i2c_add_driver(&i2c_driver_tuner);
 }
 
 static void __exit
-- 
0.99.9n
