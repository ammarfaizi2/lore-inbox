Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313006AbSC0NQF>; Wed, 27 Mar 2002 08:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313007AbSC0NPz>; Wed, 27 Mar 2002 08:15:55 -0500
Received: from mail.astrodienst.com ([192.53.104.1]:55556 "EHLO as73.astro.ch")
	by vger.kernel.org with ESMTP id <S313006AbSC0NPl>;
	Wed, 27 Mar 2002 08:15:41 -0500
Date: Wed, 27 Mar 2002 14:15:38 +0100 (MET)
From: Alois Treindl <alois@astro.ch>
To: linux-kernel@vger.kernel.org
Subject: oops with kjournald in SMP 2.4.16
Message-ID: <Pine.HPX.4.21.0203271410460.15639-100000@as73.astro.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had an OOPS and kernel crash last night,
on a dual CPU 2.4.16 (Dell Poweredge 2450, dual 933 Mhz P3, 1.75 gb RAM).

The system had been up for about 100 days without reboot.

I use the ext3 file system with 3 SCSI disks and various NFS clients
attached to this file server.

The log messages were:
Mar 27 02:30:14 w1 kernel: Unable to handle kernel paging request at virtual address 7630b5d4
Mar 27 02:30:14 w1 kernel:  printing eip:
Mar 27 02:30:14 w1 kernel: c012c3c5
Mar 27 02:30:14 w1 kernel: *pde = 00000000
Mar 27 02:30:14 w1 kernel: Oops: 0000
Mar 27 02:30:14 w1 kernel: CPU:    1
Mar 27 02:30:14 w1 kernel: EIP:    0010:[kmem_cache_alloc_batch+137/220]    Not tainted
Mar 27 02:30:14 w1 kernel: EIP:    0010:[<c012c3c5>]    Not tainted
Mar 27 02:30:14 w1 kernel: EFLAGS: 00010003
Mar 27 02:30:14 w1 kernel: eax: 613d6d67   ebx: f13b00e0   ecx: f13b0020   edx: f13b0020
Mar 27 02:30:14 w1 kernel: esi: c2c13ecc   edi: c2c26800   ebp: 0000002e   esp: f775fd6c
Mar 27 02:30:14 w1 kernel: ds: 0018   es: 0018   ss: 0018
Mar 27 02:30:14 w1 kernel: Process kjournald (pid: 119, stackpage=f775f000)
Mar 27 02:30:14 w1 kernel: Stack: 00000811 c2c13ecc 00000070 00000246 68440780 c2c13edc c2c13ed4 c012c549 
Mar 27 02:30:14 w1 kernel:        c2c13ecc 00000070 00000811 d8706260 00000001 d8706260 c0132d38 c2c13ecc 
Mar 27 02:30:14 w1 kernel:        00000070 00000811 d8706260 00000001 c0132de5 00000811 d8706260 00000001 
Mar 27 02:30:14 w1 kernel: Call Trace: [kmem_cache_alloc+93/260] [alloc_bounce_bh+16/148] [create_bounce+41/340] [__make_request+438/1604] [__make_request+147/1604] 
Mar 27 02:30:14 w1 kernel: Call Trace: [<c012c549>] [<c0132d38>] [<c0132de5>] [<c018ed36>] [<c018ec13>] 
Mar 27 02:30:14 w1 kernel:    [generic_make_request+158/292] [submit_bh+64/92] [ll_rw_block+343/468] [journal_brelse_array+28/40] [journal_commit_transaction+1203/4748] [kjournald+440/744] 
Mar 27 02:30:14 w1 kernel:    [<c018f262>] [<c018f328>] [<c018f49b>] [<c0161ecc>] [<c01610d7>] [<c0163e78>] 
Mar 27 02:30:14 w1 kernel:    [commit_timeout+0/12] [kernel_thread+35/48] 
Mar 27 02:30:14 w1 kernel:    [<c0163cb0>] [<c01057cb>] 
Mar 27 02:30:14 w1 kernel: 
Mar 27 09:39:37 w1 syslogd 1.4-0: restart (remote reception).
Mar 27 09:39:38 w1 syslog: syslogd startup succeeded

Does anyone recognize this problem, and has it been fixed in later kernels?

Thanks

Alois Treindl, Zollikon, Switzerland


