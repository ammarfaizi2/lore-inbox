Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUGNM4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUGNM4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267377AbUGNM4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:56:33 -0400
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:5792 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S267376AbUGNM4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:56:31 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Can't make use of swap memory in 2.6.7-bk19
References: <m2brir9t6d.fsf@telia.com> <40ECADF8.7010207@yahoo.com.au>
	<m2fz82hq8c.fsf@telia.com> <20040708012005.6232a781.akpm@osdl.org>
	<40ED049B.2020406@yahoo.com.au>
	<Pine.LNX.4.58.0407081126360.3104@telia.com>
	<20040714052010.GE3411@holomorphy.com> <m2u0wayisp.fsf@telia.com>
	<20040714105713.GP3411@holomorphy.com>
From: Peter Osterlund <petero2@telia.com>
Date: 14 Jul 2004 14:55:57 +0200
In-Reply-To: <20040714105713.GP3411@holomorphy.com>
Message-ID: <m2hdsabvdu.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> William Lee Irwin III <wli@holomorphy.com> writes:
> >> Probably not what will get merged, but does the following brutal hack
> >> do anything for you?
> 
> On Wed, Jul 14, 2004 at 12:39:18PM +0200, Peter Osterlund wrote:
> > Doesn't help. I added some printk's to your patch and got this:
> 
> Brilliant, about zero dirty. Okay, I'm desperate. Could you try running
> this and see what it spews when the OOM kill happens?

Out of memory: pid 2655, comm xterm        , gfp 0x466, order 0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 28, high 84, batch 14
cpu 0 cold: low 0, high 28, batch 14
HighMem per-cpu: empty

Free pages:        1820kB (0kB HighMem)
Active:754 inactive:56177 dirty:0 writeback:3427 unstable:0 free:455 slab:2880 mapped:890 pagetables:384
DMA free:884kB min:28kB low:56kB high:84kB active:24kB inactive:11124kB present:16384kB
protections[]: 14 252 252
Normal free:936kB min:476kB low:952kB high:1428kB active:2992kB inactive:213584kB present:245248kB
protections[]: 0 238 238
HighMem free:0kB min:128kB low:256kB high:384kB active:0kB inactive:0kB present:0kB
protections[]: 0 0 0
DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 884kB
Normal: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
HighMem: empty
Swap cache: add 57227, delete 1309, find 331/331, race 0+0
 [<c0131d69>] out_of_memory+0xb2/0x105
 [<c013a0bd>] try_to_free_pages+0x143/0x190
 [<c0132bae>] __alloc_pages+0x1c3/0x347
 [<c013595b>] do_page_cache_readahead+0x13b/0x197
 [<c012fb50>] filemap_nopage+0x2d8/0x371
 [<c013cfe9>] do_no_page+0xb7/0x30f
 [<c013d431>] handle_mm_fault+0xd6/0x171
 [<c0111076>] do_page_fault+0x346/0x548
 [<c01d5868>] __copy_to_user_ll+0x48/0x6c
 [<c015c7c3>] sys_select+0x228/0x4b0
 [<c0110d30>] do_page_fault+0x0/0x548
 [<c01040a1>] error_code+0x2d/0x38
Out of Memory: Killed process 2666 (memalloc2).

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
