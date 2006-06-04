Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932139AbWFDUY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWFDUY4 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWFDUYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:24:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:2991 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932139AbWFDUYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:24:51 -0400
X-Authenticated: #20450766
Date: Sun, 4 Jun 2006 22:24:44 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Tejun Heo <htejun@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@suse.de>,
        James Bottomley <James.Bottomley@SteelEye.com>,
        Dave Miller <davem@redhat.com>, bzolnier@gmail.com,
        james.steward@dynamicratings.com, jgarzik@pobox.com,
        mattjreimer@gmail.com, rmk@arm.linux.org.uk,
        lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 4/5] SCSI: add cpu cache flushes after kmapping and
 modifying a page
In-Reply-To: <4482A436.8000703@gmail.com>
Message-ID: <Pine.LNX.4.60.0606042151070.24306@poirot.grange>
References: <1149392479501-git-send-email-htejun@gmail.com>
 <11493924803460-git-send-email-htejun@gmail.com> <20060604082035.GB29696@infradead.org>
 <4482A436.8000703@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006, Tejun Heo wrote:

> Christoph Hellwig wrote:
> > On Sun, Jun 04, 2006 at 12:41:20PM +0900, Tejun Heo wrote:
> > >  			local_irq_save(flags);
> > >  			buf = kmap_atomic(sg->page, KM_IRQ0) + sg->offset;
> > >  			memcpy(buf, tw_dev->generic_buffer_virt[request_id],
> > > sg->length);
> > > +			flush_kernel_dcache_page(kmap_atomic_to_page(buf -
> > > sg->offset));
> > >  			kunmap_atomic(buf - sg->offset, KM_IRQ0);
> > >  			local_irq_restore(flags);
> > 
> > all these should switch to scsi_kmap_atomic_sg which should do the
> > flush_kernel_dcache_page call for you.
> > 
> 
> This is not specific to scsi or block.  This is a common problem for all kmap
> users.  As I wrote in the other mail, I think this should be mandated at the
> kmap/kunmap() interface.

Right. As I wrote scsi_k(un)map_atomic_sg I did mention that they, 
probably, should go to a higher layer as they were not scsi-specific, but 
as I didn't have a good idea of where exactly to put them, I called them
scsi_* and put in scsi_lib.c. Suggestions for a better place and namespace 
for them very welcome. Or just feel free to move / rename them as you see 
appropriate. See, e.g., 
http://marc.theaimsgroup.com/?l=linux-scsi&m=112345886816099&w=2 and the 
related thread from August last year for possible other potential users of 
this API.

Thanks
Guennadi
---
Guennadi Liakhovetski
