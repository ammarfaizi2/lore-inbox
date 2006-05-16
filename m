Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751793AbWEPMPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbWEPMPP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWEPMPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:15:14 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23315 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751793AbWEPMPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:15:13 -0400
Date: Tue, 16 May 2006 14:15:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Luc Saillard <luc@saillard.org>
Cc: linux-kernel@vger.kernel.org, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] drivers/media/video/pwc/: make code static
Message-ID: <20060516121510.GP6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515005637.00b54560.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 12:56:37AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc3-mm1:
>...
>  git-dvb.patch
>...
>  git trees
>...

This patch makes the following needlessly global code static:
- pwc-ctrl.c: pwc_get_leds()
- pwc_preferred_compression

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

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
