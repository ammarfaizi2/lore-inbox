Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312193AbSCYA4v>; Sun, 24 Mar 2002 19:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSCYA4k>; Sun, 24 Mar 2002 19:56:40 -0500
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:51631 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S312193AbSCYA4d>; Sun, 24 Mar 2002 19:56:33 -0500
Date: Mon, 25 Mar 2002 01:56:33 +0100
From: Arjan Opmeer <a.d.opmeer@student.utwente.nl>
To: linux-kernel@vger.kernel.org
Subject: Anyone else seen VM related oops on 2.4.18?
Message-ID: <20020325005633.GA1121@Ado.student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Are there other people that are suffering from a VM related oops on kernel
2.4.18? 

The problem is that before I started to have this problem I upgraded both
the kernel to 2.4.18 but also the NVidia driver module to the latest
version.

Yes, I know that using a closed source module taints the kernel and that I
cannot expect much help from the kernel hacker community, but I am just
trying to find out whether the kernel or the driver upgrade is causing this
problem.

Another problem is that the oops occurs during the morning cronjobs, like
updatedb, and I am not at the machine to get a better oops trace. For anyone
that is interested to take a look anyway, this is what it looks like in the
log:

 invalid operand: 0000
 CPU:    0
 EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
 EFLAGS: 00010282
 eax: c12bc79c   ebx: c1311980   ecx: c1311980   edx: c01e1520
 esi: c1311980   edi: 00000000   ebp: 00000b08   esp: c1437f28
 ds: 0018   es: 0018   ss: 0018
 Process kswapd (pid: 4, stackpage=c1437000)
 Stack: c2a0e440 c1311980 0000001e 00000b08 c1311980 000001d0 c2a0e440 c1311980
        c0127a72 c01287f3 c0127aab 00000020 000001d0 00000020 00000006 00000006
        c1436000 0000011a 000001d0 c01e1648 c0127ca1 00000006 0000001b 00000006
 Call Trace: [shrink_cache+454/724] [__free_pages+27/28] [shrink_cache+511/724] [shrink_caches+93/132] [try_to_free_pages+52/84]
    [kswapd_balance_pgdat+67/140] [kswapd_balance+18/40] [kswapd+153/188] [kernel_thread+40/56]

 Code: 0f 0b 89 d8 2b 05 ec 8e 23 c0 c1 f8 06 3b 05 e0 8e 23 c0 72
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[__free_pages_ok+40/500]    Tainted: P
 EFLAGS: 00010282
 eax: c1320d1c   ebx: c13c33c0   ecx: c13c33c0   edx: c01e1520
 esi: c13c33c0   edi: 00000000   ebp: 00000b12   esp: cdf67e20
 ds: 0018   es: 0018   ss: 0018
 Process find (pid: 31508, stackpage=cdf67000)
 Stack: c2a0e140 c13c33c0 00000020 00000b12 c13c33c0 000001d2 c2a0e140 c13c33c0
        c0127a72 c01287f3 c0127aab 00000020 000001d2 00000020 00000006 00000006
        cdf66000 0000011b 000001d2 c01e1648 c0127ca1 00000006 0000001b 00000006
 Call Trace: [shrink_cache+454/724] [__free_pages+27/28] [shrink_cache+511/724] [shrink_caches+93/132] [try_to_free_pages+52/84]
    [balance_classzone+78/364] [__alloc_pages+254/352] [read_cache_page+61/288] [_alloc_pages+22/24] [read_cache_page+84/288] [ext2_get_page+29/112]
    [ext2_readpage+0/20] [ext2_readdir+222/504] [vfs_readdir+89/124] [filldir64+0/276] [sys_getdents64+79/179] [filldir64+0/276]
    [sys_fcntl64+127/136] [system_call+51/64]

