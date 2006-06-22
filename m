Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161034AbWFVKD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbWFVKD5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161033AbWFVKDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:03:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:43535 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161032AbWFVKD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:03:27 -0400
Date: Thu, 22 Jun 2006 12:03:27 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Luc Saillard <luc@saillard.org>
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] drivers/media/video/pwc/: make code static
Message-ID: <20060622100327.GA9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following needlessly global code static:
- pwc-ctrl.c: pwc_get_leds()
- pwc_preferred_compression

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 16 May 2006

 drivers/media/video/pwc/pwc-ctrl.c |    2 +-
 drivers/media/video/pwc/pwc-if.c   |    2 +-
 drivers/media/video/pwc/pwc.h      |    2 --
 3 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc.h.old	2006-05-16 12:54:35.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc.h	2006-05-16 12:55:17.000000000 +0200
@@ -274,7 +274,6 @@
 #if CONFIG_PWC_DEBUG
 extern int pwc_trace;
 #endif
-extern int pwc_preferred_compression;
 extern int pwc_mbufs;
 
 /** functions in pwc-if.c */
@@ -308,7 +307,6 @@
 extern int pwc_get_saturation(struct pwc_device *pdev, int *value);
 extern int pwc_set_saturation(struct pwc_device *pdev, int value);
 extern int pwc_set_leds(struct pwc_device *pdev, int on_value, int off_value);
-extern int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value);
 extern int pwc_get_cmos_sensor(struct pwc_device *pdev, int *sensor);
 extern int pwc_restore_user(struct pwc_device *pdev);
 extern int pwc_save_user(struct pwc_device *pdev);
--- linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc-ctrl.c.old	2006-05-16 12:54:49.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc-ctrl.c	2006-05-16 12:54:55.000000000 +0200
@@ -925,7 +925,7 @@
 	return SendControlMsg(SET_STATUS_CTL, LED_FORMATTER, 2);
 }
 
-int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value)
+static int pwc_get_leds(struct pwc_device *pdev, int *on_value, int *off_value)
 {
 	unsigned char buf[2];
 	int ret;
--- linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc-if.c.old	2006-05-16 12:55:26.000000000 +0200
+++ linux-2.6.17-rc4-mm1-full/drivers/media/video/pwc/pwc-if.c	2006-05-16 12:55:36.000000000 +0200
@@ -133,7 +133,7 @@
 #endif
 static int power_save = 0;
 static int led_on = 100, led_off = 0; /* defaults to LED that is on while in use */
-       int pwc_preferred_compression = 1; /* 0..3 = uncompressed..high */
+static int pwc_preferred_compression = 1; /* 0..3 = uncompressed..high */
 static struct {
 	int type;
 	char serial_number[30];
