Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933885AbWKTCYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933885AbWKTCYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 21:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933876AbWKTCYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 21:24:19 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42001 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933875AbWKTCX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 21:23:58 -0500
Date: Mon, 20 Nov 2006 03:23:58 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ping Cheng <pingc@wacom.com>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] make drivers/usb/input/wacom_sys.c:wacom_sys_irq() static
Message-ID: <20061120022357.GJ31879@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the needlessly global wacom_sys_irq() static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/input/wacom.h     |    1 -
 drivers/usb/input/wacom_sys.c |    2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.19-rc5-mm2/drivers/usb/input/wacom.h.old	2006-11-20 01:05:38.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/input/wacom.h	2006-11-20 01:05:44.000000000 +0100
@@ -110,7 +110,6 @@
 };
 
 extern int wacom_wac_irq(struct wacom_wac * wacom_wac, void * wcombo);
-extern void wacom_sys_irq(struct urb *urb);
 extern void wacom_report_abs(void *wcombo, unsigned int abs_type, int abs_data);
 extern void wacom_report_rel(void *wcombo, unsigned int rel_type, int rel_data);
 extern void wacom_report_key(void *wcombo, unsigned int key_type, int key_data);
--- linux-2.6.19-rc5-mm2/drivers/usb/input/wacom_sys.c.old	2006-11-20 01:05:52.000000000 +0100
+++ linux-2.6.19-rc5-mm2/drivers/usb/input/wacom_sys.c	2006-11-20 01:05:58.000000000 +0100
@@ -42,7 +42,7 @@
 	return wcombo->wacom->dev;
 }
 
-void wacom_sys_irq(struct urb *urb)
+static void wacom_sys_irq(struct urb *urb)
 {
 	struct wacom *wacom = urb->context;
 	struct wacom_combo wcombo;

