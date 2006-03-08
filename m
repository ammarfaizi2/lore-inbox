Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWCHPBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWCHPBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 10:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWCHPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 10:01:15 -0500
Received: from surfboard.ka.sara.nl ([145.100.6.3]:49707 "EHLO
	surfboard.ka.sara.nl") by vger.kernel.org with ESMTP
	id S932141AbWCHPBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 10:01:14 -0500
Message-ID: <440EF1A7.8020400@sara.nl>
Date: Wed, 08 Mar 2006 16:00:55 +0100
From: Bas van der Vlies <basv@sara.nl>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Nfsd crashes/oops in 2.6.16-rc5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Mar 2006 15:00:58.0736 (UTC) FILETIME=[1BB13F00:01C642C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

uname: 2.6.16-rc5
libc: libc-2.3.2.so
Debian: Sarge
SMP system: 2 CPU's

On our 4 node GFS-cluster we use nfs to export the GFS filesystems to 
our 640 node cluster On our fileserver nodes we get an nfs crash/oops. 
We tried serveral kernels and they crashes/oops are the same. We node
installed 2.6.16-rc5 and here is the oops:

nable to handle kernel NULL pointer dereference at virtual address 00000038
  printing eip:
f89a4be3
*pde = 37809001
*pte = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: lock_dlm dlm cman dm_round_robin dm_multipath sg 
ide_floppy ide_cd cdrom qla2xxx siimage piix e1000 gfs lock_harness dm_mod
CPU:    0
EIP:    0060:[<f89a4be3>]    Tainted: GF     VLI
EFLAGS: 00010246   (2.6.16-rc5-sara3 #1)
EIP is at gfs_create+0x6f/0x153 [gfs]
eax: 00000000   ebx: ffffffef   ecx: f27d0d98   edx: ffffffef
esi: f2f84690   edi: f8b93000   ebp: f34a5e98   esp: f34a5e20
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 8973, threadinfo=f34a4000 task=f3462a70)
Stack: <0>f092a530 00000001 f34a5e48 00000000 f34a5e84 f89a6628 f34a5e48 
ee1fc324 00000003 00000000 f34a5e48 f34a5e48 00000000 f3462a70 00000003 
f34a5e5c f34a5e5c f27d0d98 f3462a70 00000001 00000020 00000000 000000c2 
00000000
Call Trace:
  [<c0103599>] show_stack_log_lvl+0xad/0xb5
  [<c01036db>] show_registers+0x10d/0x176
  [<c01038ad>] die+0xf2/0x16d
  [<c010f668>] do_page_fault+0x3dd/0x57a
  [<c010322f>] error_code+0x4f/0x54
  [<c01585f2>] vfs_create+0x6a/0xa7
  [<c0195e1c>] nfsd_create_v3+0x2b1/0x48a
  [<c019af2f>] nfsd3_proc_create+0x116/0x123
  [<c019229f>] nfsd_dispatch+0xbe/0x17f
  [<c02e0a52>] svc_process+0x381/0x5c7
  [<c019208c>] nfsd+0x18d/0x2e2
  [<c0100ed9>] kernel_thread_helper+0x5/0xb
Code: 94 50 8b 45 0c ff 75 10 83 c0 1c 6a 01 89 45 88 50 8d 45 c4 50 e8 
70 08 ff ff 83 c4 14 89 c3 85 c0 74 4883 f8 ef 75 33 8b 45 14 <80> 78 38 
00 78 2a 8d 45 94 50 8d 45 c4 6a 00 ff 75 88 50 e8 3c
  BUG: nfsd/8973, lock held at task exit time!
  [ee1fc398] {inode_init_once}
.. held by:              nfsd: 8973 [f3462a70, 115]
... acquired at:               nfsd_create_v3+0x127/0x48a
-- 
--
********************************************************************
*                                                                  *
*  Bas van der Vlies                     e-mail: basv@sara.nl      *
*  SARA - Academic Computing Services    phone:  +31 20 592 8012   *
*  Kruislaan 415                         fax:    +31 20 6683167    *
*  1098 SJ Amsterdam                                               *
*                                                                  *
********************************************************************
