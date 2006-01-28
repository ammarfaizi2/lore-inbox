Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWA1TRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWA1TRK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 14:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWA1TRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 14:17:09 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36117 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750725AbWA1TRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 14:17:08 -0500
Date: Sat, 28 Jan 2006 20:17:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060128191759.GC9750@suse.de>
References: <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de> <20060127202646.GC2767@flint.arm.linux.org.uk> <43DA84B2.8010501@drzeus.cx> <43DA97A3.4080408@drzeus.cx> <20060127225428.GD2767@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127225428.GD2767@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Russell King wrote:
> On Fri, Jan 27, 2006 at 10:58:59PM +0100, Pierre Ossman wrote:
> > Test done here, few minutes ago. Added this to the wbsd driver in its
> > kmap routine:
> > 
> >     if ((host->cur_sg->offset + host->cur_sg->length) > PAGE_SIZE)
> >         printk(KERN_DEBUG "wbsd: Big sg: %d, %d\n",
> >             host->cur_sg->offset, host->cur_sg->length);
> > 
> > got:
> > 
> > [17385.425389] wbsd: Big sg: 0, 8192
> > [17385.436849] wbsd: Big sg: 0, 7168
> > [17385.436859] wbsd: Big sg: 0, 7168
> > [17385.454029] wbsd: Big sg: 2560, 5632
> > [17385.454216] wbsd: Big sg: 2560, 5632
> 
> Jens - what's going on?  These look like invalid sg entries to me.
> 
> If they are supposed to be like that, there will be additional problems
> for block drivers ensuring cache coherency on PIO.

No freaking idea, must be coming out of the pci dma mapping. The IOMMU
doing funky stuff? How are these sg lists mapped?

-- 
Jens Axboe

