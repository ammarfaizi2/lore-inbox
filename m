Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136609AbRA1C2k>; Sat, 27 Jan 2001 21:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136645AbRA1C2a>; Sat, 27 Jan 2001 21:28:30 -0500
Received: from Huntington-Beach.Blue-Labs.org ([208.179.0.198]:6716 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S136609AbRA1C21>; Sat, 27 Jan 2001 21:28:27 -0500
Message-ID: <3A7383B2.19DDD006@linux.com>
Date: Sun, 28 Jan 2001 02:28:03 +0000
From: David Ford <david@linux.com>
Organization: Blue Labs Software
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: devfs@oss.sgi.com, rgooch@atnf.csiro.au
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] devfsd, compiling on glibc22x
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is simple, defines RTLD_NEXT if not previously defined.

--- devfsd.c.orig       Sat Jan 27 18:14:19 2001
+++ devfsd.c    Sat Jan 27 18:15:46 2001
@@ -165,6 +165,7 @@
     Last updated by Richard Gooch   3-JUL-2000: Added "-C
/etc/modules.devfs"
   when calling modprobe(8). Fail if a configuration line has EXECUTE
modprobe.

+    Updated by      David Ford      27-JAN-2001: Added RTLD_NEXT define


 */
 #include <unistd.h>
@@ -221,6 +222,10 @@
 #define AC_MKNEWCOMPAT              8
 #define AC_RMOLDCOMPAT              9
 #define AC_RMNEWCOMPAT              10
+
+#ifndef RTLD_NEXT
+# define RTLD_NEXT     ((void *) -1l)
+#endif

 struct permissions_type
 {


--
  There is a natural aristocracy among men. The grounds of this are virtue and talents. Thomas Jefferson
  The good thing about standards is that there are so many to choose from. Andrew S. Tanenbaum



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
