Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJUVgE>; Mon, 21 Oct 2002 17:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261714AbSJUVgE>; Mon, 21 Oct 2002 17:36:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59076 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261698AbSJUVgB>;
	Mon, 21 Oct 2002 17:36:01 -0400
Subject: Re: 2.5.44-mm2
From: Paul Larson <plars@linuxtestproject.org>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
In-Reply-To: <3DB3B858.C7CD5DA1@digeo.com>
References: <3DB3B858.C7CD5DA1@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 21 Oct 2002 16:33:36 -0500
Message-Id: <1035236017.998.490.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This test was on a 8-way PIII-700, 16 GB ram.

# echo 768 > /proc/sys/vm/nr_hugepages
# echo 1610612736 > /proc/sys/kernel/shmmax

# ./shmt01
./shmt01: IPC Shared Memory TestSuite program

        Get shared memory segment (67108864 bytes)

        Attach shared memory segment to process

        Index through shared memory segment ...

        Release shared memory

successful!
Segmentation fault

...and on the console:
mm/memory.c:1041: bad pmd f633f100(000000000c4000e7).
mm</4m>emmmo/rmye.moc:ry1.0c4:1:10 b41ad:  pbmadd  pfm63d3
ff160338(f100100(000000000000080000000ae070).0e
).                        7
mm/memory.c:1041: bad pmd f633f118(0000000000c000e7).
mm/memory.c:1041: bad pmd f633f120(0000000000e000e7).
mm/memory.c:1041: bad pmd f633f128(00000000006000e7).
mm/memory.c:1041: bad pmd f633f130(000000000c6000e7).
mm/memory.c:1041: bad pmd f633f138(000000000c8000e7).
mm/memory.c:1041: bad pmd f633f140(000000000ca000e7).
mm/memory.c:1041: bad pmd f633f148(000000000cc000e7).
mm/memory.c:1041: bad pmd f633f150(000000000ce000e7).
mm/memory.c:1041: bad pmd f633f158(000000000d0000e7).
mm/memory.c:1041: bad pmd f633f160(000000000d2000e7).
mm/memory.c:1041: bad pmd f633f168(000000000d4000e7).
mm/memory.c:1041: bad pmd f633f170(000000000d6000e7).
mm/memory.c:1041: bad pmd f633f178(000000000d8000e7).
mm/memory.c:1041: bad pmd f633f180(000000000da000e7).
mm/memory.c:1041: bad pmd f633f188(000000000dc000e7).
mm/memory.c:1041: bad pmd f633f190(000000000de000e7).
mm/memory.c:1041: bad pmd f633f198(000000000e0000e7).
mm/memory.c:1041: bad pmd f633f1a0(000000000e2000e7).
mm/memory.c:1041: bad pmd f633f1a8(000000000e4000e7).
mm/memory.c:1041: bad pmd f633f1b0(000000000e6000e7).
mm/memory.c:1041: bad pmd f633f1b8(000000000e8000e7).
mm/memory.c:1041: bad pmd f633f1c0(000000000ea000e7).
mm/memory.c:1041: bad pmd f633f1c8(000000000ec000e7).
mm/memory.c:1041: bad pmd f633f1d0(000000000ee000e7).
mm/memory.c:1041: bad pmd f633f1d8(000000000f0000e7).
mm/memory.c:1041: bad pmd f633f1e0(000000000f2000e7).
mm/memory.c:1041: bad pmd f633f1e8(000000000f4000e7).
mm/memory.c:1041: bad pmd f633f1f0(000000000f6000e7).
mm/memory.c:1041: bad pmd f633f1f8(000000000f8000e7).
------------[ cut here ]------------
kernel BUG at arch/i386/mm/hugetlbpage.c:232!
invalid operand: 0000

CPU:    0
EIP:    0060:[<c01148ab>]    Not tainted
EFLAGS: 00010246
EIP is at huge_page_release+0xb/0x30
eax: 00000000   ebx: f633f100   ecx: f7cab4a0   edx: c1000000
esi: 04000000   edi: 0c000000   ebp: f7cc9a24   esp: f64e1f08
ds: 0068   es: 0068   ss: 0068
Process shmt01 (pid: 1888, threadinfo=f64e0000 task=f6da2660)
Stack: c011493b c1000000 f7cc9a24 04000000 c012bf1e c047f094 00000000
c047f080
       f7cc9a24 f6aab130 f6da2660 00000000 c01149a4 f6f6fbb4 04000000
0c000000
       f6f6fbb4 c01149c2 f6f6fbb4 04000000 08000000 c012efd3 f6f6fbb4
f7cc9a24
Call Trace:
 [<c011493b>] unmap_hugepage_range+0x6b/0xb0
 [<c012bf1e>] unmap_all_pages+0x31e/0x330
 [<c01149a4>] zap_hugepage_range+0x24/0x30
 [<c01149c2>] zap_hugetlb_resources+0x12/0x20
 [<c012efd3>] exit_mmap+0x93/0xc0
 [<c0118027>] mmput+0x37/0x60
 [<c011d588>] do_exit+0xd8/0x2e0
 [<c012ecaa>] do_munmap+0xea/0x100
 [<c012ed04>] sys_munmap+0x44/0x70
 [<c01071f3>] syscall_call+0x7/0xb

Code: 0f 0b e8 00 28 08 30 c0 f0 ff 4a 04 0f 94 c0 84 c0 74 09 89

The shmt01 is a modified LTP shm test and has been posted a few times
before.  If anyone wants to see it again let me know and I'll repost.

