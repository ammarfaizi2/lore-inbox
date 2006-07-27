Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWG0TrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWG0TrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWG0TrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:47:09 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:43153 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751966AbWG0TrI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:47:08 -0400
Message-ID: <1154029560.44c917f8743da@portal.student.luth.se>
Date: Thu, 27 Jul 2006 21:46:00 +0200
From: ricknu-0@student.ltu.se
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Michael Buesch <mb@bu3sch.de>, Paul Jackson <pj@sgi.com>,
       Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       Nicholas Miell <nmiell@comcast.net>
Subject: Re: [RFC][PATCH] A generic boolean (version 7)
References: <1153341500.44be983ca1407@portal.student.luth.se>
In-Reply-To: <1153341500.44be983ca1407@portal.student.luth.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and it continues, here comes (lucky number) sleven.

Changes:
* put the bool-definition under __KERNEL__ (thanks Arnd).

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>

---

Like I said before, if this seems ok with you, I will send the "real" patch
tomorrow.

 drivers/block/DAC960.h            |    2 +-
 drivers/media/video/cpia2/cpia2.h |    4 ----
 drivers/net/dgrs.c                |    1 -
 drivers/scsi/BusLogic.h           |    5 +----
 include/linux/stddef.h            |    5 +++++
 include/linux/types.h             |    2 ++
 6 files changed, 9 insertions(+), 10 deletions(-)


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
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index b3a2cad..0382065 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -10,6 +10,11 @@ #else
 #define NULL ((void *)0)
 #endif
 
+enum {
+	false	= 0,
+	true	= 1
+};
+
 #undef offsetof
 #ifdef __compiler_offsetof
 #define offsetof(TYPE,MEMBER) __compiler_offsetof(TYPE,MEMBER)
diff --git a/include/linux/types.h b/include/linux/types.h
index 3f23566..406d4ae 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -33,6 +33,8 @@ typedef __kernel_clockid_t	clockid_t;
 typedef __kernel_mqd_t		mqd_t;
 
 #ifdef __KERNEL__
+typedef _Bool			bool;
+
 typedef __kernel_uid32_t	uid_t;
 typedef __kernel_gid32_t	gid_t;
 typedef __kernel_uid16_t        uid16_t;

