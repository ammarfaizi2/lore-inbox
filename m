Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262019AbSIYQSw>; Wed, 25 Sep 2002 12:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbSIYQSw>; Wed, 25 Sep 2002 12:18:52 -0400
Received: from mail.fibrespeed.net ([216.168.105.35]:1796 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S262019AbSIYQSv>; Wed, 25 Sep 2002 12:18:51 -0400
Message-ID: <3D91E32A.6000107@fibrespeed.net>
Date: Wed, 25 Sep 2002 12:24:10 -0400
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
Organization: FibreSpeed Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Consistent disk errors and oopsen
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a client running 2.4.18 with FreeS/WAN 1.98b patched in and using 
software RAID-1 on two IDE disks with Ext-3 on top of that.  They are 
getting consistent errors where the drives become un-sync'd but running 
a raidhotadd seems to repair them just fine.  They are also getting 
these errors in the syslog:

Sep 25 10:46:51 gw kernel: journal_bmap_Rc2009e7d: journal block not 
found at offset 7185 on md
Sep 25 10:46:51 gw kernel: Aborting journal on device md(9,3).
Sep 25 10:46:51 gw kernel: attempt to access beyond end of device
Sep 25 10:46:51 gw kernel: 09:03: rw=1, want=1625616132, limit=4192192
[... repeat the above two lines a few times ...]
Sep 25 10:46:51 gw kernel: Assertion failure in 
__journal_remove_journal_head() at journal.c:1730: "buffer_jbd(bh)"

[... and then an oops: ]

 >>EIP; d08181ce <[jbd]__journal_remove_journal_head+7e/e0>   <=====
Trace; d0819e60 <[jbd].rodata.end+1a91/4cb9>
Trace; d0818a98 <[jbd].rodata.end+6c9/4cb9>
Trace; d08188bf <[jbd].rodata.end+4f0/4cb9>
Trace; d0818ab6 <[jbd].rodata.end+6e7/4cb9>
Trace; d0818279 <[jbd]journal_unlock_journal_head+49/60>
Trace; d0814804 <[jbd]journal_commit_transaction+854/e6a>
Trace; c010844d <do_IRQ+6d/b0>
Trace; c010846c <do_IRQ+8c/b0>
Trace; c010a498 <call_do_IRQ+5/d>
Trace; c0105a2e <__switch_to+3e/d0>
Trace; c01126b6 <schedule+2c6/2f0>
Trace; d08169d6 <[jbd]kjournald+106/1a0>
Trace; d08168b0 <[jbd]commit_timeout+0/10>
Trace; c0105726 <kernel_thread+26/30>
Trace; d08168d0 <[jbd]kjournald+0/1a0>
Code;  d08181ce <[jbd]__journal_remove_journal_head+7e/e0>
00000000 <_EIP>:
Code;  d08181ce <[jbd]__journal_remove_journal_head+7e/e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d08181d0 <[jbd]__journal_remove_journal_head+80/e0>
   2:   83 c4 14                  add    $0x14,%esp
Code;  d08181d3 <[jbd]__journal_remove_journal_head+83/e0>
   5:   39 1e                     cmp    %ebx,(%esi)
Code;  d08181d5 <[jbd]__journal_remove_journal_head+85/e0>
   7:   74 23                     je     2c <_EIP+0x2c> d08181fa 
<[jbd]__journal_remove_journal_head+aa/e0>
Code;  d08181d7 <[jbd]__journal_remove_journal_head+87/e0>
   9:   68 c5 8a 81 d0            push   $0xd0818ac5
Code;  d08181dc <[jbd]__journal_remove_journal_head+8c/e0>
   e:   68 c3 06 00 00            push   $0x6c3
Code;  d08181e1 <[jbd]__journal_remove_journal_head+91/e0>
  13:   68 00 00 00 00            push   $0x0

-- 
Michael T. Babcock
C.T.O., FibreSpeed Ltd.
http://www.fibrespeed.net/~mbabcock


