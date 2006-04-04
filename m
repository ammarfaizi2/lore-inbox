Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWDDQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWDDQaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWDDQah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 12:30:37 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4366 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750738AbWDDQaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 12:30:03 -0400
Date: Tue, 4 Apr 2006 18:30:01 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Martin Samuelsson <sam@home.se>
Cc: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       Johannes Stezenbach <js@linuxtv.org>, v4l-dvb-maintainer@linuxtv.org
Subject: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-ID: <20060404163001.GO6529@stusta.de>
References: <20060404014504.564bf45a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060404014504.564bf45a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2006 at 01:45:04AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.16-mm2:
>...
> +avermedia-6-eyes-avs6eyes-support.patch
>...
>  New v4l driver, and a fix.
>...

This patch contains the following fixes:
- no need to hide MODULE_LICENSE() behind an #ifdef
- use module_{init,exit}; this also fixes the bug that bt866_init()
  was never called

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/media/video/bt866.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- linux-2.6.17-rc1-mm1-full/drivers/media/video/bt866.c.old	2006-04-04 17:31:55.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/media/video/bt866.c	2006-04-04 17:33:38.000000000 +0200
@@ -51,9 +51,7 @@
 
 #include <linux/video_encoder.h>
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("GPL");
-#endif
 
 #define DEBUG(x)   		/* Debug driver */
 
@@ -372,22 +370,19 @@
 /****************************************************************************
 * linux kernel module api
 ****************************************************************************/
-#ifdef MODULE
-int init_module(void)
-#else
-int bt866_init(void)
-#endif
+static int __devinit bt866_init(void)
 {
 	i2c_add_driver(&i2c_driver_bt866);
 	return 0;
 }
 
-#ifdef MODULE
-void cleanup_module(void)
+static void __devexit bt866_exit(void)
 {
 	i2c_del_driver(&i2c_driver_bt866);
 }
-#endif
+
+module_init(bt866_init);
+module_exit(bt866_exit);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.

