Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbVHaHdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbVHaHdE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVHaHdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:33:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60346 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932445AbVHaHdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:33:02 -0400
Date: Wed, 31 Aug 2005 09:33:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050831073307.GI4018@suse.de>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234823.GF780@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830234823.GF780@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31 2005, Nathan Scott wrote:
> Hi Jens,
> 
> On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> > Ok, updated version.
> 
> One thing I found a bit awkward was the way its putting all inodes
> in the root of the relayfs namespace, with the cpuid tacked on the
> end of the bdevname - I was a bit confused at first when a trace of
> sdd on my 4P box spontaneously created files for "partitions" sdd0,
> sdd1, sdd2, and sdd3 ;).

Yeah I agree, it's not very logical.

> 
> I suppose if many more users of relayfs spring into existance, this
> is going to get quite ugly.  Below is a patch that aligns the names
> to the conventions used in sysfs; so, for example, when running two
> traces simultaneously on /dev/sdd and /dev/sdb, instead of this:
> 
> # find /relay
> /relay
> /relay/sdd3
> /relay/sdd2
> /relay/sdd1
> /relay/sdd0
> /relay/sdb3
> /relay/sdb2
> /relay/sdb1
> /relay/sdb0
> 
> it now uses this...
> 
> # find /relay
> /relay
> /relay/block
> /relay/block/sdd
> /relay/block/sdd/trace3
> /relay/block/sdd/trace2
> /relay/block/sdd/trace1
> /relay/block/sdd/trace0
> /relay/block/sdb
> /relay/block/sdb/trace3
> /relay/block/sdb/trace2
> /relay/block/sdb/trace1
> /relay/block/sdb/trace0
> 
> and does the correct dynamic setup and teardown of the hierarchy
> as the userspace tool starts and stops tracing.  I had to modify
> the relayfs rmdir code a bit to make this work properly, I'll
> send a separate patch for that shortly.

It makes sense to me, please work with the relayfs people to get this
integrated. I really don't want to carry any extra stuff for relayfs
around.

> > http://www.kernel.org/pub/linux/kernel/people/axboe/tools/blktrace.c
> > 
> > has been updated as well, the protocol version was increased to
> > accomodate the trace structure changes.
> 
> I have the associated userspace change for this, as well as several
> other fixes and tweaks for your tool - if you could slap a copyright
> and license notice onto that source (pretty please? :) I'll send 'em
> right along.

You bet, I'll add it right away.

-- 
Jens Axboe

