Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVCVA1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVCVA1G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVCVA0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:26:50 -0500
Received: from fire.osdl.org ([65.172.181.4]:24451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbVCVAYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:24:48 -0500
Date: Mon, 21 Mar 2005 16:24:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: cel@citi.umich.edu
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 oops in skb_drop_fraglist
Message-Id: <20050321162444.31c6c68d.akpm@osdl.org>
In-Reply-To: <423097D5.30605@citi.umich.edu>
References: <423097D5.30605@citi.umich.edu>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Lever <cel@citi.umich.edu> wrote:
>
> testing NFS client workloads on a dual Pentium-III system running 2.6.11 
> with some NFS patches.  i hit this oops while doing simple-minded ftps 
> and tars.
> 
> the system locks up once or twice a day under this workload.  this is 
> the first time i had the console and captured the oops output.
> 

Chuck, I didn't see any followup to this.  Is it still happening in current
kernels?

Thanks.

> Unable to handle kernel NULL pointer dereference at virtual address 00000001
>   printing eip:
> c02fc752
> *pde = 00000000
> Oops: 0000 [#1]
> SMP
> CPU:    0
> EIP:    0060:[<c02fc752>]    Not tainted VLI
> EFLAGS: 00010202   (2.6.11-CITI_NFS4_ALL-1)
> EIP is at skb_drop_fraglist+0x22/0x50
> eax: f6fe26e0   ebx: 00000001   ecx: f6fe26e0   edx: 00000001
> esi: f6f29240   edi: 00000004   ebp: f697ed24   esp: c04cadd8
> ds: 007b   es: 007b   ss: 0068
> Process swapper (pid: 0, threadinfo=c04ca000 task=c03efb60)
> Stack: 00000001 c02fc7fa f6f29240 f697ecc0 c02fc838 00000000 c02fc8ba 
> ccbf2ab0
>         00000b50 c0326a16 f6f87740 f6f29240 f6f29240 c0321c4a 00000020 
> f6f87778
>         f6f87740 f697ecc0 f69d1560 00625a79 c04cae6c 00000000 00000012 
> f697ecc0
> Call Trace:
>   [<c02fc7fa>] skb_release_data+0x5a/0x90
>   [<c02fc838>] kfree_skbmem+0x8/0x20
>   [<c02fc8ba>] __kfree_skb+0x6a/0xf0
>   [<c0326a16>] tcp_transmit_skb+0x406/0x720
>   [<c0321c4a>] tcp_clean_rtx_queue+0x17a/0x410
>   [<c0322566>] tcp_ack+0xf6/0x580
>   [<c03250d9>] tcp_rcv_established+0x409/0x7f0
>   [<c0102fa0>] apic_timer_interrupt+0x1c/0x24
>   [<c032d8b0>] tcp_v4_do_rcv+0x110/0x120
>   [<c032df7f>] tcp_v4_rcv+0x6bf/0x940
>   [<c0313212>] ip_local_deliver+0xc2/0x1f0
>   [<c0313676>] ip_rcv+0x336/0x450
>   [<c02fc591>] alloc_skb+0x41/0xf0
>   [<c0302736>] netif_receive_skb+0x136/0x1a0
>   [<c026ca9e>] e1000_clean_rx_irq+0x15e/0x4a0
>   [<c02fc8ba>] __kfree_skb+0x6a/0xf0
>   [<c026c6da>] e1000_clean+0xba/0xf0
>   [<c030292f>] net_rx_action+0x6f/0x100
>   [<c011d209>] __do_softirq+0xb9/0xd0
>   [<c01048aa>] do_softirq+0x4a/0x60
> 
> c02fc730:       53                      push   %ebx
> c02fc731:       8b 80 94 00 00 00       mov    0x94(%eax),%eax
> c02fc737:       8b 58 0c                mov    0xc(%eax),%ebx
> c02fc73a:       c7 40 0c 00 00 00 00    movl   $0x0,0xc(%eax)
> c02fc741:       eb 0d                   jmp    c02fc750 
> <skb_drop_fraglist+0x20>
> c02fc743:       90                      nop
> c02fc744:       90                      nop
> c02fc745:       90                      nop
> c02fc746:       90                      nop
> c02fc747:       90                      nop
> c02fc748:       90                      nop
> c02fc749:       90                      nop
> c02fc74a:       90                      nop
> c02fc74b:       90                      nop
> c02fc74c:       90                      nop
> c02fc74d:       90                      nop
> c02fc74e:       90                      nop
> c02fc74f:       90                      nop
> c02fc750:       89 da                   mov    %ebx,%edx
> c02fc752:       8b 1b                   mov    (%ebx),%ebx
> c02fc754:       8b 82 84 00 00 00       mov    0x84(%edx),%eax
> c02fc75a:       48                      dec    %eax
> c02fc75b:       75 13                   jne    c02fc770 
> <skb_drop_fraglist+0x40>
> c02fc75d:       f0 83 44 24 00 00       lock addl $0x0,0x0(%esp,1)
> c02fc763:       89 d0                   mov    %edx,%eax
> c02fc765:       e8 e6 00 00 00          call   c02fc850 <__kfree_skb>
> c02fc76a:       85 db                   test   %ebx,%ebx
> c02fc76c:       75 e2                   jne    c02fc750 
> <skb_drop_fraglist+0x20>
> c02fc76e:       5b                      pop    %ebx
> c02fc76f:       c3                      ret
> c02fc770:       f0 ff 8a 84 00 00 00    lock decl 0x84(%edx)
> c02fc777:       0f 94 c0                sete   %al
> c02fc77a:       84 c0                   test   %al,%al
> c02fc77c:       74 ec                   je     c02fc76a 
> <skb_drop_fraglist+0x3a>
> c02fc77e:       eb e3                   jmp    c02fc763 
> <skb_drop_fraglist+0x33>
> 
> 
> 
> 
