Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286786AbRLVORL>; Sat, 22 Dec 2001 09:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286787AbRLVOQv>; Sat, 22 Dec 2001 09:16:51 -0500
Received: from castle.nmd.msu.ru ([193.232.112.53]:34820 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id <S286786AbRLVOQj>;
	Sat, 22 Dec 2001 09:16:39 -0500
Message-ID: <20011222172450.B29791@castle.nmd.msu.ru>
Date: Sat, 22 Dec 2001 17:24:50 +0300
From: Andrey Savochkin <saw@saw.sw.com.sg>
To: Steffen Persvold <sp@scali.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 ? network driver problem.
In-Reply-To: <3C246691.2CD6460F@scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <3C246691.2CD6460F@scali.no>; from "Steffen Persvold" on Sat, Dec 22, 2001 at 11:55:13AM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I can say is that your oops look quite strange.
What is located at address c0200002 in your vmlinux file?

The code 81 47 08 89 44 24 28... looks suspicious:
      0:   81 47 08 89 44 24 28      addl   $0x28244489,0x8(%edi)

For example, if it were 89 47 08 89 44 24 28..., it would be
      0:   89 47 08                  movl   %eax,0x8(%edi)
      3:   89 44 24 28               movl   %eax,0x28(%esp,1)

You might have just a severe memory corruption.

	Andrey

On Sat, Dec 22, 2001 at 11:55:13AM +0100, Steffen Persvold wrote:
> Sometimes under heavy load one of the nodes (random node each time) crash with the following Oops :
> 
> Unable to handle kernel paging request at virtual address 0000d5ca
>  printing eip:
> c0200002
> *pde = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<c0200002>]    Not tainted
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000001   ecx: dfa36000   edx: c0311840
> esi: dfa36000   edi: 0000d5c2   ebp: df7123c0   esp: c9bc5ee0
> ds: 0018   es: 0018   ss: 0018
> Process mpi_bomb (pid: 16020, stackpage=c9bc5000)
> Stack: 00000001 df7123c0 00000001 df7123c0 c01d109c 00000108 00000002 00000020 
>        0000003c c01ccd6c df7123c0 df7123c0 00000001 00000003 dfa36000 e0902188 
>        dfa36000 00000001 dfa36144 0000000c 00000001 00000001 df7123c0 df7123c0 
> Call Trace: [<c01d109c>] netif_rx [kernel] 0x8c 
> [<c01ccd6c>] alloc_skb [kernel] 0xfc 
> [<e0902188>] __insmod_eepro100_S.text_L11712 [eepro100] 0x2128 
> [<c01d154b>] net_rx_action [kernel] 0x1eb 
> [<c011f74b>] do_softirq [kernel] 0x7b 
> [<c0108c4d>] do_IRQ [kernel] 0xdd 
> [<c022a550>] call_do_IRQ [kernel] 0x5 
> 
> 
> Code: 81 47 08 89 44 24 28 b8 b8 1a 31 c0 0f b7 5e 5c f0 83 28 01 
