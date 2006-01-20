Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWATIKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWATIKp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 03:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWATIKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 03:10:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48421 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750718AbWATIKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 03:10:44 -0500
Date: Fri, 20 Jan 2006 09:12:32 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Jones <davej@redhat.com>, AChittenden@bluearc.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com
Subject: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060120081231.GE4213@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270355601F@uk-email.terastack.bluearc.com> <20060119194836.GM21663@redhat.com> <20060119141515.5f779b8d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119141515.5f779b8d.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19 2006, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> >
> > On Thu, Jan 19, 2006 at 03:11:45PM -0000, Andy Chittenden wrote:
> >  > DMA free:20kB min:24kB low:28kB high:36kB active:0kB inactive:0kB
> >  > present:12740kB pages_scanned:4 all_unreclaimable? yes
> > 
> > Note we only scanned 4 pages before we gave up.
> > Larry Woodman came up with this patch below that clears all_unreclaimable
> > when in two places where we've made progress at freeing up some pages
> > which has helped oom situations for some of our users.
> 
> That won't help - there are exactly zero pages on ZONE_DMA's LRU.
> 
> The problem appears to be that all of the DMA zone has been gobbled up by
> the BIO layer.  It seems quite inappropriate that a modern 64-bit machine
> is allocating tons of disk I/O pages from the teeny ZONE_DMA.  I'm
> suspecting that someone has gone and set a queue's ->bounce_gfp to the wrong
> thing.
> 
> Jens, would you have time to investigate please?

Certainly, I'll get this tested and fixed this afternoon. Andy, what are
you running that uses SG_IO - cd ripping, burning, something else?

-- 
Jens Axboe

