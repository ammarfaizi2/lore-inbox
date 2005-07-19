Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVGSNzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVGSNzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGSNzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:55:49 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42760 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261917AbVGSNzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:55:36 -0400
Date: Tue, 19 Jul 2005 15:55:29 +0200
From: Adrian Bunk <bunk@stusta.de>
To: shemminger@osdl.org, coreteam@netfilter.org
Cc: netfilter-devel@lists.netfilter.org, bridge@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] BRIDGE_EBT_ARPREPLY must depend on INET
Message-ID: <20050719135529.GH5031@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BRIDGE_EBT_ARPREPLY=y and INET=n results in the following compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
net/built-in.o: In function `ebt_target_reply':
ebt_arpreply.c:(.text+0x68fb9): undefined reference to `arp_send'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc3-mm1-full/net/bridge/netfilter/Kconfig.old	2005-07-19 08:48:41.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/net/bridge/netfilter/Kconfig	2005-07-19 08:49:20.000000000 +0200
@@ -138,7 +138,7 @@
 #
 config BRIDGE_EBT_ARPREPLY
 	tristate "ebt: arp reply target support"
-	depends on BRIDGE_NF_EBTABLES
+	depends on BRIDGE_NF_EBTABLES && INET
 	help
 	  This option adds the arp reply target, which allows
 	  automatically sending arp replies to arp requests.

