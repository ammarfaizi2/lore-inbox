Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWJIRrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWJIRrY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 13:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWJIRrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 13:47:24 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:641 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S964776AbWJIRrW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 13:47:22 -0400
Date: Mon, 9 Oct 2006 19:47:05 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>
Subject: Dropping NETIF_F_SG since no checksum feature.
Message-ID: <20061009174705.GG26849@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm trying to build a network device driver supporting a very large MTU (around 64K)
on top of an infiniband connection, and I've hit a couple of issues I'd
appreciate some feedback on:

1. On the send side,
   I've set NETIF_F_SG, but hardware does not support checksum offloading,
   and I see "dropping NETIF_F_SG since no checksum feature" warning,
   and I seem to be getting large packets all in one chunk.
   The reason I've set NETIF_F_SG, is because I'm concerned that under real life
   stress Linux won't be able to allocate 64K of continuous memory.

   Is this concern of mine valid? I saw in-tree drivers allocating at least 8K.
   What's the best way to enable S/G on send side?
   Is checksum offloading really required for S/G?

2. On the receive side, what's the best/right way to create an skb that
   is larger than PAGE_SIZE?
   Do I allocate with alloc_page and fill in nr_frags with skb_fill_page_desc?
   Some drivers seem to fill in frag_list - which is better?
   I see than even skb_put only works properly on linear skb.
   What are the helpers legal for fragmented skb?

Suggestions would be appreciated.

Thanks,

-- 
MST
