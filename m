Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbTDVMQI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 08:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263111AbTDVMQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 08:16:08 -0400
Received: from holomorphy.com ([66.224.33.161]:56985 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263101AbTDVMQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 08:16:06 -0400
Date: Tue, 22 Apr 2003 05:27:47 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.68-1
Message-ID: <20030422122747.GD8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brute force merge to 2.5.68. Certain things are still being worked on
which are commanding my attention above the details of merge to current.
In order to boot, back out changes from pgcl-2.5.66 to mm/bootmem.c and
mm/page_alloc.c; proper fixups for the recent bootmem.c and page_alloc.c
changes that came from mainline are still being worked on. Some simple
asm-i386/pci.h pci_dac_dma_to_page() and pci_dac_dma_to_offset() fixes
are also pending, which are the usual substitutions.

TODO (in no particular order):
(1) merge the asm-i386/pci.h fixes
(2) fix up the bootmem stuff so current works
(3) fix up the memmap_init() stuff so current works
(4) PAGE_SIZE -align pkmap and kmap portions of fixmapspace to remove
	core dependencies on FIX_KMAP_END for aligning addresses.
(5) debug the scatter/gather kmapping calls for COW and anon pages
	to reduce internal fragmentation of pagecache
(6) find the problem with ext2 and 64KB PAGE_SIZE
(7) fix q->max_sectors < PAGE_SIZE
(8) audit the rest of drivers/

As usual, available from:

ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/

Results:
$ cat /proc/meminfo
MemTotal:     65949952 kB
MemFree:      65840448 kB
Buffers:          5472 kB
Cached:          15328 kB
SwapCached:          0 kB
Active:          37536 kB
Inactive:        12864 kB
HighTotal:    65198080 kB
HighFree:     65131968 kB
LowTotal:       751872 kB
LowFree:        708480 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          24320 kB
Slab:            13216 kB
Committed_AS:     7164 kB
PageTables:       2304 kB
VmallocTotal:   131080 kB
VmallocUsed:      4552 kB
VmallocChunk:   126528 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

LowFree remains above 700MB, as compared to under 200MB on mainline.

(I was fortunately able to collect these /proc/meminfo statistics
because some specific tests were scheduled on the hardware today.)

-- wli
