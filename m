Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUGLTrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUGLTrP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 15:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUGLTrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 15:47:15 -0400
Received: from mail.convergence.de ([212.84.236.4]:64154 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262079AbUGLTrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 15:47:10 -0400
Message-ID: <40F2EAB9.2010908@convergence.de>
Date: Mon, 12 Jul 2004 21:47:05 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: colin@colino.net, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix saa7146 compilation on 2.6.8-rc1
References: <20040712082545.GA416@jack.colino.net>
In-Reply-To: <20040712082545.GA416@jack.colino.net>
Content-Type: multipart/mixed;
 boundary="------------040104060504040908000207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104060504040908000207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Linus, Andrew,

On 07/12/04 10:25, colin@colino.net wrote:
> this patch fixes a compilation error on 2.6.8-rc1. Here's the error:
> drivers/media/common/saa7146_video.c:3: conflicting types for `memory'
> include/asm-m68k/setup.h:365: previous declaration of `memory'
> make[3]: *** [drivers/media/common/saa7146_video.o] Error 1

Colin's patch is fine, an updated version of the patch with an 
additional signed-off line is attached.

Please apply. Thanks!

CU
Michael.

--------------040104060504040908000207
Content-Type: text/plain;
 name="saa7146-memory-variable.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="saa7146-memory-variable.diff"

Signed-off-by: Colin Leroy <colin@colino.net>
Signed-off-by: Michael Hunold <hunold@linuxtv.org>

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

--------------040104060504040908000207--
