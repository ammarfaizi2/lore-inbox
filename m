Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291348AbSBME3Y>; Tue, 12 Feb 2002 23:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291346AbSBME3O>; Tue, 12 Feb 2002 23:29:14 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:64012 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S291348AbSBME25>;
	Tue, 12 Feb 2002 23:28:57 -0500
Message-Id: <200202130544.g1D5i4L22169@clueserver.org>
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: Albert Cranford <ac9410@bellsouth.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.4 sound module problem
Date: Tue, 12 Feb 2002 19:10:08 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3C69E2C7.3E749061@bellsouth.net>
In-Reply-To: <3C69E2C7.3E749061@bellsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 February 2002 19:51, Albert Cranford wrote:
> Not sure if this was the same message I received. but here
> is the patch I used to get around my sound problem in
> 2.5.4.

Are you sure this is correct?  include/asm/io.h seems to indicate that i/o 
addresses for PCI may not map correctly.  The sound card I am using is PCI, 
not ISA.

Documentation/DMA-mapping.txt says that virt_to_bus is completly depreciated 
and nothing should be using it.  Well, grepping the kernel source shows that 
quite a bit still uses it.

What it looks like, on first glance, is that virt_to_bus  was changed for pci 
devices to give this error message.  (Since that symbol goes nowhere.)  That 
effects a number of things, not just sound. (A whole bunch of cardbus drivers 
I would guess...)

When was this change made? It appears as if they missed a few bits.

Comment: 2.5.4 has been more than a bit rough.  Rarely do i see more than one 
patch needed just to get it to compile. Not trying to be bitchy about it. 
Just a wee bit frustrated...

> Linus, please apply to 2.5.5 pre1
> Later,
> Albert
> --- linux/drivers/sound/dmabuf.c.orig   Tue Feb 12 10:12:59 2002
> +++ linux/drivers/sound/dmabuf.c        Tue Feb 12 10:15:06 2002
> @@ -113,7 +113,7 @@
>                 }
>         }
>         dmap->raw_buf = start_addr;
> -       dmap->raw_buf_phys = virt_to_bus(start_addr);
> +       dmap->raw_buf_phys = isa_virt_to_bus(start_addr);
>
>         for (page = virt_to_page(start_addr); page <=
> virt_to_page(end_addr); page++) mem_map_reserve(page);
