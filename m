Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316467AbSEWM0e>; Thu, 23 May 2002 08:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316475AbSEWM0d>; Thu, 23 May 2002 08:26:33 -0400
Received: from imladris.infradead.org ([194.205.184.45]:39178 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316467AbSEWM00>; Thu, 23 May 2002 08:26:26 -0400
Date: Thu, 23 May 2002 13:26:23 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include buffer_head.h in actual users instead of fs.h (1/10)
Message-ID: <20020523132623.B24361@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that fs.h grow due to the lock.h removal let's reduce it's overhead
again:  Instead of penalizing ever user of fs.h with the overhead of the
buffer head interface let it's users include it directly.

This also shows nicely which parts of the core kernel still depend on the
buffer head interface, and allows that to be cleaned up properly.

This is the first of ten patches and adds the includes needed by
buffer_head.h to it and fixes it's inclusion guard.

--- 1.9/include/linux/buffer_head.h	Sun May 19 13:49:49 2002
+++ edited/include/linux/buffer_head.h	Thu May 23 14:18:31 2002
@@ -4,8 +4,13 @@
  * Everything to do with buffer_heads.
  */
 
-#ifndef BUFFER_FLAGS_H
-#define BUFFER_FLAGS_H
+#ifndef _LINUX_BUFFER_HEAD_H
+#define _LINUX_BUFFER_HEAD_H
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <asm/atomic.h>
+
 
 enum bh_state_bits {
 	BH_Uptodate,	/* Contains valid data */
@@ -297,4 +300,4 @@
 void __buffer_error(char *file, int line);
 #define buffer_error() __buffer_error(__FILE__, __LINE__)
 
-#endif		/* BUFFER_FLAGS_H */
+#endif /* _LINUX_BUFFER_HEAD_H */
