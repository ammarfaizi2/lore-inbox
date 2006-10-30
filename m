Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422672AbWJ3WeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422672AbWJ3WeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422701AbWJ3WeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:34:06 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39657
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1422672AbWJ3WeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:34:03 -0500
Date: Mon, 30 Oct 2006 14:33:57 -0800 (PST)
Message-Id: <20061030.143357.130208425.davem@davemloft.net>
To: hch@lst.de
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] add dev_to_node()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061030141501.GC7164@lst.de>
References: <20061030141501.GC7164@lst.de>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Oct 2006 15:15:01 +0100

> Davem suggested to get the node-affinity information directly from
> struct device instead of having the caller extreact it from the
> pci_dev.  This patch adds dev_to_node() to the topology API for that.
> The implementation is rather ugly as we need to compare the bus
> operations which we can't do inline in a header without pulling all
> kinds of mess in.
> 
> Thus provide an out of line dev_to_node for ppc and let everyone else
> use the dummy variant in asm-generic.h for now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

It may be a bit much to be calling all the way through up to the PCI
layer just to pluck out a simple integer, don't you think?  The PCI
bus pointer comparison is just a symptom of how silly this is.

Especially since this will be used for every packet allocation a
device makes.

So, please add some sanity to this situation and just put the node
into the generic struct device. :-)
