Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965118AbWEaT2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWEaT2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 15:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWEaT2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 15:28:21 -0400
Received: from dvhart.com ([64.146.134.43]:56721 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S965118AbWEaT2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 15:28:20 -0400
Message-ID: <447DEE53.2010301@mbligh.org>
Date: Wed, 31 May 2006 12:28:19 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.17-rc5-mm1 panic on p-series
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get a different panic on -mm1 from mainline (and much
earlier)

http://test.kernel.org/abat/33808/debug/console.log

Badness in local_bh_disable at kernel/softirq.c:86
Call Trace:
[C00000000051F280] [C00000000000EEC8] .show_stack+0x74/0x1b4 (unreliable)
[C00000000051F330] [C000000000338664] .program_check_exception+0x1f4/0x65c
[C00000000051F410] [C0000000000044EC] program_check_common+0xec/0x100
--- Exception: 700 at .local_bh_disable+0x34/0x4c
     LR = .do_softirq+0x64/0xd0
[C00000000051F790] [C000000000063B64] .irq_exit+0x64/0x7c
[C00000000051F810] [C0000000000228E0] .timer_interrupt+0x464/0x48c
[C00000000051F8E0] [C0000000000034EC] decrementer_common+0xec/0x100
--- Exception: 901 at .memset+0x80/0xfc
     LR = .__alloc_bootmem_core+0x39c/0x3dc
[C00000000051FBD0] [C0000000004460E8] 0xc0000000004460e8 (unreliable)
[C00000000051FC90] [C0000000003D51B0] .__alloc_bootmem_nopanic+0x44/0xb0
[C00000000051FD30] [C0000000003D523C] .__alloc_bootmem+0x20/0x5c
[C00000000051FDB0] [C0000000003D6124] .alloc_large_system_hash+0x130/0x268
[C00000000051FE70] [C0000000003D78D4] .vfs_caches_init_early+0x5c/0xd4
[C00000000051FEF0] [C0000000003BD718] .start_kernel+0x220/0x320
[C00000000051FF90] [C000000000008594] .start_here_common+0x88/0x8c
Badness in __local_bh_enable at kernel/softirq.c:100
Call Trace:
[C00000000051F280] [C00000000000EEC8] .show_stack+0x74/0x1b4 (unreliable)
[C00000000051F330] [C000000000338664] .program_check_exception+0x1f4/0x65c
[C00000000051F410] [C0000000000044EC] program_check_common+0xec/0x100
--- Exception: 700 at .__local_bh_enable+0x60/0x7c
     LR = .do_softirq+0xb0/0xd0
[C00000000051F700] [C00000000000B518] .do_softirq+0xa8/0xd0 (unreliable)
[C00000000051F790] [C000000000063B64] .irq_exit+0x64/0x7c
[C00000000051F810] [C0000000000228E0] .timer_interrupt+0x464/0x48c
[C00000000051F8E0] [C0000000000034EC] decrementer_common+0xec/0x100
--- Exception: 901 at .memset+0x80/0xfc
     LR = .__alloc_bootmem_core+0x39c/0x3dc
[C00000000051FBD0] [C0000000004460E8] 0xc0000000004460e8 (unreliable)
[C00000000051FC90] [C0000000003D51B0] .__alloc_bootmem_nopanic+0x44/0xb0
[C00000000051FD30] [C0000000003D523C] .__alloc_bootmem+0x20/0x5c
[C00000000051FDB0] [C0000000003D6124] .alloc_large_system_hash+0x130/0x268
[C00000000051FE70] [C0000000003D78D4] .vfs_caches_init_early+0x5c/0xd4
[C00000000051FEF0] [C0000000003BD718] .start_kernel+0x220/0x320
[C00000000051FF90] [C000000000008594] .start_here_common+0x88/0x8c
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
