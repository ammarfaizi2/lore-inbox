Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWHPJcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWHPJcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWHPJcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:32:51 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38118 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751055AbWHPJcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:32:50 -0400
Date: Wed, 16 Aug 2006 13:32:02 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816093159.GA31882@2ka.mipt.ru>
References: <20060816053545.GB22921@2ka.mipt.ru> <20060816084808.GA7366@infradead.org> <20060816090028.GA25476@2ka.mipt.ru> <20060816.020503.74744144.davem@davemloft.net> <20060816091029.GA6375@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060816091029.GA6375@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 13:32:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 10:10:29AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Wed, Aug 16, 2006 at 02:05:03AM -0700, David Miller wrote:
> > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > Date: Wed, 16 Aug 2006 13:00:31 +0400
> > 
> > > So I would like to know how to determine which node should be used for
> > > allocation. Changes of __get_user_pages() to alloc_pages_node() are
> > > trivial.
> > 
> > netdev_alloc_skb() knows the netdevice, and therefore you can
> > obtain the "struct device;" referenced inside of the netdev,
> > and therefore you can determine the node using the struct
> > device.
> 
> It's not that easy unfortunately.  I did what you describe above in my
> first prototype but then found out the hard way that the struct device
> in the netdevice can be a non-pci one, e.g. for pcmcia.  Im that case
> the kernel will crash on you becuase you can only get the node infortmation
> for pci devices.  My current patchkit adds an "int node" member to struct
> net_device instead.  I can repost the patchkit ontop of -mm (which is
> the required slab memory leak tracking changes) if anyone cares.

Can we check device->bus_type or device->driver->bus against
&pci_bus_type for that?

-- 
	Evgeniy Polyakov
