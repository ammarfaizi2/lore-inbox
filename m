Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266166AbUFRS7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbUFRS7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUFRS66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:58:58 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7360 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S266166AbUFRS6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:58:16 -0400
Date: Fri, 18 Jun 2004 11:58:09 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Ian Molton <spyro@f2s.com>
Cc: Matt Porter <mporter@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com, tony@atomide.com, david-b@pacbell.net,
       jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-ID: <20040618115809.C3851@home.com>
References: <20040618175902.778e616a.spyro@f2s.com> <20040618110721.B3851@home.com> <20040618191958.1cc3508c.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040618191958.1cc3508c.spyro@f2s.com>; from spyro@f2s.com on Fri, Jun 18, 2004 at 07:19:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 07:19:58PM +0100, Ian Molton wrote:
> On Fri, 18 Jun 2004 11:07:21 -0700
> Matt Porter <mporter@kernel.crashing.org> wrote:
> 
> > Can't you just implement an arch-specific allocator for your 32KB
> > SRAM, then implement the DMA API streaming and dma_alloc/free APIs
> > on top of that?
> 
> Yes but thats not very generic is it? Im not the only one with this
> problem.

Yes, it's suboptimal, but an option.
 
> >  Since this architecture is obviously not designed
> > for performance
> 
> What makes you think writes to the 32K SRAM are any slower than to the
> SDRAM? the device is completely memory mapped.

I was referring to the small amount of space allowed for DMA
operations, obviously not the speed of accessing SRAM.
 
> >, it doesn't seem to be a big deal to have the streaming
> > APIs copy to/from the kmalloced (or whatever) buffer to/from the SRAM
> > allocated memory and then have those APIs return the proper dma_addr_t
> > for the embedded OHCI's address space view of the SRAM.
> 
> Again its a suboptimal solution, and on an architecture where the CPU
> isnt *that* fast in the first place it seems wrong to deliberately
> choose the slowest possible route...

Ok, so you're looking for a complete change to the streaming DMA APIs,
I guess.  Possibly requiring another call to allocate streaming-capable
memory since kmalloced buffers can't be used directly on your arch (or
all arches).  I agree it's suboptimal, it's one option to make it work
in the current API.

-Matt
