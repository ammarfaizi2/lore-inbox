Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268077AbUH1Wo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268077AbUH1Wo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268116AbUH1WmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:42:25 -0400
Received: from gepard.lm.pl ([212.244.46.42]:64925 "EHLO gepard.lm.pl")
	by vger.kernel.org with ESMTP id S268073AbUH1WkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:40:20 -0400
Subject: 2.6.9-rc1-mm1 kernel BUG at fs/jbd/checkpoint.c:646!
From: Krzysztof "Sierota (o2.pl/tlen.pl)" <Krzysztof.Sierota@firma.o2.pl>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: o2.pl Sp z o.o.
Message-Id: <1093732735.1866.2.camel@rakieeta>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 29 Aug 2004 00:38:55 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this keeps happening on the SMP highmem box under heavy sync IO load.

kernel BUG at fs/jbd/checkpoint.c:646!
invalid operand: 0000 [#1]
SMP
CPU:    3
EIP:    0060:[<c0199b44>]    Not tainted VLI
EFLAGS: 00010282   (2.6.9-rc1-mm1)
EIP is at __journal_drop_transaction+0x30c/0x39d
eax: 00000071   ebx: ccb83100   ecx: c02d9c3c   edx: c02d9c3c
esi: c320d200   edi: 00000000   ebp: 00000000   esp: ebd4ddac
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 1824, threadinfo=ebd4d000 task=f7b43830)
Stack: c02bbdc0 c02ab540 c02baafd 00000286 c02bab4d ccb83100 c320d200
c0199721
       c320d200 ccb83100 e0138d7c e4b1911c c01977ae e4b1911c ef34bc2c
00000003
       000187c7 00000051 ebd4d000 00000000 00000000 00000f7c c0eaa084
00000000
Call Trace:
 [<c0199721>] __journal_remove_checkpoint+0x4a/0x90
 [<c01977ae>] journal_commit_transaction+0x778/0x13b6
 [<c01178bc>] autoremove_wake_function+0x0/0x57
 [<c01178bc>] autoremove_wake_function+0x0/0x57
 [<c0115896>] find_busiest_queue+0x9e/0xbc
 [<c0115a9d>] load_balance_newidle+0x80/0x94
 [<c02a6a08>] schedule+0x2c4/0xb7b
 [<c0115f94>] __wake_up_common+0x3f/0x5e
 [<c01218fd>] del_timer_sync+0x92/0xcb
 [<c019a940>] kjournald+0xce/0x228
 [<c01178bc>] autoremove_wake_function+0x0/0x57
 [<c01178bc>] autoremove_wake_function+0x0/0x57
 [<c0103fd2>] ret_from_fork+0x6/0x14
 [<c019a868>] commit_timeout+0x0/0x9
 [<c019a872>] kjournald+0x0/0x228
 [<c0102309>] kernel_thread_helper+0x5/0xb
Code: 44 24 10 4d ab 2b c0 c7 44 24 0c 86 02 00 00 c7 44 24 08 fd aa 2b
c0 c7 44 24 04 40 b5 2a c0 c7 04 24 c0 bd 2b c0 e8 ff 01 f8 ff <0f> 0b
86 02 fd aa 2b c0 e9 aa fd ff ff c7 44 24 10 20 e5 2b c0


