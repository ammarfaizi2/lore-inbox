Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSKAT1t>; Fri, 1 Nov 2002 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSKAT1t>; Fri, 1 Nov 2002 14:27:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:20117 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265725AbSKAT1o>;
	Fri, 1 Nov 2002 14:27:44 -0500
Message-ID: <3DC2D72B.B4D5707E@digeo.com>
Date: Fri, 01 Nov 2002 11:34:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: rbtree scores (was Re: [patch] deadline-ioscheduler rb-tree sort)
References: <20021031134315.GC6549@suse.de> <20021101113401.GE8428@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Nov 2002 19:34:06.0760 (UTC) FILETIME=[A4830280:01C281DD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> As expected, the stock version O(N) insertion scan really hurts. Even
> with 128 requests per list, rbtree version is far superior. Once bigger
> lists are used, there's just no comparison whatsoever.
> 

Jens,  the tree just makes sense.

Remember that we added the blk_grow_request_list() thing to 2.4 for
the Dolphin SCI and other high-end hardware.  High throughput, long
request queue, uh-oh.  Probably they're not using the stock merge/insert
engine, but I bet someone will want to (Hi, Bill).

And we do know that for some classes of workloads, a larger request
queue is worth a 10x boost in throughput.

The length of the request queue is really a very important VM and
block parameter.  Varying it will have much less impact on the VM than
it used to, but it is still there...

When we get on to making the block tunables tunable, request queue
length should be there, and we will be needing that tree.

Have I convinced you yet?
