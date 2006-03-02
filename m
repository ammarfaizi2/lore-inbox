Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751047AbWCBNLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbWCBNLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 08:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWCBNLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 08:11:07 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:37924 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751047AbWCBNLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 08:11:04 -0500
Date: Thu, 2 Mar 2006 14:10:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Michael Monnerie <m.monnerie@zmi.at>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PCI-DMA: Out of IOMMU space on x86-64 (Athlon64x2), with solution
Message-ID: <20060302131043.GN4329@suse.de>
References: <200603020023.21916@zmi.at> <200603021316.38077.ak@suse.de> <20060302123033.GL4329@suse.de> <200603021409.25989.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603021409.25989.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02 2006, Andi Kleen wrote:
> On Thursday 02 March 2006 13:30, Jens Axboe wrote:
> 
> > I'd much rather prefer punting and letting the upper layer decide how to
> > handle it. Who knows, it may have to do something active like kicking
> > pending io in action at the controller level.
> 
> But how would you wait for new space to be available then?
> 
> You need at least a wait queue from the IOMMU code to hook into I suspect.

There are two cases as far as I can see:

- We have in-driver pending stuff, so we can just retry the operation
  later when some of that completes.
- We are unlucky enough that someone else holds all the resources, we
  have nothing to wait for.

The first case is easy, just punt and retry when some of your io
completes. The last case requires a way to wait on the iommu as you
describe, which the driver needs to do somewhere safe.

-- 
Jens Axboe

