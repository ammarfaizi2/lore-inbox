Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263594AbTCULyU>; Fri, 21 Mar 2003 06:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263596AbTCULyT>; Fri, 21 Mar 2003 06:54:19 -0500
Received: from landfill.ihatent.com ([217.13.24.22]:63876 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S263594AbTCULyS>;
	Fri, 21 Mar 2003 06:54:18 -0500
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.65-mm3
References: <20030320235821.1e4ff308.akpm@digeo.com>
	<87znnp3s1h.fsf@lapper.ihatent.com>
	<20030321030540.598ebca5.akpm@digeo.com>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 21 Mar 2003 13:05:20 +0100
In-Reply-To: <20030321030540.598ebca5.akpm@digeo.com>
Message-ID: <87llz87wn3.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> writes:

> Alexander Hoogerhuis <alexh@ihatent.com> wrote:
> >
> > Andrew Morton <akpm@digeo.com> writes:
> > >
> > > [SNIP]
> > >
> >
> > ... 
> > make[4]: *** [net/ipv4/netfilter/ip_conntrack_core.o] Error 1
> 
> Bah, sorry.
> 
> --- 25/net/ipv4/netfilter/ip_conntrack_core.c~a	2003-03-21 03:04:45.000000000 -0800
> +++ 25-akpm/net/ipv4/netfilter/ip_conntrack_core.c	2003-03-21 03:04:48.000000000 -0800
> @@ -274,7 +274,7 @@ static void remove_expectations(struct i
>  		 * the un-established ones only */
>  		if (exp->sibling) {
>  			DEBUGP("remove_expectations: skipping established %p of %p\n", exp->sibling, ct);
> -			exp->sibling =3D NULL;
> +			exp->sibling = NULL;
>  			continue;
>  		}
>  

Restarting my PCMCIA init.d script ended with this one in my log:

Unable to handle kernel NULL pointer dereference at virtual address 00000004
 printing eip:
c0211457
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c0211457>]    Not tainted VLI
EFLAGS: 00210246
EIP is at devclass_remove_driver+0x4b/0x8f
eax: f4d88b48   ebx: f0964664   ecx: 00000000   edx: 00000000
esi: f0964620   edi: f4d88b00   ebp: c9a59f28   esp: c9a59f14
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 5665, threadinfo=c9a58000 task=de569380)
Stack: c02b8c07 00000042 c0331440 c0331400 f4d88b00 c9a59f44 c0210d5b f4d88b00
       00000042 f4d88b0c f4d88b00 c02fa6f8 c9a59f5c c0211129 f4d88b00 f4d88c80
       f4d88c80 c02fa6f8 c9a59f98 f0948326 f4d88b00 0000001a 00000000 00000019
Call Trace:
 [<f4d88b00>] i82365_driver+0x0/0x80 [i82365]
 [<c0210d5b>] bus_remove_driver+0x5f/0x97
 [<f4d88b00>] i82365_driver+0x0/0x80 [i82365]
 [<f4d88b0c>] i82365_driver+0xc/0x80 [i82365]
 [<f4d88b00>] i82365_driver+0x0/0x80 [i82365]
 [<c0211129>] driver_unregister+0x1a/0x44
 [<f4d88b00>] i82365_driver+0x0/0x80 [i82365]
 [<f4d88c80>] +0x0/0x200 [i82365]
 [<f4d88c80>] +0x0/0x200 [i82365]
 [<f0948326>] init_i82365+0x127/0x131 [i82365]
 [<f4d88b00>] i82365_driver+0x0/0x80 [i82365]
 [<f095d940>] +0x1e0/0x397 [pcmcia_core]
 [<c01300ed>] sys_init_module+0x13f/0x21d
 [<c010ad8f>] syscall_call+0x7/0xb
 
Code: 42 00 00 00 c7 04 24 07 8c 2b c0 e8 2a 89 f0 ff 89 d8 ba 01 00 ff ff 0f c1 10 85 d2 0f 85 f1 03 00 00 8d 47 48 8b 57 48 8b 48 04 <89> 4a 04 89 11 89 40 04 89 47 48 89 3c 24 e8 68 fe ff ff 89 d8
 <6>cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3c0-0x3df 0x3f8-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x1000-0x17ff: excluding 0x1000-0x107f 0x1100-0x113f 0x1200-0x121f
cs: IO port probe 0x0a00-0x0aff: clean.
lapper root #

Apart form that, the machine seems alive :)

mvh,
A
-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
