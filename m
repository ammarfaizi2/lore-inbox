Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFBLaw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 07:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFBLaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 07:30:52 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:49129 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262171AbTFBLav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 07:30:51 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Assertion failure in 2.5.69-mm9
Date: Mon, 2 Jun 2003 21:45:30 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306022145.30533.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry been out of it a bit so you have probably already seen this which 
occurred at boot:

Freeing unused kernel memory: 268k freed
Assertion failure in __journal_remove_journal_head() at fs/jbd/journal.c:1686: 
"buffer_journal_head(bh)"
------------[ cut here ]------------
kernel BUG at fs/jbd/journal.c:1686!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<4017d988>]    Not tainted VLI
EFLAGS: 00010246
EIP is at __journal_remove_journal_head+0x30/0x120
eax: 0000006c   ebx: 4e781930   ecx: 40310e44   edx: 00000212
esi: 4dfef360   edi: 0000000b   ebp: 4eb94a00   esp: 4eb71dd8
ds: 007b   es: 007b   ss: 0068
Process kjournald (pid: 16, threadinfo=4eb70000 task=4eb6f940)
Stack: 402e11e0 402e1998 402e1195 00000696 402e1980 4e781930 4dfef360 4017daff
       4dfef360 4dfef360 4e781930 40179add 4e781930 4eb70000 4fd3766c 00000001
       4eb71fbc 4fd37678 4eb94a54 4fd37654 4fd3763c 00000000 00000f1c 4f6980e4
Call Trace:
 [<4017daff>] journal_put_journal_head+0x5b/0x80
 [<40179add>] journal_commit_transaction+0x87d/0xf70
 [<40114944>] autoremove_wake_function+0x0/0x38
 [<40114944>] autoremove_wake_function+0x0/0x38
 [<40116746>] __call_console_drivers+0x3e/0x50
 [<40113445>] default_wake_function+0x19/0x20
 [<40113482>] __wake_up_common+0x36/0x50
 [<40113320>] schedule+0x2a8/0x370
 [<4017bf4b>] kjournald+0xeb/0x29c
 [<4017be60>] kjournald+0x0/0x29c
 [<40114944>] autoremove_wake_function+0x0/0x38
 [<40114944>] autoremove_wake_function+0x0/0x38
 [<4017be50>] commit_timeout+0x0/0xc
 [<40106f7d>] kernel_thread_helper+0x5/0xc

Code: 0c 8b 5e 24 8b 06 a9 00 00 02 00 75 29 68 80 19 2e 40 68 96 06 00 00 68 
95 11 2e 40 68 98 19 2e 40 68 e0 11 2e 40 e8 70 8f f9 ff <0f> 0b 96 06 95 11 
2e 40 83 c4 14 83 7b 04 00 7d 29 68 b6 19 2e
 <6>note: kjournald[16] exited with preempt_count 1

Con
