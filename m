Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVAUTic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVAUTic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVAUTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:38:32 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:41168 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S262485AbVAUTiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:38:09 -0500
Date: Fri, 21 Jan 2005 11:37:56 -0800
From: Tony Lindgren <tony@atomide.com>
To: jgarzik@pobox.com
Cc: Nicolas Pitre <nico@cam.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add OMAP functions to smc91x.h
Message-ID: <20050121193756.GM14554@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jeff,

Attached patch adds support for various OMAP boards to the smc91x
Ethernet driver. Nicolas asked to send it to you. Can you please apply?

Regards,

Tony
--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.10-omap-net-drivers"

Add support for various OMAP boards to smc91x Ethernet driver

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nicolas Pitre <nico@cam.org>

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

--+g7M9IMkV8truYOl--
