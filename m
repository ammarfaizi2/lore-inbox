Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266250AbUH1QrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266250AbUH1QrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 12:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267475AbUH1QjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 12:39:19 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:37637 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267363AbUH1Qhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 12:37:45 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Adrian Bunk <bunk@fs.tum.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch][3/3] mm/ BUG -> BUG_ON conversions
Date: Sat, 28 Aug 2004 19:32:05 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040828151137.GA12772@fs.tum.de> <20040828151837.GD12772@fs.tum.de>
In-Reply-To: <20040828151837.GD12772@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408281932.05964.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 August 2004 18:18, Adrian Bunk wrote:
> The patch below does BUG -> BUG_ON conversions in mm/ .
>
> diffstat output:
>  mm/bootmem.c    |    6 ++----
>  mm/filemap.c    |    6 ++----
>  mm/highmem.c    |   15 +++++----------
>  mm/memory.c     |   12 ++++--------
>  mm/mempool.c    |    5 +++--
>  mm/mmap.c       |   12 ++++--------
>  mm/mprotect.c   |    3 +--
>  mm/msync.c      |    3 +--
>  mm/page_alloc.c |    3 +--
>  mm/pdflush.c    |    3 +--
>  mm/shmem.c      |    3 +--
>  mm/slab.c       |   30 ++++++++++--------------------
>  mm/swap.c       |   12 ++++--------
>  mm/swap_state.c |    6 ++----
>  mm/swapfile.c   |    6 ++----
>  mm/vmalloc.c    |    3 +--
>  mm/vmscan.c     |   18 ++++++------------
>  17 files changed, 50 insertions(+), 96 deletions(-)
>
>
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
>
> --- linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c.old	2004-08-28
> 16:25:18.000000000 +0200 +++
> linux-2.6.9-rc1-mm1-full-3.4/mm/bootmem.c	2004-08-28 16:26:48.000000000
> +0200 @@ -125,8 +125,7 @@
>  	sidx = start - (bdata->node_boot_start/PAGE_SIZE);
>
>  	for (i = sidx; i < eidx; i++) {
> -		if (unlikely(!test_and_clear_bit(i, bdata->node_bootmem_map)))
> -			BUG();
> +		BUG_ON(!test_and_clear_bit(i, bdata->node_bootmem_map));
>  	}
>  }
>
> @@ -246,8 +245,7 @@
>  	 * Reserve the area now:
>  	 */
>  	for (i = start; i < start+areasize; i++)
> -		if (unlikely(test_and_set_bit(i, bdata->node_bootmem_map)))
> -			BUG();
> +		BUG_ON(test_and_set_bit(i, bdata->node_bootmem_map));

BUG_ON is like assert(). It may be #defined to nothing.
Do not place expression with side effects into it.
--
vda

