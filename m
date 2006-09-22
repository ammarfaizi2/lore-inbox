Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWIVAcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWIVAcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWIVAcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:32:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:53155 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932143AbWIVAcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:32:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=Y1d9Q9hlv2LftWVJ+237Ja/Jvnr5J3iJCYB962nwfF9vZ5TjSiolEgtlzDfD9DO7vPPA1kcxqA1Uh/lChOBYMULW3mM3ftjnHXcx7LFjqTt4SgH36QQkPkxQdJXU7w4ZX/L+SRKU+jKMi2fs2fh044RPMNk9ge3mx7LEvbwpC3I=
Message-ID: <45132F12.908@gmail.com>
Date: Thu, 21 Sep 2006 20:32:18 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: coreteam@netfilter.org
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, akpm@osdl.org
Subject: [PATCH] Kconfig:  XT_MATCH_PHYSDEV dependency missing
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_BRIDGE=m && CONFIG_NETFILTER_XT_MATCH_PHYSDEV=y breaks at link time:

LD .tmp_vmlinux1
net/built-in.o: In function `checkentry':xt_physdev.c:(.text+0x223f8):
undefined reference to `brnf_deferred_hooks'
:xt_physdev.c:(.text+0x22420): undefined reference to `brnf_deferred_hooks'
make: *** [.tmp_vmlinux1] Error 1

net/netfilter/xt_physdev.c references 'brn_deferred_hooks' which is
declared in net/bridge/br_netfilter.c but CONFIG_BRIDGE=m prevents
linking br_netfilter.o in. So CONFIG_NETFILTER_XT_MATCH_PHYSDEV really
depends on CONFIG_BRIDGE and this should be enforced in netfilter's Kconfig.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index a9894dd..b2c412a 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -342,7 +342,7 @@ config NETFILTER_XT_MATCH_MULTIPORT
 
 config NETFILTER_XT_MATCH_PHYSDEV
 	tristate '"physdev" match support'
-	depends on NETFILTER_XTABLES && BRIDGE_NETFILTER
+	depends on NETFILTER_XTABLES && BRIDGE_NETFILTER && BRIDGE
 	help
 	  Physdev packet matching matches against the physical bridge ports
 	  the IP packet arrived on or will leave by.


