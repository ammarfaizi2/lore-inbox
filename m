Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUB0G5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 01:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261728AbUB0G5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 01:57:53 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:62322 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S261727AbUB0G5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 01:57:48 -0500
Date: Thu, 26 Feb 2004 22:57:02 -0800
From: Jeremy Higdon <jeremy@sgi.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Andrew Morton <akpm@osdl.org>, willy@debian.org,
       Jes Sorensen <jes@wildopensource.com>,
       Grant Grundler <grundler@parisc-linux.org>, alex.williamson@hp.com,
       jbarnes@sgi.com, ak@muc.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move consistent_dma_mask to the generic device
Message-ID: <20040227065702.GB561561@sgi.com>
References: <1077814394.2662.86.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077814394.2662.86.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't had a chance to try it yet, but it looks good.

If you're going to get rid of pci_dev.consistent_dma_mask in favor
of pci_dev.dev.coherent_dma_mask, would you want to do the same
with pci_dev.dma_mask?

Which brings to mind a second question; why is device.dma_mask
a u64 * instead of u64?  Does it typically point to pci_dev.dma_mask?

thanks

jeremy


On Thu, Feb 26, 2004 at 10:53:12AM -0600, James Bottomley wrote:
> This is a reroll of the previous patch.  It fixes up badness in the
> sound drivers which were accessing the dma_mask directly instead of
> using the accessor functions.
> 
> It also modifies the arch's that were using consistent_dma_mask:
> 
> x86_64, ia64 (both sn and hp) and parisc
