Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261893AbSJDVU0>; Fri, 4 Oct 2002 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262074AbSJDVU0>; Fri, 4 Oct 2002 17:20:26 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:21633 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261893AbSJDVUZ>;
	Fri, 4 Oct 2002 17:20:25 -0400
Message-ID: <3D9E0760.8040507@colorfullife.com>
Date: Fri, 04 Oct 2002 23:25:52 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       mbligh@aracnet.com
Subject: Re: [PATCH] patch-slab-split-03-tail
References: <Pine.LNX.4.33L2.0210041321370.20655-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> 
> Did you look at http://www.usenix.org/events/usenix01/bonwick.html
> for it?
> 
Thanks for the link - that describes the newer, per-cpu extensions to 
slab. Quite similar to the Linux implementation.

The text also contains a link to the original paper:

http://www.usenix.org/publications/library/proceedings/bos94/bonwick.html

Bonwick used one partially sorted list [as linux in 2.2, and 2.4.<10], 
instead of seperate lists - move tail was not an option.

The new paper contains one interesting comment:
<<<<<<<
An object cache's CPU layer contains per-CPU state that must be 
protected either by per-CPU locking or by disabling interrupts. We 
selected per-CPU locking for several reasons:
[...]
  x    Performance. On most modern processors, grabbing an uncontended 
lock is cheaper than modifying the processor interrupt level.
<<<<<<<<

Which cpus have slow local_irq_disable() implementations? At least for 
my Duron, this doesn't seem to be the case [~ 4 cpu cycles for cli]


--
	Manfred

