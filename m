Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266391AbUHIJWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266391AbUHIJWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 05:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUHIJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 05:22:37 -0400
Received: from mail.gmx.de ([213.165.64.20]:59264 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266389AbUHIJWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 05:22:25 -0400
Date: Mon, 9 Aug 2004 11:22:24 +0200 (MEST)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-ia64@vger.kernel.org, davidm@napali.hpl.hp.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20040806145451.GI17188@holomorphy.com>
Subject: Re: [2.6.7, ia64] continual memory leak at ~102kB/s...
X-Priority: 3 (Normal)
X-Authenticated: #8973862
Message-ID: <9720.1092043344@www20.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Aug 06, 2004 at 04:44:18PM +0200, Daniel Blueman wrote:
> > When running 2.6.7 on a generic ia64 system, I see memory being leaked
> in
> > the kernel. Most of the fancy (preempt, hot-plug procs, ...) features
> are
> > disabled, and the system in a quiescent state [1].
> > /proc/meminfo shows the memory as unaccounted for [2], so it seems
> likely it
> > has been kmalloc()d somehere. A small script shows memory disappearing
> at
> > 102kB/s [3].
> > Anyone else seen this on ia64?
> 
> Could you dump /proc/slabinfo?

Sampling /proc/slabinfo and again after 30 minutes while the system is
quiescent, nothing looks suspicious:

 tcp_tw_bucket  0       0
 tcp_bind_bucket        12      1129
 tcp_open_request       0       0
-inet_peer_cache        0       0
+inet_peer_cache        1       668
 ip_fib_hash    11      1309
-ip_dst_cache   11      177
+ip_dst_cache   14      177
 arp_cache      2       253
 raw4_sock      0       0
 udp_sock       6       81
 tcp_sock       18      44
 flow_cache     0       0
-scsi_cmd_cache 11      129
+scsi_cmd_cache 2       129
 nfs_write_data 36      85
 nfs_read_data  32      88
 nfs_inode_cache        16      72
@@ -23,8 +23,8 @@
 isofs_inode_cache      0       0
 fat_inode_cache        1       104
 ext2_inode_cache       0       0
-journal_handle 18      885
-journal_head   26      574
+journal_handle 16      885
+journal_head   18      574
 revoke_table   2       1559
 revoke_record  0       0
 ext3_inode_cache       981     1080
@@ -45,42 +45,42 @@
 sgpool-64      32      62
 sgpool-32      32      62
 sgpool-16      32      121
-sgpool-8       41      232
+sgpool-8       32      232
 cfq_pool       64      798
 crq_pool       0       0
 deadline_drq   0       0
-as_arq 25      474
+as_arq 16      474
 blkdev_ioc     18      1129
 blkdev_queue   28      75
-blkdev_requests        25      225
+blkdev_requests        16      225
 biovec-(256)   256     270
 biovec-128     256     279
 biovec-64      256     310
 biovec-16      256     464
 biovec-4       256     727
-biovec-1       265     1559
-bio    265     536
-sock_inode_cache       40      100
-skbuff_head_cache      268     506
+biovec-1       256     1559
+bio    256     536
+sock_inode_cache       39      100
+skbuff_head_cache      267     506
 sock   2       110
-proc_inode_cache       171     216
-sigqueue       0       404
+proc_inode_cache       177     216
+sigqueue       0       0
 radix_tree_node        644     696
 bdev_cache     5       85
 mnt_cache      23      474
 inode_cache    1369    1482
-dentry_cache   3031    3150
-filp   223     478
-names_cache    10      15
+dentry_cache   3038    3150
+filp   230     478
+names_cache    15      15
 idr_layer_cache        31      118
-buffer_head    13792   13936
-mm_struct      35      130
-vm_area_struct 508     648
+buffer_head    13888   13936
+mm_struct      34      130
+vm_area_struct 500     648
 fs_cache       36      727
 files_cache    37      154
 signal_cache   74      503
 sighand_cache  65      123
-anon_vma       292     1309
+anon_vma       291     1309
 size-131072(DMA)       0       0
 size-131072    0       0
 size-65536(DMA)        0       0
@@ -92,17 +92,17 @@
 size-8192(DMA) 0       0
 size-8192      25      32
 size-4096(DMA) 0       0
-size-4096      315     315
+size-4096      314     315
 size-2048(DMA) 0       0
-size-2048      176     186
+size-2048      175     186
 size-1024(DMA) 0       0
 size-1024      219     682
 size-512(DMA)  0       0
-size-512       496     38720
+size-512       495     38720
 size-256(DMA)  0       0
-size-256       1094    25984
+size-256       1092    25984
 size-128(DMA)  0       0
 size-128       2201    6800
 size-64(DMA)   0       0
-size-64        2527    103961
+size-64        2521    103961
 kmem_cache     120     169

-- 
Daniel J Blueman

NEU: WLAN-Router für 0,- EUR* - auch für DSL-Wechsler!
GMX DSL = supergünstig & kabellos http://www.gmx.net/de/go/dsl

