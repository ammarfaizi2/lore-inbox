Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUFRP1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUFRP1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbUFRP1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:27:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:7045 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265261AbUFRPXT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:23:19 -0400
Subject: Re: PATCH: Further aacraid work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@muc.de>
Cc: Alan Cox <alan@redhat.com>, Anton Blanchard <anton@samba.org>,
       mark_salyzyn@adaptec.com, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20040617212559.GA71701@colin2.muc.de>
References: <286GI-5y3-11@gated-at.bofh.it> <286Qp-5EU-19@gated-at.bofh.it>
	 <m3smcut2z0.fsf@averell.firstfloor.org>
	 <20040617205414.GE8705@devserv.devel.redhat.com>
	 <20040617212559.GA71701@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1087571966.8209.273.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 10:19:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-17 at 16:25, Andi Kleen wrote:
> On Thu, Jun 17, 2004 at 04:54:14PM -0400, Alan Cox wrote:
> > I would rather see it below the I/O layer for things like AMD64. The
> > reason I say this is that many drivers would suffer from iommu merging not
> > gain, and others may have limits.
> > 
> > Something like
> > 
> > 	new_sglist = sg_squash(old_sglist, [target max segments], [max per seg])
> > 
> > could be used by drivers when appropriate to hand back a better sg list
> > (or if not possible the existing one). That would put control rather closer
> > to the driver. 
> 
> My understanding was that it was too late in the driver because the SG lists
> are already sized, because higher layer manage this. That is why
> the BIO_VMERGE_BOUNDARY define is checked by BIO, not the driver.
> 
> The input of sg_squash should not be an already mapped list
> (that would be too costly) better would be probably
> a pci_map_sg_merge() with hints that tries to merge and other
> than that works like normal pci_map_sg()

Well, that's why we don't enable BIO_VMERGE_BOUNDARY nor any of the merging
at the BIO level, at least we didn't on ppc64 when I last worked on the code.

We let the BIO generate things that will always fit. We just have pci_map_*
do merging on a "best it can" basis. Most of the time, it does end up merging
a lot.

I don't think any driver control would help much here ...

Ben.


