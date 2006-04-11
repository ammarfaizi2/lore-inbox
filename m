Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWDKUba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWDKUba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWDKUba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:31:30 -0400
Received: from web51011.mail.yahoo.com ([68.142.224.81]:56227 "HELO
	web51011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750985AbWDKUb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:31:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=EAamRrq2FIH0tFkdeOz9K0bsrEilqpbApydgck3q1qB5m40gjVHOE3ZgOa4SeFOHT3kNMOIZdmlPsF7ZfqqwfW6gYGAb3gwskdcs7wnh2UIfeDPtZVFjG6uQ0/oHeEEpL1JS3KzhCzKciwphRjvD/bFzbfd/2d5l3n+N81NWkgM=  ;
Message-ID: <20060411203128.55352.qmail@web51011.mail.yahoo.com>
Date: Tue, 11 Apr 2006 13:31:28 -0700 (PDT)
From: Matthew L Foster <mfoster167@yahoo.com>
Subject: BUG 2.6.16-git20 prelink
To: linux-kernel@vger.kernel.org
Cc: mfoster167@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My machine was hung this morning, had to reboot, found the following in the log. Please CC me on
any replies since I am not subscribed to the list.

Apr 11 04:03:23 localhost kernel: BUG: unable to handle kernel paging request at virtual address
04000000
Apr 11 04:03:23 localhost kernel:  printing eip:
Apr 11 04:03:23 localhost kernel: c012e26f
Apr 11 04:03:23 localhost kernel: *pde = 00000000
Apr 11 04:03:23 localhost kernel: Oops: 0000 [#1]
Apr 11 04:03:23 localhost kernel: PREEMPT 
Apr 11 04:03:23 localhost kernel: Modules linked in:
Apr 11 04:03:23 localhost kernel: CPU:    0
Apr 11 04:03:23 localhost kernel: EIP:    0060:[<c012e26f>]    Not tainted VLI
Apr 11 04:03:23 localhost kernel: EFLAGS: 00010097   (2.6.16-git20 #7) 
Apr 11 04:03:23 localhost kernel: EIP is at find_get_pages+0x33/0x68
Apr 11 04:03:23 localhost kernel: eax: 8000086c   ebx: 00000005   ecx: de884e1c   edx: 04000000
Apr 11 04:03:23 localhost kernel: esi: 00000006   edi: d353d39c   ebp: de884dc0   esp: de884db8
Apr 11 04:03:23 localhost kernel: ds: 007b   es: 007b   ss: 0068
Apr 11 04:03:23 localhost kernel: Process prelink (pid: 2723, threadinfo=de884000 task=ce38a0b0)
Apr 11 04:03:23 localhost kernel: Stack: <0>de884e00 ffffffff de884ddc c01323e3 d353d450 00000000
0000000e de884e08 
Apr 11 04:03:23 localhost kernel:        ffffffff de884e4c c01329b1 de884e00 d353d450 00000000
0000000e 00000000 
Apr 11 04:03:23 localhost kernel:        ffffffff 00000000 00000000 00000000 c11c0160 c10cea20
c13c6820 c139b000 
Apr 11 04:03:23 localhost kernel: Call Trace:
Apr 11 04:03:23 localhost kernel:  <c01032bc> show_stack_log_lvl+0x8c/0x96   <c01033e6>
show_registers+0x120/0x18c
Apr 11 04:03:23 localhost kernel:  <c01035af> die+0x15d/0x1e8   <c010f599>
do_page_fault+0x444/0x527
Apr 11 04:03:23 localhost kernel:  <c0102d83> error_code+0x4f/0x54   <c01323e3>
pagevec_lookup+0x19/0x20
Apr 11 04:03:23 localhost kernel:  <c01329b1> truncate_inode_pages_range+0xe2/0x23c   <c0132b20>
truncate_inode_pages+0x15/0x1d
Apr 11 04:03:23 localhost kernel:  <c017762f> ext3_delete_inode+0x18/0xc5   <c015699e>
generic_delete_inode+0x6c/0xee
Apr 11 04:03:23 localhost kernel:  <c0156a34> generic_drop_inode+0x14/0x167   <c01564e1>
iput+0x6a/0x70
Apr 11 04:03:23 localhost kernel:  <c0154a90> dentry_iput+0x89/0xb9   <c0155491> dput+0x141/0x15d
Apr 11 04:03:24 localhost kernel:  <c014ece8> sys_renameat+0x183/0x1f3   <c014ed6a>
sys_rename+0x12/0x14
Apr 11 04:03:24 localhost kernel:  <c0102b5b> syscall_call+0x7/0xb  
Apr 11 04:03:24 localhost kernel: Code: fa b8 00 f0 ff ff 21 e0 ff 40 14 ff 75 10 8b 45 08 ff 75
0c 53 83 c0 04 50 e8 a2 63 08 00 89 d9 89 c6 31 d
b 83 c4 10 eb 13 8b 11 <8b> 02 f6 c4 40 74 03 8b 52 0c ff 42 04 43 83 c1 04 39 f3 75 e9 
Apr 11 04:03:24 localhost kernel:  <6>note: prelink[2723] exited with preempt_count 1
Apr 11 04:03:24 localhost kernel: BUG: prelink/2723, lock held at task exit time!
Apr 11 04:03:25 localhost kernel:  [df87fa58] {inode_init_once}
Apr 11 04:03:25 localhost kernel: .. held by:           prelink: 2723 [ce38a0b0, 135]
Apr 11 04:03:25 localhost kernel: ... acquired at:               lock_rename+0x87/0x8e


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
