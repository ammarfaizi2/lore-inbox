Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030937AbWKUM7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030937AbWKUM7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 07:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030932AbWKUM70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 07:59:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24774 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030924AbWKUM7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 07:59:09 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Luca Risolia <luca.risolia@studio.unibo.it>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 5/5] V4L/DVB (4865): Fix: Slot 0 not NULL on disconnecting
	SN9C10x PC Camera
Date: Tue, 21 Nov 2006 10:38:50 -0200
Message-id: <20061121123850.PS6444860005@infradead.org>
In-Reply-To: <20061121123202.PS8610150000@infradead.org>
References: <20061121123202.PS8610150000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Luca Risolia <luca.risolia@studio.unibo.it>

The patch fix bug 5748.

Signed-off-by: Luca Risolia <luca.risolia@studio.unibo.it>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/et61x251/et61x251_core.c |    3 +--
 drivers/media/video/sn9c102/sn9c102_core.c   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/video/et61x251/et61x251_core.c b/drivers/media/video/et61x251/et61x251_core.c
index f786ab1..86e353b 100644
--- a/drivers/media/video/et61x251/et61x251_core.c
+++ b/drivers/media/video/et61x251/et61x251_core.c
@@ -1182,8 +1182,6 @@ static void et61x251_release_resources(s
 	video_set_drvdata(cam->v4ldev, NULL);
 	video_unregister_device(cam->v4ldev);
 
-	usb_put_dev(cam->usbdev);
-
 	mutex_unlock(&et61x251_sysfs_lock);
 
 	kfree(cam->control_buffer);
@@ -1275,6 +1273,7 @@ static int et61x251_release(struct inode
 
 	if (cam->state & DEV_DISCONNECTED) {
 		et61x251_release_resources(cam);
+		usb_put_dev(cam->usbdev);
 		mutex_unlock(&cam->dev_mutex);
 		kfree(cam);
 		return 0;
diff --git a/drivers/media/video/sn9c102/sn9c102_core.c b/drivers/media/video/sn9c102/sn9c102_core.c
index a4702d3..42fb60d 100644
--- a/drivers/media/video/sn9c102/sn9c102_core.c
+++ b/drivers/media/video/sn9c102/sn9c102_core.c
@@ -1462,8 +1462,6 @@ static void sn9c102_release_resources(st
 	video_set_drvdata(cam->v4ldev, NULL);
 	video_unregister_device(cam->v4ldev);
 
-	usb_put_dev(cam->usbdev);
-
 	mutex_unlock(&sn9c102_sysfs_lock);
 
 	kfree(cam->control_buffer);
@@ -1555,6 +1553,7 @@ static int sn9c102_release(struct inode*
 
 	if (cam->state & DEV_DISCONNECTED) {
 		sn9c102_release_resources(cam);
+		usb_put_dev(cam->usbdev);
 		mutex_unlock(&cam->dev_mutex);
 		kfree(cam);
 		return 0;

