Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJUUja>; Mon, 21 Oct 2002 16:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261661AbSJUUj3>; Mon, 21 Oct 2002 16:39:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42444 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261659AbSJUUjZ>; Mon, 21 Oct 2002 16:39:25 -0400
Date: Mon, 21 Oct 2002 13:40:37 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: linux-mm mailing list <linux-mm@kvack.org>
Subject: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <302190000.1035232837@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My big NUMA box went OOM over the weekend and started killing things
for no good reason (2.5.43-mm2). Probably running some background
updatedb for locate thing, not doing any real work.

meminfo:

MemTotal:     16077728 kB
MemFree:      14950708 kB
MemShared:           0 kB
Buffers:           492 kB
Cached:         384976 kB
SwapCached:          0 kB
Active:         372608 kB
Inactive:        13380 kB
HighTotal:    15335424 kB
HighFree:     14949000 kB
LowTotal:       742304 kB
LowFree:          1708 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:           2248 kB
Slab:           724744 kB
Reserved:       570464 kB
Committed_AS:     1100 kB
PageTables:        140 kB
ReverseMaps:      1518

Big things out of slabinfo:

ext2_inode_cache  554556 554598    416 61622 61622    1 :  120   60
dentry_cache      2791320 2791320    160 116305 116305    1 :  248  124

By my reckoning, that's over 450Mb of dentry cache that's refusing to shrink
under pressure. ext2_inode_cache ain't exactly anorexic either. Hmmm ..... 
Any good ways to debug this?

M.



