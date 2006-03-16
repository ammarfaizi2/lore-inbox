Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWCPN1a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWCPN1a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 08:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWCPN13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 08:27:29 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750838AbWCPN13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 08:27:29 -0500
Date: Thu, 16 Mar 2006 14:27:27 +0100
From: Adrian Bunk <bunk@stusta.de>
To: mchehab@infradead.org
Cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIDEO_CPIA2 must depend on USB
Message-ID: <20060316132727.GF3914@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_VIDEO_CPIA2=y, CONFIG_USB=n results in the following compile 
error:


<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `set_alternate':cpia2_usb.c:(.text+0x443aa2): undefined reference to `usb_set_interface'
:cpia2_usb.c:(.text+0x443abe): undefined reference to `usb_set_interface'
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
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc6-mm1-full/drivers/media/video/Kconfig.old	2006-03-16 14:19:19.000000000 +0100
+++ linux-2.6.16-rc6-mm1-full/drivers/media/video/Kconfig	2006-03-16 14:19:36.000000000 +0100
@@ -144,7 +144,7 @@
 
 config VIDEO_CPIA2
 	tristate "CPiA2 Video For Linux"
-	depends on VIDEO_DEV
+	depends on VIDEO_DEV && USB
 	---help---
 	  This is the video4linux driver for cameras based on Vision's CPiA2
 	  (Colour Processor Interface ASIC), such as the Digital Blue QX5

