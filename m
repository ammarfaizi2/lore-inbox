Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTIDOiJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265067AbTIDOhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:37:38 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:8190 "EHLO fed1mtao02.cox.net")
	by vger.kernel.org with ESMTP id S265060AbTIDOgx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:36:53 -0400
Date: Thu, 4 Sep 2003 07:36:50 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Paul Mackerras <paulus@samba.org>, rmk@arm.linux.org.uk, hch@lst.de,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904073650.B22822@home.com>
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030904023624.592f1601.davem@redhat.com>; from davem@redhat.com on Thu, Sep 04, 2003 at 02:36:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 02:36:24AM -0700, David S. Miller wrote:
> On Thu, 4 Sep 2003 19:21:34 +1000 (EST)
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > What I would prefer is if we passed a struct device pointer, a
> > resource pointer and an offset to ioremap.  Then we could just have
> > bus addresses in PCI device resources instead of having to translate
> > them into physical addresses.
> 
> You only need a resource in order to do this.  Then you can
> stick the upper bits, controller number, whatever in the unused
> resource flag bits.

Ok, now the other part of making PCI devices work is to support
mmap.  In most cases, that means remap_page_range() is used which
is stuck with an unsigned long physical address.  For example,
should we really have a remap_resource_range() in FB drivers to
handle mmap?  This could use arch-specific resource information
to get a 36-bit physical address (PPC44x) and maybe get rid of
some of the in-driver per-arch address munging.

My local tree has an ugly hack to remap_page_range() (and friends)
so it uses a phys_addr_t and calls fixup_bigphys_addr() to allow
use of unmodified PCI FB drivers.  I'd like to get this working
without hacks. :)

-Matt
