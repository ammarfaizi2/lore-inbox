Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261825AbSI2WZT>; Sun, 29 Sep 2002 18:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSI2WZT>; Sun, 29 Sep 2002 18:25:19 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:31616 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261825AbSI2WZT>;
	Sun, 29 Sep 2002 18:25:19 -0400
Date: Sun, 29 Sep 2002 17:30:34 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Banai Zoltan <bazooka@vekoll.vein.hu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.39 problem in slab.c
In-Reply-To: <20020929215956.GA557@bazooka.saturnus.vein.hu>
Message-ID: <Pine.LNX.4.44.0209291729220.1130-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Banai Zoltan wrote:

> Hi!
> 
> I noticed a problem with 2.5.39 in slab.c:
> I got a bounch of messages:
> 
> Sleeping function called from illegal context at slab.c:1374
> c1571f20 c0114e74 c03751c0 c037993b 0000055e 000001d0 c012eed0 c037993b
> 	0000055e e0800000 00000246 00001000 00001000 c012df1d 0000001c 000001d0
> 	c1570000 00000246 00001000 000001d2 dfc37288 c012e1ce 00001000 00000002
> Call Trace:
>  [<c0114e74>]__might_sleep+0x54/0x60
>  [<c012eed0>]kmalloc+0x4c/0x130
>  [<c012df1d>]get_vm_area+0x29/0x104
>  [<c012e1ce>]__vmalloc+0x32/0x10c
>  [<c012e2bd>]vmalloc+0x15/0x1c
>  [<c02accac>]sg_init+0x80/0x100
>  [<c0284555>]scsi_register_device+0x71/0x114
>  [<c010508b>]init+0x33/0x188
>  [<c0105058>]init+0x0/0x188
>  [<c01054c9>]kernel_thread_helper+0x5/0xc

Known problem.  

sg_init() is performing vmalloc() inside
write_lock_irqsave(&sg_dev_arr_lock);

See:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103327490712028&w=2


