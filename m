Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbUL3AuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbUL3AuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 19:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUL3Aqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 19:46:49 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:55206 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261494AbUL3AqF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 19:46:05 -0500
Date: Wed, 29 Dec 2004 16:45:49 -0800
From: Tony Lindgren <tony@atomide.com>
To: linux-kernel@vger.kernel.org
Cc: nico@cam.org
Subject: [PATCH] Add OMAP support to smc91x Ethernet driver
Message-ID: <20041230004549.GD14964@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nicolas,

Following patch adds support for various OMAP boards to smc91x.

Signed-off-by: Tony Lindgren <tony@atomide.com>

Can you please apply?

Regards,

Tony


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.10-omap-net-drivers"

diff -Nru --exclude-from=/home/tmlind/src/dontdiff-tony linus/drivers/net/smc91x.h b/drivers/net/smc91x.h
--- a/drivers/net/smc91x.h	2004-12-10 11:53:52.000000000 -0800
+++ b/drivers/net/smc91x.h	2004-12-27 12:08:43.000000000 -0800
@@ -162,6 +162,26 @@
 	}
 }
 
+#elif	defined(CONFIG_ARCH_OMAP)
+
+/* We can only do 16-bit reads and writes in the static memory space. */
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+#define SMC_IO_SHIFT		0
+#define SMC_NOWAIT		1
+
+#define SMC_inb(a, r)		readb((a) + (r))
+#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
+#define SMC_inw(a, r)		readw((a) + (r))
+#define SMC_outw(v, a, r)	writew(v, (a) + (r))
+#define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
+#define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
+#define SMC_inl(a, r)		readl((a) + (r))
+#define SMC_outl(v, a, r)	writel(v, (a) + (r))
+#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
+#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
+
 #elif	defined(CONFIG_ISA)
 
 #define SMC_CAN_USE_8BIT	1

--mxv5cy4qt+RJ9ypb--
