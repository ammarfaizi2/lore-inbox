Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbVHWVnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbVHWVnT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVHWVnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:43:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60853 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932413AbVHWVmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:42:53 -0400
To: torvalds@osdl.org
Subject: [PATCH] (14/43) Kconfig fix (airo_cs on m32r)
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Message-Id: <E1E7gai-0007AN-Fb@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:45:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

airo_cs is broken on m32r; marked as such. [Proper fix would involve
separating PCI-dependent parts and making sure they don't get in the
way _and_ arranging for asm/scatterlist.h getting picked on m32r]

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-tms380tr/drivers/net/wireless/Kconfig RC13-rc6-git13-m32r-airo/drivers/net/wireless/Kconfig
--- RC13-rc6-git13-tms380tr/drivers/net/wireless/Kconfig	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-m32r-airo/drivers/net/wireless/Kconfig	2005-08-21 13:16:57.000000000 -0400
@@ -270,7 +270,7 @@
 
 config AIRO_CS
 	tristate "Cisco/Aironet 34X/35X/4500/4800 PCMCIA cards"
-	depends on NET_RADIO && PCMCIA
+	depends on NET_RADIO && PCMCIA && (BROKEN || !M32R)
 	---help---
 	  This is the standard Linux driver to support Cisco/Aironet PCMCIA
 	  802.11 wireless cards.  This driver is the same as the Aironet
