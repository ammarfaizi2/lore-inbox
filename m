Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUA3RPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 12:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUA3RPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 12:15:48 -0500
Received: from 207-245-76-132.unityhill.com ([207.245.76.132]:57538 "EHLO
	mail.newearth.org") by vger.kernel.org with ESMTP id S262686AbUA3RPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 12:15:42 -0500
Date: Fri, 30 Jan 2004 12:15:14 -0500 (EST)
From: "Michael V. David" <michael@mvdavid.com>
To: undisclosed-recipients:;
Subject: raid6 badness
Message-ID: <Pine.LNX.4.58.0401301158340.8900@sapphire.newearth.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This x86_64 system has dual Opteron CPUs on a Tyan 2880 board. Kernel
version string:

Linux version 2.6.2-bk4 (michael@sapphire) (gcc version 3.3.2 20040119 (Red Hat Linux 3.3.2-8)) #3 SMP Fri Jan 30 08:56:11 EST 2004

The same problem was produced with kernel versions 2.6.2-rc2 and
2.6.2-rc2-bk4. Output reproduced here is from -bk4.

If raid6 is compiled into the kernel, the kernel panics while
starting. In the present case, it was compiled as a module. On
loading, there is a segfault, and syslog gets what follows:

---<snip>---
raid6: int64x1   1175 MB/s
raid6: int64x2   1734 MB/s
raid6: int64x4   1773 MB/s
raid6: int64x8   1273 MB/s
general protection fault: 0000 [1]
CPU 1
Pid: 7310, comm: modprobe Not tainted
RIP: 0010:[<ffffffffa0186383>] <ffffffffa0186383>{:raid6:raid6_sse21_gen_syndrome+51}
RSP: 0018:0000010021825dd8  EFLAGS: 00010202
RAX: 000000008005003b RBX: 0000010021cc6000 RCX: 00000000c0000100
RDX: 0000010021825e88 RSI: 0000000000001000 RDI: 000000000000000f
RBP: 0000000000000001 R08: 0000010021824000 R09: 000000000000000f
R10: 00000000bfffe820 R11: 0000010021cc7000 R12: 0000010021825e88
R13: ffffffffa0186a40 R14: 0000000000000000 R15: ffffffffa0196ea0
FS:  0000002a958624c0(0000) GS:ffffffff803fe8c0(0000) knlGS:000000005577d4e0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000421140 CR3: 000000000247f000 CR4: 00000000000006a0
Process modprobe (pid: 7310, stackpage=10037f01240)
Stack: e9e6f7f8d5dacbc4 0000000000000000 1097038436b125a2 616e7f705d52434c
       0000000000000246 00000000bfffe820 0000000000000000 0000010021824000
       00000000ffff7cf4 00000000c0000100
Call Trace:<ffffffffa019b130>{:raid6:raid6_select_algo+240} <ffffffffa019b15d>{:raid6:raid6_select_algo+285}
       <ffffffffa019b009>{:raid6:raid6_init+9} <ffffffff8014f471>{sys_init_module+353}
       <ffffffff8010ee54>{system_call+124}

Code: 66 0f 7f 04 24 66 0f 7f 4c 24 10 66 0f 7f 54 24 20 66 0f 7f
RIP <ffffffffa0186383>{:raid6:raid6_sse21_gen_syndrome+51} RSP <0000010021825dd8>
bad: scheduling while atomic!

Call Trace:<ffffffff8012f6be>{schedule+94} <ffffffff80161eb5>{unmap_vmas+485}
       <ffffffff80166929>{exit_mmap+313} <ffffffff80132d17>{mmput+135}
       <ffffffff801381f0>{do_exit+576} <ffffffff80110515>{die+69}
       <ffffffff80110ef7>{do_general_protection+263} <ffffffff8010f811>{error_exit+0}
       <ffffffffa0186383>{:raid6:raid6_sse21_gen_syndrome+51}
       <ffffffffa019b130>{:raid6:raid6_select_algo+240} <ffffffffa019b15d>{:raid6:raid6_select_algo+285}
       <ffffffffa019b009>{:raid6:raid6_init+9} <ffffffff8014f471>{sys_init_module+353}
       <ffffffff8010ee54>{system_call+124}
---<snip>---





-- 
michael@mvdavid.com
