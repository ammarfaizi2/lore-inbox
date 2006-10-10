Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWJJMVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWJJMVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965139AbWJJMVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:21:32 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:57057 "EHLO
	rubicon.netdirect.ca") by vger.kernel.org with ESMTP
	id S964793AbWJJMVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:21:31 -0400
X-Originating-Ip: 72.57.81.197
Date: Tue, 10 Oct 2006 08:19:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] ixgb: Delete IXGB_DBG() macro and call pr_debug() directly.
Message-ID: <Pine.LNX.4.64.0610100816440.7711@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Delete the minimally-useful IXGB_DBG() macro and call pr_debug()
directly from the main routine.

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
---
diff --git a/drivers/net/ixgb/ixgb.h b/drivers/net/ixgb/ixgb.h
index 50ffe90..fb9fde5 100644
--- a/drivers/net/ixgb/ixgb.h
+++ b/drivers/net/ixgb/ixgb.h
@@ -77,12 +77,6 @@ #include "ixgb_hw.h"
 #include "ixgb_ee.h"
 #include "ixgb_ids.h"

-#ifdef _DEBUG_DRIVER_
-#define IXGB_DBG(args...) printk(KERN_DEBUG "ixgb: " args)
-#else
-#define IXGB_DBG(args...)
-#endif
-
 #define PFX "ixgb: "
 #define DPRINTK(nlevel, klevel, fmt, args...) \
 	(void)((NETIF_MSG_##nlevel & adapter->msg_enable) && \
diff --git a/drivers/net/ixgb/ixgb_main.c b/drivers/net/ixgb/ixgb_main.c
index e09f575..eada685 100644
--- a/drivers/net/ixgb/ixgb_main.c
+++ b/drivers/net/ixgb/ixgb_main.c
@@ -1948,7 +1948,7 @@ #endif

 			/* All receives must fit into a single buffer */

-			IXGB_DBG("Receive packet consumed multiple buffers "
+			pr_debug("ixgb: Receive packet consumed multiple buffers "
 					 "length<%x>\n", length);

 			dev_kfree_skb_irq(skb);

--

  all right ... what did i mess up *this* time?  :-)  it's good
practice.  that's my story and i'm sticking to it.

rday
