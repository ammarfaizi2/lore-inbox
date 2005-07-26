Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVGZCna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVGZCna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261619AbVGZCna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:43:30 -0400
Received: from nproxy.gmail.com ([64.233.182.195]:35763 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261613AbVGZCnZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:43:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=K0/g6SnY9POSmbFdJf8AUQ/jI+7sxmn96+cpVipTk0gDnlk3gKHjVIQpxAe1dxGHwlJa4PFV6F/2E5cBeaDecW9fMpC4KlDDPaDC8kGu76IrIwb64Rd2Msy7LEAV9uGEuHA6OZSdvCBxaclqFixqThy3rxyx6udGP0qSzKWzbVc=
Message-ID: <aee4c5bc05072519431964a561@mail.gmail.com>
Date: Tue, 26 Jul 2005 04:43:19 +0200
From: Benoit Dejean <bdejean@gmail.com>
Reply-To: Benoit Dejean <bdejean@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: mlock oops
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	i'm using Debian SID kernel-image-2.6.11-powerpc [1] (which is not
tainted). I've unfortunately started sysutils [2] memtest as user (no caps, no
sticky bit).

/usr/sbin/memtest all

I was expecting the OOMK to rescue my system by killing memtest.
As expected, a few minutes later, my system was back. But an oops occured.
Here's dmesg output :

oom-killer: gfp_mask=0xd2
DMA per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
Normal per-cpu: empty
HighMem per-cpu: empty

Free pages:        2856kB (0kB HighMem)
Active:57185 inactive:57079 dirty:0 writeback:0 unstable:0 free:714
slab:3825 mapped:114890 pagetables:822
DMA free:2856kB min:2896kB low:3620kB high:4344kB active:228740kB
inactive:228316kB present:524288kB pages_scanned:538055
all_unreclaimable? yes
lowmem_reserve[]: 0 0 0
Normal free:0kB min:0kB low:0kB high:0kB active:0kB inactive:0kB
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB
inactive:0kB present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 0*4kB 1*8kB 32*16kB 23*32kB 3*64kB 1*128kB 1*256kB 0*512kB
1*1024kB 0*2048kB 0*4096kB = 2856kB
Normal: empty
HighMem: empty
Swap cache: add 332526, delete 218150, find 72396/87670, race 0+0
Free swap  = 219592kB
Total swap = 976540kB
Out of Memory: Killed process 2386 (memtest).
memtest: page allocation failure. order:0, mode:0xd2
Call trace:
 [c0007450] dump_stack+0x18/0x28
 [c003fa2c] __alloc_pages+0x2a4/0x3e4
 [c004ce80] do_anonymous_page+0x98/0x4c8
 [c004d320] do_no_page+0x70/0x798
 [c004dc9c] handle_mm_fault+0xe8/0x1d8
 [c004afa0] get_user_pages+0x124/0x4c4
 [c004de20] make_pages_present+0x88/0xbc
 [c004e4ec] mlock_fixup+0xe4/0xe8
 [c004e5f0] do_mlock+0x100/0x104
 [c004e6b8] sys_mlock+0xc4/0x114
 [c0004290] ret_from_syscall+0x0/0x4c


Thanks.


[1] http://packages.debian.org/unstable/base/kernel-image-2.6.11-powerpc
[2] http://packages.debian.org/stable/utils/sysutils
