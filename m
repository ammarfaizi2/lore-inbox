Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUC1QLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUC1QLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 11:11:19 -0500
Received: from test.estpak.ee ([194.126.115.47]:50156 "EHLO arena.estpak.ee")
	by vger.kernel.org with ESMTP id S261918AbUC1QLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 11:11:15 -0500
From: Hasso Tepper <hasso@estpak.ee>
Organization: Elion Enterprises Ltd.
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic in 2.4.25
Date: Sun, 28 Mar 2004 19:11:06 +0300
User-Agent: KMail/1.6.2
References: <200403260035.09821.hasso@estpak.ee>
In-Reply-To: <200403260035.09821.hasso@estpak.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403281911.07139.hasso@estpak.ee>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hasso Tepper wrote:
> It's almost 100% (sometimes it just hangs) reproducable for me
> although in somewhat strange situation. I have to run Quagga/Zebra
> routing suite with zebra and ospfd daemons running. Networking
> restart script (removing 60 vlans, creating them again and
> assigning IPs to them) leads to panic. Process isn't always
> swapper, I have seen ip and kupdated as well, but trace is always
> same. I can't reproduce it with 2.4.20 kernel.

It's introduced with 2.4.25-rc1 (2.4.25-pre8 is OK). And it's still 
there in 2.4.26-rc1.

> Unable to handle kernel NULL pointer dereference at virtual address
> 00000000
> c0118743
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c0118743>]    Not tainted
> EFLAGS: 00010082
> eax: c02da4c4   ebx: c02da3c4   ecx: c02da4c4   edx: 00000000
> esi: c02e7a20   edi: c02da2a0   ebp: c028df40   esp: c028df14
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 0, stackpage=c028d000)
> Stack: 00000000 c02d1b80 00000000 00002400 00000000 00002400
> 00000004 00000000
>        00000001 c028df38 c028df38 c028df48 c0115898 c028df60
> c01157c9 00000000
>        00000001 c02d1ba0 fffffffe c028df7c c01155ab c02d1ba0
> 00000000 c02d1900
> Call Trace:    [<c0115898>] [<c01157c9>] [<c01155ab>] [<c0108072>]
> [<c0105260>]
>   [<c0105260>] [<c010a228>] [<c0105260>] [<c0105260>] [<c0105286>]
> [<c01052f9>]
>   [<c0105000>] [<c010502a>]
> Code: 8b 02 89 48 04 89 01 89 51 04 89 0a 89 f1 39 d9 0f 85 37 ff
>
> >>EIP; c0118743 <timer_bh+1b7/35c>   <=====
> >>
> >>eax; c02da4c4 <tv1+4/804>
> >>ebx; c02da3c4 <tv2+124/220>
> >>ecx; c02da4c4 <tv1+4/804>
> >>esi; c02e7a20 <serial_timer+0/20>
> >>edi; c02da2a0 <tv2+0/220>
> >>ebp; c028df40 <init_task_union+1f40/2000>
> >>esp; c028df14 <init_task_union+1f14/2000>
>
> Trace; c0115898 <bh_action+1c/4c>
> Trace; c01157c9 <tasklet_hi_action+49/70>
> Trace; c01155ab <do_softirq+4b/a0>
> Trace; c0108072 <do_IRQ+96/a8>
> Trace; c0105260 <default_idle+0/30>
> Trace; c0105260 <default_idle+0/30>
> Trace; c010a228 <call_do_IRQ+5/d>
> Trace; c0105260 <default_idle+0/30>
> Trace; c0105260 <default_idle+0/30>
> Trace; c0105286 <default_idle+26/30>
> Trace; c01052f9 <cpu_idle+41/54>
> Trace; c0105000 <_stext+0/0>
> Trace; c010502a <rest_init+2a/30>
>
> Code;  c0118743 <timer_bh+1b7/35c>
> 00000000 <_EIP>:
> Code;  c0118743 <timer_bh+1b7/35c>   <=====
>    0:   8b 02                     mov    (%edx),%eax   <=====
> Code;  c0118745 <timer_bh+1b9/35c>
>    2:   89 48 04                  mov    %ecx,0x4(%eax)
> Code;  c0118748 <timer_bh+1bc/35c>
>    5:   89 01                     mov    %eax,(%ecx)
> Code;  c011874a <timer_bh+1be/35c>
>    7:   89 51 04                  mov    %edx,0x4(%ecx)
> Code;  c011874d <timer_bh+1c1/35c>
>    a:   89 0a                     mov    %ecx,(%edx)
> Code;  c011874f <timer_bh+1c3/35c>
>    c:   89 f1                     mov    %esi,%ecx
> Code;  c0118751 <timer_bh+1c5/35c>
>    e:   39 d9                     cmp    %ebx,%ecx
> Code;  c0118753 <timer_bh+1c7/35c>
>   10:   0f 85 37 ff 00 00         jne    ff4d <_EIP+0xff4d>
> c0128690 <swap_entry
> _free+18/3c>
>
>  <0>Kernel panic: Aiee, killing interrupt handler!

-- 
Hasso Tepper
Elion Enterprises Ltd.
WAN administrator
