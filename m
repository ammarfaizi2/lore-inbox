Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbVAZJER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbVAZJER (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVAZJER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:04:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59537 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262404AbVAZJDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:03:51 -0500
Date: Wed, 26 Jan 2005 10:03:38 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
Message-ID: <20050126090338.GF2751@suse.de>
References: <1106528219.867.22.camel@boxen> <20050124204659.GB19242@suse.de> <20050124125649.35f3dafd.akpm@osdl.org> <Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org> <20050126080152.GA2751@suse.de> <20050126001113.30933eef.akpm@osdl.org> <20050126084005.GB2751@suse.de> <20050126004419.26aab4a5.akpm@osdl.org> <20050126084743.GD2751@suse.de> <20050126005844.6880d195.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126005844.6880d195.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26 2005, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > This is my current situtation:
> > 
> > ...
> >  axboe@wiggum:/home/axboe $ cat /proc/meminfo 
> >  MemTotal:      1024992 kB
> >  MemFree:          9768 kB
> >  Buffers:         76664 kB
> >  Cached:         328024 kB
> >  SwapCached:          0 kB
> >  Active:         534956 kB
> >  Inactive:       224060 kB
> >  HighTotal:           0 kB
> >  HighFree:            0 kB
> >  LowTotal:      1024992 kB
> >  LowFree:          9768 kB
> >  SwapTotal:           0 kB
> >  SwapFree:            0 kB
> >  Dirty:            1400 kB
> >  Writeback:           0 kB
> >  Mapped:         464232 kB
> >  Slab:           225864 kB
> >  CommitLimit:    512496 kB
> >  Committed_AS:   773844 kB
> >  PageTables:       8004 kB
> >  VmallocTotal: 34359738367 kB
> >  VmallocUsed:       644 kB
> >  VmallocChunk: 34359737167 kB
> >  HugePages_Total:     0
> >  HugePages_Free:      0
> >  Hugepagesize:     2048 kB
> 
> OK.  There's rather a lot of anonymous memory there - 700M on the LRU, 300M
> pageache, 400M anon, 200M of slab.  You need some swapspace ;)

Just forget to swapon again after the recent fillmem cleanup, I do have
1G of swap usually on as well!

> What are the symptoms?  Slow to load applications?  Lots of paging?  Poor
> I/O speeds?

No paging, it basically never hits swap. Buffered io by itself seems to
run at full speed. But application startup seems sluggish. Hard to
explain really, but there's a noticable difference to the feel of usage
when it has just been force-pruned with fillmem and before.

-- 
Jens Axboe

