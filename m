Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965551AbWCTPve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965551AbWCTPve (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 10:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965545AbWCTPvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 10:51:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:31970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966699AbWCTPUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:20:02 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 128/141] V4L/DVB (3399a): cpia2/cpia2_v4l.c cleanups
Date: Mon, 20 Mar 2006 12:08:58 -0300
Message-id: <20060320150858.PS389640000128@infradead.org>
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

From: Adrian Bunk <bunk@stusta.de>
Date: 1141112451 -0300

- make 2 needlessly global functions static

- remove cpia2_setup(): the driver already allows setting parameters
  through module_param(), and there's no reason for having two different
  ways for setting the same parameters

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

diff --git a/Documentation/video4linux/README.cpia2 b/Documentation/video4linux/README.cpia2
diff --git a/Documentation/video4linux/README.cpia2 b/Documentation/video4linux/README.cpia2
index f3bd343..ce8213d 100644
--- a/Documentation/video4linux/README.cpia2
+++ b/Documentation/video4linux/README.cpia2
@@ -70,7 +70,7 @@ line like this:
 
 	If the driver is compiled into the kernel, at boot time specify them
 like this:
-	cpia2=num_buffers:3,buffer_size:65535
+	cpia2.num_buffers=3 cpia2.buffer_size=65535
 
 	What buffer size should I use?
 	------------------------------
diff --git a/drivers/media/video/cpia2/cpia2_v4l.c b/drivers/media/video/cpia2/cpia2_v4l.c
diff --git a/drivers/media/video/cpia2/cpia2_v4l.c b/drivers/media/video/cpia2/cpia2_v4l.c
index 3480a2c..589283d 100644
--- a/drivers/media/video/cpia2/cpia2_v4l.c
+++ b/drivers/media/video/cpia2/cpia2_v4l.c
@@ -2053,7 +2053,7 @@ static void __init check_parameters(void
  * cpia2_init/module_init
  *
  *****************************************************************************/
-int __init cpia2_init(void)
+static int __init cpia2_init(void)
 {
 	LOG("%s v%d.%d.%d\n",
 	    ABOUT, CPIA2_MAJ_VER, CPIA2_MIN_VER, CPIA2_PATCH_VER);
@@ -2068,37 +2068,12 @@ int __init cpia2_init(void)
  * cpia2_exit/module_exit
  *
  *****************************************************************************/
-void __exit cpia2_exit(void)
+static void __exit cpia2_exit(void)
 {
 	cpia2_usb_cleanup();
 	schedule_timeout(2 * HZ);
 }
 
-
-int __init cpia2_setup(char *str)
-{
-	while(str) {
-		if(!strncmp(str, "buffer_size:", 12)) {
-			buffer_size = simple_strtoul(str + 13, &str, 10);
-		} else if(!strncmp(str, "num_buffers:", 12)) {
-			num_buffers = simple_strtoul(str + 13, &str, 10);
-		} else if(!strncmp(str, "alternate:", 10)) {
-			alternate = simple_strtoul(str + 11, &str, 10);
-		} else if(!strncmp(str, "video_nr:", 9)) {
-			video_nr = simple_strtoul(str + 10, &str, 10);
-		} else if(!strncmp(str, "flicker_freq:",13)) {
-		   flicker_freq = simple_strtoul(str + 14, &str, 10);
-		} else if(!strncmp(str, "flicker_mode:",13)) {
-		   flicker_mode = simple_strtoul(str + 14, &str, 10);
-		} else {
-			++str;
-		}
-	}
-	return 1;
-}
-
-__setup("cpia2=", cpia2_setup);
-
 module_init(cpia2_init);
 module_exit(cpia2_exit);
 

