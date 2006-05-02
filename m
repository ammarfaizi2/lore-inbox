Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWEBO1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWEBO1g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 10:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWEBO1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 10:27:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:55507 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964837AbWEBO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 10:27:35 -0400
Date: Tue, 2 May 2006 15:27:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       "Bryan O'Sullivan" <bos@pathscale.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5 of 13] ipath - use proper address translation routine
Message-ID: <20060502142729.GA29721@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Roland Dreier <rdreier@cisco.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Bryan O'Sullivan <bos@pathscale.com>, openib-general@openib.org,
	linux-kernel@vger.kernel.org
References: <1ab168913f0fea5d18b4.1145913781@eng-12.pathscale.com> <ada3bftvatf.fsf@cisco.com> <1146509646.20760.63.camel@laptopd505.fenrus.org> <aday7xltvtb.fsf@cisco.com> <20060502133507.GA26704@infradead.org> <adaaca0mrn1.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaaca0mrn1.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2006 at 07:24:18AM -0700, Roland Dreier wrote:
>     Christoph> Or stop doing the dma mapping in the IB upper level
>     Christoph> drivers.  I told you that we'll get broken hardware
>     Christoph> that doesn't want dma mapping in the upper level
>     Christoph> driver, and pathscale created exactly that :)
> 
> But see my earlier mail to Arjan about RDMA -- what address can a
> protocol (eg SRP initiator) put in a message that the other side will
> use to initiate a remote DMA operation?  It seems to me it has to be a
> bus address, and that means that the protocol has to do the DMA mapping.

Then we're back to the discussion on why RDMA is a fundamentally flawed
approach, but we already knew that.  The usual workaround is to only
allow RDMA operations to registered memory windows for which we can use
the normal dma operation.  There's also the *dac* pci dma operations that
can avoid iommu overhead if you support 64bit addressing.  But for all this
to work dma mapping fundamentally needs to be handled by the low level driver.
