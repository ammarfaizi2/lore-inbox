Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261390AbTC3P6F>; Sun, 30 Mar 2003 10:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbTC3P6F>; Sun, 30 Mar 2003 10:58:05 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:49420 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261390AbTC3P6B>; Sun, 30 Mar 2003 10:58:01 -0500
Date: Sun, 30 Mar 2003 17:08:29 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Kronos <kronos@kronoz.cjb.net>
cc: linux-fbdev-devel@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: Debug: sleeping function called from illegal context at
 mm/slab.c:1723
In-Reply-To: <20030330132915.GA2198@dreamland.darkstar.lan>
Message-ID: <Pine.LNX.4.44.0303301708090.14656-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Try my patch at http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

That should fix it.



On Sun, 30 Mar 2003, Kronos wrote:

> Hi,
> I got this  under 2.5.66. It happens when I'm using  links (the browser)
> and is reproducible:
> 
> 
> .c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c012dc06>] update_process_times+0x46/0x50
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<d8a1e678>] pbd_waitq+0x18/0x20 [xfs]
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c02b1350>] ide_dma_intr+0x0/0xc0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02cc3cd>] i8042_interrupt+0x1ed/0x3a0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c012dc06>] update_process_times+0x46/0x50
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02cc3cd>] i8042_interrupt+0x1ed/0x3a0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c012dc06>] update_process_times+0x46/0x50
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c012dc06>] update_process_times+0x46/0x50
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1723
> Call Trace:
>  [<c011fb7f>] __might_sleep+0x5f/0xa0
>  [<c014ce41>] kmalloc+0x1a1/0x1c0
>  [<c02cc3cd>] i8042_interrupt+0x1ed/0x3a0
>  [<c02bd125>] accel_cursor+0xd5/0x300
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bd545>] fb_vbl_handler+0x85/0xa0
>  [<c02bbb40>] cursor_timer_handler+0x0/0x40
>  [<c02bbb61>] cursor_timer_handler+0x21/0x40
>  [<c012dd84>] run_timer_softirq+0x154/0x400
>  [<c0112633>] timer_interrupt+0x1a3/0x3f0
>  [<c0128c61>] do_softirq+0xa1/0xb0
>  [<c010cc2f>] do_IRQ+0x23f/0x380
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c010ac3c>] common_interrupt+0x18/0x20
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107240>] default_idle+0x0/0x30
>  [<c0107267>] default_idle+0x27/0x30
>  [<c01072e1>] cpu_idle+0x31/0x40
>  [<c0105000>] _stext+0x0/0xf0
> 
> [...]
> 
> It keeps printing call traces so I have to reboot.
> 
> HTH,
> Luca
> 

