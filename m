Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVAYOtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVAYOtf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 09:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbVAYOtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 09:49:35 -0500
Received: from colin2.muc.de ([193.149.48.15]:18962 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261964AbVAYOtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 09:49:33 -0500
Date: 25 Jan 2005 15:49:32 +0100
Date: Tue, 25 Jan 2005 15:49:32 +0100
From: Andi Kleen <ak@muc.de>
To: Christoph Hellwig <hch@infradead.org>, Steve Lord <lord@xfs.org>,
       "Mukker, Atul" <Atulm@lsil.com>,
       "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Mel Gorman'" <mel@csn.ul.ie>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Linux Memory Management List'" <linux-mm@kvack.org>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'Grant Grundler'" <grundler@parisc-linux.org>
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050125144932.GA75109@muc.de>
References: <0E3FA95632D6D047BA649F95DAB60E5705A70E61@exa-atlanta> <41F65514.3040707@xfs.org> <20050125142757.GA20442@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125142757.GA20442@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:27:57PM +0000, Christoph Hellwig wrote:
> > It is not the driver per se, but the way the memory which is the I/O
> > source/target is presented to the driver. In linux there is a good
> > chance it will have to use more scatter gather elements to represent
> > the same amount of data.
> 
> Note that a change made a few month ago after seeing issues with
> aacraid means it's much more likely to see contingous memory,
> there were some numbers on linux-scsi and/or linux-kernel.

But only at the beginning. iirc after a few days of uptime 
and memory fragmentation it degenerates back to the old numbers.

Perhaps the recent anti defragmentation work will help more.

-Andi

P.S.: on a AMD x86-64 box the theory can be relatively easily tested:
just run with iommu=force,biomerge that will use the IOMMU to merge
SG elements.  I just don't recommend it for production because some errors 
are not well handled.
