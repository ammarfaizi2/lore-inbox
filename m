Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbTJOKFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJOKFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:05:20 -0400
Received: from dwdmx2.dwd.de ([141.38.3.197]:25103 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id S262490AbTJOKFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:05:09 -0400
Date: Wed, 15 Oct 2003 10:05:06 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Finding memory leak
Message-Id: <Pine.LNX.4.44.0310141345070.17096-100000@praktifix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have several systems where memory usage goes up and up until the systems
just hangup. I assume that the leak is somewhere in kernel since killing all
applications does not give me any memory back. Looking at /proc/slabinfo I
can see that size-2048 is always constantly going up, here a full output:

    cat /proc/slabinfo
    slabinfo - version: 1.1 (SMP)
    kmem_cache            64     64    244    4    4    1 :  252  126
    urb_priv               0      0     64    0    0    1 :  252  126
    tcp_tw_bucket         30     30    128    1    1    1 :  252  126
    tcp_bind_bucket      149    336     32    3    3    1 :  252  126
    tcp_open_request       0      0     64    0    0    1 :  252  126
    inet_peer_cache        1     58     64    1    1    1 :  252  126
    ip_fib_hash           15    224     32    2    2    1 :  252  126
    ip_dst_cache      163890 163890    256 10926 10926    1 :  252  126
    arp_cache             90     90    128    3    3    1 :  252  126
    blkdev_requests     3072   3090    128  103  103    1 :  252  126
    journal_head         392  47894     48   17  622    1 :  252  126
    revoke_table           2    250     12    1    1    1 :  252  126
    revoke_record        210    336     32    3    3    1 :  252  126
    dnotify_cache          0      0     20    0    0    1 :  252  126
    file_lock_cache      160    160     96    4    4    1 :  252  126
    fasync_cache           0      0     16    0    0    1 :  252  126
    uid_cache            137    224     32    2    2    1 :  252  126
    skbuff_head_cache 164571 164610    256 10974 10974    1 :  252  126
    sock                 132    132    896   33   33    1 :  124   62
    sigqueue              87     87    132    3    3    1 :  252  126
    kiobuf                 0      0     64    0    0    1 :  252  126
    cdev_cache           143    232     64    4    4    1 :  252  126
    bdev_cache            10     58     64    1    1    1 :  252  126
    mnt_cache             14     58     64    1    1    1 :  252  126
    inode_cache         1526   1526    512  218  218    1 :  124   62
    dentry_cache        2165   2460    128   82   82    1 :  252  126
    filp                1869   1890    128   63   63    1 :  252  126
    names_cache            8      8   4096    8    8    1 :   60   30
    buffer_head        74538  93690    128 2790 3123    1 :  252  126
    mm_struct            270    270    256   18   18    1 :  252  126
    vm_area_struct      4027   4380    128  146  146    1 :  252  126
    fs_cache             343    348     64    6    6    1 :  252  126
    files_cache          182    182    512   26   26    1 :  124   62
    signal_act           164    187   1408   17   17    4 :   60   30
    size-131072(DMA)       0      0 131072    0    0   32 :    0    0
    size-131072            5      5 131072    5    5   32 :    0    0
    size-65536(DMA)        0      0  65536    0    0   16 :    0    0
    size-65536             0      0  65536    0    0   16 :    0    0
    size-32768(DMA)        0      0  32768    0    0    8 :    0    0
    size-32768             2      3  32768    2    3    8 :    0    0
    size-16384(DMA)        0      0  16384    0    0    4 :    0    0
    size-16384            19     19  16384   19   19    4 :    0    0
    size-8192(DMA)         0      0   8192    0    0    2 :    0    0
    size-8192             10     12   8192   10   12    2 :    0    0
    size-4096(DMA)         0      0   4096    0    0    1 :   60   30
    size-4096            126    126   4096  126  126    1 :   60   30
    size-2048(DMA)         0      0   2048    0    0    1 :   60   30
    size-2048         164232 164232   2048 82116 82116    1 :   60   30
    size-1024(DMA)         0      0   1024    0    0    1 :  124   62
    size-1024            212    212   1024   53   53    1 :  124   62
    size-512(DMA)          0      0    512    0    0    1 :  124   62
    size-512             264    264    512   33   33    1 :  124   62
    size-256(DMA)          0      0    256    0    0    1 :  252  126
    size-256             210    210    256   14   14    1 :  252  126
    size-128(DMA)          3     30    128    1    1    1 :  252  126
    size-128           83404  84510    128 2817 2817    1 :  252  126
    size-64(DMA)           0      0    128    0    0    1 :  252  126
    size-64             1572   1650    128   55   55    1 :  252  126
    size-32(DMA)          51     58     64    1    1    1 :  252  126
    size-32             1241   1276     64   22   22    1 :  252  126

This happens with any of the 2.4.2? kernels and have also tried different
hardware (also with no SMP). But size-2048 is always going up. I think
I narrowed this down to a DVB card driver which is currently not in kernel
but the source of the driver is available.

There are some kernel values that are changed:

   net.core.rmem_max=1500000
   net.core.wmem_max=1500000
   net.ipv4.route.max_size=30000000

But even with default values memory it is still leaking.

The question that I have are: 

   - Is it correct to assume that an application cannot be the cause
     of the leak, ie. it can only be in kernel or a driver?
   - How can I really prove that its the driver leaking the memory?
   - What is the meaning of size-2048 in slabinfo?

Thanks,
Holger

PS: Please cc me since I am not on the list.

