Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267507AbTAQNfv>; Fri, 17 Jan 2003 08:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267510AbTAQNfv>; Fri, 17 Jan 2003 08:35:51 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:59357 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S267507AbTAQNfu>; Fri, 17 Jan 2003 08:35:50 -0500
Message-ID: <3E2808D4.3030200@quark.didntduck.org>
Date: Fri, 17 Jan 2003 08:44:52 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
References: <15911.64825.624251.707026@harpo.it.uu.se>
In-Reply-To: <15911.64825.624251.707026@harpo.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Previously today I wrote:
>  > 2.5.59 with CONFIG_PACKET=m oopes when af_packet.ko is insmodded:
>  > 
>  > Unable to handle kernel paging request at virtual address 2220c021
>  >  printing eip:
>  > c0124011
>  > *pde = 00000000
>  > Oops: 0000
>  > CPU:    0
>  > EIP:    0060:[<c0124011>]    Not tainted
>  > EFLAGS: 00010097
>  > EIP is at __find_symbol+0x3d/0x7c
>  > eax: c020f70e   ebx: 00000536   ecx: 00000000   edx: c028b600
>  > esi: 2220c021   edi: e8889558   ebp: e8889558   esp: e67c5ecc
>  > ds: 007b   es: 007b   ss: 0068
>  > Process insmod (pid: 482, threadinfo=e67c4000 task=e6c80ce0)
>  > Stack: e8888f34 e8889a40 00000038 e8883f50 c0124960 e8889558 e67c5ef4 00000001 
>  >        e8888f34 e8889374 e67c5f28 c0124b2a e8883f50 00000016 e8889374 e8889558 
>  >        e8889a40 e8883f50 0000000c 00000017 e8889a40 00000000 0000007c c01253a4 
>  > Call Trace:
>  >  [<c0124960>] resolve_symbol+0x20/0x4c
>  >  [<c0124b2a>] simplify_symbols+0x82/0xe4
>  >  [<c01253a4>] load_module+0x5c4/0x7ec
>  >  [<c012562b>] sys_init_module+0x5f/0x194
>  >  [<c0108887>] syscall_call+0x7/0xb
> 
> This oops occurs for every module, not just af_packet.ko, at
> resolve_symbol()'s first call to __find_symbol().
> 
> What happens is that __find_symbol() oopses because the kernel's
> symbol table is in la-la land. (Note the bogus kernel adress
> 2220c021 it tried to dereference above.)
> 
> Reverting 2.5.59's patch to arch/i386/vmlinux.lds.S cured the
> problem and modules now load correctly for me.
> 
> I don't know if this is a problem also for non-i386 archs.
> 
> /Mikael

What version of ld are you using?

--
				Brian Gerst


