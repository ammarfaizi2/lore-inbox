Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751773AbWCNIFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbWCNIFo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbWCNIFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:05:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45645 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751773AbWCNIFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:05:43 -0500
Date: Tue, 14 Mar 2006 09:05:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>,
       ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: [ck] Re: [PATCH] mm: Implement swap prefetching tweaks
Message-ID: <20060314080527.GC4419@suse.de>
References: <200603102054.20077.kernel@kolivas.org> <200603111650.23727.kernel@kolivas.org> <1142056851.7819.54.camel@homer> <200603111824.06274.kernel@kolivas.org> <1142063500.7605.13.camel@homer> <1142139283.25358.68.camel@mindpipe> <1142318403.4583.14.camel@homer> <1142319048.13256.103.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142319048.13256.103.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14 2006, Lee Revell wrote:
> On Tue, 2006-03-14 at 07:40 +0100, Mike Galbraith wrote:
> > On Sat, 2006-03-11 at 23:54 -0500, Lee Revell wrote:
> > > On Sat, 2006-03-11 at 08:51 +0100, Mike Galbraith wrote:
> > > > There used to be a pages in flight 'restrictor plate' in there that
> > > > would have probably helped this situation at least a little.  But in
> > > > any case, it sounds like you'll have to find a way to submit the IO in
> > > > itty bitty synchronous pieces. 
> > > 
> > > echo 64 > /sys/block/hd*/queue/max_sectors_kb
> > > 
> > > There is basically a straight linear relation between whatever you set
> > > this to and the maximum scheduling latency you see.  It was developed to
> > > solve the exact problem you are describing.
> > 
> > <head-scratching>
> > 
> > Is it possible that you mean pci latency?  I'm unable to measure any
> > scheduling latency > 5ms while pushing IO for all my little Barracuda
> > disk is worth.
> 
> It's only a big problem if LBA48 is in use which allows 32MB of IO to be
> in flight at once, this depends on the size of the drive.
> 
> What does that value default to?

Not quite true. Even if lba48 is active on the drive, we don't allow
more than 1MB per request. And nit picking a little, lba48 doesn't
always depend on the size of the drive, some drives smaller than 2^28
sectors also feature lba48 support.

-- 
Jens Axboe

