Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270856AbTHFSMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270857AbTHFSMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:12:54 -0400
Received: from proibm3.procempa.com.br ([200.248.222.108]:44241 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270856AbTHFSMu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:12:50 -0400
Date: Wed, 6 Aug 2003 15:15:39 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: andrea@suse.de, <linux-kernel@vger.kernel.org>, <green@namesys.com>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: <20030806094150.4d7b0610.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0308061506170.4979-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Aug 2003, Stephan von Krawczynski wrote:

> Unable to handle kernel NULL pointer dereference at virtual address 00000006
> c0144b14
> *pde = 00000000
> Oops: 0002
> CPU:    1
> EIP:    0010:[<c0144b14>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> eax: 00000000   ebx: f0f66540   ecx: f0f66540   edx: 00000006
> esi: f0f66540   edi: f0f66540   ebp: c2ce0350   esp: c345df24
> ds: 0018   es: 0018   ss: 0018
> Process kswapd (pid: 5, stackpage=c345d000)
> Stack: c0147ddf f0f66540 00000000 c2ce0350 0001bcad c02eab68 c0139228 c2ce0350
>        000001d0 00000200 000001d0 00000016 00000020 000001d0 00000020 00000006
>        c01394b3 00000006 c345c000 c02eab68 000001d0 00000006 c02eab68 00000000 
> Call Trace:    [<c0147ddf>] [<c0139228>] [<c01394b3>] [<c013952e>] [<c013963c>]
>   [<c01396c8>] [<c01397f8>] [<c0139760>] [<c0105000>] [<c010592e>] [<c0139760>]
> Code: 89 02 c7 41 30 00 00 00 00 89 4c 24 04 e9 7a ff ff ff 8d 76 
> 
> 
> >>EIP; c0144b14 <__remove_from_queues+14/30>   <=====
> 
> >>ebx; f0f66540 <_end+30bbb320/3852ee40>
> >>ecx; f0f66540 <_end+30bbb320/3852ee40>
> >>esi; f0f66540 <_end+30bbb320/3852ee40>
> >>edi; f0f66540 <_end+30bbb320/3852ee40>
> >>ebp; c2ce0350 <_end+2935130/3852ee40>
> >>esp; c345df24 <_end+30b2d04/3852ee40>

Stephan,

I'm pretty worried about this problem.

Your oopses seem to be the result of some kind of memory corruption. On
the other oopses we could see the kernel oopsing on
remove_page_from_hash_queue due to corrupted pointers (as Willy pointed 
out). 

Can you please try to crash your box again with 

CONFIG_DEBUG_SLAB=y 

Again, thanks a lot for your reports.

