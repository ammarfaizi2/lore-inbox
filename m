Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbTIDP0S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTIDP0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:26:18 -0400
Received: from fed1mtao01.cox.net ([68.6.19.244]:39839 "EHLO
	fed1mtao01.cox.net") by vger.kernel.org with ESMTP id S265091AbTIDP0H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:26:07 -0400
Date: Thu, 4 Sep 2003 08:26:05 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: paulus@samba.org, rmk@arm.linux.org.uk, hch@lst.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904082605.C22822@home.com>
References: <20030903203231.GA8772@lst.de> <16214.34933.827653.37614@nanango.paulus.ozlabs.org> <20030904071334.GA14426@lst.de> <20030904083007.B2473@flint.arm.linux.org.uk> <16215.1054.262782.866063@nanango.paulus.ozlabs.org> <20030904023624.592f1601.davem@redhat.com> <20030904073650.B22822@home.com> <20030904073009.6684112e.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030904073009.6684112e.davem@redhat.com>; from davem@redhat.com on Thu, Sep 04, 2003 at 07:30:09AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 07:30:09AM -0700, David S. Miller wrote:
> On Thu, 4 Sep 2003 07:36:50 -0700
> Matt Porter <mporter@kernel.crashing.org> wrote:
> 
> > Ok, now the other part of making PCI devices work is to support
> > mmap.
> 
> You get the pci device in the arch PCI mmap() routines, what
> more do you need?  Grep for HAVE_PCI_MMAP in the source tree
> and how sparc64 implements that.

That will work for the PCI case.  It does force us to maintain a
remap_page_range64() in arch/ppc, duplicating code, and creating a
maintainer headache.  I don't think we can hack set_pte() (so as
to call the standard remap_page_range()) to trap and add the upper
bits because there is not enough context to make the right decision.
We've got to have the remap_page_range64() for PPC4xx-specific OCP
drivers too.

A remap_page_range() that even took a paddr_t would be helpful if
not some resource based remapper.

I suppose we could even use the HAVE_PCI_MMAP approach to make
mem.c usable with a PPC44x specific hack.  Of course, a
remap_page_range() with a paddr_t arg would also help here. 

-Matt
