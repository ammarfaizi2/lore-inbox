Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933015AbWF2WGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbWF2WGO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933017AbWF2WGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:06:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:48352
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932928AbWF2WEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:04:05 -0400
Date: Thu, 29 Jun 2006 15:03:19 -0700 (PDT)
Message-Id: <20060629.150319.104035601.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA
 interrupt handler to reduce packet loss
From: David Miller <davem@davemloft.net>
In-Reply-To: <1151618377.10886.23.camel@chalcedony.pathscale.com>
References: <1b00209ef20a0e7893d8.1151617290@eng-12.pathscale.com>
	<20060629.145027.41636491.davem@davemloft.net>
	<1151618377.10886.23.camel@chalcedony.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Thu, 29 Jun 2006 14:59:37 -0700

> It could, indeed.  In fact, we had that discussion here before I sent
> this patch in.  It presumably wants to live in lib/, and acquire a more
> generic name.  What name will capture the uncached-read-but-cached-write
> semantics in a useful fashion?  memcpy_nc?

I'm not good with names :-)

Note that there also might be cases where using such a memcpy
variant might be the wrong thing to do.  For example, for a very
tightly coupled CMT cpu implementation which has the memory controller,
L2 cache, PCI controller, etc. all on the same die and the PCI controller
makes use of the L2 cache just like the cpu threads do, using this
kind of memcpy would always be the wrong thing to do.
