Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbVANRfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbVANRfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVANRfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:35:47 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64013 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262035AbVANRfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:35:40 -0500
Date: Fri, 14 Jan 2005 18:35:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org, netdev@oss.sgi.com
Subject: [patch] 2.6.11-rc1-mm1: ip_tables.c: ipt_find_target must be EXPORT_SYMBOL'ed
Message-ID: <20050114173538.GB4274@stusta.de>
References: <20050114002352.5a038710.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114002352.5a038710.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
>...
> All 434 patches:
>...
> restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
>   Restore net/sched/ipt.c After iptables Kmod Cleanup
>...

This causes the following error with CONFIG_NET_ACT_IPT=m:

<--  snip  -->

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.11-rc1-mm1; fi
WARNING: /lib/modules/2.6.11-rc1-mm1/kernel/net/sched/ipt.ko needs unknown symbol ipt_find_target

<--  snip  -->


The fix is simple:


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.11-rc1-mm1-modular/net/ipv4/netfilter/ip_tables.c.old	2005-01-14 18:03:18.000000000 +0100
+++ linux-2.6.11-rc1-mm1-modular/net/ipv4/netfilter/ip_tables.c	2005-01-14 18:04:17.000000000 +0100
@@ -488,6 +488,7 @@
 		return NULL;
 	return target;
 }
+EXPORT_SYMBOL(ipt_find_target);
 
 static int match_revfn(const char *name, u8 revision, int *bestp)
 {
