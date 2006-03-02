Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWCBMbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWCBMbq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 07:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWCBMbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 07:31:46 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57693 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932231AbWCBMbq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 07:31:46 -0500
Date: Thu, 2 Mar 2006 13:31:26 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Michael Monnerie <m.monnerie@zmi.at>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302123125.GM4329@suse.de>
References: <200603020023.21916@zmi.at> <200603021316.38077.ak@suse.de> <4406E226.4050806@pobox.com> <200603021326.33220.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021326.33220.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 13:16, Jeff Garzik wrote:
> 
> > > Yes I've been thinking about adding a new sleeping interface to the IOMMU
> > > that would block for new space to handle this. If I did that - would
> > > libata be able to use it?
> >
> > No :(  We map inside a spin_lock_irqsave.
> 
> Would it be easily possible to change that or is it difficult?
> 
> Also with the blocking interface there might be possible deadlock issues 
> because it will be essentially similar to allocating memory during IO.
> But I think it's probably safe.

For most cases, perhaps. But it's a nasty interface. It works for eg
mempools because of the way they are designed, but you simply have to
allow the caller the option of doing something in case we cannot map.

-- 
Jens Axboe

