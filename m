Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751798AbWAJAnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751798AbWAJAnp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 19:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWAJAnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 19:43:45 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:6413 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751798AbWAJAno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 19:43:44 -0500
Date: Tue, 10 Jan 2006 01:43:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dieter =?iso-8859-1?Q?St=FCken?= <stueken@conterra.de>
Cc: dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Oops: dm_mirror on 2.6.14
Message-ID: <20060110004343.GW3774@stusta.de>
References: <43763521.20302@conterra.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43763521.20302@conterra.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 07:32:01PM +0100, Dieter Stüken wrote:
> I run into trouble while moving some LVs. Looks very much the same
> as http://www.redhat.com/archives/dm-devel/2005-June/msg00162.html
> to me. The first Oops arise accessing some data during pvmove, as
> I unfortunately did not unmount the LVs. Meanwhile I recognized
> my kernel (2.6.12.2) still suffered from the bio_clone bug
> http://www.redhat.com/archives/dm-devel/2005-July/msg00086.html,
> but I can't tell if this really caused the problem. After all,
> I get an Oops now, whenever I try to activate my lvm, as dm-mirror
> is still active because the pvmove did not finish :-(
> 
> The interesting thing is, that even my new 2.6.14 kernel fails
> to activate the mirrored volume. I may either abort the pvmove or
> restore the VG to its previous state, but then the opportunity
> to analyze and fix the problem may be lost.
> 
> Here comes the Oops of my current 2.6.14 kernel (x86/PIII):


Is this problem still present in kernel 2.6.15?


> Unable to handle kernel paging request at virtual address d0a47000
>  printing eip:
> d0a339a7
> *pde = 0127b067
> Oops: 0000 [#1]
> Modules linked in: dm_mirror dm_mod sata_promise libata pdc202xx_old 
> via82cxxx ...
> CPU:    0
> EIP:    0060:[<d0a339a7>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.14-default-gf2c84c0e)
> EIP is at core_in_sync+0x7/0x20 [dm_mirror]
> eax: c958bdc0   ebx: d0a41000   ecx: 00000000   edx: 00030000
> esi: cffc2900   edi: c97657e0   ebp: 00000000   esp: c84fda3c
> ds: 007b   es: 007b   ss: 0068
> Process udev_volume_id (pid: 12044, threadinfo=c84fc000 task=c554e5c0)
> Stack: d0a38380 d0a35651 00000000 0000000a 00030000 00000000 c01608a9 
> c6a3f740
>        c958be40 c6a3f738 cffc2900 d0a310b8 d087837c 0c000000 00000000 
>        cffc2180
>        c6a3f748 c84fdae8 d0878618 00000000 00000001 00000008 00000000 
>        00000000
> Call Trace:
>  [<d0a35651>] mirror_map+0xa1/0x150 [dm_mirror]
>  [<c01608a9>] bio_clone+0xc9/0xd0
>  [<d087837c>] __map_bio+0x3c/0x100 [dm_mod]
>  [<d0878618>] __clone_and_map+0xc8/0x320 [dm_mod]
>  [<c0140f1a>] mempool_alloc+0x2a/0xc0
>  [<d0878917>] __split_bio+0xa7/0x120 [dm_mod]
>  [<d08789f6>] dm_request+0x66/0x90 [dm_mod]
>  [<c025772b>] generic_make_request+0xeb/0x170
>  [<c01608a9>] bio_clone+0xc9/0xd0
>  [<d087837c>] __map_bio+0x3c/0x100 [dm_mod]
>  [<d0878618>] __clone_and_map+0xc8/0x320 [dm_mod]
>  [<c0140f1a>] mempool_alloc+0x2a/0xc0
>  [<d0878917>] __split_bio+0xa7/0x120 [dm_mod]
>  [<d08789f6>] dm_request+0x66/0x90 [dm_mod]
>  [<c025772b>] generic_make_request+0xeb/0x170
>  [<c0257800>] submit_bio+0x50/0xe0
>  [<c01605e9>] bio_alloc_bioset+0xe9/0x1e0
>  [<c015ff6d>] submit_bh+0x13d/0x190
>  [<c015ef2a>] block_read_full_page+0x30a/0x320
>  [<c0162e90>] blkdev_get_block+0x0/0x80
>  [<c0144aec>] read_pages+0x4c/0x100
>  [<c014247c>] __alloc_pages+0x17c/0x410
>  [<c0144c44>] __do_page_cache_readahead+0xa4/0x100
>  [<c0144df1>] blockable_page_cache_readahead+0x51/0xd0
>  [<c0145031>] page_cache_readahead+0x101/0x1a0
>  [<c013e516>] do_generic_mapping_read+0x326/0x490
>  [<c013e912>] __generic_file_aio_read+0x1a2/0x210
>  [<c013e680>] file_read_actor+0x0/0xf0
>  [<c013ea85>] generic_file_read+0x95/0xc0
>  [<c012ea20>] autoremove_wake_function+0x0/0x50
>  [<c015b947>] vfs_read+0xd7/0x180
>  [<c015bcd1>] sys_read+0x41/0x70
>  [<c0102f29>] syscall_call+0x7/0xb
> 
> 
> 
> -- 
> Dieter Stüken, con terra GmbH, Münster
>     stueken@conterra.de
>     http://www.conterra.de/
>     (0)251-7474-501
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

