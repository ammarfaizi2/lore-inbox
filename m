Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262402AbTEFHAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 03:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbTEFHAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 03:00:05 -0400
Received: from einstein.kowalk.Informatik.Uni-Oldenburg.de ([134.106.55.1]:14208
	"EHLO walker.pmhahn.de") by vger.kernel.org with ESMTP
	id S262402AbTEFHAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 03:00:03 -0400
Date: Tue, 6 May 2003 09:12:26 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@brodo.de>
Subject: [BUG,2.5.69] OOPS in cpufreq_cpu_get
Message-ID: <20030506071225.GA2320@titan.lahn.de>
Mail-Followup-To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Dominik Brodowski <linux@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dominik, LKML!

2.5.69 oopsed while reading /proc/cpufreq:

Linux version 2.5.69 (root@walker) (gcc version 3.2.3) #3 Mon May 5 15:09:50 CEST 2003
...
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU:     After generic, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 01
...
Unable to handle kernel NULL pointer dereference at virtual address 00000020
 printing eip:
c013589f
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c013589f>]    Not tainted
EFLAGS: 00010246
EIP is at cpufreq_cpu_get+0x1f/0xe0
eax: 00000000   ebx: 00000000   ecx: cbbf3ba0   edx: cbc21eb0
esi: 00000001   edi: cbc21eb0   ebp: cbc21e68   esp: cbc21e5c
ds: 007b   es: 007b   ss: 0068
Process mc (pid: 300, threadinfo=cbc20000 task=c13ac780)
Stack: cbc21e74 00000000 00000000 cbc21e88 c01367e1 00000000 cbc21e88 c01b5a4f 
       00000000 c59ce045 00000000 cbc21f1c c023434f cbc21eb0 00000000 c02dfaac 
       cbc20000 c02dfaac cbc21ed0 c013d15c c10e0830 00000000 c02e0f30 00000000 
Call Trace:
 [<c01367e1>] cpufreq_get_policy+0x21/0x90
 [<c01b5a4f>] sprintf+0x1f/0x30
 [<c023434f>] cpufreq_proc_read+0x8f/0x150
 [<c013d15c>] buffered_rmqueue+0xbc/0x160
 [<c013d28d>] __alloc_pages+0x8d/0x300
 [<c02342c0>] cpufreq_proc_read+0x0/0x150
 [<c017f2ee>] proc_file_read+0xbe/0x250
 [<c0153ae3>] vfs_read+0xd3/0x140
 [<c0164784>] do_fcntl+0xd4/0x1c0
 [<c0153d8c>] sys_read+0x3c/0x60
 [<c010a33b>] syscall_call+0x7/0xb

Code: 8b 50 20 85 d2 74 2b b8 00 e0 ff ff 21 e0 ff 40 14 83 3a 02 
 
BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
