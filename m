Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTDCXLk 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263562AbTDCXLk 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:11:40 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:45785 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263568AbTDCXLf convert rfc822-to-8bit 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 18:11:35 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Badari Pulavarty <pbadari@us.ibm.com>
To: andrew <akpm@digeo.com>
Subject: mounting 4000 disks
Date: Thu, 3 Apr 2003 15:20:52 -0800
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200304031520.52138.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been playing with testing 4000 disk support. (using 32bit dev_t).

I created 4000 disks using scsi_debug and mounted them.
We consumed 84MB of low memory by just mouting 4000 filesystems.
Out of 84MB lowmem 48MB is in slabs. 33 MB is used by buffers.

Here are the slabs which used more than 1MB. 
32MB is used by size-8192 slab. (super block ?)

Anything else interesting ? I guess i can try nobh mount option.

- Badari 

ext2_inode_cache        before:136 after:4136 diff:4000 size:480 incr:1920000
ext3_inode_cache        before:2776 after:10808 diff:8032 size:504 incr:4048128
radix_tree_node         before:932 after:5026 diff:4094 size:272 incr:1113568
inode_cache     before:144258 after:148260 diff:4002 size:364 incr:1456728
dentry_cache    before:148573 after:164611 diff:16038 size:172 incr:2758536
buffer_head     before:9027 after:48970 diff:39943 size:64 incr:2556352
size-8192       before:9 after:4009 diff:4000 size:8192 incr:32768000
size-512        before:12375 after:16408 diff:4033 size:524 incr:2113292

Before:
--------
MemTotal:      3883236 kB
MemFree:       3452404 kB
Buffers:          7012 kB
Cached:         140668 kB
SwapCached:          0 kB
Active:          47564 kB
Inactive:       107040 kB
HighTotal:     3014616 kB
HighFree:      2839104 kB
LowTotal:       868620 kB
LowFree:        613300 kB
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:              92 kB
Writeback:           0 kB
Mapped:          14052 kB
Slab:           236780 kB
Committed_AS:    12132 kB
PageTables:        352 kB
ReverseMaps:      1679

After:
------
MemTotal:      3883236 kB
MemFree:       3361564 kB
Buffers:         40512 kB
Cached:         147468 kB
SwapCached:          0 kB
Active:          49564 kB
Inactive:       145560 kB
HighTotal:     3014616 kB
HighFree:      2832064 kB
LowTotal:       868620 kB
LowFree:        529500 kB
SwapTotal:     2040244 kB
SwapFree:      2040244 kB
Dirty:            6252 kB
Writeback:           0 kB
Mapped:          14060 kB
Slab:           286952 kB
Committed_AS:    12136 kB
PageTables:        352 kB
ReverseMaps:      1681

