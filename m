Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272574AbTG1AmH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 20:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272573AbTG1AEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:04:25 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272729AbTG0W6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:21 -0400
Date: Sun, 27 Jul 2003 21:23:49 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272023.h6RKNn5s029792@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix strncpy on generic user platforms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/lib/string.c linux-2.6.0-test2-ac1/lib/string.c
--- linux-2.6.0-test2/lib/string.c	2003-07-10 21:13:38.000000000 +0100
+++ linux-2.6.0-test2-ac1/lib/string.c	2003-07-17 17:46:40.000000000 +0100
@@ -80,8 +80,7 @@
  * @src: Where to copy the string from
  * @count: The maximum number of bytes to copy
  *
- * Note that unlike userspace strncpy, this does not %NUL-pad the buffer.
- * However, the result is not %NUL-terminated if the source exceeds
+ * The result is not %NUL-terminated if the source exceeds
  * @count bytes.
  */
 char * strncpy(char * dest,const char *src,size_t count)
@@ -90,7 +89,8 @@
 
 	while (count-- && (*dest++ = *src++) != '\0')
 		/* nothing */;
-
+	while (count-- > 0)
+		*dest++ = 0;
 	return tmp;
 }
 #endif
