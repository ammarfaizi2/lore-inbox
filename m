Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUKXSnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUKXSnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262785AbUKXSk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:40:27 -0500
Received: from zeus.kernel.org ([204.152.189.113]:29882 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262775AbUKXROW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:14:22 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: linux-kernel@vger.kernel.org
Subject: 2.6.9 Oops: Major problems with XFS and ext3 (VFS related?)
Date: Wed, 24 Nov 2004 18:12:33 +0100
User-Agent: KMail/1.7.1
Cc: linux-xfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411241812.33529.as@cohaesio.com>
X-OriginalArrivalTime: 24 Nov 2004 17:12:18.0365 (UTC) FILETIME=[C09476D0:01C4D248]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lists, (XFS list CC'ed)

We are encountering what looks like a race on both ext3 and XFS on a high-load 
mailserver.

Here is the cituation:
We have a high-load mailserver serving IMAP from Maildirs. We originally had 
the maildirs on ext3 but the kernel eventually Oopsed every ~20 hours (Oops - 
included) - we then moved the Maildirs to XFS thinking the problems where 
history, but now we get a somewhat similar error from XFS (inluded). They 
both look like a race to me but I am not able to get more out of it.

System: IBM Dual Xeon P4 - IBM ips raidcontroller (raid 0+1) ~150G.
Kernel: Linux 2.6.9 SMP

So buttomline both ext3 and XFS causes crashes. Comments anyone? ...We are 
desperate.

Here is what XFS says:
<SNIP>
Filesystem "sdb1": xfs_trans_delete_ail: attempting to delete a log item that 
is not in the AIL
xfs_force_shutdown(sdb1,0x8) called from line 382 of file 
fs/xfs/xfs_trans_ail.c.  Return address = 0xc0216a56
@Linux version 2.6.9 (root@mail1.domain.tld) (gcc version 2.96 20000731 (Red 
Hat Linux 7.3 2.96-113)) #1 SMP Tue Oct 19 16:04:55 CEST 2004
</SNIP>

Here is what ext3 says:
<SNIP>
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
printing eip:
c018b2f5
*pde = 00000000
Oops: 0002 [#1]
SMP
Modules linked in: nfs e1000 iptable_nat rtc
CPU:    2
EIP:    0060:[<c018b2f5>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9)
EIP is at journal_commit_transaction+0x545/0x11b0
eax: d971826c   ebx: 00000000   ecx: e489eefc   edx: 00000014
esi: d971826c   edi: f7406000   ebp: ea0a6f80   esp: f7407d8c
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 177, threadinfo=f7406000 task=f7df63b0)
Stack: 03afe6b2 c2157478 f7407e40 f7406000 c2157414 00000000 00000000 00000000
       00000000 00000000 e489ebfc cd61056c 000010e8 01c2bf60 c040e020 00000000
       f7406000 0000001e f7407e1c c0412f80 00000008 f7407e5c c01134e3 f7407e1c
Call Trace:
 [<c01134e3>] find_busiest_group+0xf3/0x300
 [<c0113799>] find_busiest_queue+0xa9/0xd0
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c018e0e1>] kjournald+0xc1/0x230
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0112ba3>] finish_task_switch+0x33/0x70
 [<c0115620>] autoremove_wake_function+0x0/0x40
 [<c0103ff6>] ret_from_fork+0x6/0x14
 [<c018e000>] commit_timeout+0x0/0x10
 [<c018e020>] kjournald+0x0/0x230
 [<c010253d>] kernel_thread_helper+0x5/0x18
Code: 00 89 f0 e8 5e e1 17 00 83 c4 14 8b 45 18 85 c0 0f 84 49 01 00 00 bf 00 
e0 ff ff 21 e7 89 f6 8d bc 27 00 00 00 00 8b 70 20 8b 1e <f0> ff 43 0c 8b 03 
83 e0 04 74 4e 8b 94 24
 e8 01 00 00 8d 82 c0
</SNIP>

I will be happy to supply any info and do some testing - if anyone catches 
interest! :-)

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
