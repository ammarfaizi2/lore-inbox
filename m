Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSL2X5u>; Sun, 29 Dec 2002 18:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbSL2X5u>; Sun, 29 Dec 2002 18:57:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:38647 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262360AbSL2X5r>;
	Sun, 29 Dec 2002 18:57:47 -0500
Message-ID: <3E0F8DEA.A84FB662@digeo.com>
Date: Sun, 29 Dec 2002 16:06:02 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Barnhart <sbarn03@softhome.net>
CC: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] Enable ALIGN #undef for drivers/net/defxx.c
References: <1041202757.19002.3.camel@sbarn.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 00:06:03.0292 (UTC) FILETIME=[3DE1B5C0:01C2AF97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Barnhart wrote:
> 
> The following patch #undef's the variable ALIGN in include/linux/cache.h
> so that drivers/net/defxx.c can use the same variable. Patch has been
> tested and defxx.c compiles. Please apply.
> 

But they're identical.  It would be better to formalise the kernel-wideness
of ALIGN() and just use it in defxx?

 drivers/net/defxx.h    |    7 -------
 include/linux/cache.h  |    3 +--
 include/linux/kernel.h |    1 +
 3 files changed, 2 insertions(+), 9 deletions(-)

--- 25/include/linux/cache.h~align	Sun Dec 29 16:02:54 2002
+++ 25-akpm/include/linux/cache.h	Sun Dec 29 16:03:13 2002
@@ -1,11 +1,10 @@
 #ifndef __LINUX_CACHE_H
 #define __LINUX_CACHE_H
 
+#include <linux/kernel.h>
 #include <linux/config.h>
 #include <asm/cache.h>
 
-#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
-
 #ifndef L1_CACHE_ALIGN
 #define L1_CACHE_ALIGN(x) ALIGN(x, L1_CACHE_BYTES)
 #endif
--- 25/drivers/net/defxx.h~align	Sun Dec 29 16:02:54 2002
+++ 25-akpm/drivers/net/defxx.h	Sun Dec 29 16:05:17 2002
@@ -1669,13 +1669,6 @@ typedef union
 #define XMT_BUFF_K_SA		7				/* six byte source address */
 #define XMT_BUFF_K_DATA		13				/* offset to start of packet data */
 
-/*
- * Macro evaluates to "value" aligned to "size" bytes.  Make sure that
- * "size" is greater than 0 bytes.
- */
-
-#define ALIGN(value,size) ((value + (size - 1)) & ~(size - 1))
-
 /* Macro for checking a "value" is within a specific range */
 
 #define IN_RANGE(value,low,high) ((value >= low) && (value <= high))
--- 25/include/linux/kernel.h~align	Sun Dec 29 16:02:54 2002
+++ 25-akpm/include/linux/kernel.h	Sun Dec 29 16:03:55 2002
@@ -28,6 +28,7 @@
 #define STACK_MAGIC	0xdeadbeef
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+#define ALIGN(x,a) (((x)+(a)-1)&~((a)-1))
 
 #define	KERN_EMERG	"<0>"	/* system is unusable			*/
 #define	KERN_ALERT	"<1>"	/* action must be taken immediately	*/

_
