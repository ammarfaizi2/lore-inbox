Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbRAYRxU>; Thu, 25 Jan 2001 12:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132577AbRAYRxL>; Thu, 25 Jan 2001 12:53:11 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:27895 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S130507AbRAYRxF>; Thu, 25 Jan 2001 12:53:05 -0500
Date: Thu, 25 Jan 2001 11:53:01 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: Jeff Hartmann <jhartmann@valinux.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3A7066A1.5030608@valinux.com>
In-Reply-To: <3A6D5D28.C132D416@sangate.com> <20010123165117Z131182-221+34@kanga.kvack.org> 
	<20010123165117Z131182-221+34@kanga.kvack.org> ; from ttabi@interactivesi.com on Tue, Jan 23, 2001 at 10:53:51AM -0600 <20010125155345Z131181-221+38@kanga.kvack.org> 
	<20010125165001Z132264-460+11@vger.kernel.org> <E14LpvQ-0008Pw-00@mail.valinux.com>
Subject: Re: ioremap_nocache problem?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Message-Id: <20010125175308Z130507-460+45@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Thu, 25 Jan
2001 10:47:13 -0700


> As in an MMIO aperture?  If its MMIO on the bus you should be able to 
> just call ioremap with the bus address.  By nature of it being outside 
> of real ram, it should automatically be uncached (unless you've set an 
> MTRR over that region saying otherwise).

It's not outside of real RAM.  The device is inside real RAM (it sits on the
DIMM itself), but I need to poke through the entire 4GB range to see how it
responds.

> Look at the functions agp_generic_free_gatt_table and 
> agp_generic_create_gatt_table in agpgart_be.c (drivers/char/agp).  They 
> do the ioremap_nocache on real ram for the GATT/GART table.

Unfortunately, the memory they remap is allocated:

table = (char *) __get_free_pages(GFP_KERNEL, page_order);

...

CACHE_FLUSH();
agp_bridge.gatt_table = ioremap_nocache(virt_to_phys(table), (PAGE_SIZE * (1 <<
page_order)));
CACHE_FLUSH();

I've searched high and low for examples of code that does what I do, and I
can't find any.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
