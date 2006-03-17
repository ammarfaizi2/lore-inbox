Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWCQU4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWCQU4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWCQU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 15:56:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58282 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030191AbWCQU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 15:56:18 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 20/21] VIDEO_CPIA2 must depend on USB
Date: Fri, 17 Mar 2006 17:54:38 -0300
Message-id: <20060317205438.PS69563100020@infradead.org>
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


From: Adrian Bunk <bunk@stusta.de>
Date: 1142524433 \-0300

CONFIG_VIDEO_CPIA2=y, CONFIG_USB=n results in the following compile 
<--  snip  -->
...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `set_alternate':cpia2_usb.c:(.text+0x443aa2): undefined reference to `usb_set_interface'
drivers/built-in.o: In function `cpia2_usb_stream_resume': undefined reference to `usb_alloc_urb'
drivers/built-in.o: In function `cpia2_usb_stream_resume': undefined reference to `usb_submit_urb'
drivers/built-in.o: In function `cpia2_usb_stream_pause': undefined reference to `usb_kill_urb'
drivers/built-in.o: In function `cpia2_usb_stream_pause': undefined reference to `usb_free_urb'
drivers/built-in.o: In function `cpia2_usb_disconnect':cpia2_usb.c:(.text+0x443e14): undefined reference to `usb_driver_release_interface'
drivers/built-in.o: In function `cpia2_usb_transfer_cmd': undefined reference to `usb_control_msg'
drivers/built-in.o: In function `cpia2_usb_transfer_cmd': undefined reference to `usb_control_msg'
drivers/built-in.o: In function `cpia2_usb_complete':cpia2_usb.c:(.text+0x444836): undefined reference to `usb_submit_urb'
drivers/built-in.o: In function `cpia2_usb_cleanup': undefined reference to `usb_deregister'
drivers/built-in.o: In function `cpia2_usb_init': undefined reference to `usb_register_driver'

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/cpia2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/media/video/cpia2/Kconfig b/drivers/media/video/cpia2/Kconfig
index 1c09ef9..513cc09 100644
--- a/drivers/media/video/cpia2/Kconfig
+++ b/drivers/media/video/cpia2/Kconfig
@@ -1,6 +1,6 @@
 config VIDEO_CPIA2
 	tristate "CPiA2 Video For Linux"
-	depends on VIDEO_DEV
+	depends on VIDEO_DEV && USB
 	---help---
 	  This is the video4linux driver for cameras based on Vision's CPiA2
 	  (Colour Processor Interface ASIC), such as the Digital Blue QX5

