Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262160AbUKDLNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262160AbUKDLNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUKDLNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:13:00 -0500
Received: from fep19.inet.fi ([194.251.242.244]:23000 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S262160AbUKDLMt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:12:49 -0500
Date: Thu, 4 Nov 2004 13:12:42 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.9 freezes upon dereferencing invalid C++ ref in xxdiff.
Message-ID: <20041104111242.GD13063@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <8393fff041103165225f9b3ef@mail.gmail.com> <Pine.LNX.4.61.0411031923160.4526@musoma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411031923160.4526@musoma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 07:42:02PM -0700, Zwane Mwaikambo wrote:
> On Wed, 3 Nov 2004, Martin Blais wrote:
> 
> > [1.] One line summary of the problem:    
> > 
> > kernel 2.6.9 freezes upon dereferenceing invalid C++ ref in xxdiff.
> 
> Interesting, i could trigger it in 2.6.9 but not 2.6.10-rc1-mm2.
> 
> ------------[ cut here ]------------
> kernel BUG at <bad filename>:25321!
                hmm
> invalid operand: 0000 [#1]
> SMP DEBUG_PAGEALLOC
> Modules linked in: pcnet32
> CPU:    0
> EIP:    0060:[<c038a344>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.9-rtl)
> EIP is at tcp_transmit_skb+0x8f4/0x900
> eax: c19e9eb8   ebx: c2974f60   ecx: 00000020   edx: c2986f60
> esi: 00000020   edi: c21b1dc0   ebp: c2974f60   esp: c23cfd8c
> ds: 007b   es: 007b   ss: 0068
> Process xxdiff (pid: 2194, threadinfo=c23ce000 task=c19e2aa0)
> Stack: c013c879 c3e9b3c0 00000020 c2986000 c03616f7 00000246 c2974f60 00000020
>        c2986f98 c21b1d28 c2974f60 00000020 c21b1bb0 c2974f60 c038c15a c21b1bb0
>        c2986f60 c21b1dc0 c2970f60 c21b1bb0 00000218 c0388d23 c21b1bb0 c2970f60
> Call Trace:
>  [<c013c879>] kmem_cache_alloc+0x69/0xa0
>  [<c03616f7>] skb_clone+0x17/0x140
>  [<c038c15a>] tcp_send_synack+0x14a/0x150
>  [<c0388d23>] tcp_rcv_synsent_state_process+0x543/0x5a0
>  [<c0389723>] tcp_rcv_state_process+0x9a3/0xab0
>  [<c0391236>] tcp_v4_do_rcv+0x76/0x110
>  [<c0360a72>] __release_sock+0x42/0x60
>  [<c0361186>] release_sock+0x56/0x60
>  [<c039e58f>] inet_wait_for_connect+0x7f/0xe0
>  [<c0118d40>] autoremove_wake_function+0x0/0x40
>  [<c0118d40>] autoremove_wake_function+0x0/0x40
>  [<c039e693>] inet_stream_connect+0xa3/0x180
>  [<c035eecd>] sys_connect+0x5d/0x80
>  [<c035fbcc>] sock_setsockopt+0x9c/0x500
>  [<c035dad2>] sock_map_fd+0x102/0x140
...

this looks familiar.  probably fixed by this patch:
[NET]: Make sure to copy TSO fields in copy_skb_header().
http://linux.bkbits.net:8080/linux-2.6/gnupatch@4175f00ayR2dZynZ8yUWYSVkL6Z5og

-- 
