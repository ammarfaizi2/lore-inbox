Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbULHNtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbULHNtV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbULHNtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:49:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54657 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261211AbULHNtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:49:12 -0500
Date: Wed, 8 Dec 2004 14:48:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041208134811.GA3033@suse.de>
References: <20041202195232.GA26695@suse.de> <20041208003736.GD16322@dualathlon.random> <1102467253.8095.10.camel@npiggin-nld.site> <20041208013732.GF16322@dualathlon.random> <20041207180033.6699425b.akpm@osdl.org> <20041208022020.GH16322@dualathlon.random> <20041207182557.23eed970.akpm@osdl.org> <1102473213.8095.34.camel@npiggin-nld.site> <20041208065858.GH3035@suse.de> <1102490086.8095.63.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102490086.8095.63.camel@npiggin-nld.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08 2004, Nick Piggin wrote:
> On Wed, 2004-12-08 at 07:58 +0100, Jens Axboe wrote:
> > On Wed, Dec 08 2004, Nick Piggin wrote:
> > > On Tue, 2004-12-07 at 18:25 -0800, Andrew Morton wrote:
> 
> > > I think we could detect when a disk asks for more than, say, 4
> > > concurrent requests, and in that case turn off read anticipation
> > > and all the anti-starvation for TCQ by default (with the option
> > > to force it back on).
> > 
> > CFQ only allows a certain depth a the hardware level, you can control
> > that. I don't think you should drop the AS behaviour in that case, you
> > should look at when the last request comes in and what type it is.
> > 
> > With time sliced cfq I'm seeing some silly SCSI disk behaviour as well,
> > it gets harder to get good read bandwidth as the disk is trying pretty
> > hard to starve me. Maybe killing write back caching would help, I'll
> > have to try.
> > 
> 
> I "fixed" this in AS. It gets (or got, last time we checked, many months
> ago) pretty good read latency even with a big write and a very large
> tag depth.

This problem was also caused by the dispatch sort bug. So you were
right, it was 'some little bug' in the code :)

-- 
Jens Axboe

