Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263781AbUFQV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbUFQV0F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUFQV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:26:05 -0400
Received: from colin2.muc.de ([193.149.48.15]:34576 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263781AbUFQV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:26:01 -0400
Date: 17 Jun 2004 23:25:59 +0200
Date: Thu, 17 Jun 2004 23:25:59 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@redhat.com>
Cc: Andi Kleen <ak@muc.de>, Anton Blanchard <anton@samba.org>,
       mark_salyzyn@adaptec.com, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040617212559.GA71701@colin2.muc.de>
References: <286GI-5y3-11@gated-at.bofh.it> <286Qp-5EU-19@gated-at.bofh.it> <m3smcut2z0.fsf@averell.firstfloor.org> <20040617205414.GE8705@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040617205414.GE8705@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 04:54:14PM -0400, Alan Cox wrote:
> I would rather see it below the I/O layer for things like AMD64. The
> reason I say this is that many drivers would suffer from iommu merging not
> gain, and others may have limits.
> 
> Something like
> 
> 	new_sglist = sg_squash(old_sglist, [target max segments], [max per seg])
> 
> could be used by drivers when appropriate to hand back a better sg list
> (or if not possible the existing one). That would put control rather closer
> to the driver. 

My understanding was that it was too late in the driver because the SG lists
are already sized, because higher layer manage this. That is why
the BIO_VMERGE_BOUNDARY define is checked by BIO, not the driver.

The input of sg_squash should not be an already mapped list
(that would be too costly) better would be probably
a pci_map_sg_merge() with hints that tries to merge and other
than that works like normal pci_map_sg()

-Andi
