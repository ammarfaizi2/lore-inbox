Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTGATth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 15:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTGATth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 15:49:37 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11525 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S263459AbTGATtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 15:49:36 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jens Axboe <axboe@suse.de>, ak@suse.de, davem@redhat.com,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alex Williamson <alex_williamson@hp.com>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
In-Reply-To: <20030701191941.GF14683@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> 
	<20030701191941.GF14683@dsl2.external.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 01 Jul 2003 15:03:45 -0500
Message-Id: <1057089827.2003.110.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 14:19, Grant Grundler wrote:
> On Tue, Jul 01, 2003 at 11:46:12AM -0500, James Bottomley wrote:
> > +/* Is the queue dma_mask eligible to be bypassed */
> > +#define __BIO_CAN_BYPASS(q) \
> > +	((BIO_VMERGE_BYPASS_MASK) && ((q)->dma_mask & (BIO_VMERGE_BYPASS_MASK)) == (BIO_VMERGE_BYPASS_MASK))
> 
> Like Andi, I had suggested a callback into IOMMU code here.
> But I'm pretty sure james proposal will work for ia64 and parisc.

OK, the core of my objection to this is that at the moment there's no
entangling of the bio layer and the DMA layer.  The bio layer works with
a nice finite list of generic or per-queue constraints; it doesn't care
currently what the underlying device or IOMMU does.  Putting such a
callback in would add this entanglement.

It could be that the bio people will be OK with this, and I'm just
worrying about nothing, but in that case, they need to say so...

James


