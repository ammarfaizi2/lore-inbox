Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310773AbSCHJpg>; Fri, 8 Mar 2002 04:45:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310777AbSCHJp0>; Fri, 8 Mar 2002 04:45:26 -0500
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:17305
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id <S310773AbSCHJpL>; Fri, 8 Mar 2002 04:45:11 -0500
Subject: 2.4.18-rc4-aa1 XFS oopses caused by cpio
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-4mdk 
Date: 08 Mar 2002 10:46:06 +0100
Message-Id: <1015580766.20800.3.camel@svetljo.st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
X-Scanner: exiscan *16jGvv-0003XG-00*lUo5Dly8yto* (Studentenwohnanlage Nuernberg St.-Peter)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

that's what i got

Unable to handle kernel NULL pointer dereference at virtual address
00000008
801dba4e
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<801dba4e>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000120   ebx: 00000000   ecx: 00000282   edx: 00000000
esi: 8b745a00   edi: 00000008   ebp: 9aa92000   esp: 9ca31904
ds: 0018   es: 0018   ss: 0018
Process cpio (pid: 20435, stackpage=9ca31000)
Stack: 00000282 00000004 8d5f4200 88dc0248 8d65b8c0 801db30d 88dc0248
00000008
       00000004 00000001 8d65b980 8d65b8c0 00000004 88dc0248 801db081
88dc0248
       8d65b980 8d65b8c0 00000004 8d65ba40 00000000 00000004 00000004
8b745b20
Call Trace: [<801db30d>] [<801db081>] [<801db674>] [<8022db0d>]
[<80209989>]
   [<8023bc4d>] [<8022dd94>] [<801db3a2>] [<8022e747>] [<80222538>]
[<8020a412>]
   [<8021d4b9>] [<80212496>] [<8020f959>] [<802236ac>] [<802299f5>]
[<80222f71>]
   [<80234f0e>] [<801d83bd>] [<80220981>] [<8020e103>] [<8022341a>]
[<8020e103>]
   [<80227c17>] [<80235098>] [<80235348>] [<80145966>] [<80145a52>]
[<8010722b>]
Code: 8b 4a 08 85 c9 74 1b 8d 74 26 00 8d bc 27 00 00 00 00 43 83

>>EIP; 801dba4e <xfs_alloc_mark_busy+3e/d0>   <=====
Trace; 801db30c <xfs_alloc_put_freelist+cc/e0>
Trace; 801db080 <xfs_alloc_fix_freelist+430/480>
Trace; 801db674 <xfs_alloc_vextent+124/3c0>
Trace; 8022db0c <_pagebuf_get_object+3c/140>
Trace; 80209988 <xfs_ialloc_ag_alloc+1d8/810>
Trace; 8023bc4c <kmem_zone_zalloc+3c/e0>
Trace; 8022dd94 <_pagebuf_free_object+f4/120>
Trace; 801db3a2 <xfs_alloc_read_agf+82/230>
Trace; 8022e746 <pagebuf_rele+66/80>
Trace; 80222538 <xfs_trans_brelse+d8/e0>
Trace; 8020a412 <xfs_dialloc+182/900>
Trace; 8021d4b8 <xfs_mod_incore_sb_batch+48/a0>
Trace; 80212496 <xfs_inode_item_unlock+76/80>
Trace; 8020f958 <xfs_ialloc+58/3e0>
Trace; 802236ac <xfs_dir_ialloc+8c/290>
Trace; 802299f4 <xfs_mkdir+374/640>
Trace; 80222f70 <xfs_trans_free_items+30/90>
Trace; 80234f0e <linvfs_common_cr+1ae/2b0>
Trace; 801d83bc <xfs_acl_iaccess+2c/90>
Trace; 80220980 <xfs_trans_reserve+90/160>
Trace; 8020e102 <xfs_iunlock+32/60>
Trace; 8022341a <xfs_dir_lookup_int+ba/2c0>
Trace; 8020e102 <xfs_iunlock+32/60>
Trace; 80227c16 <xfs_lookup+a6/110>
Trace; 80235098 <linvfs_lookup+68/c0>
Trace; 80235348 <linvfs_mkdir+18/20>
Trace; 80145966 <vfs_mkdir+106/160>
Trace; 80145a52 <sys_mkdir+92/e0>
Trace; 8010722a <system_call+32/38>
Code;  801dba4e <xfs_alloc_mark_busy+3e/d0>
00000000 <_EIP>:
Code;  801dba4e <xfs_alloc_mark_busy+3e/d0>   <=====
   0:   8b 4a 08                  mov    0x8(%edx),%ecx   <=====
Code;  801dba50 <xfs_alloc_mark_busy+40/d0>
   3:   85 c9                     test   %ecx,%ecx
Code;  801dba52 <xfs_alloc_mark_busy+42/d0>
   5:   74 1b                     je     22 <_EIP+0x22> 801dba70
<xfs_alloc_mark_busy+60/d0>
Code;  801dba54 <xfs_alloc_mark_busy+44/d0>
   7:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  801dba58 <xfs_alloc_mark_busy+48/d0>
   b:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi
Code;  801dba60 <xfs_alloc_mark_busy+50/d0>
  12:   43                        inc    %ebx
Code;  801dba60 <xfs_alloc_mark_busy+50/d0>
  13:   83 00 00                  addl   $0x0,(%eax)




