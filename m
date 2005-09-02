Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbVIBTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbVIBTNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 15:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVIBTNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 15:13:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16066 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750889AbVIBTNk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 15:13:40 -0400
Date: Fri, 2 Sep 2005 20:13:40 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig fix (PHYLIB vs. s390)
Message-ID: <20050902191340.GC5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/phy/phy.c is broken on s390; it uses enable_irq() and friends
and these do not exist on s390.  Marked as broken for now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-mxser-sparc32/drivers/net/phy/Kconfig RC13-s390-phy/drivers/net/phy/Kconfig
--- RC13-mxser-sparc32/drivers/net/phy/Kconfig	2005-09-02 03:33:39.000000000 -0400
+++ RC13-s390-phy/drivers/net/phy/Kconfig	2005-09-02 03:34:21.000000000 -0400
@@ -6,7 +6,7 @@
 
 config PHYLIB
 	tristate "PHY Device support and infrastructure"
-	depends on NET_ETHERNET
+	depends on NET_ETHERNET && (BROKEN || !ARCH_S390)
 	help
 	  Ethernet controllers are usually attached to PHY
 	  devices.  This option provides infrastructure for
