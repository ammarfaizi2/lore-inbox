Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313113AbSIDSHu>; Wed, 4 Sep 2002 14:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313190AbSIDSHu>; Wed, 4 Sep 2002 14:07:50 -0400
Received: from gargantua.enseirb.fr ([147.210.18.6]:57590 "EHLO
	gargantua.enseirb.fr") by vger.kernel.org with ESMTP
	id <S313113AbSIDSHs>; Wed, 4 Sep 2002 14:07:48 -0400
Date: Wed, 4 Sep 2002 20:11:55 +0200
From: lists@corewars.org
To: andrea@suse.de, riel@conectiva.com.br, marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 OOPS [Repost]
Message-ID: <20020904201155.A17544@corewars.org>
References: <20020903190726.A15065@corewars.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020903190726.A15065@corewars.org>; from lists@corewars.org on Tue, Sep 03, 2002 at 07:07:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just in case this had someone wondering, the problem was swap
corruption. I did an mkswap on the swap partition, and it doesn't
OOPS anymore.

The OOPS was at vmscan.c:506 (Bad EIP=200)

On Tue, Sep 03, 2002 at 07:07:26PM +0200, lists@corewars.org wrote:
> Hi,
> 
> I'm getting regular oopses that can be easily reproduced with a
> [dd if=/dev/zero of=~/boo bs=4096 count=100000] on my
> Compaq Armada M700/PIII/750MHZ with 256MB RAM with more than 3GB free
> on /home. /home is on ext2, /tmp on tmpfs, with a 500 MB swap partition.
> 
> This is with the 2.4.19 stock kernel.
> 
> Regards,
> Sapan
> 
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000100
> 00000100
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00000100>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010202
> eax: 00000001   ebx: c0315420   ecx: 00000001   edx: d081c000
> esi: 00000001   edi: 0000001e   ebp: 00002480   esp: c12f5f28
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 4, stackpage=c12f5000)
> Stack: c108eff0 c012a313 c0315420 00000000 c12f4000 00000172 000001d0 c02b6e54 
>        c12c72f0 caa9e028 c12c5420 00000000 00000020 000001d0 00000006 0001bcd8 
>        c012a498 00000006 00000000 c02b6e54 00000006 000001d0 c02b6e54 00000000 
> Call Trace:    [<c012a313>] [<c012a498>] [<c012a4fc>] [<c012a5a1>] [<c012a616>]
>   [<c012a751>] [<c012a6b0>] [<c010708b>]
> Code:  Bad EIP value.
> 
> 
> >>EIP; 00000100 Before first symbol   <=====
> 
> >>ebx; c0315420 <swap_info+0/700>
> >>edx; d081c000 <_end+104e3f3c/10525f3c>
> >>ebp; 00002480 Before first symbol
> >>esp; c12f5f28 <_end+fbde64/10525f3c>
> 
> Trace; c012a313 <shrink_cache+2c3/300>
> Trace; c012a498 <shrink_caches+58/80>
> Trace; c012a4fc <try_to_free_pages+3c/60>
> Trace; c012a5a1 <kswapd_balance_pgdat+51/a0>
> Trace; c012a616 <kswapd_balance+26/40>
> Trace; c012a751 <kswapd+a1/c0>
> Trace; c012a6b0 <kswapd+0/c0>
> Trace; c010708b <kernel_thread+2b/40>
> 
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000200
> 00000200
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00000200>]    Not tainted
> EFLAGS: 00010202
> eax: 00000001   ebx: c0315420   ecx: 00000002   edx: d081c000
> esi: 00000002   edi: 00000020   ebp: 000024f7   esp: cabdfe70
> ds: 0018   es: 0018   ss: 0018
> Process bunzip2 (pid: 792, stackpage=cabdf000)
> Stack: c11e6988 c012a313 c0315420 00000000 cabde000 0000018d 000001d2 c02b6e54 
>        c12c72f0 cd0f7034 c12c71a0 00000001 00000020 000001d2 00000006 0001c110 
>        c012a498 00000006 00000000 c02b6e54 00000006 000001d2 c02b6e54 00000000 
> Call Trace:    [<c012a313>] [<c012a498>] [<c012a4fc>] [<c012ae89>] [<c012b11b>]
>   [<c01267bf>] [<c010cfa1>] [<c0130ba6>] [<c01182dd>] [<c0109dbe>] [<c0108857>]
> Code:  Bad EIP value.
> 
> 
> >>EIP; 00000200 Before first symbol   <=====
> 
> >>ebx; c0315420 <swap_info+0/700>
> >>edx; d081c000 <_end+104e3f3c/10525f3c>
> >>ebp; 000024f7 Before first symbol
> >>esp; cabdfe70 <_end+a8a7dac/10525f3c>
> 
> Trace; c012a313 <shrink_cache+2c3/300>
> Trace; c012a498 <shrink_caches+58/80>
> Trace; c012a4fc <try_to_free_pages+3c/60>
> Trace; c012ae89 <balance_classzone+59/1d0>
> Trace; c012b11b <__alloc_pages+11b/180>
> Trace; c01267bf <generic_file_write+42f/730>
> Trace; c010cfa1 <timer_interrupt+71/120>
> Trace; c0130ba6 <sys_write+96/f0>
> Trace; c01182dd <do_softirq+4d/90>
> Trace; c0109dbe <do_IRQ+9e/b0>
> Trace; c0108857 <system_call+33/38>
> 
>  <1>Unable to handle kernel paging request at virtual address 00006c00
> 00006c00
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<00006c00>]    Not tainted
> EFLAGS: 00010202
> eax: 00000001   ebx: c0315420   ecx: 0000006c   edx: d081c000
> esi: 0000006c   edi: 00000006   ebp: 00002504   esp: c9c83e70
> ds: 0018   es: 0018   ss: 0018
> Process bunzip2 (pid: 831, stackpage=c9c83000)
> Stack: c12056a4 c012a313 c0315420 00000073 c9c82000 000001c5 000001d2 c02b6e54 
>        c0132beb 00000306 c12c7520 00000000 00000020 000001d2 00000006 0001c086 
>        c012a498 00000006 00000000 c02b6e54 00000006 000001d2 c02b6e54 00000000 
> Call Trace:    [<c012a313>] [<c0132beb>] [<c012a498>] [<c012a4fc>] [<c012ae89>]
>   [<c012b11b>] [<c01267bf>] [<c0130ba6>] [<c0108857>]
> Code:  Bad EIP value.
> 
> 
> >>EIP; 00006c00 Before first symbol   <=====
> 
> >>ebx; c0315420 <swap_info+0/700>
> >>edx; d081c000 <_end+104e3f3c/10525f3c>
> >>ebp; 00002504 Before first symbol
> >>esp; c9c83e70 <_end+994bdac/10525f3c>
> 
> Trace; c012a313 <shrink_cache+2c3/300>
> Trace; c0132beb <unmap_underlying_metadata+1b/60>
> Trace; c012a498 <shrink_caches+58/80>
> Trace; c012a4fc <try_to_free_pages+3c/60>
> Trace; c012ae89 <balance_classzone+59/1d0>
> Trace; c012b11b <__alloc_pages+11b/180>
> Trace; c01267bf <generic_file_write+42f/730>
> Trace; c0130ba6 <sys_write+96/f0>
> Trace; c0108857 <system_call+33/38>
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
