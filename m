Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVCITFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVCITFd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 14:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVCITD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 14:03:26 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:30607 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262190AbVCIS7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 13:59:38 -0500
Subject: inode cache, dentry cache, buffer heads usage
From: Badari Pulavarty <pbadari@us.ibm.com>
To: ext2-devel <ext2-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1110394558.24286.203.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Mar 2005 10:55:58 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We have a 8-way P-III, 16GB RAM running 2.6.8-1. We use this as
our server to keep source code, cscopes and do the builds.
This machine seems to slow down over the time. One thing we
keep noticing is it keeps running out of lowmem. Most of 
the lowmem is used for ext3 inode cache + dentry cache +
bufferheads + Buffers. So we did 2:2 split - but it improved
thing, but again run into same issues.

So, why is these slab cache are not getting purged/shrinked even
under memory pressure ? (I have seen lowmem as low as 6MB). What
can I do to keep the machine healthy ?

Thanks,
Badari

Meminfo:
========

$ cat /proc/meminfo
MemTotal:     16377076 kB
MemFree:       9400604 kB
Buffers:        577368 kB
Cached:        4002012 kB
SwapCached:          0 kB
Active:        2152196 kB
Inactive:      3578624 kB
HighTotal:    14548952 kB
HighFree:      9387328 kB
LowTotal:      1828124 kB
LowFree:         13276 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         301432 kB
Slab:          1227268 kB
Committed_AS:   695920 kB
PageTables:       5684 kB
VmallocTotal:   114680 kB
VmallocUsed:       312 kB
VmallocChunk:   114368 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB

Slabinfo (top users):
=====================

ext3_inode_cache  1405201 1615312    480    8    1 : tunables   54  
27    8 : slabdata 201914 201914      0
dentry_cache      1505485 1864917    144   27    1 : tunables  120  
60    8 : slabdata  69071  69071      0
buffer_head       1099832 1755375     52   75    1 : tunables  120  
60    8 : slabdata  23405  23405      0
radix_tree_node    99919 102522    276   14    1 : tunables   54   27   
8 : slabdata   7323   7323      0


