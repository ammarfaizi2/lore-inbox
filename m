Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265195AbUIVNcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265195AbUIVNcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 09:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265211AbUIVNcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 09:32:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:14277 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265195AbUIVNca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 09:32:30 -0400
X-Authenticated: #1725425
Date: Wed, 22 Sep 2004 15:37:07 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Patrick McHardy <kaber@trash.net>
Cc: davem@davemloft.net, rusty@rustcorp.com.au, torvalds@osdl.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
Message-Id: <20040922153707.2cc1d886.Ballarin.Marc@gmx.de>
In-Reply-To: <4150C448.5040604@trash.net>
References: <1095721742.5886.128.camel@bach>
	<20040921143613.2dc78e2f.Ballarin.Marc@gmx.de>
	<1095803902.1942.211.camel@bach>
	<20040922003646.3a84f4c5.Ballarin.Marc@gmx.de>
	<20040921153600.2e732ea6.davem@davemloft.net>
	<20040922013516.753044db.Ballarin.Marc@gmx.de>
	<4150C448.5040604@trash.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2004 02:16:08 +0200
Patrick McHardy <kaber@trash.net> wrote:

> Fixed by this patch.

Yes, works fine. Does this mean that ipchains was broken for a while, but
no one complained?

Anyway, here is another trivial patch against -bk7 that adds runtime
warnings. IMO most users are going to miss compile time warnings, or
won't even compile kernels themselves.

Regards

diff -Nurp tmp/linux-2.6.9/net/ipv4/netfilter/ipchains_core.c
linux-2.6.9/net/ipv4/netfilter/ipchains_core.c
--- tmp/linux-2.6.9/net/ipv4/netfilter/ipchains_core.c	2004-09-22 14:45:26.398827000 +0200
+++ linux-2.6.9/net/ipv4/netfilter/ipchains_core.c	2004-09-22 14:51:20.017069184 +0200
@@ -1800,6 +1800,9 @@ int ipfw_init_or_cleanup(int init)
 
 	if (!init) goto cleanup;
 
+	printk(KERN_WARNING
+		"Warning: ipchains is obsolete, and will be removed soon!\n");
+			
 #ifdef DEBUG_IP_FIREWALL_LOCKING
 	fwc_wlocks = fwc_rlocks = 0;
 #endif
diff -Nurp tmp/linux-2.6.9/net/ipv4/netfilter/ipfwadm_core.c
linux-2.6.9/net/ipv4/netfilter/ipfwadm_core.c
--- tmp/linux-2.6.9/net/ipv4/netfilter/ipfwadm_core.c	2004-09-22 14:45:53.545700000 +0200
+++ linux-2.6.9/net/ipv4/netfilter/ipfwadm_core.c	2004-09-22 14:51:37.780368752 +0200
@@ -1420,6 +1420,9 @@ int ipfw_init_or_cleanup(int init)
 	if (!init)
 		goto cleanup;
 
+	printk(KERN_WARNING
+		"Warning: ipfwadm is obsolete, and will be removed soon!\n");
+			
 	ret = register_firewall(PF_INET, &ipfw_ops);
 	if (ret < 0)
 		goto cleanup_nothing;
