Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWCANlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWCANlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCANlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:41:53 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:15953 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751286AbWCANlx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:41:53 -0500
Date: Wed, 1 Mar 2006 14:41:23 +0100
From: Jens Axboe <axboe@suse.de>
To: Andy Chittenden <AChittenden@bluearc.com>
Cc: Andi Kleen <ak@suse.de>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Andrew Morton <akpm@osdl.org>, davej@redhat.com,
       linux-kernel@vger.kernel.org, lwoodman@redhat.com,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: adding swap workarounds oom - was: Re: Out of Memory: Killed process 16498 (java).
Message-ID: <20060301134123.GU4816@suse.de>
References: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89E85E0168AD994693B574C80EDB9C270393C104@uk-email.terastack.bluearc.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01 2006, Andy Chittenden wrote:
> with revised patch that does:
> 
>                 printk("sg%d: dma=%llx, dma_len=%u/%u, pfn=%lu\n", i,
> (unsigned long long) sg->dma_address, sg->dma_length, sg->offset,
> page_to_pfn(sg->page));

That is correct, thanks!

> hda: DMA table too small
> ide dma table, 255 entries, bounce pfn 1310720
> sg0: dma=81c8800, dma_len=4096/0, pfn=1296369

Still the same badness here, it's 2kb into a page so straddles two pages
for one entry.

> sg1: dma=81c9800, dma_len=4096/0, pfn=1292696
> sg2: dma=81ca800, dma_len=4096/0, pfn=1296278
> sg3: dma=81cb800, dma_len=4096/0, pfn=1296092
> sg4: dma=81cc800, dma_len=4096/0, pfn=1296090
> sg5: dma=81cd800, dma_len=4096/0, pfn=1296088
> sg6: dma=81ce800, dma_len=4096/0, pfn=1296086
> sg7: dma=81cf800, dma_len=4096/0, pfn=1296083

This one gets split.

> sg8: dma=81d0800, dma_len=4096/0, pfn=1296081
> sg9: dma=81d1800, dma_len=4096/0, pfn=1292712
> sg10: dma=81d2800, dma_len=4096/0, pfn=1297008
> sg11: dma=81d3800, dma_len=4096/0, pfn=1297063
> sg12: dma=81d4800, dma_len=4096/0, pfn=1297146
> sg13: dma=81d5800, dma_len=4096/0, pfn=1297193
> sg14: dma=81d6800, dma_len=4096/0, pfn=1297198
> sg15: dma=81d7800, dma_len=4096/0, pfn=1296363
> sg16: dma=81d8800, dma_len=4096/0, pfn=1304021
> sg17: dma=81d9800, dma_len=4096/0, pfn=1303030
> sg18: dma=81da800, dma_len=4096/0, pfn=1302151
> sg19: dma=81db800, dma_len=4096/0, pfn=1303979
> sg20: dma=81dc800, dma_len=4096/0, pfn=1306158
> sg21: dma=81dd800, dma_len=4096/0, pfn=1304015
> sg22: dma=81de800, dma_len=4096/0, pfn=1304957
> sg23: dma=81df800, dma_len=4096/0, pfn=1304001

This one as well.

> sg24: dma=81e0800, dma_len=4096/0, pfn=1292710
> sg25: dma=81e1800, dma_len=4096/0, pfn=1304035
> sg26: dma=81e2800, dma_len=4096/0, pfn=1303025
> sg27: dma=81e3800, dma_len=4096/0, pfn=1304019
> sg28: dma=81e4800, dma_len=4096/0, pfn=1302256
> sg29: dma=81e5800, dma_len=4096/0, pfn=1304738
> sg30: dma=81e6800, dma_len=4096/0, pfn=1302998
> sg31: dma=81e7800, dma_len=4096/0, pfn=1304148
> sg32: dma=81e8800, dma_len=4096/0, pfn=1304126
> sg33: dma=81e9800, dma_len=4096/0, pfn=1303079
> sg34: dma=81ea800, dma_len=4096/0, pfn=1302996
> sg35: dma=81eb800, dma_len=4096/0, pfn=1296243
> sg36: dma=81ec800, dma_len=4096/0, pfn=1306396
> sg37: dma=81ed800, dma_len=4096/0, pfn=1306474
> sg38: dma=81ee800, dma_len=4096/0, pfn=1295929
> sg39: dma=81ef800, dma_len=4096/0, pfn=1296156

And this. And a few more below. The end result is that we are about ~20
entries short.

Andi, any idea what is going on here? Why is this throwing up all of a
sudden??

-- 
Jens Axboe

