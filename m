Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbUKDCqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUKDCqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbUKDCnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:43:17 -0500
Received: from fsmlabs.com ([168.103.115.128]:24971 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S261174AbUKDCmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 21:42:14 -0500
Date: Wed, 3 Nov 2004 19:42:02 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Martin Blais <blais@furius.ca>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.9 freezes upon dereferencing invalid C++ ref in
 xxdiff.
In-Reply-To: <8393fff041103165225f9b3ef@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0411031923160.4526@musoma.fsmlabs.com>
References: <8393fff041103165225f9b3ef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Nov 2004, Martin Blais wrote:

> [1.] One line summary of the problem:    
> 
> kernel 2.6.9 freezes upon dereferenceing invalid C++ ref in xxdiff.

Interesting, i could trigger it in 2.6.9 but not 2.6.10-rc1-mm2.

------------[ cut here ]------------
kernel BUG at <bad filename>:25321!
invalid operand: 0000 [#1]
SMP DEBUG_PAGEALLOC
Modules linked in: pcnet32
CPU:    0
EIP:    0060:[<c038a344>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rtl)
EIP is at tcp_transmit_skb+0x8f4/0x900
eax: c19e9eb8   ebx: c2974f60   ecx: 00000020   edx: c2986f60
esi: 00000020   edi: c21b1dc0   ebp: c2974f60   esp: c23cfd8c
ds: 007b   es: 007b   ss: 0068
Process xxdiff (pid: 2194, threadinfo=c23ce000 task=c19e2aa0)
Stack: c013c879 c3e9b3c0 00000020 c2986000 c03616f7 00000246 c2974f60 00000020
       c2986f98 c21b1d28 c2974f60 00000020 c21b1bb0 c2974f60 c038c15a c21b1bb0
       c2986f60 c21b1dc0 c2970f60 c21b1bb0 00000218 c0388d23 c21b1bb0 c2970f60
Call Trace:
 [<c013c879>] kmem_cache_alloc+0x69/0xa0
 [<c03616f7>] skb_clone+0x17/0x140
 [<c038c15a>] tcp_send_synack+0x14a/0x150
 [<c0388d23>] tcp_rcv_synsent_state_process+0x543/0x5a0
 [<c0389723>] tcp_rcv_state_process+0x9a3/0xab0
 [<c0391236>] tcp_v4_do_rcv+0x76/0x110
 [<c0360a72>] __release_sock+0x42/0x60
 [<c0361186>] release_sock+0x56/0x60
 [<c039e58f>] inet_wait_for_connect+0x7f/0xe0
 [<c0118d40>] autoremove_wake_function+0x0/0x40
 [<c0118d40>] autoremove_wake_function+0x0/0x40
 [<c039e693>] inet_stream_connect+0xa3/0x180
 [<c035eecd>] sys_connect+0x5d/0x80
 [<c035fbcc>] sock_setsockopt+0x9c/0x500
 [<c035dad2>] sock_map_fd+0x102/0x140
 [<c01515cb>] fget+0x3b/0x50
 [<c01189de>] __might_sleep+0xae/0xd0
 [<c02314cf>] copy_from_user+0x4f/0x80
 [<c035f7a1>] sys_socketcall+0x91/0x1b0
 [<c0114760>] do_page_fault+0x0/0x5a8
 [<c0106e26>] error_code+0x126/0x130
 [<c0105c87>] syscall_call+0x7/0xb
Code: 8d b4 26 00 00 00 00 8a 87 4f 01 00 00 84 c0 0f 84 02 f8 ff ff 8b 54 24 1c 25 ff 00 00
 00 8d 54 c2 04 89 54 24 1c e9 ec f7 ff ff <0f> 0b e9 62 f7 ff ff 90 8d 74 26 00 53 8b 4c 24 0
c 8b 5c 24 08
