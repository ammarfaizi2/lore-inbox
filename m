Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVAOVrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVAOVrp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 16:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVAOVqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 16:46:03 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54799 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262342AbVAOVne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 16:43:34 -0500
Date: Sat, 15 Jan 2005 22:43:31 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-rc3
Message-ID: <20050115214330.GA765@pcw.home.local>
References: <20050115151320.GB7397@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115151320.GB7397@logos.cnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On Sat, Jan 15, 2005 at 01:13:20PM -0200, Marcelo Tosatti wrote:
> Hi, 
> 
> Here goes the third release candidate.
> 
> This one comes out to release a bunch of pending networking fixes from 
> David Miller: netfilter, sctp, ipvs, etc.
> 
> Also changes the tty ldisc locking patches to not export a couple of API functions 
> as GPL, because that breaks compatibility with older modutils.
> 
> This will become final if no problems appear.
> 
> Please help with testing!

OK, it builds and runs on my dual athlon (gcc-2.95.3,e1000,scsi), my
notebook (gcc-3.3.5,tg3,acpi), and on an ultra60 (ultrasparc SMP,gcc-3.3.4,
scsi,sunhme). I also built it on an alpha ev6 with gcc-3.3.5, but I didn't
want to reboot it.

While compiling, I noticed that hosts using gcc-3 gave a few warnings such
as this one, which is easily fixed with the following patch :

  bond_alb.c: In function `bond_alb_xmit':
  bond_alb.c:1278: warning: use of cast expressions as lvalues is deprecated


--- ./drivers/net/bonding/bond_alb.c.bad	Sat Mar 20 10:08:18 2004
+++ ./drivers/net/bonding/bond_alb.c	Sat Jan 15 22:14:32 2005
@@ -1275,7 +1275,7 @@
 int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev)
 {
 	struct bonding *bond = bond_dev->priv;
-	struct ethhdr *eth_data = (struct ethhdr *)skb->mac.raw = skb->data;
+	struct ethhdr *eth_data = (struct ethhdr *)(skb->mac.raw = skb->data);
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
 	struct slave *tx_slave = NULL;
 	static u32 ip_bcast = 0xffffffff;


> Summary of changes from v2.4.29-rc2 to v2.4.29-rc3
> ============================================
(...) 
> Patrick McHardy:
>   o [NETFILTER]: Associate locally generated ICMP errors with conntrack of original packet
>   o [NETFILTER]: Remove CONFIG_IP_NF_NAT_LOCAL config option

at first, I though that both the config option and the feature were removed !
fortunately, it's only the option ;-)

Cheers,
Willy

