Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbTGBPik (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbTGBPik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:38:40 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:63237 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265045AbTGBPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:38:38 -0400
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: James Bottomley <James.Bottomley@steeleye.com>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Jens Axboe <axboe@suse.de>, ak@suse.de, davem@redhat.com,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alex Williamson <alex_williamson@hp.com>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
In-Reply-To: <20030701230147.GI14683@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave>
	<20030701191941.GF14683@dsl2.external.hp.com>
	<1057089827.2003.110.camel@mulgrave> 
	<20030701230147.GI14683@dsl2.external.hp.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Jul 2003 10:52:38 -0500
Message-Id: <1057161166.1972.19.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-01 at 18:01, Grant Grundler wrote:
> > The bio layer works with
> > a nice finite list of generic or per-queue constraints; it doesn't care
> > currently what the underlying device or IOMMU does.
> 
> I don't agree. This whole discussion revolves around getting BIO code and
> IOMMU code to agree on how block merging works for a given platform.
> Using a callback into IOMMU code means the BIO truly doesn't have to know.
> The platform specific IOMMU could just tell BIO code what it wants to
> know (how many SG entries would fit into a limited number of physical
> mappings).

Ah, but the point is that currently the only inputs the IOMMU has to the
bio layer are parameters.  I'd like to keep it this way unless there's a
really, really good reason not to.  At the moment it seems that the
proposed parameter covers all of IA64's needs and may cover AMD64's as
well.

> > Putting such a callback in would add this entanglement.
> 
> yes, sort of. But I think this entanglement is present even for machines
> that don't have an IOMMU because of bounce buffers.  But if ia64's swiotlb
> would be made generic to cover buffer bouncing....

Well, not to get into the "where should ZONE_NORMAL end" argument again,
but I was hoping that GFP_DMA32 would elminate the IA64 platform's need
for this.  __blk_queue_bounce() strikes me as being much more heavily
exercised than the swiotlb, so I think it should be the one to remain. 
It also has more context information to fail gracefully.

James


