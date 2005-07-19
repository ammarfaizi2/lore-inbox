Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVGSS32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVGSS32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 14:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVGSS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 14:29:22 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:9740 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261604AbVGSS3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 14:29:20 -0400
Date: Tue, 19 Jul 2005 20:29:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: jgarzik@pobox.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] NETCONSOLE must depend on INET
Message-ID: <20050719182919.GA5531@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NETCONSOLE=y and INET=n results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o: In function `netpoll_parse_options':
: undefined reference to `in_aton'
net/built-in.o: In function `netpoll_parse_options':
: undefined reference to `in_aton'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3/drivers/net/Kconfig.old	2005-07-19 19:29:25.000000000 +0200
+++ linux-2.6.13-rc3/drivers/net/Kconfig	2005-07-19 19:29:37.000000000 +0200
@@ -2544,7 +2544,7 @@
 
 config NETCONSOLE
 	tristate "Network console logging support (EXPERIMENTAL)"
-	depends on NETDEVICES && EXPERIMENTAL
+	depends on NETDEVICES && INET && EXPERIMENTAL
 	---help---
 	If you want to log kernel messages over the network, enable this.
 	See <file:Documentation/networking/netconsole.txt> for details.

