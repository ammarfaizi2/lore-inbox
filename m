Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318781AbSIISaU>; Mon, 9 Sep 2002 14:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSIISaU>; Mon, 9 Sep 2002 14:30:20 -0400
Received: from boxer.fnal.gov ([131.225.80.86]:10187 "EHLO boxer.fnal.gov")
	by vger.kernel.org with ESMTP id <S318781AbSIISaQ>;
	Mon, 9 Sep 2002 14:30:16 -0400
Date: Mon, 9 Sep 2002 13:34:59 -0500 (CDT)
From: Steven Timm <timm@fnal.gov>
To: <linux-kernel@vger.kernel.org>
Subject: "unable to handle kernel paging request at virtual address ....."
 (fwd)
Message-ID: <Pine.LNX.4.31.0209091333370.12090-100000@boxer.fnal.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This error message is occurring with kernel 2.4.9-31smp, particularly
on older hardware.  I am seeing the following kernel panic with
regularity:

Unable to handle kernel paging request at virtual address 0a1a77da
 printing eip:
0a1a77da
*pde = 00000000
Oops: 0000
Kernel 2.4.9-31smp
CPU:    0
EIP:    0010:[<0a1a77da>]    Tainted: P
EFLAGS: 00010202
EIP is at Using_Versions [] 0xa1a77d9
eax: 0a1a77da   ebx: d112b040   ecx: d112b050   edx: e0e1e183
esi: f74f62e0   edi: e0e1e183   ebp: fffffff6   esp: c22dbf50
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c22db000)
Stack: c0153d4b d112b040 c211c3a0 c02de878 00000000 c22da000 f74f62f8
f74f62e0
       d112b040 c01515eb d112b040 d112b040 c22da000 00000000 c1deb944
00000000
       c1eb1250 c1deb944 00000000 c0135c45 00000000 00036a22 000000c0
000000c0
Call Trace: [<c0153d4b>] iput [kernel] 0x3b
[<c01515eb>] prune_dcache [kernel] 0x10b
EIP is at Using_Versions [] 0xa1a77d9
eax: 0a1a77da   ebx: d112b040   ecx: d112b050   edx: e0e1e183
esi: f74f62e0   edi: e0e1e183   ebp: fffffff6   esp: c22dbf50
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c22db000)
Stack: c0153d4b d112b040 c211c3a0 c02de878 00000000 c22da000 f74f62f8
f74f62e0
       d112b040 c01515eb d112b040 d112b040 c22da000 00000000 c1deb944
00000000
       c1eb1250 c1deb944 00000000 c0135c45 00000000 00036a22 000000c0
000000c0
Call Trace: [<c0153d4b>] iput [kernel] 0x3b
[<c01515eb>] prune_dcache [kernel] 0x10b
[<c0135c45>] page_launder [kernel] 0x955
[<c0151a11>] shrink_dcache_memory [kernel] 0x21
[<c013604b>] do_try_to_free_pages [kernel] 0x1b
[<c01360d5>] kswapd [kernel] 0x55
[<c0105000>] stext [kernel] 0x0
[<c0105866>] kernel_thread [kernel] 0x26
[<c0136080>] kswapd [kernel] 0x0


Code:  Bad EIP value.
------------------------------------------------------------------

The Google searches I have done up until now reveal that many
people have seen this problem but nobody has found a solution as yet.
When the kernel panic happens, the machine does not crash. It stays up,
but then kswapd shows as <defunct> in the ps listing.

We have seen this problem two or three times per node on the 20
nodes in question.  These nodes are doing a number of swaps usually
at the time the error happens.

Any idea what might be going on?

Steve Timm




------------------------------------------------------------------
Steven C. Timm (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Division/Operating Systems Support
Scientific Computing Support Group--Computing Farms Operations

