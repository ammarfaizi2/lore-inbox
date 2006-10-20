Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWJTT4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWJTT4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422831AbWJTT4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:56:21 -0400
Received: from palrel11.hp.com ([156.153.255.246]:30403 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1422823AbWJTT4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:56:20 -0400
Date: Fri, 20 Oct 2006 14:56:18 -0500
From: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
To: Andrew Morton <akpm@osdl.org>, jens.axboe@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 2/2] cciss: disable dma prefetch for P600
Message-ID: <20061020195618.GA13181@beardog.cca.cpqcorp.net>
References: <20061017211303.GB17874@beardog.cca.cpqcorp.net> <20061017171021.baea3c3f.akpm@osdl.org> <20061018165453.GA14255@beardog.cca.cpqcorp.net> <20061018143723.48510ea7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061018143723.48510ea7.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 02:37:23PM -0700, Andrew Morton wrote:
> 
> argh, you removed the mailing list from cc.

Sorry, I'm still lacking proper etiquette.

> 
> On Wed, 18 Oct 2006 11:54:53 -0500
> "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
> 
> > On Tue, Oct 17, 2006 at 05:10:21PM -0700, Andrew Morton wrote:
> > > On Tue, 17 Oct 2006 16:13:03 -0500
> > > "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net> wrote:
> > > 
> > > > PATCH 2/2
> > > > Turned off DMA prefetch for the P600 on systems which may present
> > > > discontiguous memory.
> > > > 
> > > 
> > > What do you mean by "discontiguous memory"?  CONFIG_DISCONTIGMEM?
> > 
> > The IPF memory map can have holes between the different regions. I've
> > been told by our HW guys that AMD may also have holes.
> 
> Pretty much all platforms/architectures have holes in their physical memory
> map.
> 
> 
> > > 
> > > What is the actual problem which is being fixed here?
> > 
> > Sorry, I should have been clearer. There is a bug in the DMA engine that
> > that may result in prefetching data from beyond the end of memory or
> > falling off into one the holes on IPF and AMD. It causes a machine check
> > when that happens.
> > It doesn't happen on Proliant because the last 4kB (or so) of memory is
> > mapped out by the BIOS and Pentium guarantees contiguous memory.
> 
> I think that this:
> 
> > > #if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
> 
> is nowhere near strong enough and is probably inappropriate.
> 
> It _could_ be that CONFIG_DISCONTIGMEM|CONFIG_SPARSEMEM will be closer, but
> even CONFIG_FLATMEM systems can have holes.

I'm poking around on some IPF platforms. It looks like CONFIG_DISCONTIGMEM is
set on them, but not the others you mention. Would that be sufficient?

> 
> On what machines can/does this card exist?  Things like powerpc?

This problem was found on Itanium. We don't try to support powerpc.

Thanks,
mikem
