Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265841AbUFTJUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265841AbUFTJUe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 05:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUFTJUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 05:20:34 -0400
Received: from witte.sonytel.be ([80.88.33.193]:54208 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265841AbUFTJUc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 05:20:32 -0400
Date: Sun, 20 Jun 2004 11:20:29 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: page allocation failure. order:0, mode:0x20
Message-ID: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While running 2.6.7 on my Amiga, I got:

| cp: page allocation failure. order:0, mode:0x20
| Call Trace: [<000290a8>] __alloc_pages+0x230/0x250
|  [<00159e9b>] sine_data+0x1142/0x1d95
|  [<0001c9cc>] update_wall_time+0x16/0x3a
|  [<000290f2>] __get_free_pages+0x2a/0x3e
|  [<0002bc4a>] kmem_getpages+0x24/0xc2
|  [<0002c54c>] cache_grow+0x7c/0x196
|  [<0002c7ae>] cache_alloc_refill+0x148/0x17c
|  [<0000220d>] init+0xc3/0xc8
|  [<00001000>] _stext+0x0/0x1000
|  [<0002cc62>] __kmalloc+0x4e/0x6a
|  [<000f89be>] alloc_skb+0x3e/0x102
|  [<000d8d90>] ariadne_rx+0xb2/0x208
|  [<0000f204>] scosh+0x1a8/0x540
|  [<000d8936>] ariadne_interrupt+0x70/0x23a
|  [<00001000>] _stext+0x0/0x1000
|  [<0000a67c>] amiga_do_irq_list+0x42/0x54
|  [<0000abfa>] cia_handler+0x76/0x80
|  [<00001000>] _stext+0x0/0x1000
|  [<000063c6>] process_int+0x42/0x70
|  [<000051de>] inthandler+0x2a/0x2c
|  ...

But it looks like there are still opportunities to allocate memory:

| # free
|              total       used       free     shared    buffers     cached
| Mem:         10260       9844        416          0        240       5004
| -/+ buffers/cache:       4600       5660
| Swap:        33256       3796      29460

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
