Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUFSVPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUFSVPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUFSVPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 17:15:42 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:33288
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264697AbUFSVPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 17:15:40 -0400
Date: Sat, 19 Jun 2004 14:15:24 -0700
From: Tony Lindgren <tony@atomide.com>
To: Ian Molton <spyro@f2s.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, david-b@pacbell.net,
       jamey.hicks@hp.com, joshua@joshuawise.com, jgarzik@pobox.com
Subject: Re: DMA API issues
Message-ID: <20040619211524.GB9263@atomide.com>
References: <20040618175902.778e616a.spyro@f2s.com> <40D359B3.6080400@pobox.com> <20040619002618.5650e16a.spyro@f2s.com> <1087601446.2134.211.camel@mulgrave> <40D37BA5.8070704@pobox.com> <20040619005714.37b68453.spyro@f2s.com> <40D3838B.2070608@pobox.com> <20040619011621.4491600a.spyro@f2s.com> <40D3872F.5010007@pobox.com> <20040619013448.7d71ebb2.spyro@f2s.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040619013448.7d71ebb2.spyro@f2s.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ian Molton <spyro@f2s.com> [040618 17:34]:
> On Fri, 18 Jun 2004 20:22:07 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > > my CPU can write directly to this 32K of SRAM. the chip can DMA from
> > > it.
> > 
> > 
> > Yes, write via MMIO.  Non-local RAM is not DMA.
> 
> I fail to see your point. this is NOT MMIO. in MMIO you write and the
> device reads as you write. in DMA, you write and then tell the chip to
> read from the memory you wrote to.

<snip>

I could possibly see some use for allowing multiple DMA domains in
addition to the system memory. Maybe something to allow overriding
the dma allocator per device? We could have optional dev->map() and
unmap(), and then use the dma-mapping API only to keep track of what's
allocated.

But I don't know how much sense that makes because there would be
only one driver using that DMA buffer. The DMA area would not be 
shared with other drivers like the system memory is.

So maybe the only advantage would be to allow more portable generic
device drivers.

Luckily I don't need this right now :)

Tony
