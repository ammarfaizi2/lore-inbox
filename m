Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbVHAHmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbVHAHmz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVHAHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:42:55 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:24994 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S262415AbVHAHmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:42:54 -0400
Date: Mon, 1 Aug 2005 10:42:26 +0300 (EEST)
From: Tero Roponen <teanropo@cc.jyu.fi>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Andrew Morton <akpm@osdl.org>, jonsmirl@gmail.com, gregkh@suse.de,
       linux-kernel@vger.kernel.org, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: 2.6.14-rc4: dma_timer_expiry [was 2.6.13-rc2 hangs at boot]
In-Reply-To: <20050801112245.B9460@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.4.58.0508011041500.17075@tukki.cc.jyu.fi>
References: <Pine.GSO.4.58.0507061638380.13297@tukki.cc.jyu.fi>
 <9e47339105070618273dfb6ff8@mail.gmail.com> <20050728233408.550939d4.akpm@osdl.org>
 <Pine.GSO.4.58.0507291105480.12940@tukki.cc.jyu.fi> <20050729012452.16ee2a31.akpm@osdl.org>
 <Pine.GSO.4.58.0507291132130.13321@tukki.cc.jyu.fi> <20050729023921.0950968f.akpm@osdl.org>
 <20050801112245.B9460@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Mon, 01 Aug 2005 10:42:29 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Ivan Kokshaysky wrote:

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
>

Thanks, this works for me!

I hope this will be in 2.6.13 final.

-
Tero Roponen
