Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267229AbSLEFkb>; Thu, 5 Dec 2002 00:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267231AbSLEFkb>; Thu, 5 Dec 2002 00:40:31 -0500
Received: from pop.gmx.net ([213.165.64.20]:53564 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S267229AbSLEFkZ>;
	Thu, 5 Dec 2002 00:40:25 -0500
Message-Id: <5.1.1.6.2.20021205055348.00cde8c8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 05 Dec 2002 06:44:50 +0100
To: Duncan Sands <baldrick@wanadoo.fr>, root@chaos.analogic.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Reserving physical memory at boot time
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212040715.13409.baldrick@wanadoo.fr>
References: <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
 <1038952684.11426.106.camel@irongate.swansea.linux.org.uk>
 <5.1.1.6.2.20021204165742.00c6a180@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:15 AM 12/4/2002 +0100, Duncan Sands wrote:
>On Wednesday 04 December 2002 17:44, Mike Galbraith wrote:
> > At 08:25 AM 12/4/2002 -0500, Richard B. Johnson wrote:
> > >On 3 Dec 2002, Alan Cox wrote:
> > > > On Tue, 2002-12-03 at 21:11, Richard B. Johnson wrote:
> > > > > If you need a certain page reserved at boot-time you are out-of-luck.
> > > >
> > > > Wrong - you can specify the precise memory map of a box as well as use
> > > > mem= to set the top of used memory. Its a painful way of marking a page
> > > > and it only works for a page the kernel isnt loaded into.
> > >
> > >If you are refering to the "reserve=" kernel parameter, I don't
> > >think it works for memory addresses that are inside existing RAM.
> > >I guess if you used the "mem=" parameter to keep the kernel from
> > >using that RAM, the combination might work, but I have never
> > >tried it.
> >
> > reserve= is for IO ports (kernel/resource.c). I think Alan was referring to
> > mem=exactmap.
> >
> > If Duncan didn't have the pesky requirement that his module work in an
> > unmodified kernel, it would be easy to use __alloc_bootmem() to reserve an
> > address range and expose via /proc.  But alas...
>
>I actually said I was happy to modify the kernel!  As for __alloc_bootmem(),
>based on my quick reading of the implementation in 2.5.50, I don't see how
>you can be sure it will give you a particular physical page.  I would like to
>either get the page I want, or fail.

Sorry, mixed you up with someone else.  Seems to me you could just create a 
new __setup("reservepage=", gimme_page) where gimme_page() allocates with 
goal set, and frees/aborts if what it gets back isn't exactly what you 
asked for.

         -Mike

