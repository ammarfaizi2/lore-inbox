Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262174AbTDAICW>; Tue, 1 Apr 2003 03:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262180AbTDAICW>; Tue, 1 Apr 2003 03:02:22 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:24572
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262174AbTDAICU>; Tue, 1 Apr 2003 03:02:20 -0500
Date: Tue, 1 Apr 2003 03:09:24 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][2.5] smp_call_function needs mb()
Message-ID: <Pine.LNX.4.50.0304010305510.8773-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on afflicted 3way P133 system for 3days and on 8way P3 700 for 
regression.

Unable to handle kernel NULL pointer dereference at virtual address 00000200
 printing eip:
00000200
*pde = 00000000
Oops: 0000 [#1]
CPU:    2
EIP:    0060:[<00000200>]    Not tainted
EFLAGS: 00210082
EIP is at 0x200
eax: 00000026   ebx: c7666000   ecx: c7666000   edx: c7666000
esi: 00000200   edi: c034ad74   ebp: c0bc8000   esp: c7667fa8
ds: 007b   es: 007b   ss: 0068
Process rhn-applet (pid: 1654, threadinfo=c7666000 task=c0785340)
Stack: c0116407 c034ad74 40a2d760 08458490 00000004 bfffec78 c010a41a 40a2d760 
       00000000 00000000 08458490 00000004 bfffec78 0830d800 0000007b 0000007b 
       fffffffb 40a23da4 00000073 00200202 bfffec48 0000007b 
Call Trace:
 [<c0116407>] smp_call_function_interrupt+0x57/0xb0
 [<c034ad74>] sr_do_ioctl+0x124/0x250
 [<c010a41a>] call_function_interrupt+0x1a/0x20

Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interrupt handler!

Index: linux-2.5.66/arch/i386/kernel/smp.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.66/arch/i386/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.5.66/arch/i386/kernel/smp.c	24 Mar 2003 23:40:27 -0000	1.1.1.1
+++ linux-2.5.66/arch/i386/kernel/smp.c	28 Mar 2003 05:08:54 -0000
@@ -522,7 +521,8 @@ int smp_call_function (void (*func) (voi
 
 	spin_lock(&call_lock);
 	call_data = &data;
-	wmb();
+	mb();
+	
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 
