Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUCABC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 20:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbUCABC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 20:02:27 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:16794 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262203AbUCABCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 20:02:25 -0500
Message-ID: <40428B95.1000600@cyberone.com.au>
Date: Mon, 01 Mar 2004 12:02:13 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Nikita Danilov <Nikita@Namesys.COM>
Subject: Re: 2.6.4-rc1-mm1
References: <20040229140617.64645e80.akpm@osdl.org>
In-Reply-To: <20040229140617.64645e80.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>-vm-dont-rotate-active-list.patch
>-vm-lru-info.patch
>-vm-shrink-zone.patch
>-vm-tune-throttle.patch
>-zone-balancing-fix.patch
>-zone-balancing-batching.patch
>+shrink_slab-precision-fix.patch
>+try_to_free_pages-shrink_slab-evenness.patch
>+vmscan-total_scanned-fix.patch
>+zone-balancing-fix-2.patch
>+vmscan-control-by-nr_to_scan-only.patch
>+vmscan-balance-zone-scanning-rates.patch
>+vmscan-dont-throttle-if-zero-max_scan.patch
>+kswapd-avoid-higher-zones.patch
>+vmscan-throttle-later.patch
>+slab-no-higher-order.patch
>
> Page reclaim rework
>
>

Thank you Andrew.

All these changes are nicely broken out, and they all look good. 
vmscan-control-by-nr_to_scan-only.patch and
vmscan-balance-zone-scanning-rates.patch are almost exactly what
I have here.

I had one addition which is to use a "refill_counter" for inactive
list scanning as well so the scanning is batched up now that we don't
round up the amount to be done. No observed benefits, but I imagine
it would lower the acquisition frequency of the lru locks in some
cases?

kswapd-avoid-higher-zones.patch looks good, and should solve the
incremental min problem which my solution didn't.

Should I start testing again, or are you still doing more to vmscan?
Nikita's dont-rotate-active-list.patch looks to be the only major
casualty. I found this patch pretty important, so I will definitely
like to demonstrate its benefits. One question remains, would you
accept the patch in its current form?

Nick

