Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbUJ2L4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbUJ2L4g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbUJ2Lxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:53:37 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:44804 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263290AbUJ2Lwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:52:46 -0400
Date: Fri, 29 Oct 2004 12:52:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: davem@davemloft.net, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] net: generic netdev_ioaddr
Message-ID: <20041029115233.GA11391@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Pekka Enberg <penberg@cs.helsinki.fi>, davem@davemloft.net,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org
References: <1099044244.9566.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099044244.9566.0.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:04:04PM +0300, Pekka Enberg wrote:
> Hi,
> 
> This patch introduces a generic netdev_ioaddr and converts natsemi and
> 8139too drivers to use it.
> 
> With the recent __iomem annotations, the network drivers need to either
> invent this wrapper (like natsemi has done) or duplicate the IO base
> address in their private data (similar to 8139too).  Therefore, lets
> make netdev_ioaddr generic before it is all over the place.

This casting around sounds like a bad idea.  Either add another

	void __iomem *mmioaddr;

member to struct net_device, or better move that completely into the
driver-private structure which seems the better level of abstraction.

