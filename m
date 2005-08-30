Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVISSOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVISSOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbVISSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:14:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14977 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932546AbVISSOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:14:41 -0400
Date: Tue, 30 Aug 2005 17:44:20 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andy Fleming <afleming@freescale.com>
Subject: [PATCH] Kconfig fix (PHYLIB vs s390)
Message-ID: <20050830164420.GM9322@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	drivers/net/phy/phy.c is broken on s390; it uses enable_irq()
and friends and these do not exist on s390.  Marked as broken for now.

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-base/drivers/net/phy/Kconfig current/drivers/net/phy/Kconfig
--- RC13-base/drivers/net/phy/Kconfig	2005-08-30 03:24:42.000000000 -0400
+++ current/drivers/net/phy/Kconfig	2005-08-30 03:25:18.000000000 -0400
@@ -6,7 +6,7 @@
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (BROKEN || !ARCH_S390)
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
