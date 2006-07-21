Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbWGUB3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbWGUB3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 21:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030429AbWGUB3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 21:29:08 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:28622 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1030425AbWGUB3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 21:29:07 -0400
Message-ID: <1153445087.44c02cdf40511@portal.student.luth.se>
Date: Fri, 21 Jul 2006 03:24:47 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the second "version". My special thanks to Jeff Garzik and Alexey Dobriyan.

The changes are:
* u2 has been corrected to u1 (and also added it as __u1)
* removed the check if the gcc-compiler is at least of version 3, since it is
required of the kernel
* changed "false" and "true" from enum to #define, since an enum is the size of
an int. No #undef since an other definition of "false" and/or "true" should be
tracked down and not hidden)
    (this is the same as in gcc's stdbool.h-file. Is it not C99 compliant then?)
* bool is of "unsigned int" (under i386, may differ on other arches), instead of
"unsigned char"


Happy hacking
/Richard Knutsson

PS
I added everyone I found in the thread so if you to be removed, please tell.
DS


Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/asm-i386/types.h          |   11 +++++++++++
 include/linux/stddef.h            |    3 +++
 6 files changed, 16 insertions(+), 10 deletions(-)


diff --git a/drivers/block/DAC960.h b/drivers/block/DAC960.h
index a82f37f..f9217c3 100644
--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -71,7 +71,7 @@ #define DAC690_V2_PciDmaMask	0xfffffffff
   Define a Boolean data type.
 */
 
-typedef enum { false, true } __attribute__ ((packed)) boolean;
+typedef bool boolean;
 
 
 /*
diff --git a/drivers/media/video/cpia2/cpia2.h b/drivers/media/video/cpia2/cpia2.h
index c5ecb2b..8d2dfc1 100644
--- a/drivers/media/video/cpia2/cpia2.h
+++ b/drivers/media/video/cpia2/cpia2.h
@@ -50,10 +50,6 @@ #define CPIA2_PATCH_VER	0
 /***
  * Image defines
  ***/
-#ifndef true
-#define true 1
-#define false 0
-#endif
 
 /*  Misc constants */
 #define ALLOW_CORRUPT 0		/* Causes collater to discard checksum */
diff --git a/drivers/net/dgrs.c b/drivers/net/dgrs.c
index fa4f094..4dbc23d 100644
--- a/drivers/net/dgrs.c
+++ b/drivers/net/dgrs.c
@@ -110,7 +110,6 @@ static char version[] __initdata =
  *	DGRS include files
  */
 typedef unsigned char uchar;
-typedef unsigned int bool;
 #define vol volatile
 
 #include "dgrs.h"
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index 9792e5a..d6d1d56 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -237,10 +237,7 @@ enum BusLogic_BIOS_DiskGeometryTranslati
   Define a Boolean data type.
 */
 
-typedef enum {
-	false,
-	true
-} PACKED boolean;
+typedef bool boolean;
 
 /*
   Define a 10^18 Statistics Byte Counter data type.
diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
index 4b4b295..841792b 100644
--- a/include/asm-i386/types.h
+++ b/include/asm-i386/types.h
@@ -1,6 +1,13 @@
 #ifndef _I386_TYPES_H
 #define _I386_TYPES_H
 
+#if defined(__GNUC__)
+typedef _Bool bool;
+#else
+#warning You compiler doesn't seem to support boolean types, will set 'bool' as
an 'unsigned int'
+typedef unsigned int bool;
+#endif
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned short umode_t;
@@ -10,6 +17,8 @@ typedef unsigned short umode_t;
  * header files exported to user space
  */
 
+typedef bool __u1;
+
 typedef __signed__ char __s8;
 typedef unsigned char __u8;
 
@@ -36,6 +45,8 @@ #define BITS_PER_LONG 32
 #ifndef __ASSEMBLY__
 
 
+typedef bool u1;
+
 typedef signed char s8;
 typedef unsigned char u8;
 
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..498813b 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,9 @@ #else
 #define NULL ((void *)0)
 #endif
 
+#define false	((0))
+#define true	((1))
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)

