Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266334AbUGLI0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266334AbUGLI0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 04:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266756AbUGLI0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 04:26:19 -0400
Received: from colino.net ([82.228.82.76]:36344 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S266334AbUGLI0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 04:26:08 -0400
Date: Mon, 12 Jul 2004 10:25:45 +0200
From: <colin@colino.net>
To: michael@mihu.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix saa7146 compilation on 2.6.8-rc1
Message-ID: <20040712082545.GA416@jack.colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this patch fixes a compilation error on 2.6.8-rc1. Here's the error:
drivers/media/common/saa7146_video.c:3: conflicting types for `memory'
include/asm-m68k/setup.h:365: previous declaration of `memory'
make[3]: *** [drivers/media/common/saa7146_video.o] Error 1

hth.

Signed-off-by: Colin Leroy <colin@colino.net>

--- a/drivers/media/common/saa7146_video.c	2004-07-12 10:15:51.833352344 +0200
+++ b/drivers/media/common/saa7146_video.c	2004-07-12 10:16:21.209886432 +0200
@@ -1,9 +1,9 @@
 #include <media/saa7146_vv.h>
 
-static int memory = 32;
+static int max_memory = 32;
 
-MODULE_PARM(memory,"i");
-MODULE_PARM_DESC(memory, "maximum memory usage for capture buffers (default: 32Mb)");
+MODULE_PARM(max_memory,"i");
+MODULE_PARM_DESC(max_memory, "maximum memory usage for capture buffers (default: 32Mb)");
 
 #define IS_CAPTURE_ACTIVE(fh) \
 	(((vv->video_status & STATUS_CAPTURE) != 0) && (vv->video_fh == fh))
@@ -1331,9 +1331,9 @@
 
 	*size = fh->video_fmt.sizeimage;
 
-	/* check if we exceed the "memory" parameter */
-	if( (*count * *size) > (memory*1048576) ) {
-		*count = (memory*1048576) / *size;
+	/* check if we exceed the "max_memory" parameter */
+	if( (*count * *size) > (max_memory*1048576) ) {
+		*count = (max_memory*1048576) / *size;
 	}
 	
 	DEB_CAP(("%d buffers, %d bytes each.\n",*count,*size));

