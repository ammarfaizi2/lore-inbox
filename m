Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVC3Kar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVC3Kar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 05:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVC3Kar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 05:30:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13534 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261858AbVC3Kab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 05:30:31 -0500
Date: Wed, 30 Mar 2005 12:30:22 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Dave Jones'" <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimization: defer bio_vec deallocation
Message-ID: <20050330103020.GF3851@suse.de>
References: <20050329081305.GG16636@suse.de> <200503291844.j2TIiqg00464@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291844.j2TIiqg00464@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> Jens Axboe wrote on Tuesday, March 29, 2005 12:13 AM
> > Just _some_ results would be nice, Dave is right in that 'measurable
> > gains' doesn't really say anything at all. Personally I would like to
> > see a profile diff, for instance. And at least something like 'we get 1%
> > gain bla bla'.
> 
> OK, performance gain for this industry db benchmark is 0.3%.

OK.

> > Now, about the patch. I cannot convince myself that it is not deadlock
> > prone, if someone waits for a bvec to be freed. Will slab reclaim always
> > prune the bio slab and push the bvecs back into the mempool, or can
> > there be cases where this doesn't happen?
> 
> So on allocation, I should always get memory from slab first, if fail then
> get from mempool.  Mark the bvec appropriately where the memory came
> from.  On deallocating bio, check bvec flag and return memory if they
> came from mempool.  Would that address your concern?

Hmmm no, I don't think we are talking about the same thing (what you
describe is what currently happens anyways, this is how mempools work).
Am I guarenteed to get a bio with a bvec already assigned when doing a
bio allocation, if one exists?

-- 
Jens Axboe

