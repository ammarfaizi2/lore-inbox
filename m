Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVC2IdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVC2IdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVC2IbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 03:31:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:53223 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262183AbVC2INL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 03:13:11 -0500
Date: Tue, 29 Mar 2005 10:13:06 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Dave Jones'" <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] optimization: defer bio_vec deallocation
Message-ID: <20050329081305.GG16636@suse.de>
References: <20050329025932.GC435@redhat.com> <200503290307.j2T37Yg25879@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503290307.j2T37Yg25879@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> On Mon, Mar 28, 2005 at 06:38:23PM -0800, Chen, Kenneth W wrote:
> > We have measured that the following patch give measurable performance gain
> > for industry standard db benchmark.  Comments?
> 
> Dave Jones wrote on Monday, March 28, 2005 7:00 PM
> > If you can't publish results from that certain benchmark due its stupid
> > restrictions, could you also try running an alternative benchmark that
> > you can show results from ?
> >
> > These nebulous claims of 'measurable gains' could mean anything.
> > I'm assuming you see a substantial increase in throughput, but
> > how much is it worth in exchange for complicating the code?
> 
> Are you asking for micro-benchmark result?  I had a tough time last time
> around when I presented micro-benchmark result on LKML.  I got kicked in
> the butt for lack of evidence with performance data running real bench on
> real hardware.
> 
> I guess either way, I'm bruised one way or the other.

Just _some_ results would be nice, Dave is right in that 'measurable
gains' doesn't really say anything at all. Personally I would like to
see a profile diff, for instance. And at least something like 'we get 1%
gain bla bla'.

Now, about the patch. I cannot convince myself that it is not deadlock
prone, if someone waits for a bvec to be freed. Will slab reclaim always
prune the bio slab and push the bvecs back into the mempool, or can
there be cases where this doesn't happen?

-- 
Jens Axboe

