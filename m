Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSHNIiT>; Wed, 14 Aug 2002 04:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319015AbSHNIiT>; Wed, 14 Aug 2002 04:38:19 -0400
Received: from holomorphy.com ([66.224.33.161]:8372 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315279AbSHNIiS>;
	Wed, 14 Aug 2002 04:38:18 -0400
Date: Wed, 14 Aug 2002 01:40:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/21] scaled writeback throttling levels
Message-ID: <20020814084008.GO15685@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3D561478.F5173015@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D561478.F5173015@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2002 at 12:38:32AM -0700, Andrew Morton wrote:
> (resend)
> get_page_state() is showing up on profiles on some big machines.  It is
> a quite expensive function and it is being called too often.
> The patch replaces the hardwired RATELIMIT_PAGES with a calculated
> amount based on the amount of memory in the machine and the number of
> CPUs.

dbench 256 on 16x/16G numaq:

Throughput 50.5397 MB/sec (NB=63.1747 MB/sec  505.397 MBit/sec)  256 procs


c013bf74 5827289  74.4428     .text.lock.highmem
c013b7d0 797024   10.1819     kunmap_high
c013b5dc 482436   6.16306     kmap_high
c012e53c 87883    1.12269     file_read_actor
c0114820 65764    0.840126    scheduler_tick
c013bcbc 32857    0.419744    blk_queue_bounce
c013564c 31874    0.407186    rmqueue
c012f260 29442    0.376118    generic_file_write
c01113b8 28706    0.366715    smp_apic_timer_interrupt
c0143d1c 26503    0.338572    block_prepare_write
c0105394 20555    0.262587    default_idle
c012dec0 19920    0.254475    unlock_page
c014333c 17401    0.222295    __block_prepare_write
c013b558 16545    0.21136     flush_all_zero_pkmaps
c0135d28 14959    0.191099    page_cache_release
c013fb30 11923    0.152315    generic_file_llseek
c013429c 11059    0.141277    lru_cache_add
c0135b10 10277    0.131287    __alloc_pages
c0140124 9841     0.125717    vfs_write
c0143dc8 8732     0.11155     generic_commit_write
c012dcb4 8051     0.10285     add_to_page_cache
c016d620 7884     0.100717    ext2_get_block
