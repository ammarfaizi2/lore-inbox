Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUFSA5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUFSA5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUFSAyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:54:35 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:41896 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S261300AbUFSAld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:41:33 -0400
Date: Sat, 19 Jun 2004 01:34:48 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com,
       jgarzik@pobox.com
Subject: Re: DMA API issues
Message-Id: <20040619013448.7d71ebb2.spyro@f2s.com>
In-Reply-To: <40D3872F.5010007@pobox.com>
References: <20040618175902.778e616a.spyro@f2s.com>
	<40D359B3.6080400@pobox.com>
	<20040619002618.5650e16a.spyro@f2s.com>
	<1087601446.2134.211.camel@mulgrave>
	<40D37BA5.8070704@pobox.com>
	<20040619005714.37b68453.spyro@f2s.com>
	<40D3838B.2070608@pobox.com>
	<20040619011621.4491600a.spyro@f2s.com>
	<40D3872F.5010007@pobox.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 20:22:07 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> > my CPU can write directly to this 32K of SRAM. the chip can DMA from
> > it.
> 
> 
> Yes, write via MMIO.  Non-local RAM is not DMA.

I fail to see your point. this is NOT MMIO. in MMIO you write and the
device reads as you write. in DMA, you write and then tell the chip to
read from the memory you wrote to.

this is exactly what Im talking about.

Heres what the DMA mapping code deals with:

CPU-----host bus------>RAM-----io bus---->device


and heres what I have:

CPU-----host bus----->RAM-----io bus----->device

the *only* difference is that the RAM in the first case is SDRAM and in
the latter is SRAM. the type of RAM is irrelevant to the DMA system.

I *could* (at great expense) replace the SDRAM in a PC with SRAM. DMA
would still work the same way.

sure, the SRAM is *on* the die of my OCHI/multi-io controller. whats
that got to do with it?

and theres the other issue - if I made an ohci allocator for the SRAM
I'd have to partition off a small ammount ONLY for OHCI. with only 32K
to begin with thats a huge penalty for all the other devices in the
multi IO chip. a bus level DMA allocator solves this AND makes drivers
cleaner/more maintainable.

What more do you want?
