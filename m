Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269615AbUJLKxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269615AbUJLKxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 06:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269608AbUJLKwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 06:52:19 -0400
Received: from mail.renesas.com ([202.234.163.13]:43927 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S269614AbUJLKu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 06:50:59 -0400
Date: Tue, 12 Oct 2004 19:50:43 +0900 (JST)
Message-Id: <20041012.195043.137811384.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just fix compile error of drivers/net/smc91x.c for m32r.

It seems the previous patch (m32r-trivial-fix-of-smc91xh.patch) is too old. 
So I will send a new patch.

Please drop the previous patch
( $ patch -R1 -p1 <m32r-trivial-fix-of-smc91xh.patch )
and apply the new one.

	* drivers/net/smc91x.h:
	- Add set_irq_type() macro to ignore it for m32r.
	- Fix RPC_LSA_DEFAULT and RPC_LSB_DEFAULT for an M3T-M32700UT board.

Thanks.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 drivers/net/smc91x.h |    5 +++++
 1 files changed, 5 insertions(+)


diff -u15 -rNp a/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h	2004-10-12 18:26:28.000000000 +0900
+++ b/drivers/net/smc91x.h	2004-10-12 18:38:36.000000000 +0900
@@ -204,30 +204,35 @@ static inline void SMC_outsw (unsigned l
 #define RPC_LSB_DEFAULT		RPC_LED_100_10
 
 #elif   defined(CONFIG_M32R)
 
 #define SMC_CAN_USE_8BIT	0
 #define SMC_CAN_USE_16BIT	1
 #define SMC_CAN_USE_32BIT	0
 
 #define SMC_inb(a, r)		inb((a) + (r) - 0xa0000000)
 #define SMC_inw(a, r)		inw((a) + (r) - 0xa0000000)
 #define SMC_outb(v, a, r)	outb(v, (a) + (r) - 0xa0000000)
 #define SMC_outw(v, a, r)	outw(v, (a) + (r) - 0xa0000000)
 #define SMC_insw(a, r, p, l)	insw((a) + (r) - 0xa0000000, p, l)
 #define SMC_outsw(a, r, p, l)	outsw((a) + (r) - 0xa0000000, p, l)
 
+#define set_irq_type(irq, type)	do {} while(0)
+
+#define RPC_LSA_DEFAULT		RPC_LED_TX_RX
+#define RPC_LSB_DEFAULT		RPC_LED_100_10
+
 #else
 
 #define SMC_CAN_USE_8BIT	1
 #define SMC_CAN_USE_16BIT	1
 #define SMC_CAN_USE_32BIT	1
 #define SMC_NOWAIT		1
 
 #define SMC_inb(a, r)		readb((a) + (r))
 #define SMC_inw(a, r)		readw((a) + (r))
 #define SMC_inl(a, r)		readl((a) + (r))
 #define SMC_outb(v, a, r)	writeb(v, (a) + (r))
 #define SMC_outw(v, a, r)	writew(v, (a) + (r))
 #define SMC_outl(v, a, r)	writel(v, (a) + (r))
 #define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
 #define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
