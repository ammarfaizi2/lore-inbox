Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbVKXIEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbVKXIEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 03:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVKXIEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 03:04:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:44330 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1161044AbVKXIEf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 03:04:35 -0500
Date: Thu, 24 Nov 2005 08:04:39 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel BUG at mm/rmap.c:491
In-Reply-To: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0511240754190.5688@goblin.wat.veritas.com>
References: <200511232256.jANMuGg20547@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Nov 2005 08:04:28.0961 (UTC) FILETIME=[B1AA3110:01C5F0CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Chen, Kenneth W wrote:
> Has people seen this BUG_ON before?  On 2.6.15-rc2, x86-64.
> 
> Bad page state at free_hot_cold_page (in process 'sh', page ffff81000482dde8)
> flags:0x8000000000000000 mapping:0000000000000000 mapcount:1 count:0
> Bad page state at free_hot_cold_page (in process 'sh', page ffff8100049d0f78)
> flags:0x8000000000000000 mapping:0000000000000000 mapcount:1 count:0
> Bad page state at free_hot_cold_page (in process 'sh', page ffff8100049d0f40)
> flags:0x8000000000000004 mapping:0000000000000000 mapcount:1 count:0
> Kernel BUG at mm/swap.c:218
> Kernel BUG at mm/rmap.c:491

Neither mm/rmap.c (page_remove_rmap) nor mm/swap.c (put_page_testzero)
BUG is interesting in this case, they're just side-effects of trying to
recover from the preceding "Bad page state"s.

Which are interesting.  Not at all the same case as the many recently
reported while we were fixing up PageReserved removal cases; though
yours will probably be related.

It could conceivably be an effect of a DRM pci_alloc_consistent issue
which Dave Airlie spotted yesterday; but not a typical case of it,
and I'm probably only thinking of that one because it's uppermost.

Please send your .config (I hope it's tailored somewhat to your machine,
rather than an allyesconfig or the like?) and bootup dmesg, in case they
help to narrow the search.  You were just running straight 2.6.15-rc2,
no additional patches?  Doing anything interesting just before this
happened?

Thanks,
Hugh
