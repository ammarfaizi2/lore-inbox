Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQJ3QGW>; Mon, 30 Oct 2000 11:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129040AbQJ3QGM>; Mon, 30 Oct 2000 11:06:12 -0500
Received: from [62.172.234.2] ([62.172.234.2]:1499 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129033AbQJ3QGG>;
	Mon, 30 Oct 2000 11:06:06 -0500
Date: Mon, 30 Oct 2000 16:06:10 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030104956.735A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.21.0010301602240.2383-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick,

Sorry, I thought you knew this already :) The maximum for kmalloc is 128K
and is defined in mm/slab.c. It is trivial to "enhance" slab.c to support
more but it is in practice not very useful because requesting too much
physically-contiguous (which kmalloc is all about) memory is impossible
except at very early stages after boot (due to obvious fragmentation).

So, if you don't need physically contiguous (and fast) allocations perhaps
you could make use of vmalloc()/vfree() instead? There must be also some
"exotic" allocation APIs like bootmem but I know nothing of them so I stop
here.

Regards,
Tigran


On Mon, 30 Oct 2000, Richard B. Johnson wrote:

> 
> Hello,
> How much memory would it be reasonable for kmalloc() to be able
> to allocate to a module?
> 
> Oct 30 10:48:31 chaos kernel: kmalloc: Size (524288) too large 
> 
> Using Version 2.2.17, I can't allocate more than 64k!  I need
> to allocate at least 1/2 megabyte and preferably more (like 2 megabytes).
> 
> There are 256 megabytes of SDRAM available. I don't think it's
> reasonable that a 1/2 megabyte allocation would fail, especially
> since it's the first module being installed.
> 
> The attempt to allocate is memory of type GFP_KERNEL.
> 
> 
> Any advice?
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.2.17 on an i686 machine (801.18 BogoMips).
> 
> "Memory is like gasoline. You use it up when you are running. Of
> course you get it all back when you reboot..."; Actual explanation
> obtained from the Micro$oft help desk.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
