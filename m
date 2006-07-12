Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWGLGC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWGLGC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 02:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGLGC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 02:02:26 -0400
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:9429 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1751351AbWGLGCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 02:02:25 -0400
Date: Tue, 11 Jul 2006 23:02:48 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Update smc91x driver with ARM Versatile board info
Message-ID: <20060712060248.GA28976@plexity.net>
Reply-To: dsaxena@plexity.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We need to specify a Versatile-specific SMC_IRQ_FLAGS value or the new
generic IRQ layer will complain thusly:

No IRQF_TRIGGER set_type function for IRQ 25 (<NULL>)

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

diff --git a/drivers/net/smc91x.h b/drivers/net/smc91x.h
index b402804..4ec4b4d 100644
--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -354,6 +354,24 @@ #define SMC_outsw(a, r, p, l)	\
 
 #define SMC_IRQ_FLAGS		(0)
 
+#elif	defined(CONFIG_ARCH_VERSATILE)
+
+#define SMC_CAN_USE_8BIT	1
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	1
+#define SMC_NOWAIT		1
+
+#define SMC_inb(a, r)		readb((a) + (r))
+#define SMC_inw(a, r)		readw((a) + (r))
+#define SMC_inl(a, r)		readl((a) + (r))
+#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
+#define SMC_outw(v, a, r)	writew(v, (a) + (r))
+#define SMC_outl(v, a, r)	writel(v, (a) + (r))
+#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
+#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
+
+#define SMC_IRQ_FLAGS		(0)
+
 #else
 
 #define SMC_CAN_USE_8BIT	1


-- 
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

"An open heart has no possessions, only experiences" - Matt Bibbeau
