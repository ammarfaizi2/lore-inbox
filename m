Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUCAI0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 03:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbUCAI0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 03:26:07 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:961 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262273AbUCAI0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 03:26:02 -0500
Message-ID: <4042F38B.8020307@matchmail.com>
Date: Mon, 01 Mar 2004 00:25:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: MM VM patches was: 2.6.3-mm4
References: <20040225185536.57b56716.akpm@osdl.org>
In-Reply-To: <20040225185536.57b56716.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> shrink_slab-for-all-zones.patch
>   vm: scan slab in response to highmem scanning
> 
> zone-balancing-fix.patch
>   vmscan: zone balancing fix

On 2.6.3 + [1] + nfsd-lofft.patch running on a 1GB ram file server.   I 
have noticed two related issues.

First, under 2.6.3 it averages about 90MB[2] anon memory, and 30MB with 
the -mm4 vm (the rest is in swap cache).  This could balance out on the 
normal non-idle week-day load though...

Second the -mm4 vm, there is a lot more swapping[3] going on during the 
daily updatedb, and backup runs that are performed on this machine.
I'd have to call this second issue a regression, but I want to run it a 
couple more days to see if it gets any better (unless you agree of course).

Mike

[1]
instrument-highmem-page-reclaim.patch
blk_congestion_wait-return-remaining.patch
vmscan-remove-priority.patch
kswapd-throttling-fixes.patch
vm-dont-rotate-active-list.patch
vm-lru-info.patch
vm-shrink-zone.patch
vm-tune-throttle.patch
shrink_slab-for-all-zones.patch
zone-balancing-fix.patch
zone-balancing-batching.patch

[2]
http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-memory.html

[3]
http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-swap.html
