Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269654AbUJMIPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269654AbUJMIPj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269655AbUJMIPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 04:15:39 -0400
Received: from mail-03.iinet.net.au ([203.59.3.35]:1197 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S269654AbUJMIPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 04:15:37 -0400
Message-ID: <416CE423.3000607@cyberone.com.au>
Date: Wed, 13 Oct 2004 18:15:31 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: Page cache write performance issue
References: <20041013054452.GB1618@frodo> <20041012231945.2aff9a00.akpm@osdl.org> <20041013063955.GA2079@frodo> <20041013000206.680132ad.akpm@osdl.org> <20041013172352.B4917536@wobbly.melbourne.sgi.com>
In-Reply-To: <20041013172352.B4917536@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan Scott wrote:

>On Wed, Oct 13, 2004 at 12:02:06AM -0700, Andrew Morton wrote:
>
>>Well something else if fishy: how can you possibly achieve only 4MB/sec? 
>>
>
>These are 1K writes too remember, so it feels a bit like we
>write 'em out one at a time, sync (though no O_SYNC, or fsync,
>or such involved here).  This is on an i686, so 4K pages, and
>using 4K filesystem blocksizes (both xfs and ext2).
>
>

Still shouldn't cause such a big slowdown. Seems like they
might be getting written off the end of the page reclaim
LRU (although in that case it is a bit odd that increasing
the dirty thresholds are improving performance).

I don't think we have any vmscan metrics for this... kswapd
definitely has become more active in 2.6.9-rc. If you're stuck
for ideas, try editing mm/vmscan.c:may_write_to_queue - comment
out the if(current_is_kswapd()) check.

It is a long shot though. Andrew probably has better ideas.

