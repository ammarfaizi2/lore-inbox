Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265920AbUGNVxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265920AbUGNVxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 17:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUGNVxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 17:53:10 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46573 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265920AbUGNVxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 17:53:03 -0400
Date: Wed, 14 Jul 2004 23:52:56 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: [2.6 patch] net/hamachi.c: remove bogus inline at function prototype
Message-ID: <20040714215255.GS7308@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to compile drivers/net/hamachi.c in 2.6.8-rc1-mm1 using gcc 3.4 
results in the folloeing compile error:

<--  snip  -->

...
  CC      drivers/net/hamachi.o
drivers/net/hamachi.c: In function `hamachi_interrupt':
drivers/net/hamachi.c:562: sorry, unimplemented: inlining failed in call 
to 'hamachi_rx': function body not available
drivers/net/hamachi.c:1402: sorry, unimplemented: called from here
make[2]: *** [drivers/net/hamachi.o] Error 1

<--  snip  -->


The inline at the prototype is bogus since the function itself is not 
marked as inline.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm6-full-gcc3.4/drivers/net/hamachi.c.old	2004-07-09 00:28:31.000000000 +0200
+++ linux-2.6.7-mm6-full-gcc3.4/drivers/net/hamachi.c	2004-07-09 00:30:18.000000000 +0200
@@ -559,7 +559,7 @@
 static void hamachi_init_ring(struct net_device *dev);
 static int hamachi_start_xmit(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t hamachi_interrupt(int irq, void *dev_instance, struct pt_regs *regs);
-static inline int hamachi_rx(struct net_device *dev);
+static int hamachi_rx(struct net_device *dev);
 static inline int hamachi_tx(struct net_device *dev);
 static void hamachi_error(struct net_device *dev, int intr_status);
 static int hamachi_close(struct net_device *dev);

