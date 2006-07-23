Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWGWPu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWGWPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWGWPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 11:50:26 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:32477 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751239AbWGWPuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 11:50:25 -0400
Message-ID: <1153669750.44c39a7607a30@portal.student.luth.se>
Date: Sun, 23 Jul 2006 17:49:10 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And here comes lucky number four.

Since there seems to be no case where _Bool is not defined (we uses only gcc >=
3), it got simplefied to just a:
typedef _Bool bool;

Hopefully it is now ready for a "real" patch, whom adds bool to all arches. If
there is no comments on this one, it will be sent about tomorrow night (GMT).

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/asm-i386/types.h          |    2 ++
 include/linux/stddef.h            |   11 +++++++++++
 6 files changed, 15 insertions(+), 10 deletions(-)


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
index 4b4b295..3cb84ac 100644
--- a/include/asm-i386/types.h
+++ b/include/asm-i386/types.h
@@ -1,6 +1,8 @@
 #ifndef _I386_TYPES_H
 #define _I386_TYPES_H
 
+typedef _Bool bool;
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned short umode_t;
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..f137815 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,17 @@ #else
 #define NULL ((void *)0)
 #endif
 
+#undef false
+#undef true
+
+enum {
+	false	= 0,
+	true	= 1
+};
+
+#define false false
+#define true true 
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)



