Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWDAWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWDAWah (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 17:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbWDAWah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 17:30:37 -0500
Received: from ozlabs.org ([203.10.76.45]:8401 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751423AbWDAWah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 17:30:37 -0500
Date: Sun, 2 Apr 2006 08:29:21 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Add prctl to change endian of a task
Message-ID: <20060401222921.GI23416@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add a prctl to change a tasks endian. While we only have powerpc code to
implement this so far, it seems like something that warrants a generic
interface (like setting floating point mode bits).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/kernel/sys.c
===================================================================
--- build.orig/kernel/sys.c	2006-04-02 08:11:40.000000000 +1000
+++ build/kernel/sys.c	2006-04-02 08:13:13.000000000 +1000
@@ -57,6 +57,12 @@
 #ifndef GET_FPEXC_CTL
 # define GET_FPEXC_CTL(a,b)	(-EINVAL)
 #endif
+#ifndef GET_ENDIAN
+# define GET_ENDIAN(a,b)	(-EINVAL)
+#endif
+#ifndef SET_ENDIAN
+# define SET_ENDIAN(a,b)	(-EINVAL)
+#endif
 
 /*
  * this is where the system-wide overflow UID and GID are defined, for
@@ -2057,6 +2063,13 @@ asmlinkage long sys_prctl(int option, un
 				return -EFAULT;
 			return 0;
 		}
+		case PR_GET_ENDIAN:
+			error = GET_ENDIAN(current, arg2);
+			break;
+		case PR_SET_ENDIAN:
+			error = SET_ENDIAN(current, arg2);
+			break;
+
 		default:
 			error = -EINVAL;
 			break;
Index: build/include/linux/prctl.h
===================================================================
--- build.orig/include/linux/prctl.h	2006-04-02 08:11:40.000000000 +1000
+++ build/include/linux/prctl.h	2006-04-02 08:13:13.000000000 +1000
@@ -52,4 +52,10 @@
 #define PR_SET_NAME    15		/* Set process name */
 #define PR_GET_NAME    16		/* Get process name */
 
+/* Get/set process endian */
+#define PR_GET_ENDIAN	19
+#define PR_SET_ENDIAN	20
+# define PR_ENDIAN_BIG		0
+# define PR_ENDIAN_LITTLE	1
+
 #endif /* _LINUX_PRCTL_H */
