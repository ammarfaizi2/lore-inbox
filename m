Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVCTVll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVCTVll (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 16:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVCTVll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 16:41:41 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:10669 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261288AbVCTVl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 16:41:28 -0500
Date: Sun, 20 Mar 2005 22:45:59 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>, Vojtech Pavlik <vojtech@suse.cz>,
       video4linux-list@redhat.com
Subject: [PATCH 2.6.11.2][SECURITY] printk with anti-cluttering-feature
In-Reply-To: <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
Message-ID: <Pine.LNX.4.58.0503202243220.3051@be1.lrz>
References: <Pine.LNX.4.58.0503200528520.2804@be1.lrz> <423D6353.5010603@tls.msk.ru>
 <Pine.LNX.4.58.0503201425080.2886@be1.lrz> <Pine.LNX.4.58.0503202151360.2869@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Security fix against a log spamming DoS in tuner.c, compile-tested

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- linux-2.6.11/drivers/media/video/tuner.c	2005-03-20 20:54:54.000000000 +0100
+++ hotfix/drivers/media/video/tuner.c	2005-03-20 21:10:33.000000000 +0100
@@ -1048,8 +1048,9 @@ static void set_tv_freq(struct i2c_clien
 		   right now we don't have that in the config
 		   struct and this way is still better than no
 		   check at all */
-		printk("tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
-		       freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
+		if(printk_ratelimit())
+			printk("tuner: TV freq (%d.%02d) out of range (%d-%d)\n",
+			       freq/16,freq%16*100/16,tv_range[0],tv_range[1]);
 		return;
 	}
 	t->tv_freq(c,freq);
