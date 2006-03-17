Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932847AbWCQXC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbWCQXC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 18:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWCQXBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 18:01:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4514 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932788AbWCQXBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 18:01:21 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Markus Rechberger <mrechberger@gmail.com>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 21/21] Fixed em28xx based system lockup
Date: Fri, 17 Mar 2006 17:54:39 -0300
Message-id: <20060317205439.PS01560100021@infradead.org>
In-Reply-To: <20060317205359.PS65198900000@infradead.org>
References: <20060317205359.PS65198900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Markus Rechberger <mrechberger@gmail.com>
Date: Tue, 7 Feb 2006 08:49:13 +0000 (-0200)

Fixed em28xx based system lockup, device needs to be initialized
before starting the isoc transfer otherwise the system will completly lock up.

Signed-off-by: Markus Rechberger <mrechberger@gmail.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/em28xx/em28xx-video.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index d58a12c..385d22a 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -367,6 +367,9 @@ static int em28xx_v4l2_open(struct inode
 	em28xx_capture_start(dev, 1);
 	em28xx_resolution_set(dev);
 
+	/* device needs to be initialized before isoc transfer */
+	video_mux(dev, 0);
+
 	/* start the transfer */
 	errCode = em28xx_init_isoc(dev);
 	if (errCode)

