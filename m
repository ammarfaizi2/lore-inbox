Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbUKDB10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbUKDB10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUKDB10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:27:26 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:52413 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262015AbUKDB1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:27:17 -0500
Date: Wed, 3 Nov 2004 20:27:09 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@lazuli.engin.umich.edu
To: Ray Van Dolson <rayvd@digitalpath.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: kernel BUG at mm/prio_tree.c:377
Message-ID: <Pine.GSO.4.58.0411032015500.9079@lazuli.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ray,

Can you please apply the patch I recently posted and report
back.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109926628920398

The patch fixes a bug reported earlier. However, earlier
oops were triggered at mm/prio_tree.c:538.

I haven't looked at the trace carefully. I will do so.
Please report back if the previous patch fixes your problem.

Thanks,
Rajesh

-----------------------------------------------------

Ray Van Dolson <rayvd@digitalpath.net> wrote:

Description of problem:
Running on an HP DL140, w/ Dual 2.4GHz Xeon's.  1GB of ECC DDR.  Fedora
Core 2.

This server operates as a PPTP Concentrator running the PoPToP server
(1.2.1) along with pppd 2.4.3.  We have tried this system using both
the onboard Broadcom gigabit NIC's as well as a dual Intel EEPro 100.

Usually within 24 hours of bootup, the following oops occurs:

kernel BUG at mm/prio_tree.c:377!
invalid operand: 0000 [#1]
SMP nntrack(U) ip_tables(U) md5(U) ipv6(U) sunrpc(U) e100(U) mii(U)
sg(U) scsi_mod(U) microcode(U) dm_mod(U) ohci_hcd(U) button(U)
battery(U) asus_acpi(U) ac(U) ext3(U) jbd(U)
Modules linked in: ipt_LOG(U) sch_tbf(U) ppp_mppe(U) ppp_async(U)
crc_ccitt(U) ppp_generic(U) slhc(U) ipt_limit(U) ipt_REJECT(U)
ipt_multiport(U) iptable_filter(U) iptable_nat(U) ip_co
CPU:    1
EIP:    0060:[<021425de>]    Tainted: P
EFLAGS: 00010202   (2.6.8-1.521custom)
EIP is at prio_tree_right+0x85/0xc5
eax: 00000009   ebx: 0cf1acf8   ecx: 00000000   edx: 12da3d00
esi: 00000000   edi: 00000004   ebp: 404a6d78   esp: 0cf1ac90
ds: 007b   es: 007b   ss: 0068
Process yum (pid: 24194, threadinfo=0cf1a000 task=12e4ecb0)
Stack: 0cf1acf8 00000004 00000004 404a6d78 021427ae 00000004 0cf1acb0
0cf1acb4 00000000 00000043 0cf1acf8 404a6d78 00000004 08ec1ac4 02142968
00000004 0000007b 404a6d54 034fac80 02150cf7 00000004 00000004 00000004
00000001
Call Trace:
 [<021427ae>] prio_tree_next+0x89/0x9b
 [<02142968>] vma_prio_tree_next+0x4b/0x63
 [<02150cf7>] page_referenced+0x14d/0x18d
 [<021478cd>] refill_inactive_zone+0x245/0x6a0
 [<0211b29e>] activate_task+0x86/0x93
 [<02147db5>] shrink_zone+0x8d/0xb4
 [<02147e1f>] shrink_caches+0x43/0x4e
 [<02147edd>] try_to_free_pages+0xb3/0x16c
 [<02140369>] __alloc_pages+0x1c8/0x2be
 [<0214bd83>] do_anonymous_page+0xb6/0x241
 [<0214bf77>] do_no_page+0x69/0x3a0
 [<0214c460>] handle_mm_fault+0xdf/0x1d4
 [<0211955b>] do_page_fault+0x17c/0x58b
 [<0214e81d>] unmap_vma_list+0xe/0x17
 [<0214ebd5>] do_munmap+0x17a/0x186
 [<0214fcef>] move_page_tables+0x3f/0x4c
 [<0214fded>] move_vma+0xf1/0x175
 [<0215017a>] do_mremap+0x309/0x32c
 [<021193df>] do_page_fault+0x0/0x58b
Code: 0f 0b 79 01 cf fa 2e 02 39 52 04 74 08 0f 0b 7a 01 cf fa 2e

The system continues to function for approxiamately another minute.  I
see messages such as the following on the console repeatedly:

dst cache overflow

Eventually the system becomes completely unresponsive.  When I hit the
power button, ACPI tries to power down the system, but hangs after
killing a few processes and I must hard reset it.

I do not think this is bad hardware as we have approximately 11
DL140's and this will happen on all of them although more quickly on
the ones with higher user load (network traffic, CPU usage, etc).

Hoping someone can give me some suggestions if this is more likely to be a
hardware issue... just can't imagine getting that many bad servers. :)

Thanks in advance.
