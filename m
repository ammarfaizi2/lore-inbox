Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbRHFDkl>; Sun, 5 Aug 2001 23:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266559AbRHFDkb>; Sun, 5 Aug 2001 23:40:31 -0400
Received: from [208.152.224.2] ([208.152.224.2]:1811 "EHLO redhat1.mmaero.com")
	by vger.kernel.org with ESMTP id <S266469AbRHFDkW>;
	Sun, 5 Aug 2001 23:40:22 -0400
Date: Sun, 5 Aug 2001 23:40:18 -0400 (EDT)
From: <jlewis@lewis.org>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.1x kernel memory "leaks" 
Message-ID: <Pine.LNX.4.30.0108052337300.1854-100000@redhat1.mmaero.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a mail relay server that seems to have serious kernel memory leak
issues since upgrading to the later 2.2.1x kernels.  Currently, it's
running Red Hat's 2.2.19-6.2.7.  What I see is that after a few days,
pretty much all memory is consumed.  The majority of it is not being used
by user-space processes.  i.e. killing nearly all processes free's up some
memory, but the majority is still tied up by the kernel.  I haven't found
much documentation on it, but I suspect the dentry_cache may be to blame.
What's a reasonable size for the dentry_cache?

# uptime
 10:30pm  up 3 days, 11:14,  1 user,  load average: 0.93, 0.63, 0.52

# free
             total       used       free     shared    buffers     cached
Mem:        261668     251968       9700          0       7368       8192
-/+ buffers/cache:     236408      25260
Swap:       264168      13760     250408

# cat /proc/slabinfo
slabinfo - version: 1.0
kmem_cache            29     42
tcp_tw_bucket        128    210
tcp_bind_bucket       80    254
tcp_open_request       3     63
skbuff_head_cache    192    378
sock                 100    143
dquot                  0      0
filp                1887   1890
signal_queue           0      0
kiobuf                 0      0
buffer_head         7517  10038
mm_struct             90    155
vm_area_struct      2224   3276
dentry_cache      1189547 1263374
files_cache           89    126
uid_cache              3    127
size-131072            0      0
size-65536             0      0
size-32768             1      1
size-16384             0      0
size-8192              1      1
size-4096             18     20
size-2048            255    344
size-1024             15    112
size-512              15     24
size-256             515    882
size-128             423    500
size-64               83     84
size-32             3623   4221
slab_cache           115    189

Anyone else run into this or have suggestions?

-- 
----------------------------------------------------------------------
 Jon Lewis *jlewis@lewis.org*|  I route
 System Administrator        |  therefore you are
 Atlantic Net                |
_________ http://www.lewis.org/~jlewis/pgp for PGP public key_________


