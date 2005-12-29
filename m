Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVL2Kk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVL2Kk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVL2Kk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:40:58 -0500
Received: from general.keba.co.at ([193.154.24.243]:12003 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S932499AbVL2Kk6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:40:58 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Thu, 29 Dec 2005 11:40:47 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323302@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: SLAB-related panic in 2.6.15-rc7-rt1 on ARM
Thread-Index: AcYMZELZJQec+3GaSZWMbt+bvgL8Jg==
From: "kus Kusche Klaus" <kus@keba.com>
To: "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My sa1100-based system panics while booting with 2.6.15-rc7-rt1 when the
SLAB allocator is configured. Everything is fine with the SLOB
allocator.

Please cc me, I'm currently not subscribed.


Memory: 62856KB available (1552K code, 381K data, 80K init)
Unhandled fault: alignment exception (0xc0207003) at 0x0000015b
Internal error: : c0207003 [#1]
Modules linked in:
CPU: 0
PC is at get_page_from_freelist+0x1c/0x3d8
LR is at __alloc_pages+0x5c/0x2ac
pc : [<c0257338>]    lr : [<c0257750>]    Not tainted
sp : c03a3e84  ip : c03a3ecc  fp : c03a3ec8
r10: c03a7598  r9 : c03ac650  r8 : c03a6048
r7 : 00000000  r6 : 000000d0  r5 : 00000000  r4 : c03a7598
r3 : 00000044  r2 : 0000000b  r1 : 00000000  r0 : 000200d0
Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  Segment kernel
Control: C020717F  Table: C020717F  DAC: 00000017
Process swapper (pid: 0, stack limit = 0xc03a2194)
Stack: (0xc03a3e84 to 0xc03a4000)
3e80:          fffffb48 00000042 c021abbc c03a3ebc c03a7598 c03a3eac
000200d0
3ea0: c03a7598 00000000 000000d0 00000000 c03a6048 c03ac650 c03a7598
c03a3f04
3ec0: c03a3ecc c0257750 c0257328 000200d0 c03a3edc 00000010 c0231974
00000010
3ee0: 00000000 c03ac618 c03ac60c 00000000 c03ac650 000000d0 c03a3f3c
c03a3f08
3f00: c0269fb4 c0257700 00000001 000000d0 00000000 c021af70 c03a2000
000000d0
3f20: c03ac650 00000020 c0382f14 00000000 c03a3f60 c03a3f40 c0269c8c
c0269d2c
3f40: 20000000 c03f8570 00000000 00000020 00042000 c03a3f9c c03a3f64
c026ae68
3f60: c0269c0c c03a3f70 c024a84c c0249f28 00000326 c03ac54c 00000000
c021aee0
3f80: c03ac60c c03ac54c c021af60 c03f8570 c03a3fd8 c03a3fa0 c0213a00
c026acb8
3fa0: 00000000 00000000 00000080 00000000 c020717d c03e2580 c03a70c4
c0401424
3fc0: c0219c10 6901b118 c0219be0 c03a3ff4 c03a3fdc c0208760 c0213900
c02082e4
3fe0: c03e25e8 c020717d 00000000 c03a3ff8 c0208094 c0208678 00000000
00000000
Backtrace:
[<c025731c>] (get_page_from_freelist+0x0/0x3d8) from [<c0257750>]
(__alloc_pages+0x5c/0x2ac)
[<c02576f4>] (__alloc_pages+0x0/0x2ac) from [<c0269fb4>]
(cache_alloc_refill+0x294/0x548)
[<c0269d20>] (cache_alloc_refill+0x0/0x548) from [<c0269c8c>]
(kmem_cache_alloc+0x8c/0xd0)
[<c0269c00>] (kmem_cache_alloc+0x0/0xd0) from [<c026ae68>]
(kmem_cache_create+0x1bc/0x52c)
 r7 = 00042000  r6 = 00000020  r5 = 00000000  r4 = C03F8570
[<c026acac>] (kmem_cache_create+0x0/0x52c) from [<c0213a00>]
(kmem_cache_init+0x10c/0x2b8)
[<c02138f4>] (kmem_cache_init+0x0/0x2b8) from [<c0208760>]
(start_kernel+0xf4/0x1a8)
[<c020866c>] (start_kernel+0x0/0x1a8) from [<c0208094>]
(__enable_mmu+0x0/0x2c)
 r4 = C020717D
Code: e24dd01c e50b2034 e5922000 e50b002c (e5920150)
 <0>Kernel panic - not syncing: Attempted to kill the idle task!


-- 
Klaus Kusche
Entwicklung Software - Steuerung
Software Development - Control

KEBA AG
A-4041 Linz
Gewerbepark Urfahr
Tel +43 / 732 / 7090-3120
Fax +43 / 732 / 7090-6301
E-Mail: kus@keba.com
www.keba.com


