Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264179AbTICT2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTICT1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:27:00 -0400
Received: from 12-251-184-225.client.attbi.com ([12.251.184.225]:27019 "EHLO
	chris.pebenito.dhs.org") by vger.kernel.org with ESMTP
	id S264054AbTICTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:25:29 -0400
Subject: 2.6.0-test4-mm3-1 (PPC) kernel BUG in refill_inactive_zone at
	mm/vmscan.c:610
From: Chris PeBenito <pebenito@gentoo.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LinuxPPC-devel <linuxppc-devel@lists.linuxppc.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062617110.8467.115.camel@chris.pebenito.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 03 Sep 2003 14:25:11 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got this oops on 2.6.0-test4-mm3-1 on PPC which leads to a panic:

Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C00409B8 LR: C004092C SP: C07DBE00 REGS: c07dbd50 TRAP: 0700    Not tainted
MSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cfe0ea10[7] 'kswapd0' Last syscall: -1
GPR00: C061B840 C07DBE00 CFE0EA10 00100100 00200200 00000020 C01FCDB0 00000020
GPR08: C061B854 00000001 C061B840 C061B83F 00000418 003770AC 00000000 00000000
GPR16: 00000000 00000000 00000000 00000080 C07DBE68 C07DBE60 C07DBE68 00000000
GPR24: C07DBE60 C07DBF58 00000065 C01FCDB0 C07DBE58 0000001B C01FCDA0 C061B828
Call trace:
 [c0040f60] shrink_zone+0x8c/0xb8
 [c0041330] balance_pgdat+0x130/0x218
 [c00414cc] kswapd+0xb4/0xb8
 [c000a9b0] kernel_thread+0x44/0x60
kernel BUG in refill_inactive_zone at mm/vmscan.c:610!
Oops: Exception in kernel mode, sig: 5 [#2]
NIP: C00409A0 LR: C004092C SP: C23C9BE0 REGS: c23c9b30 TRAP: 0700    Not tainted
MSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cd306120[11170] 'python2.2' Last syscall: 6
GPR00: 00000000 C23C9BE0 CD306120 00100100 00200200 00000020 C01FCDB0 00000020
GPR08: C01FCDA0 00010440 C061B840 00000001 C029E2A8 100DEACC 104C4F40 104C4F2C
GPR16: 00000000 00000000 00000000 00000080 C23C9C48 C23C9C40 C23C9C48 00000000
GPR24: C23C9C40 C23C9D08 00000080 C01FCDB0 C23C9C38 00000000 C01FCDA0 C061B828
Call trace:
 [c0040f60] shrink_zone+0x8c/0xb8
 [c0041048] shrink_caches+0xbc/0x100
 [c004112c] try_to_free_pages+0xa0/0x174
 [c00395c8] __alloc_pages+0x208/0x368
 [c00436e4] do_wp_page+0xd4/0x3d0
 [c00448e8] handle_mm_fault+0x17c/0x188
 [c0012a84] do_page_fault+0x1dc/0x3a8
 [c0007dec] ret_from_except+0x0/0x14
kernel BUG in refill_inactive_zone at mm/vmscan.c:610!
Oops: Exception in kernel mode, sig: 5 [#3]
NIP: C00409A0 LR: C004092C SP: CEFB7C00 REGS: cefb7b50 TRAP: 0700    Not tainted
MSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cf5c2a90[2825] 'metalog' Last syscall: 167
GPR00: 00000000 CEFB7C00 CF5C2A90 00100100 00200200 00000020 C01FCDB0 00000020
GPR08: CEFB7D28 00010440 C061B840 00000061 00000040 1001E0E8 100C0000 00000005
GPR16: 10010000 00000000 00000000 00000080 CEFB7C68 CEFB7C60 CEFB7C68 00000000
GPR24: CEFB7C60 CEFB7D28 00000080 C01FCDB0 CEFB7C58 00000000 C01FCDA0 C061B828
Call trace:
 [c0040f60] shrink_zone+0x8c/0xb8
 [c0041048] shrink_caches+0xbc/0x100
 [c004112c] try_to_free_pages+0xa0/0x174
 [c00395c8] __alloc_pages+0x208/0x368
 [c0039754] __get_free_pages+0x2c/0x70
 [c0067470] __pollwait+0x48/0xd8
 [c0149900] datagram_poll+0x138/0x13c
 [c0143b0c] sock_poll+0x2c/0x3c
 [c0067dc4] do_pollfd+0xd8/0xe0
 [c0067e30] do_poll+0x64/0xf0
 [c0068034] sys_poll+0x178/0x288
 [c000781c] ret_from_syscall+0x0/0x44
kernel BUG in refill_inactive_zone at mm/vmscan.c:610!
Oops: Exception in kernel mode, sig: 5 [#4]
NIP: C00409A0 LR: C004092C SP: C06AFBE0 REGS: c06afb30 TRAP: 0700    Not tainted
MSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = cffdb9d0[1] 'init' Last syscall: 142
GPR00: 00000000 C06AFBE0 CFFDB9D0 00100100 00200200 00000020 C01FCDB0 00000020
GPR08: C06AFD08 00010440 C061B840 00000061 00000040 1001F410 00000000 00000400
GPR16: 00000000 CFFE748C 00000000 00000080 C06AFC48 C06AFC40 C06AFC48 00000000
GPR24: C06AFC40 C06AFD08 00000080 C01FCDB0 C06AFC38 00000000 C01FCDA0 C061B828
Call trace:
 [c0040f60] shrink_zone+0x8c/0xb8
 [c0041048] shrink_caches+0xbc/0x100
 [c004112c] try_to_free_pages+0xa0/0x174
 [c00395c8] __alloc_pages+0x208/0x368
 [c0039754] __get_free_pages+0x2c/0x70
 [c0067470] __pollwait+0x48/0xd8
 [c0060818] pipe_poll+0xa8/0xb0
 [c006780c] do_select+0x218/0x280
 [c0067b54] sys_select+0x298/0x430
 [c000d638] ppc_select+0xa8/0xac
 [c000781c] ret_from_syscall+0x0/0x44
Kernel panic: Attempted to kill init!
kernel BUG in refill_inactive_zone at mm/vmscan.c:610!
Oops: Exception in kernel mode, sig: 5 [#5]
NIP: C00409A0 LR: C004092C SP: CE481BD0 REGS: ce481b20 TRAP: 0700    Not tainted
MSR: 00021032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = ce5f3508[3258] 'ntpd' Last syscall: 142
GPR00: 00000000 CE481BD0 CE5F3508 00100100 00200200 00000020 C01FCDB0 00000020
GPR08: CE481CF8 00010440 C061B840 00000061 00000040 1005AC40 00000000 00000070
GPR16: 00000000 C8F4638C 00000000 00000080 CE481C38 CE481C30 CE481C38 00000000
GPR24: CE481C30 CE481CF8 00000080 C01FCDB0 CE481C28 00000000 C01FCDA0 C061B828
Call trace:
 [c0040f60] shrink_zone+0x8c/0xb8
 [c0041048] shrink_caches+0xbc/0x100
 [c004112c] try_to_free_pages+0xa0/0x174
 [c00395c8] __alloc_pages+0x208/0x368
 [c0039754] __get_free_pages+0x2c/0x70
 [c0067470] __pollwait+0x48/0xd8
 [c0149900] datagram_poll+0x138/0x13c
 [c0143b0c] sock_poll+0x2c/0x3c
 [c006780c] do_select+0x218/0x280
 [c0067b54] sys_select+0x298/0x430
 [c000d638] ppc_select+0xa8/0xac
 [c000781c] ret_from_syscall+0x0/0x44
 <0>Rebooting in 180 seconds..

-- 
Chris PeBenito
<pebenito@gentoo.org>
Developer, SELinux
Hardened Gentoo Linux
 
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE6AF9243
Key fingerprint = B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243
