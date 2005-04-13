Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVDMKVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDMKVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 06:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDMKVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 06:21:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53157 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261290AbVDMKUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 06:20:50 -0400
Date: Wed, 13 Apr 2005 12:20:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [patch 6/9] blk: unplug later
Message-ID: <20050413102030.GO20044@suse.de>
References: <425BC262.1070500@yahoo.com.au> <425BC421.9010302@yahoo.com.au> <20050412125859.209beead.akpm@osdl.org> <425C7691.80605@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425C7691.80605@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13 2005, Nick Piggin wrote:
> Andrew Morton wrote:
> >Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >>get_request_wait needn't unplug the device immediately.
> >
> >
> >Probably.  But what if the get_request(q, rw, GFP_NOIO); did
> >some sleeping?
> >
> 
> It can't sleep unless it returns the request, because it
> is using mempool allocs. So any time it returns NULL, it
> hasn't slept.
> 
> But Jens would have a better idea of the correct behaviour.
> Jens, what do you think?

I think the patch makes sense. Additionally, it looks safer to unplug in
the loop as well - not just as an optimization for the first run, but
further loops of the code may need to trigger an unplug of the queue.

-- 
Jens Axboe

