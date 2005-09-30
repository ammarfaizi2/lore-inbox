Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbVI3C3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVI3C3L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbVI3C3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:29:10 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:26013 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932419AbVI3C3J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:29:09 -0400
Date: Fri, 30 Sep 2005 03:29:05 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uml get_user() NULL noise removal
Message-ID: <20050930022905.GB7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/include/asm-um/uaccess.h current/include/asm-um/uaccess.h
--- RC14-rc2-git6-base/include/asm-um/uaccess.h	2005-09-26 00:02:29.000000000 -0400
+++ current/include/asm-um/uaccess.h	2005-09-24 01:43:27.000000000 -0400
@@ -44,7 +44,7 @@
         const __typeof__(ptr) __private_ptr = ptr; \
         __typeof__(*(__private_ptr)) __private_val; \
         int __private_ret = -EFAULT; \
-        (x) = 0; \
+        (x) = (__typeof__(*(__private_ptr)))0; \
 	if (__copy_from_user(&__private_val, (__private_ptr), \
 	    sizeof(*(__private_ptr))) == 0) {\
         	(x) = (__typeof__(*(__private_ptr))) __private_val; \
