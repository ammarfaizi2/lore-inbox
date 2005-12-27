Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVL0UDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVL0UDW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 15:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbVL0UDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 15:03:22 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:524 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751051AbVL0UDW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 15:03:22 -0500
Date: Tue, 27 Dec 2005 21:06:28 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Deepak Saxena <dsaxena@plexity.net>,
       Russell King <rmk+kernel@arm.linux.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix EISA/VLB/PCI network controllers alignment in
 menuconfig
Message-Id: <20051227210628.0575f672.khali@linux-fr.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Deepak, Russell, Jeff,

The CS89x0 Kconfig entry currently breaks the alignment of all
"EISA, VLB, PCI and on board controllers" that follow it in menuconfig.
This patch fixes it.

This bug was introduced in version 2.6.13-rc1. A first, different fix
attempt was made by Deepak Saxena:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=712cb1ebb1653538527500165d8382ca48a7fca1

But it seems it was then overwritten by a subsequent (unsigned?) changeset
from Russell King:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e399822da0f99f8486c33c47e7ae0d32151461e5

Whatever, Deepak's fix wasn't actually fixing the problem for me.
I'm not sure my fix is correct (what exactly are the dependencies
we want for this driver?) but at least it fixes the alignment problem.
It would be nice if we could have this fix in 2.6.15, although it
admittedly isn't critical.

This patch also fixes the module name in the help text, which was
incorrect.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Deepak Saxena <dsaxena@plexity.net>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>
---
 drivers/net/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.15-rc7.orig/drivers/net/Kconfig	2005-12-26 19:59:50.000000000 +0100
+++ linux-2.6.15-rc7/drivers/net/Kconfig	2005-12-27 20:57:05.000000000 +0100
@@ -1374,7 +1374,7 @@
 
 config CS89x0
 	tristate "CS89x0 support"
-	depends on (NET_PCI && (ISA || ARCH_IXDP2X01)) || ARCH_PNX0105
+	depends on NET_PCI && (ISA || ARCH_IXDP2X01 || ARCH_PNX0105)
 	---help---
 	  Support for CS89x0 chipset based Ethernet cards. If you have a
 	  network (Ethernet) card of this type, say Y and read the
@@ -1384,7 +1384,7 @@
 
 	  To compile this driver as a module, choose M here and read
 	  <file:Documentation/networking/net-modules.txt>.  The module will be
-	  called cs89x.
+	  called cs89x0.
 
 config TC35815
 	tristate "TOSHIBA TC35815 Ethernet support"


-- 
Jean Delvare
