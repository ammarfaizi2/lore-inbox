Return-Path: <linux-kernel-owner+w=401wt.eu-S1753348AbWLYBJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348AbWLYBJK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 20:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753427AbWLYBJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 20:09:10 -0500
Received: from ns.theshore.net ([67.18.92.50]:34239 "EHLO www.theshore.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753348AbWLYBJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 20:09:09 -0500
Message-ID: <458F24BA.5090006@theshore.net>
Date: Sun, 24 Dec 2006 20:09:14 -0500
From: "Christopher S. Aker" <caker@theshore.net>
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
MIME-Version: 1.0
To: "Christopher S. Aker" <caker@theshore.net>
CC: Patrick McHardy <kaber@trash.net>,
       Santiago Garcia Mantinan <manty@manty.net>,
       linux-kernel@vger.kernel.org, ebtables-devel@lists.sourceforge.net
Subject: Re: ebtables problems on 2.6.19.1 *and* 2.6.16.36
References: <20061218082413.GA11064@clandestino.aytolacoruna.es> <45890135.9000306@trash.net> <458DEF02.90908@theshore.net>
In-Reply-To: <458DEF02.90908@theshore.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher S. Aker wrote:
> Patrick McHardy wrote:
>> I'm trying to reproduce this (without success so far), please send your
>> kernel config and your ebtables script.
>>
>> You could try if 2.6.19 works, there were some ebtables changes in
>> 2.6.19.1 that touched this code.
> 
> We're hitting this too, on both 2.6.16.36 and 2.6.19.1.
> 
> BUG: unable to handle kernel paging request at virtual address f8cec008
>  printing eip:
> c0462272
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> Modules linked in: e1000
> CPU:    1
> EIP:    0060:[<c0462272>]    Not tainted VLI
> EFLAGS: 00010286   (2.6.19.1-1-bigmem #1)
> EIP is at translate_table+0x2b3/0xddf
> eax: f8ce2000   ebx: 00000004   ecx: f6d53e90   edx: f8ce2000
> esi: f8cebfa0   edi: 0000000e   ebp: 00000000   esp: f6d53e08
> ds: 007b   es: 007b   ss: 0068
> Process ebtables (pid: 4788, ti=f6d52000 task=f6d51550 task.ti=f6d52000)
> Stack: f6d53e40 c0540440 00000007 f6d53ebc 00000001 00000028 00000000 
> 00000000
>        00000004 00000fa0 00000fd0 f8d38000 f8ce2000 f6d53e90 00000000 
> 80000000
>        00000000 00000000 00000000 00000004 00000014 00000000 00000014 
> 00000600
> Call Trace:
>  [<c0462f5f>] do_replace+0x113/0x6da
>  [<c0142267>] get_page_from_freelist+0x8c/0xa8
>  [<c0463f4c>] do_ebt_set_ctl+0x2d/0x2e
>  [<c03efbc2>] nf_sockopt+0xfa/0xfc
>  [<c03efbe7>] nf_setsockopt+0x23/0x2b
>  [<c03fac35>] ip_setsockopt+0x86/0x91
>  [<c03d54ef>] sock_common_setsockopt+0x23/0x2f
>  [<c03d2d69>] sys_setsockopt+0x61/0xac
>  [<c03d33f3>] sys_socketcall+0x1e9/0x249
>  [<c0114348>] do_page_fault+0x0/0x664
>  [<c0102bc5>] sysenter_past_esp+0x56/0x79
>  [<c047007b>] svc_recv+0x9c/0x3f5
>  =======================
> Code: 30 3b 28 0f 83 5c 02 00 00 8b 54 24 30 8b 74 24 24 8b 4c 24 34 8b 
> 5c 24 4c 03 72 24 8b 79 20 89 5c 24 20 c7 44 24 1c 00 00 00 00 <8b> 56 
> 68 8b 46 6c 29 d0 31 d2 89 44 24 14 8b 06 85 c0 0f 84 f7
> EIP: [<c0462272>] translate_table+0x2b3/0xddf SS:ESP 0068:f6d53e08
> 
> 
> Unable to handle kernel paging request at virtual address f8a3b00c
>  printing eip:
> c03cce45
> *pde = 00000000
> Oops: 0000 [#13]
> SMP
> Modules linked in: e1000
> CPU:    1
> EIP:    0060:[<c03cce45>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16.36-1-bigmem #1)
> EIP is at translate_table+0x47b/0xfc2
> eax: d8fbbc3c   ebx: 00000098   ecx: c049b780   edx: 00000000
> esi: f8a3afa0   edi: 0000000e   ebp: 00000001   esp: d8fbbb7c
> ds: 007b   es: 007b   ss: 0068
> Process ebtables (pid: 7917, threadinfo=d8fba000 task=e7892550)
> Stack: <0>c049b75c f8a3af78 c04468f8 d8fbbbcc c049b740 00000007 d8fbbc68 
> d30f4260
>        000000d2 d8fba000 d30f4240 d8fba000 00000028 00000004 00000000 
> 00000004
>        00000000 00000fa0 00000fd0 f8a8e000 00000000 f8a38000 00000000 
> 00000000
> Call Trace:
>  [<c03cdbd0>] do_replace+0x16b/0x887
>  [<c03ced74>] copy_everything_to_user+0x21a/0x35c
>  [<c03ceef6>] do_ebt_set_ctl+0x40/0x42
>  [<c0354ee0>] nf_sockopt+0x11f/0x121
>  [<c0354f19>] nf_setsockopt+0x37/0x3b
>  [<c0360b14>] ip_setsockopt+0x3f9/0xb0e
>  [<c0354e6e>] nf_sockopt+0xad/0x121
>  [<c0354f54>] nf_getsockopt+0x37/0x3b
>  [<c03617e6>] ip_getsockopt+0x5bd/0x62b
>  [<c012360e>] current_fs_time+0x5d/0x78
>  [<c0178813>] touch_atime+0x7d/0xcd
>  [<c014b366>] zap_pte_range+0xf1/0x316
>  [<c014b68e>] unmap_page_range+0x103/0x174
>  [<c02228a7>] prio_tree_remove+0x77/0xe7
>  [<c014358c>] buffered_rmqueue+0x155/0x209
>  [<c014358c>] buffered_rmqueue+0x155/0x209
>  [<c014376e>] get_page_from_freelist+0x8c/0xa6
>  [<c014376e>] get_page_from_freelist+0x8c/0xa6
>  [<c01437de>] __alloc_pages+0x56/0x309
>  [<c015274c>] page_add_file_rmap+0x2a/0x2c
>  [<c014d48d>] do_anonymous_page+0x122/0x22a
>  [<c014dabd>] __handle_mm_fault+0x138/0x326
>  [<c03391e6>] sock_common_setsockopt+0x33/0x37
>  [<c0336c88>] sys_setsockopt+0x6c/0xb2
>  [<c033739a>] sys_socketcall+0x1f4/0x254
>  [<c01160e5>] do_page_fault+0x0/0x630
>  [<c0102c7f>] sysenter_past_esp+0x54/0x75
> Code: 24 8b bc 24 8c 00 00 00 8b 84 24 88 00 00 00 8b 54 24 64 8b 74 24 
> 44 03 77 24 8b 78 20 c7 44 24 38 00 00 00 00 89 54 24 3c 31 d2 <8b> 4e 
> 6c 8b 5e 68 29 d9 89 4c 24 30 8b 06 85 c0 0f 84 14 02 00
> 
> 
> It seems to happen when flushing a user-defined ebtable, or removing a 
> rule -- but not every time. It leaves the ebtable userspace process in D 
> state on 2.6.19.1 but not on 2.6.16.36 (?).
> 
> Considering I've never had these problems before, and that both stable 
> (2.6.16.36) and current (2.6.19.1) exhibit this issue, I'd venture to 
> guess that it's something that went into both of them very recently.

Just a follow-up -- this doesn't happen with 2.6.19.

-Chris


