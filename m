Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270716AbTHFLdJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270717AbTHFLdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:33:09 -0400
Received: from [66.212.224.118] ([66.212.224.118]:20749 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S270716AbTHFLdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:33:04 -0400
Date: Wed, 6 Aug 2003 07:21:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: use after free in detach_pid (recurring!)
Message-ID: <Pine.LNX.4.53.0308060719080.7244@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manfred, ok i think we have a winner here. 2.6.0-test2-mm4 wont even 
make it to runlevel 3 (i've rebooted it 5times now). How would you like to 
handle this?

Unable to handle kernel paging request at virtual address 6b6b6b6b
 printing eip:
c0137d17
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP 
CPU:    2
EIP:    0060:[<c0137d17>]    Not tainted VLI
EFLAGS: 00010046
EIP is at detach_pid+0x17/0x140
eax: cbbb4d20   ebx: cbbb4e2c   ecx: 6b6b6b6b   edx: 6b6b6b6b
esi: cbbb4d70   edi: 00000000   ebp: 00000000   esp: ca51df10
ds: 007b   es: 007b   ss: 0068
Process S90crond (pid: 881, threadinfo=ca51c000 task=ca534060)
Stack: cbbb4d20 00000000 00000000 c0126a01 cbbb4d20 c0126b43 cbbb4d20 cbbb4d20 
       cbbb52f4 cbbb4d20 00000374 bfffeea4 c012886c cbbb4d20 cbbb4dd0 cbbb4d20 
       ca534060 00000001 c0128c15 cbbb4d20 bfffeea4 00000000 ca51c000 00000001 
Call Trace:
 [<c0126a01>] __unhash_process+0x41/0xc0
 [<c0126b43>] release_task+0xc3/0x250
 [<c012886c>] wait_task_zombie+0x1ec/0x200
 [<c0128c15>] sys_wait4+0x165/0x280
 [<c01201c0>] default_wake_function+0x0/0x20
 [<c01201c0>] default_wake_function+0x0/0x20
 [<c04e4897>] syscall_call+0x7/0xb

Code: 51 08 52 e8 6c ae fe ff 58 5b 5e c3 90 8d b4 26 00 00 00 00 57 56 53 
89 d3 8d 14 9b 8d 34 d 
 <6>note: S90crond[881] exited with preempt_count 2


-- 
function.linuxpower.ca
