Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945949AbWGOAgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945949AbWGOAgd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 20:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945946AbWGOAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 20:36:22 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34313 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1945944AbWGOAgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 20:36:18 -0400
Date: Sat, 15 Jul 2006 02:36:17 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [2.6 patch] net/core/user_dma.c should #include <net/netdma.h>
Message-ID: <20060715003617.GL3633@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should #include the headers containing the prototypes for 
its global functions.

Especially in cases like this one where gcc can tell us through a 
compile error that the prototype was wrong...

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/net/netdma.h |    2 +-
 net/core/user_dma.c  |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc1-mm2-full/include/net/netdma.h.old	2006-07-15 00:52:38.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/include/net/netdma.h	2006-07-15 00:52:43.000000000 +0200
@@ -37,7 +37,7 @@
 }
 
 int dma_skb_copy_datagram_iovec(struct dma_chan* chan,
-		const struct sk_buff *skb, int offset, struct iovec *to,
+		struct sk_buff *skb, int offset, struct iovec *to,
 		size_t len, struct dma_pinned_list *pinned_list);
 
 #endif /* CONFIG_NET_DMA */
--- linux-2.6.18-rc1-mm2-full/net/core/user_dma.c.old	2006-07-14 21:59:37.000000000 +0200
+++ linux-2.6.18-rc1-mm2-full/net/core/user_dma.c	2006-07-14 21:59:50.000000000 +0200
@@ -29,6 +29,7 @@
 #include <linux/socket.h>
 #include <linux/rtnetlink.h> /* for BUG_TRAP */
 #include <net/tcp.h>
+#include <net/netdma.h>
 
 #define NET_DMA_DEFAULT_COPYBREAK 4096
 

