Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUH0V5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUH0V5y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267926AbUH0Vx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 17:53:58 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17918 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S267612AbUH0VxT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 17:53:19 -0400
From: trini@kernel.crashing.org
Message-Id: <200408272153.OAA28839@av.mvista.com>
Subject: [patch 1/3] 
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, jdubois@mc.com
Date: Fri, 27 Aug 2004 14:53:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


#   The following is from Jean-Christophe Dubois <jdubois@mc.com>.
#   On Solaris 2.8, <stdint.h> does not exist, but <inttypes.h> does.
#   However, on cygwin (the other odd place that the kernel is compiled
#   on) <inttypes.h> doesn't exist.  So we end up with something like
#   the following.
#   
#   Signed-off-by: Tom Rini <trini@kernel.crashing.org>
---

 linux-2.6-solaris-trini/arch/ppc/boot/utils/mkbugboot.c |   12 ++++++------
 linux-2.6-solaris-trini/arch/ppc/boot/utils/mktree.c    |    4 ++++
 linux-2.6-solaris-trini/scripts/mod/sumversion.c        |    4 ++++
 3 files changed, 14 insertions(+), 6 deletions(-)

diff -puN arch/ppc/boot/utils/mkbugboot.c~inttypes_stdint arch/ppc/boot/utils/mkbugboot.c
--- linux-2.6-solaris/arch/ppc/boot/utils/mkbugboot.c~inttypes_stdint	2004-08-27 14:29:03.092719804 -0700
+++ linux-2.6-solaris-trini/arch/ppc/boot/utils/mkbugboot.c	2004-08-27 14:29:36.311001737 -0700
@@ -1,5 +1,5 @@
 /*
- * arch/ppc/pp3boot/mkbugboot.c
+ * arch/ppc/boot/utils/mkbugboot.c
  *
  * Makes a Motorola PPCBUG ROM bootable image which can be flashed
  * into one of the FLASH banks on a Motorola PowerPlus board.
@@ -21,6 +21,11 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <fcntl.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else
+#include <stdint.h>
+#endif
 
 #ifdef __i386__
 #define cpu_to_be32(x) le32_to_cpu(x)
@@ -49,11 +54,6 @@ unsigned short le16_to_cpu(unsigned shor
 /* size of read buffer */
 #define SIZE 0x1000
 
-/* typedef long int32_t; */
-typedef unsigned long uint32_t;
-typedef unsigned short uint16_t;
-typedef unsigned char uint8_t;
-
 /* PPCBUG ROM boot header */
 typedef struct bug_boot_header {
   uint8_t	magic_word[4];		/* "BOOT" */
diff -puN arch/ppc/boot/utils/mktree.c~inttypes_stdint arch/ppc/boot/utils/mktree.c
--- linux-2.6-solaris/arch/ppc/boot/utils/mktree.c~inttypes_stdint	2004-08-27 14:29:03.111715390 -0700
+++ linux-2.6-solaris-trini/arch/ppc/boot/utils/mktree.c	2004-08-27 14:29:36.312001505 -0700
@@ -15,7 +15,11 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <netinet/in.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else
 #include <stdint.h>
+#endif
 
 /* This gets tacked on the front of the image.  There are also a few
  * bytes allocated after the _start label used by the boot rom (see
diff -puN scripts/mod/sumversion.c~inttypes_stdint scripts/mod/sumversion.c
--- linux-2.6-solaris/scripts/mod/sumversion.c~inttypes_stdint	2004-08-27 14:29:03.136709583 -0700
+++ linux-2.6-solaris-trini/scripts/mod/sumversion.c	2004-08-27 14:29:36.313001272 -0700
@@ -1,5 +1,9 @@
 #include <netinet/in.h>
+#ifdef __sun__
+#include <inttypes.h>
+#else
 #include <stdint.h>
+#endif
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>
_
