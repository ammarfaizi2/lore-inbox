Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUFTKZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUFTKZO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 06:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbUFTKZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 06:25:14 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:5290 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264908AbUFTKZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 06:25:08 -0400
Message-ID: <40D565FE.1050903@yahoo.com.au>
Date: Sun, 20 Jun 2004 20:25:02 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: page allocation failure. order:0, mode:0x20
References: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0406201115470.23356@waterleaf.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> While running 2.6.7 on my Amiga, I got:
> 
> | cp: page allocation failure. order:0, mode:0x20
> | Call Trace: [<000290a8>] __alloc_pages+0x230/0x250
> |  [<00159e9b>] sine_data+0x1142/0x1d95
> |  [<0001c9cc>] update_wall_time+0x16/0x3a
> |  [<000290f2>] __get_free_pages+0x2a/0x3e
> |  [<0002bc4a>] kmem_getpages+0x24/0xc2
> |  [<0002c54c>] cache_grow+0x7c/0x196
> |  [<0002c7ae>] cache_alloc_refill+0x148/0x17c
> |  [<0000220d>] init+0xc3/0xc8
> |  [<00001000>] _stext+0x0/0x1000
> |  [<0002cc62>] __kmalloc+0x4e/0x6a
> |  [<000f89be>] alloc_skb+0x3e/0x102
> |  [<000d8d90>] ariadne_rx+0xb2/0x208
> |  [<0000f204>] scosh+0x1a8/0x540
> |  [<000d8936>] ariadne_interrupt+0x70/0x23a
> |  [<00001000>] _stext+0x0/0x1000
> |  [<0000a67c>] amiga_do_irq_list+0x42/0x54
> |  [<0000abfa>] cia_handler+0x76/0x80
> |  [<00001000>] _stext+0x0/0x1000
> |  [<000063c6>] process_int+0x42/0x70
> |  [<000051de>] inthandler+0x2a/0x2c
> |  ...
> 
> But it looks like there are still opportunities to allocate memory:
> 
> | # free
> |              total       used       free     shared    buffers     cached
> | Mem:         10260       9844        416          0        240       5004
> | -/+ buffers/cache:       4600       5660
> | Swap:        33256       3796      29460
> 

Not even atomic allocations memory are allowed to consume all memory.
A small amount is reserved for memory freeing (which sometimes
requires initial memory allocations).

The message should be harmless.
