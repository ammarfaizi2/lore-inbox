Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261789AbVBOXde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261789AbVBOXde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 18:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVBOXde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 18:33:34 -0500
Received: from scrat.cs.umu.se ([130.239.40.18]:23731 "EHLO scrat.cs.umu.se")
	by vger.kernel.org with ESMTP id S261789AbVBOXdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 18:33:32 -0500
Date: Wed, 16 Feb 2005 00:33:25 +0100
From: Peter Hagervall <hager@cs.umu.se>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kill some sparse warnings
Message-ID: <20050215233325.GA26342@peppar.cs.umu.se>
References: <20050215224553.GA24630@peppar.cs.umu.se> <20050215225655.A26733@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050215225655.A26733@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2005 at 10:56:56PM +0000, Russell King wrote:
> On Tue, Feb 15, 2005 at 11:45:53PM +0100, Peter Hagervall wrote:
> > Cleaned up some address space issues in:
> 
> This is wrong, and highlights a problem with the "remote" dma pool API.
> dma_alloc_coherent() normally returns CPU-local memory, unless you've
> declared remote memory, in which case it's __iomem-type memory.
> 
> Therefore, I don't think we want to mark the return value of
> dma_alloc_coherent with __iomem, because in the vast majority of
> cases, it isn't.

Doh! My bad, I changed the attribute for the return value to get it on
par with the dma-mapping.h file, which as it turned out, was changed
by myself some time ago.

An aonther issue, what I'd like to see, is sort of a "don't care"
attribute which could be used to mark some of the library functions,
e.g. memset and family. AFAICS, many of them shouldn't need to care what
address space they're handling, and at the same time we could get rid of
a lot of the __force casts. Please correct me if this sounds completely
wrong or otherwise insane.

Any other comments welcome.

-- 
Peter Hagervall <hager@cs.umu.se>
