Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWJNMLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWJNMLF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 08:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWJNMKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 08:10:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9421 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932189AbWJNMID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 08:08:03 -0400
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 11/18] V4L/DVB (4740): Fixed an if-block to avoid floating
	with debug-messages
Date: Sat, 14 Oct 2006 09:00:51 -0300
Message-id: <20061014120051.PS09977000011@infradead.org>
In-Reply-To: <20061014115356.PS36551000000@infradead.org>
References: <20061014115356.PS36551000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0-1mdv2007.0 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>

The dbgarg() macro in videodev.c contains some printk() statements
where only the first one is influenced by an if-statement. This causes
floating with debug-messages which is fixed by this patch by adding a
'{ ... }' pair.

Signed-off-by: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
---

 drivers/media/video/videodev.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
index 479a067..98de872 100644
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -17,10 +17,11 @@
  */
 
 #define dbgarg(cmd, fmt, arg...) \
-		if (vfd->debug & V4L2_DEBUG_IOCTL_ARG)			\
+		if (vfd->debug & V4L2_DEBUG_IOCTL_ARG) {		\
 			printk (KERN_DEBUG "%s: ",  vfd->name);		\
 			v4l_printk_ioctl(cmd);				\
-			printk (KERN_DEBUG "%s: " fmt, vfd->name, ## arg);
+			printk (KERN_DEBUG "%s: " fmt, vfd->name, ## arg); \
+		}
 
 #define dbgarg2(fmt, arg...) \
 		if (vfd->debug & V4L2_DEBUG_IOCTL_ARG)			\

