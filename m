Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129710AbRAPUKi>; Tue, 16 Jan 2001 15:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129593AbRAPUK3>; Tue, 16 Jan 2001 15:10:29 -0500
Received: from sisley.ri.silicomp.fr ([62.160.165.44]:58127 "EHLO
	sisley.ri.silicomp.fr") by vger.kernel.org with ESMTP
	id <S129532AbRAPUKS>; Tue, 16 Jan 2001 15:10:18 -0500
Date: Tue, 16 Jan 2001 21:09:57 +0100 (CET)
From: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
To: <mingo@redhat.com>, <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
cc: Eric Paire <paire@ri.silicomp.fr>,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>
Subject: [BUG] Panic in smp_call_function_interrupt
Message-ID: <Pine.LNX.4.31.0101161858340.23569-100000@sisley.ri.silicomp.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When I discovered the nice "smp affinity" feature, I gave it a try on our
old SMP testbed (quad P100 with 2 Adaptec AIC-7870 SCSI adapters).  And by
chance, I discovered that the following command causes an oops (after a
couple of seconds), even without any kind of smp affinity :

[root@picasso /]# dd if=/dev/sda of=/dev/null

Fortunately I had kdb and the console on a serial line :

<some random characters>
Entering kdb (current=0xc116e000, pid 0) on processor 3 Panic: Oops
due to panic @ 0x0
eax = 0xc1145e64 ebx = 0xc012a0ff ecx = 0x00000000 edx = 0x00000000
esi = 0xc116e000 edi = 0xc116e000 esp = 0xc116ff5c eip = 0x00000000
ebp = 0xc116ff68 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010002
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc116ff28
[3]kdb> bt
    EBP       EIP         Function(args)
0xc116ff68 0x00000000 <unknown> (0x0)
                               kernel <unknown> 0x0 0x0 0x0
           0xc0110545 smp_call_function_interrupt+0x25 (0xc01071d0, 0x0,
0xc116e000, 0xc116e000, 0xc116e000)
                               kernel .text 0xc0100000 0xc0110520
0xc0110560
0xc116ffa4 0xc01fa92d call_call_function_interrupt+0x5
                               kernel .rodata 0xc01f7ae0 0xc01fa928
0xc01fa940
           0xc0107265 cpu_idle+0x35
                               kernel .text 0xc0100000 0xc0107230
0xc0107278

This is a 2.4.0 (release) with kdb 1.7 for 2.4.0. I tried the same on a
similar machine with 2 CPUs and without kdb, it gave the same result. A
2.4.0 without SMP support on these machines has no problem.

Can anyone reproduce this ? Or maybe it has already been fixed ?


Regards,

-- 
Jean-Marc Saffroy - Research Engineer - Silicomp Research Institute
mailto:saffroy@ri.silicomp.fr

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
