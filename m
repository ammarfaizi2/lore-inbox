Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWHPJEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWHPJEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 05:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWHPJEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 05:04:33 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:41870 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1751030AbWHPJEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 05:04:32 -0400
Date: Wed, 16 Aug 2006 13:00:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-ID: <20060816090028.GA25476@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru> <200608152221.22883.arnd@arndb.de> <20060816053545.GB22921@2ka.mipt.ru> <20060816084808.GA7366@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060816084808.GA7366@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 16 Aug 2006 13:00:40 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 09:48:08AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > Doesn't alloc_pages() automatically switches to alloc_pages_node() or
> > alloc_pages_current()?
> 
> That's not what's wanted.  If you have a slow interconnect you always want
> to allocate memory on the node the network device is attached to.

There is drawback here - if data was allocated on CPU wheere NIC is
"closer" and then processed on different CPU it will cost more than 
in case where buffer was allocated on CPU where it will be processed.

But from other point of view, most of the adapters preallocate set of
skbs, and with msi-x help there will be a possibility to bind irq and
processing to the CPU where data was origianlly allocated.

So I would like to know how to determine which node should be used for
allocation. Changes of __get_user_pages() to alloc_pages_node() are
trivial.

-- 
	Evgeniy Polyakov
