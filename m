Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTICUoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264234AbTICUoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:44:24 -0400
Received: from pc1-cmbg5-6-cust223.cmbg.cable.ntl.com ([81.104.201.223]:8949
	"EHLO flat") by vger.kernel.org with ESMTP id S264231AbTICUoV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:44:21 -0400
Date: Wed, 3 Sep 2003 21:46:45 +0100
From: cb-lkml@fish.zetnet.co.uk
To: linux-kernel@vger.kernel.org
Subject: [2.6.0-test4-mm5] [BLUETOOTH] rfcomm: kernel BUG at include/net/sock.h:459!
Message-ID: <20030903204645.GA2094@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I get this BUG (twice) during boot when the rfcomm init script runs.

System info available on request.

------------[ cut here ]------------
kernel BUG at include/net/sock.h:459!
invalid operand: 0000 [#1]
PREEMPT 
CPU:    0
EIP:    0060:[<c8859860>]    Not tainted VLI
EFLAGS: 00010286
EIP is at l2cap_sock_alloc+0xd0/0xe0 [l2cap]
eax: c88d4e60   ebx: c6f9ace0   ecx: 00000000   edx: c6f9ace0
esi: 00000000   edi: 00000001   ebp: ffffff9f   esp: c72a5f10
ds: 007b   es: 007b   ss: 0068
Process krfcommd (pid: 443, threadinfo=c72a4000 task=c731e6b0)
Stack: c77411e0 00000000 00000024 000000d0 c77411e0 ffffffa3 c88598d4 c77411e0 
       00000000 000000d0 00000000 c88ca0ec c77411e0 00000000 0000001f c77411e0 
       00000001 c020193c c77411e0 00000000 c72a5fa4 00000000 c72a5fdc 00000000 
Call Trace:
 [<c88598d4>] l2cap_sock_create+0x64/0xa0 [l2cap]
 [<c88ca0ec>] bt_sock_create+0x8c/0x110 [bluetooth]
 [<c020193c>] sock_create+0xcc/0x270
 [<c886f06b>] rfcomm_l2sock_create+0x2b/0x60 [rfcomm]
 [<c8871910>] rfcomm_add_listener+0x10/0x170 [rfcomm]
 [<c011baba>] preempt_schedule+0x2a/0x50
 [<c011c272>] set_user_nice+0x122/0x160
 [<c8871b1c>] rfcomm_run+0x6c/0x90 [rfcomm]
 [<c8871ab0>] rfcomm_run+0x0/0x90 [rfcomm]
 [<c0109289>] kernel_thread_helper+0x5/0xc

Code: ff ff 89 5c 24 04 c7 04 24 40 e9 85 c8 e8 59 0a 07 00 89 d8 83 c4 10 5b 5e c3 e8 3c 22 8c f7 eb b7 0f 0b 28 01 af cf 85 c8 eb 93 <0f> 0b cb 01 c6 cf 85 c8 e9 66 ff ff ff 8d 76 00 83 ec 10 89 5c 
 <6>Bluetooth: RFCOMM TTY layer initialized
------------[ cut here ]------------
kernel BUG at include/net/sock.h:459!
invalid operand: 0000 [#2]
PREEMPT 
CPU:    0
EIP:    0060:[<c8872515>]    Not tainted VLI
EFLAGS: 00010286
EIP is at rfcomm_sock_alloc+0x115/0x130 [rfcomm]
eax: c88d4e60   ebx: c6f9a060   ecx: 00000000   edx: c6f9a060
esi: 000000d0   edi: 00000001   ebp: ffffff9f   esp: c79cfef8
ds: 007b   es: 007b   ss: 0068
Process rfcomm (pid: 440, threadinfo=c79ce000 task=c79e5370)
Stack: c7741360 00000003 00000008 000000d0 fffffff4 ffffffa3 c887257a c7741360 
       00000003 000000d0 00000003 c88ca0ec c7741360 00000003 0000001f c7741360 
       00000001 c020193c c7741360 00000003 00000000 00000001 c79cff90 00000000 
Call Trace:
 [<c887257a>] rfcomm_sock_create+0x4a/0x70 [rfcomm]
 [<c88ca0ec>] bt_sock_create+0x8c/0x110 [bluetooth]
 [<c020193c>] sock_create+0xcc/0x270
 [<c0201b0b>] sys_socket+0x2b/0x60
 [<c0202b09>] sys_socketcall+0x89/0x2a0
 [<c025ff0f>] syscall_call+0x7/0xb

Code: 89 d8 83 c4 10 5b 5e c3 89 1c 24 e8 36 15 99 f7 31 c0 eb ee e8 8d 95 8a f7 e9 79 ff ff ff 0f 0b 28 01 b5 55 87 c8 e9 52 ff ff ff <0f> 0b cb 01 cc 55 87 c8 e9 21 ff ff ff 8d b4 26 00 00 00 00 8d 
