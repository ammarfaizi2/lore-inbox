Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268844AbTCCVYV>; Mon, 3 Mar 2003 16:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268847AbTCCVYV>; Mon, 3 Mar 2003 16:24:21 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:39617 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP
	id <S268844AbTCCVYT>; Mon, 3 Mar 2003 16:24:19 -0500
Date: Mon, 3 Mar 2003 14:34:40 -0700
From: Matt Porter <porter@cox.net>
To: linux-kernel@vger.kernel.org, Dave Miller <davem@redhat.com>
Subject: Re: *dma_sync_single API change to support non-coherent cpus
Message-ID: <20030303143440.B31278@home.com>
References: <20030303111848.A31278@home.com> <20030303195825.C17997@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030303195825.C17997@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Mon, Mar 03, 2003 at 07:58:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:58:25PM +0000, Russell King wrote:
> On Mon, Mar 03, 2003 at 11:18:48AM -0700, Matt Porter wrote:
> > On non cache coherent processors, it is necessary to perform
> > cache operations on the virtual address associated with the
> > buffer to ensure consistency.  There is one problem, however,
> > the current API does not provide the virtual address for the
> > buffer.  It only provides the bus address in the dma_addr_t.
> > On arm and mips, this is dealt with by simply doing bus_to_virt().
> > However, bus_to_virt() isn't valid for all addresses that could
> > have been passed into *map_single().
> 
> I find myself thinking, in passing, why we don't have these
> architectures define something like the following in architecture
> specific code:
> 
> 	struct dma_addr {
> 		unsigned long cpu;
> 		unsigned long bus;
> 		unsigned long size;
> 	};

<snip>

> Architectures which only need the CPU address can place only that in
> their structure definition, and make dma_map_single and friends no-ops.
> I feel that this would get rid of all the shouting DMA_* macros found
> in various pci.h header files.
> 
> This may be something considering for 2.7 though.

I like this abstraction of dma_addr. As you suggest, it's probably
significant enough to be only considered for 2.7.  I was shooting
for the minimal API change for 2.5/2.6 to make non-coherent 
processors functional.  I seriously don't want to submit a
documentation patch clarifying that this API is only valid for
certain addresses. :)

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
