Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbUB0O4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 09:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbUB0O4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 09:56:09 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:7639 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262914AbUB0Oz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 09:55:59 -0500
Subject: Re: [PATCH] move consistent_dma_mask to the generic device
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jeremy Higdon <jeremy@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, willy@debian.org,
       Jes Sorensen <jes@wildopensource.com>,
       Grant Grundler <grundler@parisc-linux.org>, alex.williamson@hp.com,
       jbarnes@sgi.com, ak@muc.de, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040227065702.GB561561@sgi.com>
References: <1077814394.2662.86.camel@mulgrave> 
	<20040227065702.GB561561@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 27 Feb 2004 08:55:30 -0600
Message-Id: <1077893732.1806.2.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 00:57, Jeremy Higdon wrote:
> I haven't had a chance to try it yet, but it looks good.
> 
> If you're going to get rid of pci_dev.consistent_dma_mask in favor
> of pci_dev.dev.coherent_dma_mask, would you want to do the same
> with pci_dev.dma_mask?

It's probably about time that was done, yes.

> Which brings to mind a second question; why is device.dma_mask
> a u64 * instead of u64?  Does it typically point to pci_dev.dma_mask?

That's a bad design decision that will forever haunt me.  When I first
proposed moving from the PCI DMA model to the generic device DMA model,
the dma_mask was in the wrong place.  Quite a few drivers touched it
themselves outside of the accessor functions, so actually moving it in
to struct device became quite involved, so I took the easy way out and
simply made the entry in struct device a pointer to the real one so that
anything that updated the mask outside of the accessors would still
work.

I suppose I should really do the work as pennance, plus write out a
hundred times "never sacrifice design integrity for expediency", sigh.

James


