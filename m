Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWEAMoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWEAMoz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 08:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWEAMoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 08:44:55 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24207 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932079AbWEAMoy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 08:44:54 -0400
Date: Mon, 1 May 2006 14:49:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060501124942.GA21918@elte.hu>
References: <20060419112130.GA22648@elte.hu> <20060420091856.GB21660@wotan.suse.de> <20060421112049.GA5609@elte.hu> <20060421114501.GA22570@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060421114501.GA22570@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=no SpamAssassin version=3.0.3
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI, even on 2.6.17-rc3 i get the one below. v2.6.17 showstopper i 
guess?

	Ingo

zone c1e04600 (HighMem):
pfn: 00037d00
zone->zone_start_pfn: 00037e00
zone->spanned_pages: 00007e00
zone->zone_start_pfn + zone->spanned_pages: 0003fc00
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:526!
invalid opcode: 0000 [#1]
PREEMPT SMP 
Modules linked in:
CPU:    1
EIP:    0060:[<c0159183>]    Not tainted VLI
EFLAGS: 00010002   (2.6.17-rc3-lockdep #143) 
EIP is at __rmqueue+0x98/0xdd
eax: 00000001   ebx: c305d400   ecx: c012ac22   edx: 00000001
esi: c1e046dc   edi: 00000008   ebp: f4ea6bd0   esp: f4ea6bb4
ds: 007b   es: 007b   ss: 0068
Process chroot02 (pid: 9970, threadinfo=f4ea6000 task=f448e030)
Stack: <0>00000000 c1e04600 c3058000 00000100 c6d42e50 c6d42e5c 00000296 f4ea6c20 
       c01592ec 00000000 f448e608 00000003 c1e04908 00000000 000201d2 c1e04908 
       00000014 00000000 00000003 00000001 00000001 c1e04600 00000377 00000000 
Call Trace:
 [<c0104e5c>] show_stack_log_lvl+0x8b/0x95
 [<c0104ffc>] show_registers+0x147/0x1ad
 [<c010531b>] die+0x179/0x24e
 [<c0f48f9f>] do_trap+0x7c/0x96
 [<c0105768>] do_invalid_op+0x89/0x93
 [<c0104a03>] error_code+0x4f/0x54
 [<c01592ec>] get_page_from_freelist+0x124/0x436
 [<c015965e>] __alloc_pages+0x60/0x290
 [<c016ba71>] alloc_pages_current+0x77/0x7c
 [<c0154cec>] page_cache_alloc_cold+0x7f/0x83
 [<c015aa4a>] __do_page_cache_readahead+0x9e/0x1b2
 [<c015ac6d>] do_page_cache_readahead+0x40/0x4d
 [<c0155fa8>] filemap_nopage+0x149/0x30a
 [<c016141b>] __handle_mm_fault+0x3e9/0xb18
 [<c0f49e4d>] do_page_fault+0x317/0x725
 [<c0104a03>] error_code+0x4f/0x54
 [<c019f63d>] padzero+0x19/0x28
 [<c01a06fc>] load_elf_binary+0x904/0x15de
 [<c0181896>] search_binary_handler+0xcf/0x29e
 [<c0181bc0>] do_execve+0x15b/0x1fe
 [<c01029df>] sys_execve+0x2a/0x6d
 [<c0103ddb>] syscall_call+0x7/0xb
Code: 4d e8 29 01 88 d9 d3 e2 89 55 f0 eb 40 d1 6d f0 83 ee 0c 8b 5d ec 4f 6b 45 f0 54 01 c3 8b 45 e8 89 da e8 24 f8 ff ff 85 c0 74 08 <0f> 0b 0e 02 43 8f 04 c1 8b 16 8d 43 4c 89 42 04 89 53 4c 89 70 
