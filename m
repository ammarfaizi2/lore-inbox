Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268020AbUIKBaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268020AbUIKBaV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 21:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268021AbUIKBaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 21:30:20 -0400
Received: from gepard.lm.pl ([212.244.46.42]:15559 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S268020AbUIKBaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 21:30:09 -0400
Subject: [BUG] kernel BUG at fs/jbd/checkpoint.c:646!
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: linux-kernel@vger.kernel.org
Cc: ext2-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-BKn5CZXHLeu1uPWjGMbY"
Organization: o2.pl Sp z o.o.
Message-Id: <1094866100.1770.338.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Sep 2004 03:28:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BKn5CZXHLeu1uPWjGMbY
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

the following bug is present on kernels: 2.6.7-mm6, 2.6.9-rc1-mm1,
2.6.8.1-mm3. If any testing would be needed I can trigger it here in the
matter of hours.

Oops from 2.6.8.1-mm3 attached.

Hope that someone will be able to find a solution for this.

tia,
Krzysztof

--=-BKn5CZXHLeu1uPWjGMbY
Content-Disposition: attachment; filename=2.6.8.1-mm3-oo1
Content-Type: text/plain; name=2.6.8.1-mm3-oo1; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

Assertion failure in __journal_drop_transaction() at fs/jbd/checkpoint.c:646: "transaction->t_forget == NULL"
------------[ cut here ]------------
kernel BUG at fs/jbd/checkpoint.c:646!
invalid operand: 0000 [#1]
SMP 
CPU:    2
EIP:    0060:[<c019d940>]    Not tainted VLI
EFLAGS: 00010282   (2.6.8.1-mm3) 
EIP is at __journal_drop_transaction+0x30c/0x39d
eax: 00000071   ebx: f7edc380   ecx: c0334c3c   edx: c0334c3c
esi: c31a5a00   edi: 00000000   ebp: 00000000   esp: f6495dac
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 1188, threadinfo=f6495000 task=f6a5f390)
Stack: c030c7cc c02fa560 c030b4e4 00000286 c030b534 f7edc380 c31a5a00 c019d51d 
       c31a5a00 f7edc380 f5e6d834 edde3b3c c019b5aa edde3b3c c32f5a00 00000003 
       000016fa c041916c f6495000 00000000 00000000 00000f64 f21d809c 00000000 
Call Trace:
 [<c019d51d>] __journal_remove_checkpoint+0x4a/0x90
 [<c019b5aa>] journal_commit_transaction+0x778/0x13b6
 [<c0117e2c>] autoremove_wake_function+0x0/0x57
 [<c0117e2c>] autoremove_wake_function+0x0/0x57
 [<c0116420>] scheduler_tick+0x18c/0x23f
 [<c019e73c>] kjournald+0xce/0x228
 [<c0117e2c>] autoremove_wake_function+0x0/0x57
 [<c0117e2c>] autoremove_wake_function+0x0/0x57
 [<c0103f86>] ret_from_fork+0x6/0x14
 [<c019e664>] commit_timeout+0x0/0x9
 [<c019e66e>] kjournald+0x0/0x228
 [<c0102309>] kernel_thread_helper+0x5/0xb
Code: 44 24 10 34 b5 30 c0 c7 44 24 0c 86 02 00 00 c7 44 24 08 e4 b4 30 c0 c7 44 24 04 60 a5 2f c0 c7 04 24 cc c7 30 c0 e8 43 c9 f7 ff <0f> 0b 86 02 e4 b4 30 c0 e9 aa fd ff ff c7 44 24 10 40 ef 30 c0 
 <1>Unable to handle kernel paging request at virtual address 80402028
 printing eip:
c0114761
*pde = 00000000
Oops: 0000 [#2]
SMP 
CPU:    3
EIP:    0060:[<c0114761>]    Not tainted VLI
EFLAGS: 00010096   (2.6.8.1-mm3) 
EIP is at task_rq_lock+0x2d/0x5f
eax: 30000002   ebx: c03fd0c0   ecx: c0402020   edx: c03fd0c0
esi: c0408f8c   edi: f6a5f390   ebp: c0408f54   esp: c0408f48
ds: 007b   es: 007b   ss: 0068
Process cleanup (pid: 29104, threadinfo=c0408000 task=f47da850)
Stack: f6a5f390 c019e664 c3043760 c0408f9c c0114cb2 f6a5f390 c0408f8c 00000001 
       f7434130 00000001 00000003 0000000e c3042c20 00000001 00000000 00000003 
       c3044820 00000296 f6a5f390 c019e664 c3043760 c0408fb0 c0114f1c f6a5f390 
Call Trace:
Stack pointer is garbage, not printing trace
Code: e5 83 ec 0c 89 74 24 04 89 7c 24 08 89 1c 24 8b 7d 08 8b 75 0c 9c 8f 06 fa 8b 47 04 b9 20 20 40 c0 8b 40 10 ba c0 d0 3f c0 89 d3 <03> 1c 81 f0 fe 0b 0f 88 bb 31 00 00 8b 47 04 8b 40 10 03 14 81 
 <0>Kernel panic - not syncing: Fatal exception in interrupt

--=-BKn5CZXHLeu1uPWjGMbY--

