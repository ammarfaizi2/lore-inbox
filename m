Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318213AbSHNIjW>; Wed, 14 Aug 2002 04:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319078AbSHNIjW>; Wed, 14 Aug 2002 04:39:22 -0400
Received: from holomorphy.com ([66.224.33.161]:10676 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318213AbSHNIjV>;
	Wed, 14 Aug 2002 04:39:21 -0400
Date: Wed, 14 Aug 2002 01:41:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 5/21] pagevec infrastructure
Message-ID: <20020814084112.GP15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D561482.AC248312@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D561482.AC248312@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:38:42AM -0700, Andrew Morton wrote:
> This is the first patch in a series of eight which address
> pagemap_lru_lock contention, and which simplify the VM locking
> hierarchy.
> Most testing has been done with all eight patches applied, so it would
> be best not to cherrypick, please.

dbench 256 on a 16x/16G numaq:

Throughput 50.3639 MB/sec (NB=62.9549 MB/sec  503.639 MBit/sec)  256 procs


c013c444 7514467  78.18       .text.lock.highmem
c013baac 584912   6.08539     kmap_high
c013bca0 556734   5.79223     kunmap_high
c012f260 133797   1.39202     generic_file_write
c012e53c 85433    0.88884     file_read_actor
c0114820 72361    0.752839    scheduler_tick
c01441ec 61757    0.642516    block_prepare_write
c013c18c 46977    0.488746    blk_queue_bounce
c0105394 46657    0.485417    default_idle
c01113b8 37263    0.387682    smp_apic_timer_interrupt
c0135afc 35618    0.370567    rmqueue
c014380c 26328    0.273915    __block_prepare_write
c012dec0 19238    0.200151    unlock_page
c01405f4 17391    0.180935    vfs_write
c01433e8 17382    0.180841    create_empty_buffers
c01361d8 16797    0.174755    page_cache_release
c01143d8 16727    0.174027    load_balance
c0136632 16378    0.170396    .text.lock.page_alloc
c013ba28 12628    0.131381    flush_all_zero_pkmaps
c013429c 10114    0.105225    lru_cache_add
c016de8c 9700     0.100918    ext2_prepare_write
c0135820 7610     0.079174    __free_pages_ok
