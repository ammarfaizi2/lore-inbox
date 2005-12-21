Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVLUVGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVLUVGh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 16:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVLUVGh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 16:06:37 -0500
Received: from mato.luukku.com ([193.209.83.251]:58855 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S1751218AbVLUVGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 16:06:36 -0500
Date: Wed, 21 Dec 2005 23:06:21 +0200
From: Mika Kukkonen <mikukkon@iki.fi>
To: coreteam@netfilter.org, netfilter@lists.netfilter.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NETFILTER: Fix handling of module param dcc_timeout in ip_conntrack_irc.c
Message-ID: <20051221210621.GD24213@localhost.localdomain>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Variable dcc_timeout is unsigned, so change the module_param() to
reflect that, and also remove the now unneeded check in init().

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

diff --git a/net/ipv4/netfilter/ip_conntrack_irc.c b/net/ipv4/netfilter/ip_conntrack_irc.c
index d7c4042..90bd850 100644
--- a/net/ipv4/netfilter/ip_conntrack_irc.c
+++ b/net/ipv4/netfilter/ip_conntrack_irc.c
@@ -56,7 +56,7 @@ module_param_array(ports, ushort, &ports
 MODULE_PARM_DESC(ports, "port numbers of IRC servers");
 module_param(max_dcc_channels, int, 0400);
 MODULE_PARM_DESC(max_dcc_channels, "max number of expected DCC channels per IRC session");
-module_param(dcc_timeout, int, 0400);
+module_param(dcc_timeout, uint, 0400);
 MODULE_PARM_DESC(dcc_timeout, "timeout on for unestablished DCC channels");
 
 static const char *dccprotos[] = { "SEND ", "CHAT ", "MOVE ", "TSEND ", "SCHAT " };
@@ -254,10 +254,6 @@ static int __init init(void)
 		printk("ip_conntrack_irc: max_dcc_channels must be a positive integer\n");
 		return -EBUSY;
 	}
-	if (dcc_timeout < 0) {
-		printk("ip_conntrack_irc: dcc_timeout must be a positive integer\n");
-		return -EBUSY;
-	}
 
 	irc_buffer = kmalloc(65536, GFP_KERNEL);
 	if (!irc_buffer)

