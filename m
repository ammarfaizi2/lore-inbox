Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTJNGhz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTJNGhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:37:55 -0400
Received: from [217.222.53.238] ([217.222.53.238]:61708 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S262074AbTJNGhx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 02:37:53 -0400
Message-ID: <3F8B99B9.5030101@gts.it>
Date: Tue, 14 Oct 2003 08:37:45 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] ext3 bug
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel: 2.6.0-test7-bk5

Yesterday my laptop switched off by power failure; as usual, at reboot 
ext3 performed the journal recovery correctly, but now, trying to issue 
an apt-get update gives the following report, after which the file 
system is in a read-only state (note, I've not performed a disk check 
just in case you need to test something).

kernel BUG at fs/jbd/transaction.c:1224!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c018ff40>]    Not tainted
EFLAGS: 00010282
EIP is at journal_forget+0x1e0/0x230
eax: 0000005f   ebx: c627a000   ecx: 00000001   edx: c027b7d8
esi: c5c83810   edi: c68ce1b0   ebp: c74d3f00   esp: c627bd68
ds: 007b   es: 007b   ss: 0068
Process apt-get (pid: 373, threadinfo=c627a000 task=c62fc080)
Stack: c025d200 c024f667 c025b931 000004c8 c025ba47 00000000 c5f6a400 
c5c83810
        c121d424 c0183640 c121d424 c5c83810 c5c83810 00050000 00001000 
00050000
        c5f0d208 c121d424 c5f6a400 c0185bf2 c121d424 00000000 c5f6a400 
c5c83810
Call Trace:
  [<c0183640>] ext3_forget+0xf0/0x100
  [<c0185bf2>] ext3_clear_blocks+0x112/0x160
  [<c0185cd8>] ext3_free_data+0x98/0x160
  [<c0185e86>] ext3_free_branches+0xe6/0x270
  [<c0185e86>] ext3_free_branches+0xe6/0x270
  [<c01864c5>] ext3_truncate+0x4b5/0x600
  [<c018eb4d>] journal_start+0xad/0xe0
  [<c01836a3>] start_transaction+0x23/0x60
  [<c0183848>] ext3_delete_inode+0xc8/0x120
  [<c0183780>] ext3_delete_inode+0x0/0x120
  [<c0167dba>] generic_delete_inode+0x6a/0x110
  [<c0168043>] iput+0x63/0x90
  [<c015dec0>] sys_unlink+0x110/0x140
  [<c014da01>] sys_close+0x61/0xa0
  [<c010938b>] syscall_call+0x7/0xb

Code: 0f 0b c8 04 31 b9 25 c0 e9 41 ff ff ff c7 04 24 00 d2 25 c0
  <6>note: apt-get[373] exited with preempt_count 2

Message from syslogd@nbsr at Tue Oct 14 08:25:40 2003 ...
nbsr kernel: Assertion failure in journal_forget() at 
fs/jbd/transaction.c:1224: "!jh->b_committed_data"
Segmentation fault

-- 
Stefano RIVOIR
GTS Srl



