Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWGBXGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWGBXGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbWGBXGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:06:44 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:11990 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750928AbWGBXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:06:43 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:06:30 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 09/19] ieee1394: remove unused macros HPSB_PANIC and
 HPSB_TRACE
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.0af9009a3597cd8c@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.341) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.c	2006-07-01 12:47:12.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.c	2006-07-01 18:07:33.000000000 +0200
@@ -14,6 +14,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 
+#include <asm/bug.h>
 #include <asm/errno.h>
 
 #include "ieee1394.h"
@@ -214,7 +215,7 @@ int hpsb_packet_success(struct hpsb_pack
 				 packet->node_id);
 			return -EAGAIN;
 		}
-		HPSB_PANIC("reached unreachable code 1 in %s", __FUNCTION__);
+		BUG();
 
 	case ACK_BUSY_X:
 	case ACK_BUSY_A:
@@ -261,8 +262,7 @@ int hpsb_packet_success(struct hpsb_pack
 			 packet->ack_code, packet->node_id, packet->tcode);
 		return -EAGAIN;
 	}
-
-	HPSB_PANIC("reached unreachable code 2 in %s", __FUNCTION__);
+	BUG();
 }
 
 struct hpsb_packet *hpsb_make_readpacket(struct hpsb_host *host, nodeid_t node,
Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h	2006-07-01 17:42:38.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_types.h	2006-07-01 17:55:20.000000000 +0200
@@ -65,11 +65,6 @@ typedef u16 arm_length_t;
 #define HPSB_VERBOSE(fmt, args...)
 #endif
 
-#define HPSB_PANIC(fmt, args...) panic("ieee1394: " fmt "\n" , ## args)
-
-#define HPSB_TRACE() HPSB_PRINT(KERN_INFO, "TRACE - %s, %s(), line %d", __FILE__, __FUNCTION__, __LINE__)
-
-
 #ifdef __BIG_ENDIAN
 
 static inline void *memcpy_le32(u32 *dest, const u32 *__src, size_t count)


