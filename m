Return-Path: <linux-kernel-owner+w=401wt.eu-S964771AbWL0RNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWL0RNi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 12:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964769AbWL0RNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 12:13:37 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41512 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933010AbWL0RNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 12:13:01 -0500
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: V4L-DVB Maintainers <v4l-dvb-maintainer@linuxtv.org>,
       David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 25/28] V4L/DVB (5014): Allyesconfig build fixes on some non
	x86 arch
Date: Wed, 27 Dec 2006 14:57:32 -0200
Message-id: <20061227165732.PS37648900025@infradead.org>
In-Reply-To: <20061227165016.PS89442900000@infradead.org>
References: <20061227165016.PS89442900000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: David Brownell <david-b@pacbell.net>

- CAFE_CCIC needs to depend on PCI, else "allyesconfig" breaks
   on systems without PCI
- em28xx-video can't udelay(2500) else "allyesconfig" breaks
   on systems that refuse to spin that long (I saw it on ARM)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/Kconfig               |    2 +-
 drivers/media/video/em28xx/em28xx-video.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index 29a11c1..57357db 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -668,7 +668,7 @@ config VIDEO_M32R_AR_M64278
 
 config VIDEO_CAFE_CCIC
 	tristate "Marvell 88ALP01 (Cafe) CMOS Camera Controller support"
-	depends on I2C && VIDEO_V4L2
+	depends on PCI && I2C && VIDEO_V4L2
 	select VIDEO_OV7670
 	---help---
 	  This is a video4linux2 driver for the Marvell 88ALP01 integrated
diff --git a/drivers/media/video/em28xx/em28xx-video.c b/drivers/media/video/em28xx/em28xx-video.c
index 2a461dd..36e72c2 100644
--- a/drivers/media/video/em28xx/em28xx-video.c
+++ b/drivers/media/video/em28xx/em28xx-video.c
@@ -1674,9 +1674,9 @@ #endif
 	if (dev->has_msp34xx) {
 		/* Send a reset to other chips via gpio */
 		em28xx_write_regs_req(dev, 0x00, 0x08, "\xf7", 1);
-		udelay(2500);
+		msleep(3);
 		em28xx_write_regs_req(dev, 0x00, 0x08, "\xff", 1);
-		udelay(2500);
+		msleep(3);
 
 	}
 	video_mux(dev, 0);

