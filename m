Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263255AbSJJGBO>; Thu, 10 Oct 2002 02:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263267AbSJJGBO>; Thu, 10 Oct 2002 02:01:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59575 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263255AbSJJGBN>;
	Thu, 10 Oct 2002 02:01:13 -0400
Date: Wed, 09 Oct 2002 22:59:41 -0700 (PDT)
Message-Id: <20021009.225941.88169695.davem@redhat.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.41-mm2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA512B1.63287C02@digeo.com>
References: <3DA512B1.63287C02@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Wed, 09 Oct 2002 22:40:01 -0700

     but we're seeing a consistent few-percent regression in tests which perform
     networking to localhost.

There's debugging code in loopback that is helping us stress test
the TCP segmentation offload, you might want to disable that to
get more reliable numbers in 2.5.x.

Try this:

--- drivers/net/loopback.c.~1~	Wed Oct  9 23:01:16 2002
+++ drivers/net/loopback.c	Wed Oct  9 23:01:35 2002
@@ -190,12 +190,12 @@
 	dev->rebuild_header	= eth_rebuild_header;
 	dev->flags		= IFF_LOOPBACK;
 	dev->features		= NETIF_F_SG|NETIF_F_FRAGLIST|NETIF_F_NO_CSUM|NETIF_F_HIGHDMA;
-
+#if 0
 	/* Current netfilter will die with oom linearizing large skbs,
 	 * however this will be cured before 2.5.x is done.
 	 */
 	dev->features	       |= NETIF_F_TSO;
-
+#endif
 	dev->priv = kmalloc(sizeof(struct net_device_stats), GFP_KERNEL);
 	if (dev->priv == NULL)
 			return -ENOMEM;
