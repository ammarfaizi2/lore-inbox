Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVHBPfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVHBPfE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVHBPfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:35:03 -0400
Received: from aun.it.uu.se ([130.238.12.36]:50859 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261566AbVHBPfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:35:02 -0400
Date: Tue, 2 Aug 2005 17:34:25 +0200 (MEST)
Message-Id: <200508021534.j72FYPmX014377@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, ink@jurassic.park.msu.ru
Subject: Re: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
Cc: gregkh@suse.de, jonsmirl@gmail.com, linux-kernel@vger.kernel.org,
       teanropo@cc.jyu.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005 11:22:45 +0400, Ivan Kokshaysky wrote:
> On Fri, Jul 29, 2005 at 02:39:21AM -0700, Andrew Morton wrote:
> > Tero Roponen <teanropo@cc.jyu.fi> wrote:
> > > My original report is here: http://lkml.org/lkml/2005/7/6/174
> > 
> > I see.  Ivan, do we know what's going on here?
> 
> Sort of. The 4K cardbus windows are working fine for non-x86
> architectures where all IO resources are usually well known
> and added to the resource tree properly.
> However, on x86 there are sometimes "hidden" system IO port
> ranges that aren't reported by BIOS, so the large (4K) cardbus
> windows overlap these ranges.
> 
> Actually I don't like reducing CARDBUS_IO_SIZE to 256 bytes, because
> we lose an ability to handle cards with built-in p2p bridges (which
> require 4K for IO), plus it won't fix Sony VAIO problem.
> 
> Tero and Mikael, can you try this one-liner instead?
> 
> Ivan.
> 
> --- 2.6.13-rc4/include/asm-i386/pci.h	Sun Jul 31 14:32:09 2005
> +++ linux/include/asm-i386/pci.h	Mon Aug  1 08:29:18 2005
> @@ -18,7 +18,7 @@ extern unsigned int pcibios_assign_all_b
>  #define pcibios_scan_all_fns(a, b)	0
>  
>  extern unsigned long pci_mem_start;
> -#define PCIBIOS_MIN_IO		0x1000
> +#define PCIBIOS_MIN_IO		0x2000
>  #define PCIBIOS_MIN_MEM		(pci_mem_start)
>  
>  #define PCIBIOS_MIN_CARDBUS_IO	0x4000

No joy. 2.6.13-rc5 vanilla + this patch still hangs my laptop
during boot. So far only the CARDBUS_IO_SIZE reduction patch
avoids the hang during boot regression 2.6.13-rc2 introduced.

I can send lspci & /proc/ioports if you think that might help.

/Mikael
