Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVHWVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVHWVqE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbVHWVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:45:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23734 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932448AbVHWVpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:45:14 -0400
To: torvalds@osdl.org
Subject: [PATCH] (42/43) %t... in vsnprintf
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gcz-0007Ft-Kb@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:48:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

handling of %t... (ptrdiff_t) in vsnprintf

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-m68k-adb.patch/lib/vsprintf.c RC13-rc6-git13-printf-t/lib/vsprintf.c
--- RC13-rc6-git13-m68k-adb.patch/lib/vsprintf.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-printf-t/lib/vsprintf.c	2005-08-21 13:17:44.000000000 -0400
@@ -269,6 +269,7 @@
 	int qualifier;		/* 'h', 'l', or 'L' for integer fields */
 				/* 'z' support added 23/7/1999 S.H.    */
 				/* 'z' changed to 'Z' --davidm 1/25/99 */
+				/* 't' added for ptrdiff_t */
 
 	/* Reject out-of-range values early */
 	if (unlikely((int) size < 0)) {
@@ -339,7 +340,7 @@
 		/* get the conversion qualifier */
 		qualifier = -1;
 		if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
-		    *fmt =='Z' || *fmt == 'z') {
+		    *fmt =='Z' || *fmt == 'z' || *fmt == 't') {
 			qualifier = *fmt;
 			++fmt;
 			if (qualifier == 'l' && *fmt == 'l') {
@@ -467,6 +468,8 @@
 				num = (signed long) num;
 		} else if (qualifier == 'Z' || qualifier == 'z') {
 			num = va_arg(args, size_t);
+		} else if (qualifier == 't') {
+			num = va_arg(args, ptrdiff_t);
 		} else if (qualifier == 'h') {
 			num = (unsigned short) va_arg(args, int);
 			if (flags & SIGN)
