Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265898AbSKBIvL>; Sat, 2 Nov 2002 03:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265899AbSKBIvL>; Sat, 2 Nov 2002 03:51:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:48052 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265898AbSKBIvK>;
	Sat, 2 Nov 2002 03:51:10 -0500
Date: Sat, 2 Nov 2002 09:57:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
Message-ID: <20021102085728.GI807@suse.de>
References: <20021031134315.GC6549@suse.de> <20021101113401.GE8428@suse.de> <3DC2D72B.B4D5707E@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC2D72B.B4D5707E@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01 2002, Andrew Morton wrote:
> Jens Axboe wrote:
> > 
> > As expected, the stock version O(N) insertion scan really hurts. Even
> > with 128 requests per list, rbtree version is far superior. Once bigger
> > lists are used, there's just no comparison whatsoever.
> > 
> 
> Jens,  the tree just makes sense.

Agree

> Remember that we added the blk_grow_request_list() thing to 2.4 for
> the Dolphin SCI and other high-end hardware.  High throughput, long
> request queue, uh-oh.  Probably they're not using the stock merge/insert
> engine, but I bet someone will want to (Hi, Bill).
> 
> And we do know that for some classes of workloads, a larger request
> queue is worth a 10x boost in throughput.

Indeed

> The length of the request queue is really a very important VM and
> block parameter.  Varying it will have much less impact on the VM than
> it used to, but it is still there...

Well yes, cue long story about vm flushing acting up with longer
queues...

> When we get on to making the block tunables tunable, request queue
> length should be there, and we will be needing that tree.
> 
> Have I convinced you yet?

I think there are two sides to this. One is that some devices just dont
ever need long queues. For a floppy and cdrom, it's just a huge waste of
memory, they should always just limited to a few entries. Some devices
might benefit from nice long queues, we want to give them the option of
having them. That's the hardware side, and I suspect such hints are best
passed in by the drivers. Probably by specifying device class.

Then there's the vm side, where we don't want to waste large amounts of
memory on requests... So based on the class of a device, select a
default depth that fits with the current system.

But yes, definitely needs to be tweakable.

-- 
Jens Axboe

