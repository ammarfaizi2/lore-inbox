Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318192AbSHNIeP>; Wed, 14 Aug 2002 04:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSHNIeP>; Wed, 14 Aug 2002 04:34:15 -0400
Received: from holomorphy.com ([66.224.33.161]:7092 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318192AbSHNIeO>;
	Wed, 14 Aug 2002 04:34:14 -0400
Date: Wed, 14 Aug 2002 01:36:04 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/21] reduced locking in buffer.c
Message-ID: <20020814083604.GN15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D561473.40A53C0D@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D561473.40A53C0D@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:38:27AM -0700, Andrew Morton wrote:
> Resend.  Replace the buffer lru spinlock protection with
> local_irq_disable and a cross-CPU call to invalidate them.

dbench 256 on a 16x/16G numaq:

Throughput 50.4801 MB/sec (NB=63.1001 MB/sec  504.801 MBit/sec)  256 procs


c013bf74 6612685  74.0731     .text.lock.highmem
c013b7d0 802362   8.98779     kunmap_high
c013b5dc 593514   6.64834     kmap_high
c012f260 107218   1.20102     generic_file_write
c012e53c 85566    0.958481    file_read_actor
c0114820 82810    0.92761     scheduler_tick
c0105394 68424    0.766463    default_idle
c0143c3c 42473    0.475768    block_prepare_write
c01113b8 36678    0.410855    smp_apic_timer_interrupt
c013564c 33728    0.37781     rmqueue
c013bcbc 32868    0.368176    blk_queue_bounce
c0142e38 23095    0.258702    create_empty_buffers
c01143d8 22315    0.249965    load_balance
c012dec0 20193    0.226195    unlock_page
c014325c 19229    0.215397    __block_prepare_write
c013b558 16795    0.188132    flush_all_zero_pkmaps
c0135d28 15512    0.17376     page_cache_release
c013429c 10994    0.123151    lru_cache_add
c0135b10 10675    0.119578    __alloc_pages
c013fa50 9353     0.104769    generic_file_llseek
c0140044 8889     0.0995716   vfs_write
c012dcb4 8417     0.0942844   add_to_page_cache
