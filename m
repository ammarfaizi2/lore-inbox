Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268227AbUHYSiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268227AbUHYSiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUHYSiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 14:38:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:44729 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268227AbUHYSei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 14:34:38 -0400
Message-Id: <200408251834.i7PIYZ2s027802@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: linux-kernel@vger.kernel.org
Subject: 2.6.8.1-mm4 - kernel oops on ext3 fs out of inodes.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1025488448P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Aug 2004 14:34:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1025488448P
Content-Type: text/plain; charset=us-ascii

The setup:  /usr/local is an ext3 file system, has 750 or so free inodes.
I untar a tarball that has about 960 files, and about 200 files from the end,
we get this when we run out of free inodes:

Unable to handle kernel paging request at virtual address 025cb557
 printing eip:
c01b6859
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: thermal processor fan button battery ac rtc
CPU:    0
EIP:    0060:[<c01b6859>]    Not tainted VLI
EFLAGS: 00010202   (2.6.8.1-mm4) 
EIP is at ext3_discard_reservation+0x32/0x6f
eax: 025cb557   ebx: cd5e0000   ecx: 0000004e   edx: c944543c
esi: c944548c   edi: cf8f1c00   ebp: cd5e1e64   esp: cd5e1e5c
ds: 007b   es: 007b   ss: 0068
Process tar (pid: 14664, threadinfo=cd5e0000 task=ceafb830)
Stack: c944548c c944548c cd5e1e70 c015c6d3 c944548c cd5e1e84 c015d585 c944548c 
       c944548c ffffffe4 cd5e1e90 c015d60c ffffffe4 cd5e1ee4 c01b902e cd5e1ef4 
       00000246 c94453e0 00000050 cf10eb80 cf256400 00000202 0000005d ffffffff 
Call Trace:
 [<c0105e11>] show_stack+0x76/0x7e
 [<c0105f1a>] show_registers+0xea/0x152
 [<c01060d0>] die+0xd4/0x150
 [<c0112f8f>] do_page_fault+0x3e1/0x54d
 [<c0105a61>] error_code+0x2d/0x38
 [<c015c6d3>] clear_inode+0xc1/0xee
 [<c015d585>] generic_forget_inode+0x113/0x123
 [<c015d60c>] iput+0x62/0x65
 [<c01b902e>] ext3_new_inode+0x5dd/0x61c
 [<c01be5fa>] ext3_create+0x52/0xb3
 [<c01534e7>] vfs_create+0xbd/0xf7
 [<c015389e>] open_namei+0x15e/0x59e
 [<c01461a6>] filp_open+0x27/0x40
 [<c0146507>] sys_open+0x31/0x7e
 [<c0104fc1>] sysenter_past_esp+0x52/0x71
Code: 89 c6 53 83 7a 0c 00 74 5b bb 00 e0 ff ff 21 e3 ff 43 14 c7 42 08 00 00 00 00 c7 42 0c 00 0
0 00 00 c7 42 14 00 00 00 00 8b 42 04 <39> 10 74 08 0f 0b a4 00 be c4 38 c0 8b 4e b0 39 51 04 74 
08 0f 
 <6>note: tar[14664] exited with preempt_count 1
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
in_atomic():1, irqs_disabled():0
 [<c0105e2e>] dump_stack+0x15/0x17
 [<c0114f8d>] __might_sleep+0xa0/0xab
 [<c0118e8f>] do_exit+0xd7/0x3a5
 [<c010614c>] do_divide_error+0x0/0xf8
 [<c0112f8f>] do_page_fault+0x3e1/0x54d
 [<c0105a61>] error_code+0x2d/0x38
 [<c015c6d3>] clear_inode+0xc1/0xee
 [<c015d585>] generic_forget_inode+0x113/0x123
 [<c015d60c>] iput+0x62/0x65
 [<c01b902e>] ext3_new_inode+0x5dd/0x61c
 [<c01be5fa>] ext3_create+0x52/0xb3
 [<c01534e7>] vfs_create+0xbd/0xf7
 [<c015389e>] open_namei+0x15e/0x59e
 [<c01461a6>] filp_open+0x27/0x40
 [<c0146507>] sys_open+0x31/0x7e
 [<c0104fc1>] sysenter_past_esp+0x52/0x71
bad: scheduling while atomic!
 [<c0105e2e>] dump_stack+0x15/0x17
 [<c037b434>] schedule+0x3c/0x4ac
 [<c0139f50>] unmap_vmas+0x141/0x19a
 [<c013d7e0>] exit_mmap+0x61/0x11b
 [<c011550a>] mmput+0x7a/0x9f
 [<c0118f65>] do_exit+0x1ad/0x3a5
 [<c010614c>] do_divide_error+0x0/0xf8
 [<c0112f8f>] do_page_fault+0x3e1/0x54d
 [<c0105a61>] error_code+0x2d/0x38
 [<c015c6d3>] clear_inode+0xc1/0xee
 [<c015d585>] generic_forget_inode+0x113/0x123
 [<c015d60c>] iput+0x62/0x65
 [<c01b902e>] ext3_new_inode+0x5dd/0x61c
 [<c01be5fa>] ext3_create+0x52/0xb3
 [<c01534e7>] vfs_create+0xbd/0xf7
 [<c015389e>] open_namei+0x15e/0x59e
 [<c01461a6>] filp_open+0x27/0x40
 [<c0146507>] sys_open+0x31/0x7e
 [<c0104fc1>] sysenter_past_esp+0x52/0x71


The system lived for a while longer (long enough for me to get the 'dmesg'
run to save the output) and then hung up hard.

Quite reproducible - the dmesg output is from the 3rd time I did it (first time I
suspected "random NVidia lockup", second time I decided it wasn't random, 3rd time I
did it in single user mode to get a proper untainted output.

 

--==_Exmh_-1025488448P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBLNu7cC3lWbTT17ARAqhCAKDPCMri8d22gSO+Q/NBjATcmF5TVwCfeeMo
wNmIHBYNGOejAdujb5OdNbc=
=eYOr
-----END PGP SIGNATURE-----

--==_Exmh_-1025488448P--
