Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932713AbWBYNPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932713AbWBYNPb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932715AbWBYNPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:15:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42757 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932713AbWBYNPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:15:30 -0500
Date: Sat, 25 Feb 2006 14:15:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, scottbertin@yahoo.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [-mm patch] drivers/media/video/cpia2/cpia2_v4l.c cleanups
Message-ID: <20060225131529.GL3674@stusta.de>
References: <20060224031002.0f7ff92a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224031002.0f7ff92a.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 03:10:02AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.16-rc4-mm1:
>...
> +add-cpia2-camera-support.patch
> 
>  CPIA camera driver

This patch contains the following cleanups:
- make 2 needlessly global functions static
- remove cpia2_setup(): the driver already allows setting parameters 
  through module_param(), and there's no reason for having two different
  ways for setting the same parameters


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 Documentation/video4linux/README.cpia2 |    2 -
 drivers/media/video/cpia2/cpia2_v4l.c  |   29 +------------------------
 2 files changed, 3 insertions(+), 28 deletions(-)

--- linux-2.6.16-rc4-mm2-full/Documentation/video4linux/README.cpia2.old	2006-02-25 05:00:43.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/Documentation/video4linux/README.cpia2	2006-02-25 05:01:30.000000000 +0100
@@ -70,7 +70,7 @@
 
 	If the driver is compiled into the kernel, at boot time specify them
 like this:
-	cpia2=num_buffers:3,buffer_size:65535
+	cpia2.num_buffers=3 cpia2.buffer_size=65535
 
 	What buffer size should I use?
 	------------------------------
--- linux-2.6.16-rc4-mm2-full/drivers/media/video/cpia2/cpia2_v4l.c.old	2006-02-25 05:02:17.000000000 +0100
+++ linux-2.6.16-rc4-mm2-full/drivers/media/video/cpia2/cpia2_v4l.c	2006-02-25 05:38:03.000000000 +0100
@@ -2054,7 +2054,7 @@
  * cpia2_init/module_init
  *
  *****************************************************************************/
-int __init cpia2_init(void)
+static int __init cpia2_init(void)
 {
 	LOG("%s v%d.%d.%d\n",
 	    ABOUT, CPIA2_MAJ_VER, CPIA2_MIN_VER, CPIA2_PATCH_VER);
@@ -2069,37 +2069,12 @@
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
 

