Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263818AbUFTSZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263818AbUFTSZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 14:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbUFTSZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 14:25:59 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24549 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263818AbUFTSZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 14:25:58 -0400
Date: Sun, 20 Jun 2004 11:25:51 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Ian Molton <spyro@f2s.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, James.Bottomley@steeleye.com,
       benh@kernel.crashing.org, jamey.hicks@hp.com,
       linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040620182551.GA12523@plexity.net>
Reply-To: dsaxena@plexity.net
References: <1087582845.1752.107.camel@mulgrave> <20040618193544.48b88771.spyro@f2s.com> <1087584769.2134.119.camel@mulgrave> <40D340FB.3080309@hp.com> <1087589651.8210.288.camel@gaston> <1087590286.2135.161.camel@mulgrave> <20040618222014.D17516@flint.arm.linux.org.uk> <20040619002051.66661ff4.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619002051.66661ff4.spyro@f2s.com>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 19 2004, at 00:20, Ian Molton was caught saying:
> On Fri, 18 Jun 2004 22:20:14 +0100
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > > Yes, we do this on parisc too.  We actually have a hidden method
> > > pointer(per platform) and cache the iommu (we have more than one)
> > > accessors in platform_data.
> > 
> > Except that platform_data already has multiple other uses, especially
> > for platform devices.
> 
> In the case of the SOC devices I described, its actually appropriate to
> make the allocator system tied to the bus - as several devices end up
> sharing the same 32K pool in the device. at the device level the
> allocator would be useless in these cases.

I've followed the whole thread and I still think what you are trying
to do can be currently accomplished with the existing API by simply 
overriding the generic ARM implementation and providing one specific
to your platform. All the dma_* APIs take a dev structure as a
parameter, so you simply have to look at that and if it's your OHCI
device, call your specific allocator/deallocator/mapping function/etc.
Your dma_alloc_coherent() would simply ioremap() and return the
ioremap'd address as the virtual address and the OHCI-bus address 
as the DMA_ADDR. Your dma_map_single() simply bounces data between
the SRAM and system memory.  Having per-bus or per-device allocators 
as you are proposing is very possibly the correct way to go, but I don't 
think it's a simple enough change that we want to do it on 2.6.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
