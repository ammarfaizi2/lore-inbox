Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267649AbUHMWz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267649AbUHMWz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUHMWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:55:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43241 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267649AbUHMWzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:55:16 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix sn_console for CONFIG_SMP=n
Date: Fri, 13 Aug 2004 15:54:57 -0700
User-Agent: KMail/1.6.2
Cc: Pat Gefre <pfg@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_BbUHBmQRq1G424X"
Message-Id: <200408131554.57139.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_BbUHBmQRq1G424X
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I found that sn_console was missing an include and a fix if CONFIG_SMP=n.  
This patch fixes up the two small problems I found.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse

--Boundary-00=_BbUHBmQRq1G424X
Content-Type: text/plain;
  charset="us-ascii";
  name="sn-console-no-smp-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sn-console-no-smp-fix.patch"

diff -Nru a/drivers/serial/sn_console.c b/drivers/serial/sn_console.c
--- a/drivers/serial/sn_console.c	2004-08-13 15:50:37 -07:00
+++ b/drivers/serial/sn_console.c	2004-08-13 15:50:37 -07:00
@@ -50,6 +50,7 @@
 #include <linux/miscdevice.h>
 #include <linux/serial_core.h>
 
+#include <asm/io.h>
 #include <asm/sn/simulator.h>
 #include <asm/sn/sn2/sn_private.h>
 #include <asm/sn/sn_sal.h>
@@ -1085,7 +1086,9 @@
 			spin_unlock_irqrestore(&port->sc_port.lock, flags);
 
 			puts_raw_fixed(port->sc_ops->sal_puts_raw, s, count);
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 		}
+#endif
 	}
 	else {
 		/* Not yet registered with serial core - simple case */

--Boundary-00=_BbUHBmQRq1G424X--
