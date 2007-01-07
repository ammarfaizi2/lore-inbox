Return-Path: <linux-kernel-owner+w=401wt.eu-S964778AbXAGQ4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbXAGQ4g (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbXAGQ4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:56:35 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:29648 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932614AbXAGQ4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:56:35 -0500
Subject: crash on CONFIG_CFAG12864B=y in 2.6.20-rc3-mm1
From: Daniel Walker <dwalker@mvista.com>
To: maxextreme@gmail.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 07 Jan 2007 08:55:31 -0800
Message-Id: <1168188931.26086.255.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(forgot to CC LKML)

The options,

CONFIG_CFAG12864B=y
CONFIG_CFAG12864B_RATE=20

causes a crash at boot in 2.6.20-rc3-mm1. I don't have the hardware
associated with the options. It looks like it just doesn't have guards
to detect if the hardware doesn't exists.

Here is the crash,

ks0108: ERROR: parport didn't find 888 port
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000004 printing eip:
c02dbff9
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP
last sysfs file:
Modules linked in:
CPU:    3
EIP:    0060:[<c02dbff9>]    Not tainted VLI
EFLAGS: 00010246   (2.6.20-rc3-mm1 #11)
EIP is at ks0108_writecontrol+0x79/0xc0
eax: 00001008   ebx: 0000000a   ecx: 673e2eb8   edx: 00000001
esi: 0000000a   edi: 00000000   ebp: f7c3ff6c   esp: f7c3ff50
ds: 007b   es: 007b   fs: 00d8  gs: 0000  ss: 0068
Process swapper (pid: 1, ti=f7c3e000 task=f7c26a90 task.ti=f7c3e000)
Stack: 00000001 f7552c40 f7c3ff60 c0120e3f 00000000 c049f450 00000000 f7c3ff74
       c02dc159 f7c3ff80 c02dc177 00000000 f7c3ff98 c048feda 00000378 c02d74db
       00000000 00000000 f7c3ffe0 c0478610 c03d9d35 00000004 f7c26a90 c0473fc4
Call Trace:
 [<c01053da>] show_trace_log_lvl+0x1a/0x30
 [<c0105499>] show_stack_log_lvl+0xa9/0xd0
 [<c01056c7>] show_registers+0x207/0x370
 [<c0105949>] die+0x119/0x250
 [<c011d267>] do_page_fault+0x277/0x610
 [<c038e9d4>] error_code+0x7c/0x84
 [<c02dc159>] cfag12864b_e+0x19/0x20
 [<c02dc177>] cfag12864b_page+0x17/0x30
 [<c048feda>] cfag12864b_init+0x8a/0x130
 [<c0478610>] init+0x110/0x250
 [<c0104fd3>] kernel_thread_helper+0x7/0x14
 =======================
Code: 8b 98 ec 00 00 00 0f b6 03 24 df 88 45 f3 80 75 f3 20 0f b6 43 01 20 45 f
EIP: [<c02dbff9>] ks0108_writecontrol+0x79/0xc0 SS:ESP 0068:f7c3ff50
 <0>Kernel panic - not syncing: Attempted to kill init!



