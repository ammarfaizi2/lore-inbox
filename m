Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130899AbQKLOb3>; Sun, 12 Nov 2000 09:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbQKLObU>; Sun, 12 Nov 2000 09:31:20 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28176 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130745AbQKLObD>;
	Sun, 12 Nov 2000 09:31:03 -0500
Date: Sun, 12 Nov 2000 09:30:59 -0500
Message-Id: <200011121430.JAA22978@havoc.gtf.org>
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Linus Torvalds <torvalds@transmeta.com>
CC: viro@math.psu.edu, Rasmus Andersen <rasmus@jaquet.dk>,
        linux-kernel@vger.kernel.org
Subject: PATCH 2.4.0.11.3: sysctl.h fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> I tried to include <linux/types.h> in md.c and had to include 
> <linux/blkdev.h> also. Otherwise I got the following:

Here is the solution I prefer...  md builds fine with this, core kernel builds fine with this, and
I'm about 3/4 of the way through a "build everything" build with this.

I tried to avoid including fs.h, but I do prefer updating sysctl.h, because it fixes potential
breakage similar to md's as well.

	Jeff




Index: include/linux/sysctl.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/sysctl.h,v
retrieving revision 1.1.1.8
diff -u -r1.1.1.8 sysctl.h
--- include/linux/sysctl.h	2000/10/31 21:19:40	1.1.1.8
+++ include/linux/sysctl.h	2000/11/12 14:28:04
@@ -24,7 +24,11 @@
 #ifndef _LINUX_SYSCTL_H
 #define _LINUX_SYSCTL_H
 
+#include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/list.h>
+
+struct file;
 
 #define CTL_MAXNAME 10
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
