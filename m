Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWDRLam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWDRLam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDRLam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:30:42 -0400
Received: from sunray.wldelft.nl ([145.9.132.100]:40109 "EHLO
	pophost.wldelft.nl") by vger.kernel.org with ESMTP id S932186AbWDRLal
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:30:41 -0400
Message-ID: <4444CD03.30201@wldelft.nl>
Date: Tue, 18 Apr 2006 13:26:59 +0200
From: Leroy van Logchem <Leroy.vanLogchem@wldelft.nl>
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops: clear_inode [nfs?]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite often our HPC clusternodes oops so we setup the netdump service to 
recieve details.
We're running 2.6.9-11.ELsmp (yes, it's RedHat, no anwers).
The nodes are plain Intel mainboards with Pentium4 3.40GHz running root 
NFS mounted,
booted via pXe. All nodes have 4GB aboard (3.3GB usable), use a local 
4GB swapfile.
So far no method to trigger the oops.

Included are: pci-output, three netdump oops reports (all seperate 
nodes) and one dmesg (boot).
Excluded: the vmcores, 3.3GB each (available on request)

-Leroy
( Please CC )

===PCI===
00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor 
to I/O Controller
00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express 
Root Port
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 3 (rev 03)
00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) PCI Express Port 4 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC 
Interface Bridge (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B60 
[Radeon X300 (PCIE)]
01:00.1 Display controller: ATI Technologies Inc: Unknown device 5b70
06:03.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit 
Ethernet Controller

===Netdump logfile 1===

VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...
nfs: server hafilerg not responding, still trying
nfs: server hafilerg OK
Unable to handle kernel paging request at virtual address 00200038
printing eip:EIP
c016b7ec
*pde = 0aec6001
Oops: 0000 [#1]
SMP
Modules linked in: ext3 jbd nfsd exportfs md5 ipv6 netconsole netdump 
autofs4 i2c_dev i2c_core sd_mod ata_piix libata scsi_mod nfs lockd 
sunrpc e1000
CPU:    0
EIP:    0060:[<c016b7ec>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-11.ELsmp)
EIP is at clear_inode+0x8f/0xf8
eax: 00200034   ebx: d04718ec   ecx: 00000000   edx: f40b1a00
esi: f40b1a00   edi: ec8e721c   ebp: 00000053   esp: df6f2ed8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 44, threadinfo=df6f2000 task=df495730)
Stack: d04718ec c016c542 d04718ec ec8e7214 c016c5bd d04718ec c016a1d8 
00000000
kswapd+0xca/0xcc
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c02c7296>] ret_from_fork+0x6/0x14
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01461de>] kswapd+0x0/0xcc
[<c01041f1>] kernel_thread_helper+0x5/0xb
Code: 00 f6 83 3c 01 00 00 08 74 07 89 d8 e8 cb 10 00 00 f6 83 44 01 00 
00 20 75 36 8b 93 a4 00 00 00 85 d2 74 2c 8b 42 28 85 c0 74 25 <83> 40 83 f8

Pid: 44, comm:              kswapd0
EIP: 0060:[<c016b7ec>] CPU: 0
EIP is at clear_inode+0x8f/0xf8
EFLAGS: 00010202    Not tainted  (2.6.9-11.ELsmp)
EAX: 00200034 EBX: d04718ec ECX: 00000000 EDX: f40b1a00
ESI: f40b1a00 EDI: ec8e721c EBP: 00000053 DS: 007b ES: 007b
CR0: 8005003b CR2: 00200038 CR3: 3407d880 CR4: 000006f0
[<c016c542>] generic_forget_inode+0xea/0xf6
[<c016c5bd>] iput+0x5f/0x61
[<c016a1d8>] prune_dcache+0x13f/0x18e
[<c016a553>] shrink_dcache_memory+0x14/0x2b
[<c0144e2c>] shrink_slab+0xf8/0x161
[<c01460b8>] balance_pgdat+0x1d2/0x2f8
[<c02c5604>] schedule+0x844/0x87a
[<c011f619>] prepare_to_wait+0x12/0x4c
[<c01462a8>] kswapd+0xca/0xcc
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c02c7296>] ret_from_fork+0x6/0x14
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01461de>] kswapd+0x0/0xcc
syscall_call+0x7/0xb
trisim.exe    S C15DE960  3416 22238  22141 22239               (NOTLB)
c5581f2c 00000082 c013f7c4 c15de960 f24deeb0 00000000 c031c180 f24deeb0
      00000000 c2a2d6c0 c2a2cd60 00000000 00000688 74df30ee 00099c10 
f24deeb0
      def586b0 def5881c 00000000 00000246 a179cdd3 a179cdd3 c5581fa0 
dd377940
Call Trace:
[<c013f7c4>] buffered_rmqueue+0x17d/0x1a5
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c0166a4f>] do_poll+0x8e/0xac
[<c0166c0c>] sys_poll+0x19f/0x24f
[<c01660fd>] __pollwait+0x0/0x95
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    S F4237380  3144 22239  22238         22240       (NOTLB)
f3398f9c 00000082 f24df9b0 f4237380 f40bc1b0 f4237380 f4237380 f40bc1b0
      00000000 c2a2d6c0 c2a2cd60 00000000 00000840 f3a225f7 00099c0f 
f40bc1b0
      def58c30 def58d9c 00000000 f3398000 f3398000 f3398fac 00e39d68 
f3398000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S F4237380  3152 22240  22238         22242 22239 (NOTLB)
f2821f9c 00000082 f24df430 f4237380 f24deeb0 f4237380 f4237380 f24deeb0
      00000000 c2a2d6c0 c2a2cd60 00000000 00000899 83df1eb6 00099c0f 
f24deeb0
      def591b0 def5931c 00000000 f2821000 f2821000 f2821fac 01039b60 
f2821000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S 0000F008  1432 22242  22238         22243 22240 (NOTLB)
de054f9c 00000082 000056e2 0000f008 f24df9b0 00000000 00000000 f24df9b0
      00000000 c2a2d6c0 c2a2cd60 00000000 00004852 a4ee76a8 00099c10 
f24df9b0
      f40bc1b0 f40bc31c 00000000 de054000 de054000 de054fac 01234f44 
de054000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    S 0000F008  1440 22243  22238         22244 22242 (NOTLB)
d09eff9c 00000082 000056e3 0000f008 f24deeb0 00000000 00000000 f24deeb0
      00000000 c2a2d6c0 c2a2cd60 00000000 00004ebd ced00201 00099c10 
f24deeb0
      f24df9b0 f24dfb1c 00000000 d09ef000 d09ef000 d09effac 01434f44 
d09ef000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    S F4237380  1628 22244  22238         22245 22243 (NOTLB)
deb3df9c 00000082 f24df9b0 f4237380 f24deeb0 f4237380 f4237380 f24deeb0
      00000000 c2a2d6c0 c2a2cd60

===Netdump logfile 2===
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
nfs: server hafilerg not responding, still trying
nfs: server hafilerg OK
nfs: server hafilerg not responding, still trying
nfs: server hafilerg not responding, still trying
nfs: server hafilerg not responding, still trying
nfs: server hafilerg OK
nfs: server hafilerg OK
nfs: server hafilerg OK
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...
Unable to handle kernel paging request at virtual address 0000cc4b
printing eip:
c016b7ec
*pde = 2dea3001
Oops: 0000 [#1]
SMP
Modules linked in: ext3 jbd nfsd exportfs md5 ipv6 netconsole netdump 
autofs4 i2c_dev
                                  i2c_core sd_mod ata_piix libata 
scsi_mod nfs lockd sunrpc e1000
CPU:    0
EIP:    0060:[<c016b7ec>]    Not tainted VLI
EFLAGS: 00010206   (2.6.9-11.ELsmp)
EIP is at clear_inode+0x8f/0xf8
eax: 0000cc47   ebx: f1ba7664   ecx: 00000000   edx: df413800
esi: df413800   edi: e85d68a4   ebp: 0000000c   esp: df6f2ed8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 44, threadinfo=df6f2000 task=df495730)
Stack: f1ba7664 c016c542 f1ba7664 e85d689c c016c5bd f1ba7664 c016a1d8 
00000000
ret_from_fork+0x6/0x14
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01461de>] kswapd+0x0/0xcc
[<c01041f1>] kernel_thread_helper+0x5/0xb
Code: 00 f6 83 3c 01 00 00 08 74 07 89 d8 e8 cb 10 00 00 f6 83 44 01 00 
00 20 75 36 8b 93 a4 00 00 00 85 d2 74 2c 8b 42 28 85 c0 74 25 <83> 1f 
31 c0 83 bc 83
Pid: 44, comm:              kswapd0
EIP: 0060:[<c016b7ec>] CPU: 0
EIP is at clear_inode+0x8f/0xf8
EFLAGS: 00010206    Not tainted  (2.6.9-11.ELsmp)
EAX: 0000cc47 EBX: f1ba7664 ECX: 00000000 EDX: df413800
ESI: df413800 EDI: e85d68a4 EBP: 0000000c DS: 007b ES: 007b
CR0: 8005003b CR2: 0000cc4b CR3: 3407d4c0 CR4: 000006f0
[<c016c542>] generic_forget_inode+0xea/0xf6
[<c016c5bd>] iput+0x5f/0x61
[<c016a1d8>] prune_dcache+0x13f/0x18e
[<c016a553>] shrink_dcache_memory+0x14/0x2b
[<c0144e2c>] shrink_slab+0xf8/0x161
[<c01460b8>] balance_pgdat+0x1d2/0x2f8
[<c02c5604>] schedule+0x844/0x87a
[<c011f619>] prepare_to_wait+0x12/0x4c
[<c01462a8>] kswapd+0xca/0xcc
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c02c7296>] ret_from_fork+0x6/0x14
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01461de>] kswapd+0x0/0xcc
unix_release_sock+0x15a/0x201
kjournald     S 00000001  2572  1352      1          1368  1340 (L-TLB)
f4143f64 00000046 00000000 00000001 f43d8230 c0107956 c0318900 f43d8230
      00000000 c2a2d6c0 c2a2cd60 00000000 000003a5 af23ea0b 0008fd56 
f43d8230
      f4380130 f438029c 00000000 c011f619 df406214 df406200 00000001 
00000000
Call Trace:
[<c0107956>] do_IRQ+0xf8/0x130
[<c011f619>] prepare_to_wait+0x12/0x4c
[<f8943f45>] kjournald+0x19f/0x213 [jbd]
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c011f6ee>] read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
mingetty      S 00000003  1448  1369      1          1370  1368 (NOTLB)
f4196e90 00000082 00000000 00000003 f43806b0 f41cd298 0000000a f43806b0
      00000000 c2a2d6c0 c2a2cd60 00000000 000155e3 6a67f316 00000008 
f43806b0
      f40bd7b0 f40bd91c 00000000 f4196e94 f41c3000 7fffffff f41c3c04 
00000000
Call Trace:
[<c02c5abc>] schedule_timeout+0x53/0xee
[<c011f586>] add_wait_queue+0x12/0x30
[<c01f5eba>] read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
mingetty      S 00000003  1448  1370      1         22548  1369 (NOTLB)
f4314e90 00000082 00000000 00000003 00000001 f420c298 0000000a 00000003
      00000001 00000002 c2a2cd60 00000000 000140c9 70cdef42 00000008 
c0314a60
      f43fd8b0 f43fda1c 00000002 00000000 f41b5000 7fffffff f41b5c04 
00000000
Call Trace:
[<c02c5abc>] schedule_timeout+0x53/0xee
[<c011f586>] add_wait_queue+0x12/0x30
[<c01f5eba>] read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62



===Netdump logfile 3===
nfs: server hafilerg not responding, still trying
nfs: server hafilerg OK
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...
VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice 
day...
Unable to handle kernel paging request at virtual address 64840995
printing eip:
c016b7ec
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: ext3 jbd nfsd exportfs md5 ipv6 netconsole netdump 
autofs4 i2c_dev
                                 i2c_core sd_mod ata_piix libata 
scsi_mod nfs lockd sunrpc e1000
CPU:    0
EIP:    0060:[<c016b7ec>]    Not tainted VLI
EFLAGS: 00010202   (2.6.9-11.ELsmp)
EIP is at clear_inode+0x8f/0xf8
eax: 64840991   ebx: f27c6154   ecx: 00000000   edx: df414400
esi: df414400   edi: d47f2f2c   ebp: 0000006b   esp: df6f2ed8
ds: 007b   es: 007b   ss: 0068
Process kswapd0 (pid: 44, threadinfo=df6f2000 task=df495730)
Stack: f27c6154 c016c542 f27c6154 d47f2f24 c016c5bd f27c6154 c016a1d8 
00000000

Pid: 44, comm:              kswapd0
EIP: 0060:[<c016b7ec>] CPU: 0
EIP is at clear_inode+0x8f/0xf8
EFLAGS: 00010202    Not tainted  (2.6.9-11.ELsmp)
EAX: 64840991 EBX: f27c6154 ECX: 00000000 EDX: df414400
ESI: df414400 EDI: d47f2f2c EBP: 0000006b DS: 007b ES: 007b
CR0: 8005003b CR2: 64840995 CR3: 3407dce0 CR4: 000006f0
[<c016c542>] generic_forget_inode+0xea/0xf6
[<c016c5bd>] iput+0x5f/0x61
[<c016a1d8>] prune_dcache+0x13f/0x18e
[<c016a553>] shrink_dcache_memory+0x14/0x2b
[<c0144e2c>] shrink_slab+0xf8/0x161
[<c01460b8>] balance_pgdat+0x1d2/0x2f8
[<c02c5604>] schedule+0x844/0x87a
[<c011f619>] prepare_to_wait+0x12/0x4c
[<c01462a8>] kswapd+0xca/0xcc
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c02c7296>] ret_from_fork+0x6/0x14
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01461de>] kswapd+0x0/0xcc
[<c01041f1>] kernel_thread_helper+0x5/0xb

                                              sibling
 task             PC      pid father child younger older
init          S DF428EC0   844     1      0     2               (NOTLB)
df428ec4 00000082 00000000 df428ec0 f4390130 df41ad00 c031c180 f4390130
      00000000 c2a2d6c0 c2a2cd60 00000000 000013e2 3278cbf2 00099f1b 
f4390130
      df451630 df45179c 00000000 00000246 a1acf40c a1acf40c 00000000 
00000800
Call Trace:
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c01664c8>] do_select+0x291/0x2c6
[<c01660fd>] __pollwait+0x0/0x95
[<c01667f0>] sys_select+0x2e0/0x43a
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
migration/0   S C2A2CD60  3768     2      1             3       (L-TLB)
df42bfb4 00000046 c011caf1 c2a2cd60 df451630 df4517a0 df42bfcc c02c5604
      00000000 c0401520 c2a2cd60 00000000 0000026b 7abbd7dd 00000006 
df451630
      df4510b0 df45121c 0000125a 7abbcdc3 c2a2d6a4 c2a2cd60 df42b000 
df42bfcc
Call Trace:
[<c011caf1>] finish_task_switch+0x30/0x66
[<c02c5604>] schedule+0x844/0x87a
[<c011eb1b>] migration_thread+0x8f/0x133
[<c011ea8c>] migration_thread+0x0/0x133
[<c0132e31>] kthread+0x73/0x9b
[<c0132dbe>] kthread+0x0/0x9b
[<c01041f1>] kernel_thread_helper+0x5/0xb
ksoftirqd/0   R running  3612     3      1             4     2 (L-TLB)
events/0      S 00000246  2784     4      1     5       7     3 (L-TLB)
df42df68 00000046 00000287 00000246 f40bc1b0 c2a2e938 c0128d4d f40bc1b0
      00000000 c2a2d6c0 c2a2cd60 00000000 00000ff2 e08adb7d 00099f1b 
f40bc1b0
      df4505b0 df45071c 00000000 df458018 c2a2e920 df458010 00000246 
df458000
Call Trace:
[<c0128d4d>] __mod_timer+0x101/0x10b
[<c012f7fc>] worker_thread+0xc9/0x1d5
[<c014392a>] cache_reap+0x0/0x1a1
[<c011dc6f>] default_wake_function+0x0/0xc
[<c011dc6f>] default_wake_function+0x0/0xc
[<c012f733>] worker_thread+0x0/0x1d5
[<c0132e31>] kthread+0x73/0x9b
[<c0132dbe>] kthread+0x0/0x9b
[<c01041f1>] kernel_thread_helper+0x5/0xb
khelper       S 00000086  3424     5      4             6       (L-TLB)
dfff8f68 00000046 00000003 00000086 f43c9830 00000001 f4184e14 f43c9830
      00000000 c2a2d6c0 c2a2cd60 00000000 00000b70 0c5cc9eb 0000000a 
f43c9830
      df450030 df45019c 00000000 df45c018 f4184db0 df45c010 00000246 
df45c000
Call Trace:
[<c012f7fc>] worker_thread+0xc9/0x1d5
[<c012f4fc>] __call_usermodehelper+0x0/0x41
[<c011dc6f>] default_wake_function+0x0/0xc
[<c011dc6f>] default_wake_function+0x0/0xc
[<c012f733>] worker_thread+0x0/0x1d5
[<c0132e31>] kthread+0x73/0x9b
[<c0132dbe>] kthread+0x0/0x9b
[<c01041f1>] kernel_thread_helper+0x5/0xb
kblockd/0     S DFE1F600  3648     6      4            42     5 (L-TLB)
df440f68 00000046 f40d9000 dfe1f600 f4348b30 f40d9000 dfe0d9b0 f4348b30
      00000000  schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c011f586>] add_wait_queue+0x12/0x30
[<f88c8d38>] svc_recv+0x2b0/0x439 [sunrpc]
[<c0169cfc>] dput+0x34/0x19b
[<c011dc6f>] default_wake_function+0x0/0xc
[<c011dc6f>] default_wake_function+0x0/0xc
[<c012bc11>] sigprocmask+0xb0/0xca
[<f8a1330a>] nfsd+0x11f/0x332 [nfsd]
[<f8a131eb>] nfsd+0x0/0x332 [nfsd]
[<c01041f1>] kernel_thread_helper+0x5/0xb
rpc.mountd    S F4312CC4  1680  1240      1          1282  1236 (NOTLB)
f4153ec4 00000082 c29d6d20 f4312cc4 00000000 fffcfeb0 c031c180 c031c180
      00000246 c013f7c4 c2a2cd60 00000000 0000706e cb1ff668 00000009 
c0314a60
      f43b41b0 f43b431c 00000001 00000000 f435fc80 7fffffff 00000000 
00000100
Call Trace:
[<c013f7c4>] buffered_rmqueue+0x17d/0x1a5
[<c02c5abc>] schedule_timeout+0x53/0xee
[<c0290af5>] tcp_poll+0x31/0x146
[<c0271819>] datagram_poll+0x25/0xcc
[<c01664c8>] do_select+0x291/0x2c6
[<c01660fd>] __pollwait+0x0/0x95
[<c01667f0>] sys_select+0x2e0/0x43a
[<c0156d33>] __fput+0xda/0x100
[<c02c7377>] syscall_call+0x7/0xb
sendmail      S C141F620  1544  1282      1          1293  1240 (NOTLB)
f4159ec4 00000082 c013f7c4 c141f620 f4390130 00000000 c031c180 f4390130
      00000000 c2a2d6c0 c2a2cd60 00000000 00003974 29ab850c 00099f1b 
f4390130
      f437cbb0 f437cd1c 00000000 00000246 a1acf378 a1acf378 00000000 
00000040
Call Trace:
[<c013f7c4>] buffered_rmqueue+0x17d/0x1a5
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c01664c8>] do_select+0x291/0x2c6
[<c01660fd>] __pollwait+0x0/0x95
[<c01667f0>] sys_select+0x2e0/0x43a
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
crond         S 00000001  1384  1293      1 14112    1317  1282 (NOTLB)
f4141f5c 00000082 000081a4 00000001 f40bd7b0 00000000 00000000 f40bd7b0
      00000000 c2a2d6c0 c2a2cd60 00000000 00000630 d3bd4a22 00099f18 
f40bd7b0
      f42dadb0 f42daf1c 00000000 00000246 a1ada31a a1ada31a 0000ea6b 
fa09bac0
Call Trace:
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c012970f>] sys_nanosleep+0x103/0x1a1
[<c02c7377>] syscall_call+0x7/0xb
torque_mom    S C15B5C40  1300  1317      1 22292    1329  1293 (NOTLB)
f3d78ec4 00000082 c013f7c4 c15b5c40 f4390130 00000000 c031c180 f4390130
      00000000 c2a2d6c0 c2a2cd60 00000000 0000149f ab18632a 00099f19 
f4390130
      f4254230 f425439c 00000000 00000246 a1acede2 a1acede2 00000000 
00000200
Call Trace:
[<c013f7c4>] buffered_rmqueue+0x17d/0x1a5
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c01664c8>] do_select+0x291/0x2c6
[<c01660fd>] __pollwait+0x0/0x95
[<c01667f0>] sys_select+0x2e0/0x43a
[<c012bc11>] sigprocmask+0xb0/0xca
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
kjournald     S 00000212  2936  1329      1          1345  1317 (L-TLB)
f41d9f64 00000046 00000000 00000212 f4391730 00002801 00002801 f4391730
      00000000 c2a2d6c0 c2a2cd60 00000000 00001654 269d3e4c 00081e72 
f4391730
      df4946b0 df49481c 00000000 c011f619 df402414 df402400 00000001 
00000000
Call Trace:
[<c011f619>] prepare_to_wait+0x12/0x4c
[<f8943f45>] kjournald+0x19f/0x213 [jbd]
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c011cb39>] schedule_tail+0x12/0x55
[<f8943da0>] commit_timeout+0x0/0x5 [jbd]
[<f8943da6>] kjournald+0x0/0x213 [jbd]
[<c01041f1>] kernel_thread_helper+0x5/0xb
mingetty      S 00000003  1512  1345      1          1346  1329 (NOTLB)
f43a4e90 00000082 00000000 00000003 f437d6b0 00000202 0000000a f437d6b0
read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
mingetty      S 00000003  1448  1346      1          1347  1345 (NOTLB)
f42e8e90 00000082 00000000 00000003 f42ee8b0 f3de0298 0000000a f42ee8b0
      00000000 c2a2d6c0 c2a2cd60 00000000 00004d1e 05be97d3 0000000a 
f42ee8b0
      f437d6b0 f437d81c 00000000 f42e8e94 f41dd000 7fffffff f41ddc04 
00000000
Call Trace:
[<c02c5abc>] schedule_timeout+0x53/0xee
[<c011caf1>] finish_task_switch+0x30/0x66
[<c011f586>] add_wait_queue+0x12/0x30
[<c01f5eba>] read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
mingetty      S 00000003  1512  1347      1                1346 (NOTLB)
f4184e90 00000082 00000000 00000003 00000001 f3dfb298 0000000a 00000003
      00000001 00000002 c2a2cd60 00000000 00013de6 0c853917 0000000a 
c0314a60
      df494130 df49429c 00000002 00000000 f3de2000 7fffffff f3de2c04 
00000000
Call Trace:
[<c02c5abc>] schedule_timeout+0x53/0xee
[<c011f586>] add_wait_queue+0x12/0x30
[<c01f5eba>] read_chan+0x31b/0x759
[<c011f5e2>] remove_wait_queue+0xf/0x34
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01a2131>] selinux_file_permission+0x117/0x120
[<c011dc6f>] default_wake_function+0x0/0xc
[<c01f1822>] tty_read+0xcf/0x11e
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
ksh           S E00A9EDC  1432 22292   1317 22319               (NOTLB)
e00a9f28 00000082 00000004 e00a9edc 00000004 00000004 00000000 ffffffff
      00000000 c011a65b c2a2cd60 00000000 00000c70 4c894c71 00087cbf 
c0314a60
      f43b4730 f43b489c 00000000 00000000 f43b47d4 fffffe00 f43b4730 
00000000
Call Trace:
[<c011a65b>] do_page_fault+0x1ae/0x5b6
[<c0124ab0>] do_wait+0x26e/0x449
[<c011c0a7>] task_rq_lock+0x2e/0x55
[<c011dc6f>] default_wake_function+0x0/0xc
[<c02c5604>] schedule+0x844/0x87a
[<c011dc6f>] default_wake_function+0x0/0xc
[<c0124d1e>] sys_wait4+0x27/0x2a
[<c0124d34>] sys_waitpid+0x13/0x17
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S 0000F008  1448 22319  22292 22405               (NOTLB)
e88ccf9c 00000082 0000572f 0000f008 f4391730 bfffda98 007f6ff4 f4391730
      00000000 c2a2d6c0 c2a2cd60 00000000 00007140 a5b92304 00087cce 
f4391730
      f43243b0 f432451c 00000000 e88cc000 e88cc000 e88ccfac bfffda5c 
e88cc000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S C12A6D60  3416 22405  22319 22406               (NOTLB)
de103f2c 00000082 c013f7c4 c12a6d60 000000d0 00000000 c031c180 00000000
      000000d0 c031e980 c2a2cd60 00000000 000004a3 c0755da5 00099f1b 
c0314a60
      f43c8230 f43c839c 00000000 00000000 a1acf1a7 a1acf1a7 de103fa0 
dfe3fe00
Call Trace:
[<c013f7c4>] buffered_rmqueue+0x17d/0x1a5
[<c02c5b3c>] schedule_timeout+0xd3/0xee
[<c01295f7>] process_timeout+0x0/0x5
[<c0166a4f>] do_poll+0x8e/0xac
[<c0166c0c>] sys_poll+0x19f/0x24f
[<c01660fd>] __pollwait+0x0/0x95
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S 0000F008  3144 22406  22405         22407       (NOTLB)
cf1aef9c 00000082 00005786 0000f008 f4255830 00404d68 007f6ff4 f4255830
      00000000 c2a2d6c0 c2a2cd60 00000000 000006a0 f85d2973 00099f1a 
f4255830
      f4391730 f439189c 00000000 cf1ae000 cf1ae000 cf1aefac 00404d68 
cf1ae000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S 0000F008  3132 22407  22405         22409 22406 (NOTLB)
c42aef9c 00000082 00005787 0000f008 f4390130 01139acc 007f6ff4 f4390130
      00000000 c2a2d6c0 c2a2cd60 00000000 00000f97 81fa5c90 00099f1a 
f4390130
      f43c9830 f43c999c 00000000 c42ae000 c42ae000 c42aefac 01139b60 
c42ae000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
trisim.exe    S 0000F008  1448 22409  22405         22410 22407 (NOTLB)
c42bff9c 00000082 00005789 0000f008 f4390c30 00000000 00000000 f4390c30
      00000000 c2a2d6c0 c2a2cd60 00000000 00006598 9687bd5b 00099f1b 
f4390c30
      f4390130 f439029c 00000000 c42bf000 c42bf000 c42bffac 01534f44 
c42bf000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    R running  1432 22410  22405         22411 22409 (NOTLB)
trisim.exe    S F42EA380  1628 22411  22405         22412 22410 (NOTLB)
d0104f9c 00000082 f4390c30 f42ea380 f4390130 f42ea380 f42ea380 f4390130
      00000000 c2a2d6c0 c2a2cd60 00000000 00000566 2a95a5bc 00099f1b 
f4390130
      f4255830 f425599c 00000000 d0104000 d0104000 d0104fac 01939c88 
d0104000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    S 00000000  1448 22412  22405         22413 22411 (NOTLB)
c7819f9c 00000082 d5fced5c 00000000 f43c8d30 c011f6ee c7819f58 f43c8d30
      00000000 c2a2d6c0 c2a2cd60 00000000 0081c671 650b5cbe 00099f1b 
f43c8d30
      f40bd7b0 f40bd91c 00000000 c7819000 c7819000 c7819fac 01b34f44 
c7819000
Call Trace:
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
[<c02c007b>] unix_release_sock+0x15a/0x201
trisim.exe    S F42EA380  3140 22413  22405               22412 (NOTLB)
c3ddff9c 00000082 f4390130 f42ea380 f4390c30 f42ea380 f42ea380 f4390c30
      00000000 c2a2d6c0 c2a2cd60 00000000 00008638 48cf686e 00099f1b 
f4390c30
      f437c0b0 f437c21c 00000000 c3ddf000 c3ddf000 c3ddffac 01d39c88 
c3ddf000
Call Trace:
[<c010511b>] sys_rt_sigsuspend+0xed/0x108
[<c02c7377>] syscall_call+0x7/0xb
crond         S 00000002  1608 14112   1293 14113               (NOTLB)
d13f0ee8 00000082 00000002 00000002 f40bd7b0 ffffffff 00000000 f40bd7b0
      00000000 c2a2d6c0 c2a2cd60 00000000 000061a7 3059f2cb 00098bb3 
f40bd7b0
      f42ee330 f42ee49c 00000000 c011f619 f3df7b60 d13f0f10 d13f0f04 
f3df7af0
Call Trace:
[<c011f619>] prepare_to_wait+0x12/0x4c
[<c0160257>] pipe_wait+0x6b/0xa2
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01604b3>] pipe_readv+0x225/0x29e
[<c0160548>] pipe_read+0x1c/0x20
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
run-parts     S D79FEEDC  1260 14113  14112 14479               (NOTLB)
d79fef28 00000082 00000004 d79feedc c4204330 00000004 00000000 c4204330
      00000000 c2a2d6c0 c2a2cd60 00000000 00007b75 44da005a 00098bbc 
c4204330
      f42ee8b0 f42eea1c 00000000 ffffffff f42ee954 fffffe00 f42ee8b0 
00000000
Call Trace:
[<c0124ab0>] do_wait+0x26e/0x449
[<c011dc6f>] default_wake_function+0x0/0xc
[<c012ca8b>] sys_rt_sigaction+0xdd/0xf2
[<c011dc6f>] default_wake_function+0x0/0xc
[<c0124d1e>] sys_wait4+0x27/0x2a
[<c0124d34>] sys_waitpid+0x13/0x17
[<c02c7377>] syscall_call+0x7/0xb
prelink       S C6F9AEDC  1424 14479  14113 14499   14480       (NOTLB)
c6f9af28 00000082 00000004 c6f9aedc f40bd7b0 00000004 00000000 f40bd7b0
      00000000 c2a2d6c0 c2a2cd60 00000000 0000b709 f0aeb223 00098bc0 
f40bd7b0
      c4204330 c420449c 00000000 ffffffff c42043d4 fffffe00 c4204330 
00000000
Call Trace:
[<c0124ab0>] do_wait+0x26e/0x449
[<c011dc6f>] default_wake_function+0x0/0xc
[<c012ca8b>] sys_rt_sigaction+0xdd/0xf2
[<c011dc6f>] default_wake_function+0x0/0xc
[<c0124d1e>] sys_wait4+0x27/0x2a
[<c0124d34>] sys_waitpid+0x13/0x17
[<c02c7377>] syscall_call+0x7/0xb
awk           S 00000002  1448 14480  14113               14479 (NOTLB)
f2b93ee8 00000082 00000002 00000002 c4204330 ffffffff 00000000 c4204330
      00000000 c2a2d6c0 c2a2cd60 00000000 00094313 450d357f 00098bbc 
c4204330
      f43c87b0 f43c891c 00000000 c011f619 f3c8ee10 f2b93f10 f2b93f04 
f3c8eda0
Call Trace:
[<c011f619>] prepare_to_wait+0x12/0x4c
[<c0160257>] pipe_wait+0x6b/0xa2
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c011f6ee>] autoremove_wake_function+0x0/0x2d
[<c01604b3>] pipe_readv+0x225/0x29e
[<c0160548>] pipe_read+0x1c/0x20
[<c0156011>] vfs_read+0xb6/0xe2
[<c0156224>] sys_read+0x3c/0x62
[<c02c7377>] syscall_call+0x7/0xb
prelink       R running  1404 14499  14479                     (NOTLB)
Mem-info:
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16

Free pages:       16984kB (1600kB HighMem)
Active:461390 inactive:360100 dirty:116 writeback:0 unstable:1 free:4246 
slab:13949 mapped:389908 pagetables:1013
DMA free:12640kB min:16kB low:32kB high:48kB active:0kB inactive:0kB 
present:16384kB pages_scanned:864 all_unreclaimable? yes
protections[]: 0 0 0
Normal free:2744kB min:928kB low:1856kB high:2784kB active:132672kB 
inactive:674444kB present:901120kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:1600kB min:512kB low:1024kB high:1536kB active:1712888kB 
inactive:765956kB present:2488508kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 4*4kB 4*8kB 3*16kB 4*32kB 4*64kB 1*128kB 1*256kB 1*512kB 1*1024kB 
1*2048kB 2*4096kB = 12640kB
Normal: 44*4kB 29*8kB 58*16kB 6*32kB 1*64kB 1*128kB 0*256kB 0*512kB 
1*1024kB 0*2048kB 0*4096kB = 2744kB
HighMem: 14*4kB 13*8kB 10*16kB 2*32kB 11*64kB 0*128kB 0*256kB 851503 
pages of RAM
622127 pages of HIGHMEM
8160 reserved pages
6997 pages shared
0 pages swap cached

===Boot dmesg===
Linux version 2.6.9-11.ELsmp (bhcompile@decompose.build.redhat.com) (gcc 
version 3.4.3 20050227 (Red Hat 3.4.3-22)) #1 SMP Fri May 20 18:26:27 
EDT 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cfe2f800 (usable)
 BIOS-e820: 00000000cfe2f800 - 00000000cfe3ea2b (ACPI NVS)
 BIOS-e820: 00000000cff2f800 - 00000000cff30000 (ACPI NVS)
 BIOS-e820: 00000000cff30000 - 00000000cff40000 (ACPI data)
 BIOS-e820: 00000000cff40000 - 00000000cfff0000 (ACPI NVS)
 BIOS-e820: 00000000cfff0000 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fed13000 - 00000000fed1a000 (reserved)
 BIOS-e820: 00000000fed1c000 - 00000000feda0000 (reserved)
2430MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 851503
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 622127 pages, LIFO batch:16
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 ACPIAM                                ) @ 0x000f4ea0
ACPI: RSDT (v001 INTEL  D915PGN  0x20050913 MSFT 0x00000097) @ 0xcff30000
ACPI: FADT (v002 INTEL  D915PGN  0x20050913 MSFT 0x00000097) @ 0xcff30200
ACPI: MADT (v001 INTEL  D915PGN  0x20050913 MSFT 0x00000097) @ 0xcff30390
ACPI: MCFG (v001 INTEL  D915PGN  0x20050913 MSFT 0x00000097) @ 0xcff30400
ACPI: ASF! (v016 LEGEND I865PASF 0x00000001 INTL 0x02002026) @ 0xcff35fc0
ACPI: TCPA (v001 INTEL  TBLOEMID 0x00000001 MSFT 0x00000097) @ 0xcff36060
ACPI: WDDT (v001 INTEL  OEMWDDT  0x00000001 INTL 0x02002026) @ 0xcff36092
ACPI: DSDT (v001 INTEL  D915PGN  0x00000001 INTL 0x02002026) @ 0x00000000
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID:  Product ID: Grantsdale-G APIC at: 0xFEE00000
Processor #0 15:3 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Built 1 zonelists
Kernel command line: initrd=slave/initrd.img acpi=off root=/dev/ram0 
NFSROOT=a.b.c.d:/part0/diskless/slave ramdisk_size=68000 ETHERNET=eth0 
SNAPSHOT=x335 BOOT_IMAGE=slave/vmlinuz
Initializing CPU#0
CPU 0 irqstacks, hard=c03db000 soft=c03bb000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3402.450 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3362928k/3406012k available (1824k kernel code, 42256k reserved, 
744k data, 176k init, 2488508k highmem)
Calibrating delay loop... 6684.67 BogoMIPS (lpj=3342336)
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebf3ff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.40GHz stepping 04
per-CPU timeslice cutoff: 2925.48 usecs.
task migration cache decay timeout: 3 msecs.
Total of 1 processors activated (6684.67 BogoMIPS).
WARNING: 1 siblings found for CPU0, should be 2
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=0
Brought up 1 CPUs
zapping low mappings.
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 10081k freed
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.2
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI->APIC IRQ transform: (B0,I29,P0) -> 193
PCI->APIC IRQ transform: (B0,I29,P1) -> 185
PCI->APIC IRQ transform: (B0,I29,P2) -> 177
PCI->APIC IRQ transform: (B0,I29,P3) -> 169
PCI->APIC IRQ transform: (B0,I31,P1) -> 185
PCI->APIC IRQ transform: (B0,I31,P1) -> 185
PCI->APIC IRQ transform: (B1,I0,P0) -> 169
PCI->APIC IRQ transform: (B6,I3,P0) -> 185
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
audit: initializing netlink socket (disabled)
audit(1142638314.283:0): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key D67B3E6B1ED6FEC7
- User ID: Red Hat, Inc. (Kernel Module GPG key)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 915G Chipset.
agpgart: Maximum main memory to use for agp memory: 3175M
agpgart: AGP aperture is 256M @ 0x0
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 68000K size 1024 blocksize
divert: not allocating divert_blk for non-ethernet device lo
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: TSSTcorpDVD-ROM SH-D162C, ATAPI CD/DVD-ROM drive
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
Using cfq io scheduler
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 176k freed
Intel(R) PRO/1000 Network Driver - version 5.6.10.1-k2-NAPI
Copyright (c) 1999-2004 Intel Corporation.
divert: allocating divert_blk for eth0
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
EXT2-fs warning: checktime reached, running e2fsck is recommended
e1000: eth0: e1000_watchdog: NIC Link is Up 1000 Mbps Full Duplex
ip_tables: (C) 2000-2002 Netfilter core team
SCSI subsystem initialized
libata version 1.10 loaded.
ata_piix version 1.03
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xFFA0 irq 14
ata1: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3469 86:3c41 87:4003 
88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
  Vendor: ATA       Model: WDC WD1200SD-01K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
ip_tables: (C) 2000-2002 Netfilter core team
i2c /dev entries driver
netconsole: network logging started
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03356c0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: no IPv6 routers present
Adding 4194296k swap on /temp/swapfile.  Priority:-1 extents:1058

===Free===
(typical output)
             total       used       free     shared    buffers     cached
Mem:       3373628    3056660     316968          0      65612    1364908
-/+ buffers/cache:    1626140    1747488
Swap:      4194296          0    4194296

Thanks for reading this far.

