Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbUCBLDb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUCBLDb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:03:31 -0500
Received: from 75.80-203-232.nextgentel.com ([80.203.232.75]:18939 "EHLO
	lincoln.jordet.nu") by vger.kernel.org with ESMTP id S261597AbUCBLD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:03:27 -0500
Subject: Re: Oopses with both recent 2.4.x kernels and 2.6.x kernels
From: Stian Jordet <liste@jordet.nu>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
References: <1075832813.5421.53.camel@chevrolet.hybel>
	 <Pine.LNX.4.58L.0402052139420.16422@logos.cnet>
Content-Type: text/plain
Message-Id: <1078225389.931.3.camel@buick.jordet>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 12:03:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 06.02.2004 kl. 00.51 skrev Marcelo Tosatti:
> On Tue, 3 Feb 2004, Stian Jordet wrote:
> 
> > Hello,
> >
> > I have a server which was running 2.4.18 and 2.4.19 for almost 200 days
> > each, without problems. After an upgrade to 2.4.22, the box haven't been
> > up for 30 days in a row. This happened early november. I have caputered
> > oopses with both 2.4.23 and 2.6.1 which I have sent decoded to the list,
> > but have never got any reply.
> >
> > I have ran memtest86 on the box, no errors. What else can be the
> > problem? I could of course go back to 2.4.19, which I know worked fine,
> > but I there have been some fixed security holes since then...
> >
> > Any thoughts?
> 
> Stian,
> 
> I have seen your 2.4.x oopses and they seemed odd. The faults were
> happening in different functions (mostly inside VM "freeing" , due to
> what seems to be random crap in memory:
>
>  <1>Unable to handle kernel NULL pointer dereference at virtual address 00000021
> c0132e86
> *pde = 00000000
> 
> eax: 00000000   ebx: 00000009   ecx: 000001d2   edx: 00000012
> esi: 00000000   edi: c17e38c0   ebp: c1047a00   esp: c86cbdb4
> 
> >>EIP; c0132e86 <sync_page_buffers+e/a4>   <=====
> 
> >>edi; c17e38c0 <_end+14b5844/bd23f84>
> >>ebp; c1047a00 <_end+d19984/bd23f84>
> >>esp; c86cbdb4 <_end+839dd38/bd23f84>
> 
> Trace; c0132fdc <try_to_free_buffers+c0/ec>
> 
> Code;  c0132e86 <sync_page_buffers+e/a4>
> 00000000 <_EIP>:
> Code;  c0132e86 <sync_page_buffers+e/a4>   <=====
>    0:   f6 43 18 06               testb  $0x6,0x18(%ebx)   <=====
> Code;  c0132e8a <sync_page_buffers+12/a4>
>    4:   74 7c                     je     82 <_EIP+0x82> c0132f08
> <sync_page_buffers+90/a4>
> Code;  c0132e8c <sync_page_buffers+14/a4>
>    6:   b8 07 00 00 00            mov    $0x7,%eax
> Code;  c0132e91 <sync_page_buffers+19/a4>
> 
> 
> 
> 
>  <1>Unable to handle kernel NULL pointer dereference at virtual address
> 00000028
> c015e3a2
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c015e3a2>]    Not tainted
> EFLAGS: 00010203
> 
> eax: 0100004d   ebx: 00000000   ecx: 000001d2   edx: 00000000
> 
> Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>
> 00000000 <_EIP>:
> Code;  c015e3a2 <journal_try_to_free_buffers+5a/98>   <=====
>    0:   8b 5b 28                  mov    0x28(%ebx),%ebx   <=====
> Code;  c015e3a5 <journal_try_to_free_buffers+5d/98>
>    3:   f6 42 19 04               testb  $0x4,0x19(%edx)
> Code;  c015e3a9 <journal_try_to_free_buffers+61/98>
>    7:   74 17                     je     20 <_EIP+0x20> c015e3c2
> <journal_try_to_free_buffers+7a/98>
> 
> And other similar oopses.
> 
> Are you sure there is nothing messing up the hardware ?
> 
> How long have you ran memtest86? It can, sometimes, take a long to showup
> errors.
> 
> The 2.6.x oopses on the same hardware is also a useful source of
> information.

Marcelo,

sorry for getting back to you so insanely late. This was a production
server, and I have now moved the services it were running to another
box, so I could run a more exhaustive memtest86. It has now ran for two
days, without any errors. Of course there could be other flaky hardware,
but since I don't know any way to test it, and the oops occurs with
two-four weeks interval, it's quite time consuming to find out. I'm not
even sure if it will oops without the typical load it used to have.

Anyway, thank you very much for at least answering me. Much appreciated
:)

Best regards,
Stian

