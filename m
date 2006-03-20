Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965514AbWCTPtH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965514AbWCTPtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965511AbWCTPtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:49:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36066 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966741AbWCTPUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:23 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 066/141] V4L/DVB (3314): Fixed em28xx based system lockup 
Date: Mon, 20 Mar 2006 12:08:48 -0300
Message-id: <20060320150847.PS992973000066@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Rechberger <mrechberger@gmail.com>
Date: 1139302153 -0200

Fixed em28xx based system lockup, device needs to be initialized
before starting the isoc transfer otherwise the system will completly lock up.

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 1726b2c..1c1557d 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -383,12 +383,14 @@ static int em28xx_v4l2_open(struct inode
 		em28xx_capture_start(dev, 1);
 		em28xx_resolution_set(dev);
 
+		/* device needs to be initialized before isoc transfer */
+		video_mux(dev, 0);
+
 		/* start the transfer */
 		errCode = em28xx_init_isoc(dev);
 		if (errCode)
 			goto err;
 
-		video_mux(dev, 0);
 	}
 
 	dev->users++;

