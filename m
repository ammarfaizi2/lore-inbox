Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbTHZVyC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 17:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTHZVyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 17:54:01 -0400
Received: from zero.aec.at ([193.170.194.10]:44044 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262921AbTHZVx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 17:53:57 -0400
Date: Tue, 26 Aug 2003 23:53:53 +0200
From: Andi Kleen <ak@muc.de>
To: linux-kernel@vger.kernel.org
Subject: [ak@muc.de: frequent BUG in ext3 in 2.4.22/amd64]
Message-ID: <20030826215353.GA8160@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to cc linux-kernel on the first mail.

----- Forwarded message from Andi Kleen <ak@muc.de> -----

Date: Tue, 26 Aug 2003 23:27:19 +0200
From: Andi Kleen <ak@muc.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, akpm@osdl.org,
	sct@redhat.com
Subject: frequent BUG in ext3 in 2.4.22/amd64 
User-Agent: Mutt/1.4i


When I run LTP with light background load (kernel compile) on 2.4.22/AMD64 I 
get an repeatable ext3 BUG quickly.

-Andi

ksymoops 2.4.6 on i686 2.4.20-4GB-athlon.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.20-4GB-athlon/ (default)
     -m lsrc/sledge/cvsref/linux-work/System.map (specified)

No modules in ksyms, skipping objects
Kernel BUG at checkpoint:591
invalid operand: 0000
CPU 0 
Pid: 92, comm: kjournald Not tainted
RIP: 0010:[<ffffffff8018edaf>]
Using defaults from ksymoops -t elf32-i386 -a i386
RSP: 0000:000001001f661bb8  EFLAGS: 00010216
RAX: 000000000000006a RBX: 000001001f1d4b28 RCX: 000001001f660000
RDX: 000001001f145ef8 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 000001001f740e00 R08: ffffffffffffffff R09: 0000000000000001
R10: 0000000000000000 R11: 000001001f660000 R12: 0000010015298b58
R13: 000001001f1d4b28 R14: 0000000000000004 R15: 000001001fbb8728
FS:  0000002a975e2060(0000) GS:ffffffff804b3400(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000002a99067000 CR3: 0000000000101000 CR4: 00000000000006e0
Process kjournald (pid: 92, stackpage=1001f661000)
Stack: 000001001f661bb8 0000000000000000 ffffffff8018edaf 0000010015298b58 
       000001001f740e00 0000010015298b58 ffffffff8018e9c3 0000010013e51c08 
       ffffffff8018e11c 0000010015298b58 ffffffff8018e93f 0000010019cfab68 
       000001001f740e00 000001001f740e90 000001001f740fc0 0000000000000000 
       0000000000000000 000001001f740f10 ffffffff8018c50f 0000000000000000 
       0000000000000000 0000010019cfa3f8 000001001f740e00 0000010013bed540 
       0000000000000aad ffffffffffffffff ffffffffffffffff ffffffffffffffff 
       ffffffffffffffff ffffffffffffffff 0000000000000216 0000000000000216 
       ffffffffffffffff 000001001565ae30 000001001565ad78 000001001565acc0 
       000001001565ac08 000001001565ab50 000001001565aa98 000001001565a9e0 
Call Trace: [<ffffffff8018edaf>] [<ffffffff8018e9c3>] 
       [<ffffffff8018e11c>] [<ffffffff8018e93f>] [<ffffffff8018c50f>] 
       [<ffffffff801203d1>] [<ffffffff8018fb30>] [<ffffffff8018f900>] 
       [<ffffffff80110be0>] [<ffffffff8018f920>] [<ffffffff80110bd8>] 
Code: 0f 0b 90 41 35 80 ff ff ff ff 4f 02 48 83 7b 58 00 74 34 48 
Error (Oops_bfd_perror): set_section_contents Bad value


>>EIP; ffffffff8018edaf <__journal_drop_transaction+19f/363>   <=====

Trace; ffffffff8018edaf <__journal_drop_transaction+19f/363>
Trace; ffffffff8018e9c3 <__journal_remove_checkpoint+63/80>
Trace; ffffffff8018e11c <__try_to_free_cp_buf+1c/50>
Trace; ffffffff8018e93f <__journal_clean_checkpoint_list+4f/70>
Trace; ffffffff8018c50f <journal_commit_transaction+26f/143c>
Trace; ffffffff801203d1 <thread_return+0/19f>
Trace; ffffffff8018fb30 <kjournald+210/320>
Trace; ffffffff8018f900 <commit_timeout+0/10>
Trace; ffffffff80110be0 <child_rip+8/10>
Trace; ffffffff8018f920 <kjournald+0/320>
Trace; ffffffff80110bd8 <child_rip+0/10>


1 error issued.  Results may not be reliable.


----- End forwarded message -----
