Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290630AbSA3Vli>; Wed, 30 Jan 2002 16:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290635AbSA3VlU>; Wed, 30 Jan 2002 16:41:20 -0500
Received: from mail.conwaycorp.net ([24.144.1.33]:4286 "HELO
	mail.conwaycorp.net") by vger.kernel.org with SMTP
	id <S290630AbSA3VlK>; Wed, 30 Jan 2002 16:41:10 -0500
Date: Wed, 30 Jan 2002 15:41:08 -0600
From: Nathan Poznick <poznick@conwaycorp.net>
To: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Oops in bdflush with 2.4.1[4|7]-xfs
Message-ID: <20020130214108.GA25792@conwaycorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We've got a couple of development machines with hardware raid sets
that we use XFS on.  A few weeks ago, while running 2.4.14-xfs, there
was an Oops in bdflush, which caused bdflush to go defunct, and
kupdated to go into some sort of loop, chewing one of the CPUs.  I
upgraded the machine to 2.4.17-xfs, and for a few weeks it's been
fine, but then this afternoon there was again an oops in bdflush,
which again caused bdflush to go defunct, and kupdated to chew a CPU
(along with an attempted sync, the shutdown process, etc).  Below is
the decoded oops.  Any help is appreciated.  Thanks.


ksymoops 0.7c on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000030
c0192fe9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0192fe9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000000
esi: 00000000   edi: 00000001   ebp: 00000000   esp: c4c49864
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 6, stackpage=c4c49000)
Stack: e5187ed8 00000000 00000000 c4c4996c c4c4996c c4c49b68 c4c49b68
0b000003 
       f3242be0 00000000 00000004 cbf27200 c4c498c8 f3242be0 00000046
0b000010 
       00000000 00000001 f79fd8f4 00000000 00000016 f71a5400 00000000
00000002 
Call Trace: [<c0194b68>] [<c018f9ad>] [<c018f746>] [<c01919ce>] [<c01a103e>]
   [<c021a41e>] [<c02208d2>] [<c022004a>] [<c0220244>] [<c02204b1>]
[<c0238573>] 
   [<c01ad063>] [<c01ad063>] [<c01a34b3>] [<c01a515f>] [<c0238573>]
[<c01d12fb>] 
   [<c01d23a6>] [<c01efd74>] [<c012b965>] [<c012b9ac>] [<c012c270>]
[<c01edcf3>] 
   [<c0182854>] [<c018188b>] [<c01edc78>] [<c01ede8b>] [<c01edc78>]
[<c0133745>] 
   [<c0133909>] [<c01369a4>] [<c0105000>] [<c01055db>] 
Code: 8b 52 30 89 54 24 58 51 55 8b 44 24 60 50 8b 54 24 78 52 e8 

>>EIP; c0192fe9 <pagebuf_lookup+79/8c>   <=====
Trace; c0194b68 <_pagebuf_handle_iovecs+dc/f0>
Trace; c018f9ad <nlm4svc_callback+19/98>
Trace; c018f746 <nlm4svc_proc_unshare+2/bc>
Trace; c01919ce <devpts_root_readdir+12e/134>
Trace; c01a103e <xfs_dm_punch_hole+1e/27c>
Trace; c021a41e <vt_ioctl+6ce/2050>
Trace; c02208d2 <do_con_trol+996/e28>
Trace; c022004a <do_con_trol+10e/e28>
Trace; c0220244 <do_con_trol+308/e28>
Trace; c02204b1 <do_con_trol+575/e28>
Trace; c0238573 <scsi_init_cmd_errh+a7/e0>
Trace; c01ad063 <xfs_attr_leaf_toosmall+1af/244>
Trace; c01ad063 <xfs_attr_leaf_toosmall+1af/244>
Trace; c01a34b3 <xfs_alloc_ag_vextent_exact+9b/178>
Trace; c01a515f <xfs_alloc_read_agf+93/23c>
Trace; c0238573 <scsi_init_cmd_errh+a7/e0>
Trace; c01d12fb <xfs_dir2_block_to_sf+f3/2f8>
Trace; c01d23a6 <xfs_dir2_sf_lookup+c6/280>
Trace; c01efd74 <xfs_trans_init+1384/1f30>
Trace; c012b965 <vmalloc_area_pages+35/1b0>
Trace; c012b9ac <vmalloc_area_pages+7c/1b0>
Trace; c012c270 <kmem_cache_destroy+7c/fc>
Trace; c01edcf3 <xfs_rename_target_checks+33/b8>
Trace; c0182854 <nfsd_cache_init+124/138>
Trace; c018188b <exp_rootfh+10f/278>
Trace; c01edc78 <xfs_rename_error_checks+c0/108>
Trace; c01ede8b <xfs_rename+113/c78>
Trace; c01edc78 <xfs_rename_error_checks+c0/108>
Trace; c0133745 <sys_ftruncate+4d/154>
Trace; c0133909 <sys_truncate64+bd/184>
Trace; c01369a4 <fsync_inode_buffers+140/18c>
Trace; c0105000 <_stext+0/0>
Trace; c01055db <kernel_thread+13/30>
Code;  c0192fe9 <pagebuf_lookup+79/8c>
00000000 <_EIP>:
Code;  c0192fe9 <pagebuf_lookup+79/8c>   <=====
   0:   8b 52 30                  mov    0x30(%edx),%edx   <=====
Code;  c0192fec <pagebuf_lookup+7c/8c>
   3:   89 54 24 58               mov    %edx,0x58(%esp,1)
Code;  c0192ff0 <pagebuf_lookup+80/8c>
   7:   51                        push   %ecx
Code;  c0192ff1 <pagebuf_lookup+81/8c>
   8:   55                        push   %ebp
Code;  c0192ff2 <pagebuf_lookup+82/8c>
   9:   8b 44 24 60               mov    0x60(%esp,1),%eax
Code;  c0192ff6 <pagebuf_lookup+86/8c>
   d:   50                        push   %eax
Code;  c0192ff7 <pagebuf_lookup+87/8c>
   e:   8b 54 24 78               mov    0x78(%esp,1),%edx
Code;  c0192ffb <pagebuf_lookup+8b/8c>
  12:   52                        push   %edx
Code;  c0192ffc <pagebuf_readahead+0/3c>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c0193001 <pagebuf_readahead+5/3c>

