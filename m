Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbVEJOBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVEJOBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 10:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVEJOBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 10:01:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:15767 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261657AbVEJOBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 10:01:35 -0400
Subject: Re: [PATCH] Fix PCI mmap on ppc and ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
In-Reply-To: <je8y2nqkwk.fsf@sykes.suse.de>
References: <1115700814.6157.7.camel@gaston>  <je8y2nqkwk.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 10 May 2005 23:57:49 +1000
Message-Id: <1115733469.6157.60.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-10 at 15:18 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > @@ -351,9 +351,12 @@
> >  		*offset += hose->pci_mem_offset;
> >  		res_bit = IORESOURCE_MEM;
> >  	} else {
> > -		io_offset = (unsigned long)hose->io_base_virt;
> > +		io_offset = (unsigned long)hose->io_base_virt - pci_io_base;
> > +		printk("offset: %lx, io_base_virt: %p, pci_io_base: %lx, io_offset: %
> > lx\n",
> > +		       *offset, hose->io_base_virt, pci_io_base, io_offset);
> >  		*offset += io_offset;
> >  		res_bit = IORESOURCE_IO;
> > +		printk(" -> offset: %lx\n", *offset);
> 
> I don't think you want those debugging printks be left here.

Good point, looks like I got really sloppy on this patch. I'll send a
fix tomorrow unless andrew beats me at it as this isn't yet in any
released -mm

Ben.


