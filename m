Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbTF2MF0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 08:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265644AbTF2MF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 08:05:26 -0400
Received: from [66.212.224.118] ([66.212.224.118]:33542 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S265641AbTF2MFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 08:05:20 -0400
Date: Sun, 29 Jun 2003 08:08:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Oops in __change_page_attr Re: (was 2.5.73-mm2)
Message-ID: <Pine.LNX.4.53.0306290806230.1878@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Jun 2003, William Lee Irwin III wrote:

> On Sat, Jun 28, 2003 at 04:00:13PM -0700, Andrew Morton wrote:
> > What architectures has this been tested on?
> 
> i386 only, CONFIG_HIGHMEM64G with various combinations of highpte &
> highpmd, and nohighmem. No CONFIG_HIGHMEM4G or non-i386 machines that
> can run 2.5.x are within my grasp (obviously CONFIG_HIGHMEM4G machines
> could, I just don't have them, and the discontig code barfs on mem=).

Well i just tried it on a 16G box with CONFIG_HIGHMEM4G;

Manfred, Bill said this would be best routed your way.

Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 0009e140
...
Calibrating delay loop... 1395.91 BogoMIPS
------------[ cut here ]------------
kernel BUG at arch/i386/mm/pageattr.c:110!
invalid operand: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
CPU:    0
EIP:    0060:[<c011c443>]    Not tainted VLI
EFLAGS: 00010046
EIP is at __change_page_attr+0x13/0x1a0
eax: c03b4000   ebx: c18c0000   ecx: 00000000   edx: 00000001
esi: c18c0000   edi: 00000000   ebp: 00000246   esp: c03b5f14
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c03b4000 task=c03380e0)
Stack: c0111f51 00000000 c18c0000 00000000 00000246 c011c645 c18c0000 00000000 
       00000000 c18c0000 00000003 c18c0000 c011c80f c18c0000 00000001 00000000 
       c0142964 c18c0000 00000001 00000000 00000002 c033d4a0 00000000 00000000 
Call Trace:
 [<c0111f51>] timer_interrupt+0xc1/0x1a0
 [<c011c645>] change_page_attr+0x75/0xe0
 [<c011c80f>] kernel_map_pages+0x1f/0x57
 [<c0142964>] free_hot_cold_page+0x24/0x110
 [<c010d552>] do_IRQ+0x1f2/0x220
 [<c03c1feb>] one_highpage_init+0xab/0xd0
 [<c03c2046>] set_highmem_pages_init+0x36/0x50
 [<c03c2386>] mem_init+0x156/0x1f0
 [<c0105000>] _stext+0x0/0x80
 [<c03b6861>] start_kernel+0x121/0x1b0

Code: 08 83 e0 08 74 05 e8 bd 20 00 00 5b 5e 5f 5d c3 90 8d b4 26 00 00 00 
00 55 57 56 53 83 ec 04 8b 5c 24 18 3b 1d d0 86 40 c0 72 08 <0f> 0b 6e 00 
60 8f 2f c0 53 31 ed e8 4d 14 03 00 8b 15 50 7f 33 
 <0>Kernel panic: Attempted to kill the idle task!
In idle task - not syncing
 -- 
function.linuxpower.ca
