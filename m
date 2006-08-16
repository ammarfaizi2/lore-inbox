Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWHPJir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWHPJir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbWHPJir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:38:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26059 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750700AbWHPJiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:38:46 -0400
Date: Wed, 16 Aug 2006 10:38:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, David Miller <davem@davemloft.net>,
       arnd@arndb.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816093837.GA11096@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	David Miller <davem@davemloft.net>, arnd@arndb.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20060816053545.GB22921@2ka.mipt.ru> <20060816084808.GA7366@infradead.org> <20060816090028.GA25476@2ka.mipt.ru> <20060816.020503.74744144.davem@davemloft.net> <20060816091029.GA6375@infradead.org> <20060816093159.GA31882@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816093159.GA31882@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 01:32:02PM +0400, Evgeniy Polyakov wrote:
> On Wed, Aug 16, 2006 at 10:10:29AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > On Wed, Aug 16, 2006 at 02:05:03AM -0700, David Miller wrote:
> > > From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> > > Date: Wed, 16 Aug 2006 13:00:31 +0400
> > > 
> > > > So I would like to know how to determine which node should be used for
> > > > allocation. Changes of __get_user_pages() to alloc_pages_node() are
> > > > trivial.
> > > 
> > > netdev_alloc_skb() knows the netdevice, and therefore you can
> > > obtain the "struct device;" referenced inside of the netdev,
> > > and therefore you can determine the node using the struct
> > > device.
> > 
> > It's not that easy unfortunately.  I did what you describe above in my
> > first prototype but then found out the hard way that the struct device
> > in the netdevice can be a non-pci one, e.g. for pcmcia.  Im that case
> > the kernel will crash on you becuase you can only get the node infortmation
> > for pci devices.  My current patchkit adds an "int node" member to struct
> > net_device instead.  I can repost the patchkit ontop of -mm (which is
> > the required slab memory leak tracking changes) if anyone cares.
> 
> Can we check device->bus_type or device->driver->bus against
> &pci_bus_type for that?

We could, but I'd rather waste 4 bytes in struct net_device than having
such ugly warts in common code.
