Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVAXTzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVAXTzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 14:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVAXTzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 14:55:18 -0500
Received: from colo.lackof.org ([198.49.126.79]:64153 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261543AbVAXTzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 14:55:10 -0500
Date: Mon, 24 Jan 2005 12:55:18 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Mel Gorman <mel@csn.ul.ie>, William Lee Irwin III <wli@holomorphy.com>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       grundler@parisc-linux.org, jejb@steeleye.com, awilliam@fc.hp.com
Subject: Re: [PATCH] Avoiding fragmentation through different allocator
Message-ID: <20050124195518.GA19747@colo.lackof.org>
References: <20050120101300.26FA5E598@skynet.csn.ul.ie> <20050121142854.GH19973@logos.cnet> <Pine.LNX.4.58.0501222128380.18282@skynet> <20050122215949.GD26391@logos.cnet> <Pine.LNX.4.58.0501241141450.5286@skynet> <20050124122952.GA5739@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124122952.GA5739@logos.cnet>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:29:52AM -0200, Marcelo Tosatti wrote:
> Grant Grundler and James Bottomley have been working on this area,
> they might want to add some comments to this discussion.
> 
> It seems HP (Grant et all) has pursued using big pages on IA64 (64K)
> for this purpose.

Marcello,
That might have been Alex Williamson...but the reasons for 64K pages
is to reduce TLB thrashing, not faster IO.

On HP ZX1 boxes, SG performance is slightly better (max +5%) when going
through the IOMMU than when bypassing it. The IOMMU can perfectly
coalesce DMA pages but has a small CPU and DMA cost to do so as well.

Otherwise, I totally agree with James. IO devices do scatter-gather
pretty well and IO subsystems are tuned for page-size chunk or
smaller anyway.

...
> > I could keep digging, but I think the bottom line is that having large
> > pages generally available rather than a fixed setting is desirable. 
> 
> Definately, yes. Thanks for the pointers. 

Big pages are good for CPU TLB and that's where most of the
research has been done. I think IO devices have learned to cope
with the fact the alot less has been (or can be for many
workloads) done to coalesce IO pages.

grant
