Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbWBQQ0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWBQQ0D (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWBQQ0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:26:01 -0500
Received: from colo.lackof.org ([198.49.126.79]:21481 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1030639AbWBQQ0A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:26:00 -0500
Date: Fri, 17 Feb 2006 09:36:05 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, linux-ia64@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Problems with MSI-X on ia64
Message-ID: <20060217163605.GA26660@colo.lackof.org>
References: <D4CFB69C345C394284E4B78B876C1CF10B848090@cceexc23.americas.cpqcorp.net> <20060217075829.GB22451@esmail.cup.hp.com> <20060217084605.GG4523@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217084605.GG4523@taniwha.stupidest.org>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 12:46:05AM -0800, Chris Wedgwood wrote:
> On Thu, Feb 16, 2006 at 11:58:29PM -0800, Grant Grundler wrote:
> 
> > The root cause is the use of u32 to describe a PCI resource "start".
> > phys_addr needs to be "unsigned long". More details in Log entry
> > below.
> 
> That won't always suffice.
> 
> I have machines at work that will place some PCI resources above the
> 4GB boundary even when booting in '32-bit OS' mode (there is a BIOS
> option for this but no matter the setting some resources always end up
> above 4GB).  I've heard from others they've also been hit by this
> (with 64-bit kernels it's fine).  I guess it could be argued that it's
> a BIOS bug, I'm not entirely sure what to thing,  Windows seems to
> deal with it.

If the machine is suppose to support a 32-bit OS, then yeah, it's
a BIOS bug. It all depends on who defines the support matrix.

One way to support that behavior is use u64 in struct resource (ioport.h)
(NOT dma_addr_t) instead of "unsigned long".

The other way is to reassign "invalid" resources (above 4GB) with 
"valid" ones (below 4GB).  I suspect windows is doing this and
I'd rather see linux take this route as well if possible.

grant
