Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265083AbUAOWQF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbUAOWQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:16:00 -0500
Received: from palrel11.hp.com ([156.153.255.246]:36580 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262683AbUAOWPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:15:54 -0500
Date: Thu, 15 Jan 2004 14:16:40 -0800
From: Grant Grundler <iod00d@hp.com>
To: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040115221640.GA11283@cup.hp.com>
References: <20040115204913.GA8172@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115204913.GA8172@sgi.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 12:49:13PM -0800, Jesse Barnes wrote:
> Based on the PIO ordering disucssion, I've come up with the following
> patch.  It has the potential to help any platform that has seperate PIO
> and DMA channels, and allows them to be reorderd wrt each other.

This is only significant for DMA writes (inbound) vs. PIO Read returns.
The ZX1 platforms have reordering enabled for outbound DMA (vs PIO
writes) since last summer.

Outside the context of PCI-X Relaxed Ordering, this violates PCI
ordering rules. Any patches to drivers *using* the new readb()
variants in effect work around this violation. I"m ok with that - just
want it to be clear.

PCI-X support will need a different interface
(eg pcix_enable_relaxed_ordering()) to support
it's form of "Relaxed Ordering".

> Some
> SGI MIPS platforms, as well as the SGI Altix (aka sn2) platform behave
> this way, and will thus benefit from this patch.
> 
> It adds a new PIO read routine for PIOs that don't have to be ordered
> wrt DMA on the system.
> 
> If it looks ok, I'll add in macros for the other arches and send it out
> for inclusion.

It looks ok to me.

thanks,
grant
