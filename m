Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWGaOdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWGaOdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 10:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWGaOdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 10:33:36 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:57944 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932404AbWGaOdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 10:33:14 -0400
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.18-rc3] build fixes: smc91x
Date: Mon, 31 Jul 2006 07:32:18 -0700
User-Agent: KMail/1.7.1
Cc: Nicolas Pitre <nico@cam.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yRhzE5fy52rHGle"
Message-Id: <200607310732.18822.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_yRhzE5fy52rHGle
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Another driver that wouldn't build in mainline kernels for OMAP.


--Boundary-00=_yRhzE5fy52rHGle
Content-Type: text/x-diff;
  charset="us-ascii";
  name="smc91x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="smc91x.patch"

Unclear how these bugs arrived, presumably from incorrect cleanup of
the 16-bit-only paths, but smc91x wouldn't build for OMAP.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- a/drivers/net/smc91x.h
+++ b/drivers/net/smc91x.h
@@ -189,16 +189,10 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_IO_SHIFT		0
 #define SMC_NOWAIT		1
 
-#define SMC_inb(a, r)		readb((a) + (r))
-#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
 #define SMC_inw(a, r)		readw((a) + (r))
 #define SMC_outw(v, a, r)	writew(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
 #define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
-#define SMC_inl(a, r)		readl((a) + (r))
-#define SMC_outl(v, a, r)	writel(v, (a) + (r))
-#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
-#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
 
 #include <asm/mach-types.h>
 #include <asm/arch/cpu.h>

--Boundary-00=_yRhzE5fy52rHGle--
