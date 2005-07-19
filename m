Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVGSN55@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVGSN55 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVGSN4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:56:02 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40968 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261382AbVGSNz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:55:29 -0400
Date: Tue, 19 Jul 2005 15:55:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] VIA_VELOCITY must depend on INET
Message-ID: <20050719135523.GF5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VIA_VELOCITY=y and INET=n results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `velocity_register_notifier':
via-velocity.c:(.text+0x3462c6): undefined reference to `register_inetaddr_notifier'
drivers/built-in.o: In function `velocity_unregister_notifier':
via-velocity.c:(.text+0x3462d6): undefined reference to `unregister_inetaddr_notifier'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/drivers/net/Kconfig.old	2005-07-19 02:11:45.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/net/Kconfig	2005-07-19 02:12:09.000000000 +0200
@@ -2016,7 +2016,7 @@
 
 config VIA_VELOCITY
 	tristate "VIA Velocity support"
-	depends on NET_PCI && PCI
+	depends on INET && NET_PCI && PCI
 	select CRC32
 	select CRC_CCITT
 	select MII

