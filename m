Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264328AbTFPVV3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 17:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264336AbTFPVUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 17:20:33 -0400
Received: from franka.aracnet.com ([216.99.193.44]:16537 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264328AbTFPVSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 17:18:02 -0400
Date: Mon, 16 Jun 2003 14:31:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 813] New: Filesystem test creating kernel BUGs at include/asm/spinlock.h
Message-ID: <2300000.1055799091@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: Filesystem test creating kernel BUGs at
                    include/asm/spinlock.h
    Kernel Version: 2.5.71-bk2
            Status: NEW
          Severity: normal
             Owner: shaggy@austin.ibm.com
         Submitter: robbiew@us.ibm.com
                CC: sglass@us.ibm.com,trond.myklebust@fys.uio.no


Distribution: SuSE 8.0

Hardware Environment:
---------------------
vega:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.267
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1380.35

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.267
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1400.83

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.267
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1400.83

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 6
model           : 10
model name      : Pentium III (Cascades)
stepping        : 1
cpu MHz         : 702.267
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 1400.83

vega:~ # cat /proc/meminfo
MemTotal:      4325112 kB
MemFree:       3532184 kB
Buffers:        623208 kB
Cached:          52012 kB
SwapCached:          0 kB
Active:          40856 kB
Inactive:       640608 kB
HighTotal:     3465188 kB
HighFree:      3403776 kB
LowTotal:       859924 kB
LowFree:        128408 kB
SwapTotal:     2097136 kB
SwapFree:      2097136 kB
Dirty:             456 kB
Writeback:           0 kB
Mapped:           9636 kB
Slab:            31392 kB
Committed_AS:    20812 kB
PageTables:        320 kB
VmallocTotal:   114680 kB
VmallocUsed:      2180 kB
VmallocChunk:   112500 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
vega:~ # mount
/dev/sda3 on / type ext2 (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw)
/dev/sda1 on /boot type ext2 (rw)
/dev/sdb1 on /nfsserver/ext3 type ext3 (rw)
/dev/sdc1 on /nfsserver/jfs type jfs (rw)
/dev/sdd1 on /nfsserver/reiserfs type reiserfs (rw)
usbdevfs on /proc/bus/usb type usbdevfs (rw)
localhost:/nfsserver/jfs on /mnt/nfs_real/jfs/udp/2 type nfs 
(rw,soft,intr,proto=udp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/jfs on /mnt/nfs_real/jfs/udp/3 type nfs 
(rw,soft,intr,proto=udp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
localhost:/nfsserver/jfs on /mnt/nfs_real/jfs/tcp/2 type nfs 
(rw,soft,intr,proto=tcp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/jfs on /mnt/nfs_real/jfs/tcp/3 type nfs 
(rw,soft,intr,proto=tcp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
localhost:/nfsserver/ext3 on /mnt/nfs_real/ext3/udp/2 type nfs 
(rw,soft,intr,proto=udp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/ext3 on /mnt/nfs_real/ext3/udp/3 type nfs 
(rw,soft,intr,proto=udp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
localhost:/nfsserver/ext3 on /mnt/nfs_real/ext3/tcp/2 type nfs 
(rw,soft,intr,proto=tcp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/ext3 on /mnt/nfs_real/ext3/tcp/3 type nfs 
(rw,soft,intr,proto=tcp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
localhost:/nfsserver/reiserfs on /mnt/nfs_real/reiserfs/udp/2 type nfs 
(rw,soft,intr,proto=udp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/reiserfs on /mnt/nfs_real/reiserfs/udp/3 type nfs 
(rw,soft,intr,proto=udp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
localhost:/nfsserver/reiserfs on /mnt/nfs_real/reiserfs/tcp/2 type nfs 
(rw,soft,intr,proto=tcp,vers=2,addr=127.0.0.1)
localhost:/nfsserver/reiserfs on /mnt/nfs_real/reiserfs/tcp/3 type nfs 
(rw,soft,intr,proto=tcp,vers=3,rsize=8192,wsize=8192,addr=127.0.0.1)
vega:~ # df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda3              25G  3.7G   20G  16% /
/dev/sda1              23M   11M   11M  50% /boot
/dev/sdb1              33G   33M   31G   1% /nfsserver/ext3
/dev/sdc1              34G  7.4M   33G   1% /nfsserver/jfs
/dev/sdd1              34G   33M   33G   1% /nfsserver/reiserfs
localhost:/nfsserver/jfs
                       34G  7.4M   33G   1% /mnt/nfs_real/jfs/udp/2
localhost:/nfsserver/jfs
                       34G  7.4M   33G   1% /mnt/nfs_real/jfs/udp/3
localhost:/nfsserver/jfs
                       34G  7.4M   33G   1% /mnt/nfs_real/jfs/tcp/2
localhost:/nfsserver/jfs
                       34G  7.4M   33G   1% /mnt/nfs_real/jfs/tcp/3
localhost:/nfsserver/ext3
                       33G   33M   31G   1% /mnt/nfs_real/ext3/udp/2
localhost:/nfsserver/ext3
                       33G   33M   31G   1% /mnt/nfs_real/ext3/udp/3
localhost:/nfsserver/ext3
                       33G   33M   31G   1% /mnt/nfs_real/ext3/tcp/2
localhost:/nfsserver/ext3
                       33G   33M   31G   1% /mnt/nfs_real/ext3/tcp/3
localhost:/nfsserver/reiserfs
                       34G   33M   33G   1% /mnt/nfs_real/reiserfs/udp/2
localhost:/nfsserver/reiserfs
                       34G   33M   33G   1% /mnt/nfs_real/reiserfs/udp/3
localhost:/nfsserver/reiserfs
                       34G   33M   33G   1% /mnt/nfs_real/reiserfs/tcp/2
localhost:/nfsserver/reiserfs
                       34G   33M   33G   1% /mnt/nfs_real/reiserfs/tcp/3
--------------------


Software Environment:
Gnu C                  2.95.3
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
module-init-tools      2.4.12
e2fsprogs              1.26
jfsutils               1.0.15
xfsprogs               2.0.0
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        x    1 root     root      1394238 Mar 23  
2002 /lib/libc.so.6
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
NFS-utils              1.0.3
No Modules Loaded


Problem Description: 
While attempting to execute the test scenario defined at http://ltp.sf.net/nfs, 
I am able to generate Kernel BUGs.  I'm not sure if this is JFS or NFS 
related...I figured I'd open in JFS first. Here is the trace output:
===================================================
------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:75!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c012129d>]    Not tainted
EFLAGS: 00010002
EIP is at printk+0x1f5/0x214
eax: 00000001   ebx: c05cde49   ecx: c04d4da0   edx: 00000039
esi: 00000002   edi: 00000029   ebp: d01ab780   esp: d01ab774
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1112, threadinfo=d01aa000 task=d01ad920)
Stack: 00000000 d01ad920 c0118dd0 d01ab838 c011903b c0421280 5a5a5a5a 00000000 
       c0118dd0 f7fd2694 f77c3c94 f7680270 f7668a5c f76802e8 5a5a5a5a c02cd3ba 
       f77c3c94 f7680270 d01ab7d0 00030001 f7680270 f7680270 f7680270 d01ab7ec 
Call Trace:
 [<c0118dd0>] do_page_fault+0x0/0x478
 [<c011903b>] do_page_fault+0x26b/0x478
 [<c0118dd0>] do_page_fault+0x0/0x478
 [<c02cd3ba>] deadline_next_request+0x1e/0x2c
 [<c0304be1>] scsi_request_fn+0x35/0x374
 [<c0140713>] check_poison_obj+0x3b/0x190
 [<c0142347>] kmem_cache_alloc+0x13f/0x150
 [<c0140713>] check_poison_obj+0x3b/0x190
 [<c010b84d>] error_code+0x2d/0x38
 [<c011c2a2>] __wake_up_common+0x36/0x50
 [<c011c34e>] __wake_up_locked+0xe/0x14
 [<c01099e6>] __down+0x15a/0x1a4
 [<c011c24c>] default_wake_function+0x0/0x20
 [<c0109ca3>] __down_failed+0xb/0x14
 [<c022edb6>] .text.lock.jfs_dmap+0x1c5/0x24f
 [<c022cc16>] dbAllocDmap+0x22/0x70
 [<c022c16e>] dbAllocNext+0x11e/0x128
 [<c022b99c>] dbAlloc+0x290/0x4ac
 [<c0235b94>] extBalloc+0x14c/0x1f4
 [<c017aaa7>] __mark_inode_dirty+0x37/0x134
 [<c023571f>] extAlloc+0x18f/0x2f0
 [<c021dca4>] jfs_get_blocks+0x21c/0x2cc
 [<c0139e0c>] find_get_page+0x44/0x8c
 [<c021dd72>] jfs_get_block+0x1e/0x24
 [<c015d87c>] nobh_prepare_write+0xc8/0x35c
 [<c013ce30>] mempool_free_slab+0x10/0x14
 [<c0139a1f>] add_to_page_cache+0x7b/0x17c
 [<c021de01>] jfs_prepare_write+0x19/0x20
 [<c021dd54>] jfs_get_block+0x0/0x24
 [<c013bf5b>] generic_file_aio_write_nolock+0x5e7/0xac4
 [<c03ae43d>] skb_free_datagram+0x25/0x2c
 [<c04056fd>] udp_data_ready+0x1ed/0x228
 [<c013c4a7>] generic_file_write_nolock+0x6f/0x8c
 [<c011c2a2>] __wake_up_common+0x36/0x50
 [<c011c34e>] __wake_up_locked+0xe/0x14
 [<c011c24c>] default_wake_function+0x0/0x20
 [<c0109ca3>] __down_failed+0xb/0x14
 [<c013c696>] generic_file_writev+0x42/0x58
 [<c0159c76>] do_readv_writev+0x182/0x21c
 [<c013c558>] generic_file_write+0x0/0x70
 [<c015a49d>] open_private_file+0x81/0x90
 [<c01d3343>] nfsd_open+0xd3/0x114
 [<c0159da4>] vfs_writev+0x4c/0x50
 [<c01d3a1e>] nfsd_write+0x10a/0x2c4
 [<c011aa19>] kmap_atomic+0x21/0xa4
 [<c03ad677>] skb_copy_bits+0x147/0x200
 [<c01d0d46>] nfsd_proc_write+0xce/0xd8
 [<c01cffba>] nfsd_dispatch+0xda/0x195
 [<c040b28d>] svc_process+0x3cd/0x65a
 [<c01cfcf0>] nfsd+0x24c/0x43c
 [<c01cfaa4>] nfsd+0x0/0x43c
 [<c0108d75>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 4b 00 a0 21 42 c0 c6 05 b8 4d 4d c0 01 56 9d 89 f6 89 
 ------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#2]
CPU:    3
EIP:    0060:[<c011c2e8>]    Not tainted
EFLAGS: 00010002
EIP is at __wake_up+0x2c/0x84
eax: 0000000e   ebx: d024f00c   ecx: c04d4da0   edx: 00008991
esi: 00000286   edi: 00000001   ebp: cfe97cf4   esp: cfe97cdc
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1167, threadinfo=cfe96000 task=cfe99900)
Stack: c04218f7 c011c2d0 00000038 d024e000 00000044 00000003 cfe97cfc c0109888 
       cfe97d48 c0109cd4 d024f004 00000044 00000001 c022ec6e c044cb42 00000077 
       00000004 f1ae15d8 d0af5044 cfe97d44 00000044 d024f004 ffffffff 00000000 
Call Trace:
 [<c011c2d0>] __wake_up+0x14/0x84
 [<c0109888>] __up+0x18/0x1c
 [<c0109cd4>] __up_wakeup+0x8/0xc
 [<c022ec6e>] .text.lock.jfs_dmap+0x7d/0x24f
 [<c022831d>] eip: c01098d0
diAlloc+0x8d/0x6bc
 [<c021cf90>] jfs_alloc_inode+0x10/0x28
 [<c021cf90>] jfs_alloc_inode+0x10/0x28
 [<c01738eb>] new_inode+0x17/0xd0
 [<c0235447>] ialloc+0x57/0x1a0
 [<c021e0fa>] jfs_create+0x4a/0x2bc
 [<c03c2606>] ip_finish_output+0x15e/0x1bc
 [<c03c27eb>] ip_output+0x73/0x7c
 [<c03c40ab>] ip_push_pending_frames+0x2a3/0x358
 [<c03e1a0e>] udp_push_pending_frames+0x1f2/0x210
 [<c016721a>] permission+0x2a/0x34
 [<c01d5629>] nfsd_permission+0x91/0xd8
 [<c016721a>] permission+0x2a/0x34
 [<c0168936>] vfs_create+0x6a/0x90
 [<c01d3f53>] nfsd_create+0x2cf/0x398
 [<c01d11ba>] nfsd_proc_create+0x46a/0x5fc
 [<c01cffba>] nfsd_dispatch+0xda/0x195
 [<c040b28d>] svc_process+0x3cd/0x65a
 [<c01cfcf0>] nfsd+0x24c/0x43c
 [<c01cfaa4>] nfsd+0x0/0x43c
 [<c0108d75>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 78 00 e0 18 42 c0 83 c4 08 f0 fe 0b 0f 88 ef 1d 00 00 
 ------------[ cut here ]------------
kernel BUG at include/asm/spinlock.h:120!
invalid operand: 0000 [#3]
CPU:    1
EIP:    0060:[<c01098e8>]    Not tainted
EFLAGS: 00010002
EIP is at __down+0x5c/0x1a4
eax: 0000000e   ebx: d024f00c   ecx: c04d4da0   edx: 000098e4
esi: d024e000   edi: cfdd9950   ebp: cfdd9950   esp: cfdd9920
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 1180, threadinfo=cfdd8000 task=cfe006b0)
Stack: c0418cf7 c01098d0 d0af595c d024e000 d024f004 00000246 cfe006b0 00000000 
       cfe006b0 c011c24c 00000000 00000000 cfdd9964 c0109ca3 d024f004 00000003 
       00000000 cfdd99a0 c022ec64 c044cb42 00000077 d0af595c cc4f5000 0000001c 
Call Trace:
 [<c01098d0>] __down+0x44/0x1a4
 [<c011c24c>] default_wake_function+0x0/0x20
 [<c0109ca3>] __down_failed+0xb/0x14
 [<c022ec64>] .text.lock.jfs_dmap+0x73/0x24f
 [<c0236954>] release_metapage+0x3d8/0x3e4
 [<c022baff>] dbAlloc+0x3f3/0x4ac
 [<c0235b94>] extBalloc+0x14c/0x1f4
 [<c023571f>] extAlloc+0x18f/0x2f0
 [<c021dca4>] jfs_get_blocks+0x21c/0x2cc
 [<c01746c0>] iput+0x44/0x70
 [<c021dd72>] jfs_get_block+0x1e/0x24
 [<c015d87c>] nobh_prepare_write+0xc8/0x35c
 [<c0244c97>] radix_tree_node_alloc+0x17/0x64
 [<c0244c97>] radix_tree_node_alloc+0x17/0x64
 [<c0244e3e>] radix_tree_insert+0x5a/0xb8
 [<c0139a1f>] add_to_page_cache+0x7b/0x17c
 [<c021de01>] jfs_prepare_write+0x19/0x20
 [<c021dd54>] jfs_get_block+0x0/0x24
 [<c013bf5b>] generic_file_aio_write_nolock+0x5e7/0xac4
 [<c03ac6b8>] __kfree_skb+0xac/0xb4
 [<c03ae43d>] skb_free_datagram+0x25/0x2c
 [<c04056fd>] udp_data_ready+0x1ed/0x228
 [<c013c4a7>] generic_file_write_nolock+0x6f/0x8c
 [<c03bfaea>] ip_local_deliver+0xfa/0x1d0
 [<c03bff51>] ip_rcv+0x391/0x435
 [<c03b0ab0>] netif_receive_skb+0x16c/0x19c
 [<c013c696>] generic_file_writev+0x42/0x58
 [<c0159c76>] do_readv_writev+0x182/0x21c
 [<c013c558>] generic_file_write+0x0/0x70
 [<c015a49d>] open_private_file+0x81/0x90
 [<c01d3343>] nfsd_open+0xd3/0x114
 [<c0159da4>] vfs_writev+0x4c/0x50
 [<c01d3a1e>] nfsd_write+0x10a/0x2c4
 [<c011aa19>] kmap_atomic+0x21/0xa4
 [<c03ad677>] skb_copy_bits+0x147/0x200
 [<c01d9fcd>] nfsd3_proc_write+0x105/0x124
 [<c01cffba>] nfsd_dispatch+0xda/0x195
 [<c040b28d>] svc_process+0x3cd/0x65a
 [<c01cfcf0>] nfsd+0x24c/0x43c
 [<c01cfaa4>] nfsd+0x0/0x43c
 [<c0108d75>] kernel_thread_helper+0x5/0xc

Code: 0f 0b 78 00 e0 8c 41 c0 83 c4 08 f0 fe 0b 0f 88 10 04 00 00 
===================================================

Steps to reproduce:
Execute the test scenario described in the 2.5 NFS testplan located at 
http://ltp.sf.net/nfs .  The test scenario is modified to have only one client 
and to have the NFS server and client be the same machine....using the 
localhost interface.

