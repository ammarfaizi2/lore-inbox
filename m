Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWEBNfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWEBNfO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 09:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWEBNfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 09:35:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:22763 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964813AbWEBNfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 09:35:12 -0400
Date: Tue, 2 May 2006 14:35:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
Message-ID: <20060502133507.GA26704@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Bryan O'Sullivan <bos@pathscale.com>, openib-general@openib.org,
	linux-kernel@vger.kernel.org
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com> <ada3bftvatf.fsf@cisco.com> <1146509646.20760.63.camel@laptopd505.fenrus.org> <aday7xltvtb.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aday7xltvtb.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 12:00:00PM -0700, Roland Dreier wrote:
>     Arjan> do you really NEED the vaddr?  (most of the time linux
>     Arjan> drivers don't need it, while other OSes do) If you really
>     Arjan> need it you should grab it at dma_map time ...  (and
>     Arjan> realize that it's not kernel addressable per se ;)
> 
> Yes, they need some kind of vaddr.
> 
> It's kind of a layering problem.  The IB stack assumes that IB devices
> have a DMA engine that deals with bus addresses.  But the ipath driver
> has to simulate this by using a memcpy on the CPU to move data to the
> PCI device.
> 
> I really don't know what the right solution is.  Maybe having some way
> to override the dma mapping operations so that the ipath driver can
> keep the info it needs?

Or stop doing the dma mapping in the IB upper level drivers.  I told you
that we'll get broken hardware that doesn't want dma mapping in the upper
level driver, and pathscale created exactly that :)

