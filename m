Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWAYOHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWAYOHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 09:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWAYOHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 09:07:31 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:16914 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751171AbWAYOHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 09:07:31 -0500
Message-ID: <43D785E1.4020708@shadowen.org>
Date: Wed, 25 Jan 2006 14:06:25 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm3
References: <20060124232406.50abccd1.akpm@osdl.org>
In-Reply-To: <20060124232406.50abccd1.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that something is causing panic's on some of our test beds.  At
first sight it appears to be something slab related (alloc_slabmgmt).  I
had a quick look at what had been added in -mm3 (as -mm2 is ok) but the
only things that jumped out really didn't want to be backed out.

Any suggestions as to what I should try?

-apw

Checking if this processor honours the WP bit even in supervisor mode... Ok.
BUG: unable to handle kernel paging request at virtual address dfff9010
 printing eip:
c014dfb7
*pde = 00000000
Oops: 0002 [#1]
SMP
last sysfs file:
Modules linked in:
CPU:    0
EIP:    0060:[<c014dfb7>]    Not tainted VLI
EFLAGS: 00010206   (2.6.16-rc1-mm3-autokern1 #1)
EIP is at alloc_slabmgmt+0x3b/0x50
eax: c04335a0   ebx: 00000060   ecx: 00000014   edx: dfff9000
esi: dfff9000   edi: c04335a0   ebp: 00000001   esp: c04b5f20
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c04b4000 task=c042e960)
Stack: <0>dfff9000 00000000 c014e1a8 c04335a0 dfff9000 00000000 000000d0
00000010
       000000d0 c04b4000 c04d52b0 00000001 c04d52a0 c014e3e8 c04335a0
000000d0
       00000000 c04d5280 c04b4000 c04335a0 00000202 000000d0 c014e71f
c04335a0
Call Trace:
 <c014e1a8> cache_grow+0xb1/0x12d   <c014e3e8>
cache_alloc_refill+0x1c4/0x206
 <c014e71f> kmem_cache_alloc+0x77/0x84   <c014d729>
kmem_cache_create+0x184/0x5d8
 <c014cd63> cache_estimate+0x6c/0x8a   <c04c7fc8>
kmem_cache_init+0x139/0x36d
 <c04ba701> start_kernel+0x109/0x17e
Code: d0 00 00 00 00 79 1b ff 74 24 18 ff b0 f0 00 00 00 e8 06 07 00 00
89 c2 58 31 c0 85 d2 59 74 1d eb 09 8d 14 33 03 98 f4 00 00 00 <c7> 42
10 00 00 00 00 8d 04 33 89 42 0c 89 d0 89 5a 08 5b 5e c3
 <0>Kernel panic - not syncing: Attempted to kill the idle task!

