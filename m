Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264883AbTBJKGl>; Mon, 10 Feb 2003 05:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264885AbTBJKGl>; Mon, 10 Feb 2003 05:06:41 -0500
Received: from [195.223.140.107] ([195.223.140.107]:62849 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S264883AbTBJKGk>;
	Mon, 10 Feb 2003 05:06:40 -0500
Date: Mon, 10 Feb 2003 11:15:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@digeo.com>, piggin@cyberone.com.au,
       jakob@unthought.net, david.lang@digitalinsight.com,
       riel@conectiva.com.br, ckolivas@yahoo.com.au,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.4.20-ck3 / aa / rmap with contest]
Message-ID: <20030210101539.GS31401@dualathlon.random>
References: <20030209203343.06608eb3.akpm@digeo.com> <20030210045107.GD1109@unthought.net> <3E473172.3060407@cyberone.com.au> <20030210073614.GJ31401@dualathlon.random> <3E47579A.4000700@cyberone.com.au> <20030210080858.GM31401@dualathlon.random> <20030210001921.3a0a5247.akpm@digeo.com> <20030210085649.GO31401@dualathlon.random> <20030210010937.57607249.akpm@digeo.com> <3E4779DD.7080402@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E4779DD.7080402@namesys.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 01:07:25PM +0300, Hans Reiser wrote:
> Andrew Morton wrote:
> 
> >
> >Large directories tend to be spread all around the disk anyway.  And I've
> >never explicitly tested for any problems which the loss of readahead might
> >have caused ext2.  Nor have I tested inode table readahead.  Guess I 
> >should.
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> > 
> >
> readahead seems to be less effective for non-sequential objects.  Or at 

yes, this is why I said readahead matters mostly to generate the big dma
commands, so if the object is sequential it will be served by the
lowlevel with a single dma using SG. this is also why when I moved the
high dma limit of scsi to 512k (from 128k IIRC) I got such a relevant
throughput improvement. Also watch the read speed in my tree compared to
2.4 and 2.5 in bigbox.html from Randy (bonnie shows it well).

> least, you don't get the order of magnitude benefit from doing only one 
> seek, you only get the better elevator scheduling from having more 
> things in the elevator, which isn't such a big gain.

Agreed.

Andrea
