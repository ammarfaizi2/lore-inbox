Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310564AbSCGWi2>; Thu, 7 Mar 2002 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310565AbSCGWiT>; Thu, 7 Mar 2002 17:38:19 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:21712 "EHLO gin")
	by vger.kernel.org with ESMTP id <S310564AbSCGWiE>;
	Thu, 7 Mar 2002 17:38:04 -0500
Date: Thu, 7 Mar 2002 22:15:27 +0100
To: linux-kernel@vger.kernel.org
Cc: irda-users@lists.sourceforge.net, jt@bougret.hpl.hp.com,
        torvalds@transmeta.com
Subject: [PATCH] make irtty.c compile again
Message-ID: <20020307211527.GA7597@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

irtty.c includes irqueue.h which includes linux/cache.h (via
asm/processor.h <- asm/thread_info.h <- linux/thread_info.h <-
linux/spinlock.h)

both irqueue.h and cache.h defines a ALIGN (for different
purposes). 

This patch renames ALIGN in irqueue.h to IRDA_ALIGN.

Guess i'll go grepping for more places ALIGN might be defined.

-- 

//anders/g

--- linux-2.5.6-pre3/include/net/irda/irda.h	Thu Mar  7 19:13:01 2002
+++ linux-2.5.6-pre3-mekk/include/net/irda/irda.h	Thu Mar  7 21:24:18 2002
@@ -54,8 +54,8 @@
 #define IRDA_MIN(a, b) (((a) < (b)) ? (a) : (b))
 #endif
 
-#ifndef ALIGN
-#  define ALIGN __attribute__((aligned))
+#ifndef IRDA_ALIGN
+#  define IRDA_ALIGN __attribute__((aligned))
 #endif
 #ifndef PACK
 #  define PACK __attribute__((packed))
diff -ru linux-2.5.6-pre3/include/net/irda/irqueue.h linux-2.5.6-pre3-mekk/include/net/irda/irqueue.h
--- linux-2.5.6-pre3/include/net/irda/irqueue.h	Thu Mar  7 19:39:58 2002
+++ linux-2.5.6-pre3-mekk/include/net/irda/irqueue.h	Thu Mar  7 21:24:18 2002
@@ -49,8 +49,8 @@
 #define HASHBIN_SIZE   8
 #define HASHBIN_MASK   0x7
 
-#ifndef ALIGN 
-#define ALIGN __attribute__((aligned))
+#ifndef IRDA_ALIGN 
+#define IRDA_ALIGN __attribute__((aligned))
 #endif
 
 #define Q_NULL { NULL, NULL, "", 0 }
@@ -75,8 +75,8 @@
 	__u32      magic;
 	int        hb_type;
 	int        hb_size;
-	spinlock_t hb_mutex[HASHBIN_SIZE] ALIGN;
-	irda_queue_t   *hb_queue[HASHBIN_SIZE] ALIGN;
+	spinlock_t hb_mutex[HASHBIN_SIZE] IRDA_ALIGN;
+	irda_queue_t   *hb_queue[HASHBIN_SIZE] IRDA_ALIGN;
 
 	irda_queue_t* hb_current;
 } hashbin_t;
