Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbTGAWr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 18:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTGAWr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 18:47:26 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:28425 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S263818AbTGAWrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 18:47:24 -0400
Date: Tue, 1 Jul 2003 17:01:47 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jens Axboe <axboe@suse.de>, ak@suse.de, davem@redhat.com,
       suparna@in.ibm.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Alex Williamson <alex_williamson@hp.com>,
       Bjorn Helgaas <bjorn_helgaas@hp.com>
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
Message-ID: <20030701230147.GI14683@dsl2.external.hp.com>
References: <1057077975.2135.54.camel@mulgrave> <20030701191941.GF14683@dsl2.external.hp.com> <1057089827.2003.110.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057089827.2003.110.camel@mulgrave>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 01, 2003 at 03:03:45PM -0500, James Bottomley wrote:
> OK, the core of my objection to this is that at the moment there's no
> entangling of the bio layer and the DMA layer.

I agree this is a good thing.

> The bio layer works with
> a nice finite list of generic or per-queue constraints; it doesn't care
> currently what the underlying device or IOMMU does.

I don't agree. This whole discussion revolves around getting BIO code and
IOMMU code to agree on how block merging works for a given platform.
Using a callback into IOMMU code means the BIO truly doesn't have to know.
The platform specific IOMMU could just tell BIO code what it wants to
know (how many SG entries would fit into a limited number of physical
mappings).

> Putting such a callback in would add this entanglement.

yes, sort of. But I think this entanglement is present even for machines
that don't have an IOMMU because of bounce buffers.  But if ia64's swiotlb
would be made generic to cover buffer bouncing....

> It could be that the bio people will be OK with this, and I'm just
> worrying about nothing, but in that case, they need to say so...

Would that be Jens Axboe/Dave Miller/et al?

thanks,
grant
