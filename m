Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWACIAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWACIAz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 03:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWACIAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 03:00:55 -0500
Received: from general.keba.co.at ([193.154.24.243]:42377 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1751216AbWACIAy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 03:00:54 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Date: Tue, 3 Jan 2006 09:00:48 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323312@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
Thread-Index: AcYPtp58ENWyrFz2TZSr1mY6CDtvTAAhIOiQ
From: "kus Kusche Klaus" <kus@keba.com>
To: "Daniel Walker" <dwalker@mvista.com>
Cc: "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Walker
> Here's a more updated patch, the should replace the other 
> patch I sent.
> I think the tracing error is the result of a missed interrupt 
> enable in
> the ARM assembly code. I've only compile tested this.  

Compiles, but BUGs immediately after uncompressing (second line of
console output) and then runs into an infinite Oops loop...
Reproducible.

Uncompressing
Linux.................................................................
done, booting the kernel.
BUG: bad raw irq-flag value 600000d3, swapper/0!
Linux version 2.6.15-rc7-rt1 (kk@silver) (gcc version 3.4.4) #22 PREEMPT
Tue Jan 3 08:03:43 CET 2006
CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4)
Machine: Keba KETOP
Ignoring unrecognised tag 0x00000000
Memory policy: ECC disabled, Data cache writeback
MM: invalid domain in supersection mapping for 0x8000000000 at
0xea000000
MM: invalid domain in supersection mapping for 0x18000000000 at
0xf0000000
ketop map io done
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: root=31:02 rootfstype=ext2 console=ttySA0,38400n8
console=tty0
WARNING: experimental RCU implementation.
PID hash table entries: 512 (order: 9, 8192 bytes)
Warning: uninitialized Real Time Clock
Console: colour dummy device 80x30
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 64MB = 64MB total
Memory: 61148KB available (1606K code, 2041K data, 80K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
Unable to handle kernel NULL pointer dereference at virtual address
000000c0
pgd = c0204000
[000000c0] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in:
CPU: 0
PC is at 0xc0
LR is at 0xc0
pc : [<000000c0>]    lr : [<000000c0>]    Not tainted
sp : c00a1fb0  ip : c00a1fb0  fp : 00000000
r10: 00000000  r9 : c00a0000  r8 : 00000001
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : c00a0000  r2 : 40000053  r1 : 00000000  r0 : 00000000
Flags: nZCv  IRQs on  FIQs off  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc00a0194)
Stack: (0xc00a1fb0 to 0xc00a2000)
1fa0:                                     00000000 00000000 c021c084
c02345f8 
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
1fe0: 00000000 00000000 00000000 c021d94c 00000013 00000000 ffffffff
ffffffff 
Backtrace: no frame pointer
Code: <1>Unable to handle kernel NULL pointer dereference at virtual
address 000000c0
pgd = c0204000
[000000c0] *pgd=00000000
Internal error: Oops: 0 [#2]
Modules linked in:
CPU: 0
PC is at 0xc0
LR is at 0xc0
pc : [<000000c0>]    lr : [<000000c0>]    Not tainted
sp : c00a1e74  ip : c00a1e74  fp : c00a1ecc
r10: c05bf9c0  r9 : 000000d3  r8 : c00a1fb0
r7 : 000000c0  r6 : 00000000  r5 : c00a1ea8  r4 : ffffffff
r3 : c00a0000  r2 : 600000d3  r1 : c03b1548  r0 : c038c508
Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc00a0194)
Stack: (0xc00a1e74 to 0xc00a2000)
1e60:                                              00000009 00000001
000000b0 
1e80: 00000000 fffffffc c00a0000 00000000 000000c0 c00a1fb0 c00a1f68
c05bf9c0 
1ea0: c00a1ecc c00a1de0 c00a1ebc c024cda4 c0385770 000000d3 ffffffff
00000000 
1ec0: c00a1eec c00a1ed0 c0222b60 c0220f60 000000c0 c05bf9c0 c00a0000
00000000 
1ee0: c00a1f28 c00a1ef0 c0222e3c c0222afc 00000000 c025034c 001da3bf
00000000 
1f00: 000000c0 c00a1f9c c00a0000 00000000 c00a1f68 60000053 00000000
c00a1f54 
1f20: c00a1f2c c0222e8c c0222c4c c00a0000 ffffffff c00a1f9c 00000000
00000000 
1f40: 00000001 00000000 c00a1f64 c00a1f58 c0223028 c0222e60 00000000
c00a1f68 
1f60: c021ca60 c022301c 00000000 00000000 40000053 c00a0000 00000000
00000000 
1f80: 00000000 00000000 00000001 c00a0000 00000000 00000000 c00a1fb0
c00a1fb0 
1fa0: 000000c0 000000c0 60000053 ffffffff 00000000 00000000 c021c084
c02345f8 
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
1fe0: 00000000 00000000 00000000 c021d94c 00000013 00000000 ffffffff
ffffffff 
Backtrace: 
[<c0220f54>] (die+0x0/0x344) from [<c0222b60>]
(__do_kernel_fault+0x70/0x84)
[<c0222af0>] (__do_kernel_fault+0x0/0x84) from [<c0222e3c>]
(do_page_fault+0x1fc/0x214)
 r7 = 00000000  r6 = C00A0000  r5 = C05BF9C0  r4 = 000000C0
[<c0222c40>] (do_page_fault+0x0/0x214) from [<c0222e8c>]
(do_translation_fault+0x38/0xc4)
[<c0222e54>] (do_translation_fault+0x0/0xc4) from [<c0223028>]
(do_PrefetchAbort+0x18/0x1c)
[<c0223010>] (do_PrefetchAbort+0x0/0x1c) from [<c021ca60>]
(__pabt_svc+0x40/0x80)
Code: <1>Unable to handle kernel NULL pointer dereference at virtual
address 000000c0
pgd = c0204000
[000000c0] *pgd=00000000
Internal error: Oops: 0 [#3]
Modules linked in:
CPU: 0
PC is at 0xc0
LR is at 0xc0
pc : [<000000c0>]    lr : [<000000c0>]    Not tainted
sp : c00a1d38  ip : c00a1d38  fp : c00a1d90
r10: c05bf9c0  r9 : 000000d3  r8 : c00a1e74
r7 : 000000c0  r6 : 00000000  r5 : c00a1d6c  r4 : ffffffff
r3 : c00a0000  r2 : 600000d3  r1 : c03b1548  r0 : c038c508
Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xc00a0194)
Stack: (0xc00a1d38 to 0xc00a2000)
1d20:                                                       00000009
00000001 
1d40: 000000b0 00000000 fffffffc c00a0000 00000000 000000c0 c00a1e74
c00a1e2c 
1d60: c05bf9c0 c00a1d90 0000c024 c00a1d80 000000c0 c0385770 000000d3
ffffffff 
1d80: 00000000 c00a1db0 c00a1d94 c0222b60 c0220f60 000000c0 c05bf9c0
c00a0000 
1da0: 00000000 c00a1dec c00a1db4 c0222e3c c0222afc 000000b0 c05bf9c0
c00a1e70 
1dc0: 00000000 000000c0 c00a1e60 c00a0000 00000000 c00a1e2c 200000d3
c05bf9c0 
1de0: c00a1e18 c00a1df0 c0222e8c c0222c4c 00000000 ffffffff c00a1e60
00000000 
1e00: 000000c0 c00a1fb0 c05bf9c0 c00a1e28 c00a1e1c c0223028 c0222e60
c00a1ecc 
1e20: c00a1e2c c021ca60 c022301c c038c508 c03b1548 600000d3 c00a0000
ffffffff 
1e40: c00a1ea8 00000000 000000c0 c00a1fb0 000000d3 c05bf9c0 c00a1ecc
c00a1e74 
1e60: c00a1e74 000000c0 000000c0 200000d3 ffffffff 00000009 00000001
000000b0 
1e80: 00000000 fffffffc c00a0000 00000000 000000c0 c00a1fb0 c00a1f68
c05bf9c0 
1ea0: c00a1ecc c00a1de0 c00a1ebc c024cda4 c0385770 000000d3 ffffffff
00000000 
1ec0: c00a1eec c00a1ed0 c0222b60 c0220f60 000000c0 c05bf9c0 c00a0000
00000000 
1ee0: c00a1f28 c00a1ef0 c0222e3c c0222afc 00000000 c025034c 001da3bf
00000000 
1f00: 000000c0 c00a1f9c c00a0000 00000000 c00a1f68 60000053 00000000
c00a1f54 
1f20: c00a1f2c c0222e8c c0222c4c c00a0000 ffffffff c00a1f9c 00000000
00000000 
1f40: 00000001 00000000 c00a1f64 c00a1f58 c0223028 c0222e60 00000000
c00a1f68 
1f60: c021ca60 c022301c 00000000 00000000 40000053 c00a0000 00000000
00000000 
1f80: 00000000 00000000 00000001 c00a0000 00000000 00000000 c00a1fb0
c00a1fb0 
1fa0: 000000c0 000000c0 60000053 ffffffff 00000000 00000000 c021c084
c02345f8 
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000 
1fe0: 00000000 00000000 00000000 c021d94c 00000013 00000000 ffffffff
ffffffff 
Backtrace: 
[<c0220f54>] (die+0x0/0x344) from [<c0222b60>]
(__do_kernel_fault+0x70/0x84)
[<c0222af0>] (__do_kernel_fault+0x0/0x84) from [<c0222e3c>]
(do_page_fault+0x1fc/0x214)
 r7 = 00000000  r6 = C00A0000  r5 = C05BF9C0  r4 = 000000C0
[<c0222c40>] (do_page_fault+0x0/0x214) from [<c0222e8c>]
(do_translation_fault+0x38/0xc4)
[<c0222e54>] (do_translation_fault+0x0/0xc4) from [<c0223028>]
(do_PrefetchAbort+0x18/0x1c)
[<c0223010>] (do_PrefetchAbort+0x0/0x1c) from [<c021ca60>]
(__pabt_svc+0x40/0x80)
[<c0220f54>] (die+0x0/0x344) from [<c0222b60>]
(__do_kernel_fault+0x70/0x84)
[<c0222af0>] (__do_kernel_fault+0x0/0x84) from [<c0222e3c>]
(do_page_fault+0x1fc/0x214)
 r7 = 00000000  r6 = C00A0000  r5 = C05BF9C0  r4 = 000000C0
[<c0222c40>] (do_page_fault+0x0/0x214) from [<c0222e8c>]
(do_translation_fault+0x38/0xc4)
[<c0222e54>] (do_translation_fault+0x0/0xc4) from [<c0223028>]
(do_PrefetchAbort+0x18/0x1c)
[<c0223010>] (do_PrefetchAbort+0x0/0x1c) from [<c021ca60>]
(__pabt_svc+0x40/0x80)


-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com 
