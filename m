Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWJKJUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWJKJUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965218AbWJKJUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:20:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23435
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965216AbWJKJUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:20:12 -0400
Date: Wed, 11 Oct 2006 02:20:15 -0700 (PDT)
Message-Id: <20061011.022015.63051509.davem@davemloft.net>
To: mst@mellanox.co.il
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061011090504.GC2938@mellanox.co.il>
References: <20061010.191547.83619974.davem@davemloft.net>
	<20061011090504.GC2938@mellanox.co.il>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Date: Wed, 11 Oct 2006 11:05:04 +0200

> So, it seems that if I set NETIF_F_SG but clear NETIF_F_ALL_CSUM,
> data will be copied over rather than sent directly.
> So why does dev.c have to force set NETIF_F_SG to off then?

Because it's more efficient to copy into a linear destination
buffer of an SKB than page sub-chunks when doing checksum+copy.
