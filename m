Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWF3AcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWF3AcK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWF3AcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:32:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:11716
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750745AbWF3AcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:32:08 -0400
Date: Thu, 29 Jun 2006 17:32:06 -0700 (PDT)
Message-Id: <20060629.173206.48800902.davem@davemloft.net>
To: rick.jones2@hp.com
Cc: bos@pathscale.com, akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 39 of 39] IB/ipath - use streaming copy in RDMA
 interrupt handler to reduce packet loss
From: David Miller <davem@davemloft.net>
In-Reply-To: <44A47042.8060203@hp.com>
References: <1151624063.10886.34.camel@chalcedony.pathscale.com>
	<20060629.164623.59469884.davem@davemloft.net>
	<44A47042.8060203@hp.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Jones <rick.jones2@hp.com>
Date: Thu, 29 Jun 2006 17:28:50 -0700

> I thought that most PCI controllers (that is to say the things bridging 
> PCI to the rest of the system) could do prefetching and/or that PCI-X 
> (if not PCI, no idea about PCI-e) cards could issue multiple 
> transactions anyway?

People doing deep CMT chips have found out that all of that
prefetching and store buffering is unnecessary when everything is so
tightly integrated.

All of the previous UltraSPARC boxes before Niagara had a
streaming cache sitting on the PCI controller.  It basically
prefetched for reads and collected writes from PCI devices
into cacheline sized chunks.

The PCI controller in the current Niagara systems has none of that
stuff.
