Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265722AbUFDK4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbUFDK4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 06:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUFDK4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 06:56:13 -0400
Received: from hq.alert.sk ([147.175.66.131]:13471 "EHLO hq.alert.sk")
	by vger.kernel.org with ESMTP id S265722AbUFDK4C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 06:56:02 -0400
Date: Fri, 4 Jun 2004 12:55:50 +0200
To: linux-kernel@vger.kernel.org
Subject: Ext3 Oops of 2.6.6
Message-ID: <20040604105550.GA22713@hq.alert.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: nite@hq.alert.sk (Robert Varga)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

Tonight I got following 4 oopsen on a single-proc HT Compaq BL20p G2 server.
After the last one the machine went dead. Since a collegue of mine rebooted
it before I got to the console, I do not know the last error.

It runs RH 9.0 with vanilla 2.6.6 kernel and does not experience any
kind of heavy load during night (although it was heavily loaded the day
before yesterday).

I brought it down to init=/bin/bash today and e2fsck 1,32 of all
filesystems came out clean as a baby.

Any clues where the problem might be?

Jun  4 01:16:29 pwww1 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jun  4 01:16:29 pwww1 kernel:  printing eip:
Jun  4 01:16:29 pwww1 kernel: c012468a
Jun  4 01:16:29 pwww1 kernel: *pde = 00000000
Jun  4 01:16:29 pwww1 kernel: Oops: 0000 [#1]
Jun  4 01:16:29 pwww1 kernel: SMP
Jun  4 01:16:29 pwww1 kernel: CPU:    0
Jun  4 01:16:29 pwww1 kernel: EIP:    0060:[<c012468a>]    Not tainted
Jun  4 01:16:29 pwww1 kernel: EFLAGS: 00010246   (2.6.6)
Jun  4 01:16:29 pwww1 kernel: EIP is at groups_search+0x4b/0x70
Jun  4 01:16:29 pwww1 kernel: eax: 00000000   ebx: 00000001   ecx: 00000000   edx: 00000000
Jun  4 01:16:29 pwww1 kernel: esi: 00000000   edi: c938b554   ebp: 00000000   esp: db5c8eb8
Jun  4 01:16:29 pwww1 kernel: ds: 007b   es: 007b   ss: 0068
Jun  4 01:16:29 pwww1 kernel: Process patrol (pid: 4780, threadinfo=db5c8000 task=c15e06c0)
Jun  4 01:16:29 pwww1 kernel: Stack: 00000000 db5c8000 00000001 dfda6b1c dfda6b1c c0124833 000041ed 00000001
Jun  4 01:16:29 pwww1 kernel:        c0183e66 dfda6b1c c0183dc4 fffffff5 dfda6b1c c0150637 000041ed c1e4f001
Jun  4 01:16:29 pwww1 kernel:        c015121a c2aebe84 00000101 db5c8f78 d5916820 c2aeb584 c15e06c0 c0112bce
Jun  4 01:16:29 pwww1 kernel: Call Trace:
Jun  4 01:16:29 pwww1 kernel:  [<c0124833>] in_group_p+0x39/0x6a
Jun  4 01:16:29 pwww1 kernel:  [<c0183e66>] ext3_permission+0xa2/0x1a2
Jun  4 01:16:29 pwww1 kernel:  [<c0183dc4>] ext3_permission+0x0/0x1a2
Jun  4 01:16:29 pwww1 kernel:  [<c0150637>] permission+0x36/0x38
Jun  4 01:16:29 pwww1 kernel:  [<c015121a>] link_path_walk+0x7f1/0x8b8
Jun  4 01:16:29 pwww1 kernel:  [<c0112bce>] do_page_fault+0x114/0x4e0
Jun  4 01:16:29 pwww1 kernel:  [<c0151539>] path_lookup+0x8a/0x147
Jun  4 01:16:29 pwww1 kernel:  [<c0151b33>] open_namei+0x90/0x3c1
Jun  4 01:16:29 pwww1 kernel:  [<c0144344>] filp_open+0x33/0x54
Jun  4 01:16:29 pwww1 kernel:  [<c01446e2>] sys_open+0x4d/0x78
Jun  4 01:16:29 pwww1 kernel:  [<c0103c9f>] syscall_call+0x7/0xb
Jun  4 01:16:29 pwww1 kernel:
Jun  4 01:16:29 pwww1 kernel: Code: 2b 2c 90 85 ed 7e 11 8d 71 01 39 de 7c c1 31 c0 83 c4 04 5b

Jun  4 01:16:29 pwww1 kernel:  <1>Unable to handle kernel paging request at virtual address 080e1510
Jun  4 01:16:29 pwww1 kernel:  printing eip:
Jun  4 01:16:29 pwww1 kernel: c012468a
Jun  4 01:16:29 pwww1 kernel: *pde = 00000000
Jun  4 01:16:29 pwww1 kernel: Oops: 0000 [#2]
Jun  4 01:16:29 pwww1 kernel: SMP
Jun  4 01:16:29 pwww1 kernel: CPU:    1
Jun  4 01:16:29 pwww1 kernel: EIP:    0060:[<c012468a>]    Not tainted
Jun  4 01:16:29 pwww1 kernel: EFLAGS: 00010206   (2.6.6)
Jun  4 01:16:29 pwww1 kernel: EIP is at groups_search+0x4b/0x70
Jun  4 01:16:29 pwww1 kernel: eax: 080e1504   ebx: 00000006   ecx: 00000003   edx: 00000003
Jun  4 01:16:29 pwww1 kernel: esi: 00000000   edi: c938b554   ebp: 00000000   esp: db5c8c80
Jun  4 01:16:29 pwww1 kernel: ds: 007b   es: 007b   ss: 0068
Jun  4 01:16:29 pwww1 kernel: Process patrol (pid: 4781, threadinfo=db5c8000 task=c15e06c0)
Jun  4 01:16:29 pwww1 kernel: Stack: 00000000 db5c8000 00000001 ddad299c c8074e00 c0124833 000081ed 00000004
Jun  4 01:16:29 pwww1 kernel:        c0183e66 ddad299c c0183dc4 df021880 c8074e00 c0150637 db5c8000 00000006
Jun  4 01:16:29 pwww1 kernel:        c014e41a dfdaf5d8 00000080 00000000 00000000 db5c8e60 db5c8000 c0000000
Jun  4 01:16:29 pwww1 kernel: Call Trace:
Jun  4 01:16:29 pwww1 kernel:  [<c0124833>] in_group_p+0x39/0x6a
Jun  4 01:16:29 pwww1 kernel:  [<c0183e66>] ext3_permission+0xa2/0x1a2
Jun  4 01:16:29 pwww1 kernel:  [<c0183dc4>] ext3_permission+0x0/0x1a2
Jun  4 01:16:29 pwww1 kernel:  [<c0150637>] permission+0x36/0x38
Jun  4 01:16:30 pwww1 kernel:  [<c014e41a>] flush_old_exec+0x2e2/0x808
Jun  4 01:16:30 pwww1 kernel:  [<c014df8c>] kernel_read+0x40/0x53
Jun  4 01:16:30 pwww1 kernel:  [<c0168b41>] load_elf_binary+0x336/0xc1e
Jun  4 01:16:30 pwww1 kernel:  [<c014eb63>] search_binary_handler+0x5a/0x10a
Jun  4 01:16:30 pwww1 kernel:  [<c014ede5>] do_execve+0x1d2/0x222
Jun  4 01:16:30 pwww1 kernel:  [<c010293a>] sys_execve+0x43/0x6e
Jun  4 01:16:30 pwww1 kernel:  [<c0103c9f>] syscall_call+0x7/0xb
Jun  4 01:16:30 pwww1 kernel:
Jun  4 01:16:30 pwww1 kernel: Code: 2b 2c 90 85 ed 7e 11 8d 71 01 39 de 7c c1 31 c0 83 c4 04 5b

Jun  4 01:16:34 pwww1 kernel:  <1>Unable to handle kernel paging request at virtual address 080e1510
Jun  4 01:16:34 pwww1 kernel:  printing eip:
Jun  4 01:16:34 pwww1 kernel: c012468a
Jun  4 01:16:34 pwww1 kernel: *pde = 00000000
Jun  4 01:16:34 pwww1 kernel: Oops: 0000 [#3]
Jun  4 01:16:34 pwww1 kernel: SMP
Jun  4 01:16:34 pwww1 kernel: CPU:    0
Jun  4 01:16:34 pwww1 kernel: EIP:    0060:[<c012468a>]    Not tainted
Jun  4 01:16:34 pwww1 kernel: EFLAGS: 00010206   (2.6.6)
Jun  4 01:16:34 pwww1 kernel: EIP is at groups_search+0x4b/0x70
Jun  4 01:16:34 pwww1 kernel: eax: 080e1504   ebx: 00000006   ecx: 00000003   edx: 00000003
Jun  4 01:16:34 pwww1 kernel: esi: 00000000   edi: c938b554   ebp: 00000000   esp: cea69c80
Jun  4 01:16:34 pwww1 kernel: ds: 007b   es: 007b   ss: 0068
Jun  4 01:16:34 pwww1 kernel: Process patrol (pid: 4782, threadinfo=cea69000 task=c15e06c0)
Jun  4 01:16:34 pwww1 kernel: Stack: 00000000 cea69000 00000001 ddad299c c8074e00 c0124833 000081ed 00000004
Jun  4 01:16:34 pwww1 kernel:        c0183e66 ddad299c c0183dc4 df021680 c8074e00 c0150637 cea69000 00000006
Jun  4 01:16:34 pwww1 kernel:        c014e41a dfdaf5d8 00000080 00000000 00000000 cea69e60 cea69000 c0000000
Jun  4 01:16:34 pwww1 kernel: Call Trace:
Jun  4 01:16:34 pwww1 kernel:  [<c0124833>] in_group_p+0x39/0x6a
Jun  4 01:16:34 pwww1 kernel:  [<c0183e66>] <1>Unable to handle kernel paging request at virtual address 080e1510
Jun  4 01:16:34 pwww1 kernel:  printing eip:
Jun  4 01:16:34 pwww1 kernel: c012468a
Jun  4 01:16:34 pwww1 kernel: *pde = 00000000
Jun  4 01:16:34 pwww1 kernel: ext3_permission+0xa2/0x1a2
Jun  4 01:16:34 pwww1 kernel:  [<c0183dc4>] ext3_permission+0x0/0x1a2
Jun  4 01:16:34 pwww1 kernel:  [<c0150637>] permission+0x36/0x38
Jun  4 01:16:34 pwww1 kernel:  [<c014e41a>] flush_old_exec+0x2e2/0x808
Jun  4 01:16:34 pwww1 kernel:  [<c014df8c>] kernel_read+0x40/0x53
Jun  4 01:16:34 pwww1 kernel:  [<c0168b41>] load_elf_binary+0x336/0xc1e
Jun  4 01:16:34 pwww1 kernel:  [<c014eb63>] search_binary_handler+0x5a/0x10a
Jun  4 01:16:34 pwww1 kernel:  [<c014ede5>] do_execve+0x1d2/0x222
Jun  4 01:16:34 pwww1 kernel:  [<c010293a>] sys_execve+0x43/0x6e
Jun  4 01:16:34 pwww1 kernel:  [<c0103c9f>] syscall_call+0x7/0xb
Jun  4 01:16:34 pwww1 kernel:
Jun  4 01:16:34 pwww1 kernel: Code: 2b 2c 90 85 ed 7e 11 8d 71 01 39 de 7c c1 31 c0 83 c4 04 5b

Jun  4 01:16:34 pwww1 kernel:  Oops: 0000 [#4]
Jun  4 01:16:34 pwww1 kernel: SMP
Jun  4 01:16:34 pwww1 kernel: CPU:    1
Jun  4 01:16:34 pwww1 kernel: EIP:    0060:[<c012468a>]    Not tainted
Jun  4 01:16:34 pwww1 kernel: EFLAGS: 00010206   (2.6.6)
Jun  4 01:16:34 pwww1 kernel: EIP is at groups_search+0x4b/0x70
Jun  4 01:16:34 pwww1 kernel: eax: 080e1504   ebx: 00000006   ecx: 00000003   edx: 00000003
Jun  4 01:16:34 pwww1 kernel: esi: 00000000   edi: c938b554   ebp: 00000000   esp: db5c8c80
Jun  4 01:16:34 pwww1 kernel: ds: 007b   es: 007b   ss: 0068
Jun  4 01:16:34 pwww1 kernel: Process patrol (pid: 4783, threadinfo=db5c8000 task=d9d757f0)
Jun  4 01:16:34 pwww1 kernel: Stack: 00000000 db5c8000 00000001 ddad299c df4a9c00 c0124833 000081ed 00000004
Jun  4 01:16:34 pwww1 kernel:        c0183e66 ddad299c c0183dc4 df021880 df4a9c00 c0150637 db5c8000 00000006
Jun  4 01:16:34 pwww1 kernel:        c014e41a dfdaf5d8 00000080 00000000 00000000 db5c8e60 db5c8000 c0000000
Jun  4 01:16:34 pwww1 kernel: Call Trace:
Jun  4 01:16:35 pwww1 kernel:  [<c0124833>] in_group_p+0x39/0x6a
Jun  4 01:16:35 pwww1 kernel:  [<c0183e66>] ext3_permission+0xa2/0x1a2
Jun  4 01:16:35 pwww1 kernel:  [<c0183dc4>] ext3_permission+0x0/0x1a2
Jun  4 01:16:35 pwww1 kernel:  [<c0150637>] permission+0x36/0x38
Jun  4 01:16:35 pwww1 kernel:  [<c014e41a>] flush_old_exec+0x2e2/0x808
Jun  4 01:16:35 pwww1 kernel:  [<c014df8c>] kernel_read+0x40/0x53
Jun  4 01:16:35 pwww1 kernel:  [<c0168b41>] load_elf_binary+0x336/0xc1e
Jun  4 01:16:35 pwww1 kernel:  [<c014eb63>] search_binary_handler+0x5a/0x10a
Jun  4 01:16:35 pwww1 kernel:  [<c014ede5>] do_execve+0x1d2/0x222
Jun  4 01:16:35 pwww1 kernel:  [<c010293a>] sys_execve+0x43/0x6e
Jun  4 01:16:35 pwww1 kernel:  [<c0103c9f>] syscall_call+0x7/0xb
Jun  4 01:16:35 pwww1 kernel:
Jun  4 01:16:35 pwww1 kernel: Code: 2b 2c 90 85 ed 7e 11 8d 71 01 39 de 7c c1 31 c0 83 c4 04 5b

-- 
Kind regards,
Robert Varga
------------------------------------------------------------------------------
n@hq.sk                                          http://hq.sk/~nite/gpgkey.txt
      Wanna make me happy? http://www.amazon.com/o/registry/18CYK97BPGHAV
