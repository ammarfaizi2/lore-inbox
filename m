Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262045AbTCHPdt>; Sat, 8 Mar 2003 10:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262046AbTCHPdt>; Sat, 8 Mar 2003 10:33:49 -0500
Received: from franka.aracnet.com ([216.99.193.44]:7084 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262045AbTCHPds>; Sat, 8 Mar 2003 10:33:48 -0500
Date: Sat, 08 Mar 2003 07:44:21 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 452] New: Null pointer dereference in find_inode_fast
Message-ID: <393980000.1047138261@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=452

           Summary: Null pointer dereference in iget_locked
    Kernel Version: 2.5.64
            Status: NEW
          Severity: normal
             Owner: hch@sgi.com
         Submitter: kpfleming@cox.net


Distribution: heavily modified RedHat 7.2
Hardware Environment: Athlon Thunderbird 1.0GHz, (2) WD1600JB
Software Environment: 2.5.64 kernel, LVM2 on top of MD RAID-1
Problem Description: Null pointer dereference in iget_locked

Mar  8 08:09:18 jeeves kernel: Unable to handle kernel NULL pointer dereference
at virtual address 00000000
 printing eip:
c0152ddc
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0152ddc>]    Not tainted
EFLAGS: 00010286
EIP is at find_inode_fast+0x1c/0x40
eax: 00000000   ebx: 00cb55d8   ecx: 00000000   edx: c53616a0
esi: cfd21000   edi: 00cb55d8   ebp: cfd21000   esp: c6cdbd88
ds: 007b   es: 007b   ss: 0068
Process make (pid: 11518, threadinfo=c6cda000 task=c3892680)
Stack: 00000000 c12a98b4 c0153209 cfd21000 c12a98b4 00cb55d8 00cb55d8 00000000 
       c17b4af8 00000000 00000000 00000000 00000000 00000000 00000000 c17b4af8 
       00cb55d8 00000000 c01ac7c4 cfd21000 00cb55d8 00000000 00000000 00000000 
Call Trace:
 [<c0153209>] iget_locked+0x39/0x80
 [<c01ac7c4>] xfs_iget+0x34/0x120
 [<c01c16b6>] xfs_dir_lookup_int+0x56/0xc0
 [<c01c52cd>] xfs_lookup+0x3d/0x70
 [<c01cf18f>] linvfs_lookup+0x3f/0x80
 [<c014988d>] real_lookup+0x4d/0xc0
 [<c0149ada>] do_lookup+0x4a/0x90
 [<c01cf5a0>] linvfs_permission+0x0/0x20
 [<c014a00e>] link_path_walk+0x4ee/0x7b0
 [<c01cc0bd>] linvfs_readdir+0x1bd/0x1d0
 [<c01495dd>] getname+0x5d/0xa0
 [<c014a664>] __user_walk+0x24/0x40
 [<c0146617>] vfs_stat+0x17/0x50
 [<c0146bc0>] sys_stat64+0x10/0x30
 [<c0130000>] s_show+0x150/0x1c0
 [<c010a5b3>] syscall_call+0x7/0xb

