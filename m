Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVC2Spb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVC2Spb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVC2Spa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 13:45:30 -0500
Received: from fmr23.intel.com ([143.183.121.15]:63409 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261292AbVC2SpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 13:45:06 -0500
Message-Id: <200503291844.j2TIiqg00464@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: "'Dave Jones'" <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: RE: [patch] optimization: defer bio_vec deallocation
Date: Tue, 29 Mar 2005 10:44:53 -0800
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU0NyTvIRa9PMdgQw2sXy7BjJLFGgAVTi/Q
In-Reply-To: <20050329081305.GG16636@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Dave Jones wrote on Monday, March 28, 2005 7:00 PM
> > If you can't publish results from that certain benchmark due its stupid
> > restrictions,

Forgot to thank Dave earlier for his understanding.  I can't even mention the
4 letter acronym for the benchmark.  Sorry, I did not make the rule nor have
the power to change the rule.


Jens Axboe wrote on Tuesday, March 29, 2005 12:13 AM
> Just _some_ results would be nice, Dave is right in that 'measurable
> gains' doesn't really say anything at all. Personally I would like to
> see a profile diff, for instance. And at least something like 'we get 1%
> gain bla bla'.

OK, performance gain for this industry db benchmark is 0.3%.


> Now, about the patch. I cannot convince myself that it is not deadlock
> prone, if someone waits for a bvec to be freed. Will slab reclaim always
> prune the bio slab and push the bvecs back into the mempool, or can
> there be cases where this doesn't happen?

So on allocation, I should always get memory from slab first, if fail then
get from mempool.  Mark the bvec appropriately where the memory came from.
On deallocating bio, check bvec flag and return memory if they came from
mempool.  Would that address your concern?


