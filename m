Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130504AbRCDUHe>; Sun, 4 Mar 2001 15:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130505AbRCDUHY>; Sun, 4 Mar 2001 15:07:24 -0500
Received: from hood.tvd.be ([195.162.196.21]:62363 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S130504AbRCDUHM>;
	Sun, 4 Mar 2001 15:07:12 -0500
Date: Sun, 4 Mar 2001 21:04:42 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Grant Grundler <grundler@cup.hp.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: IO issues vs. multiple busses 
In-Reply-To: <200103031805.KAA01024@milano.cup.hp.com>
Message-ID: <Pine.LNX.4.05.10103042101410.12571-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001, Grant Grundler wrote:
> Benjamin Herrenschmidt wrote:
> > Additionally, the same problem is true for ISA memory, when it exist
> > obviously.
> 
> Really? I expected ISA memory to look like reguler uncacheable memory
> and the drivers would simply dereference the address. But I'm not an
> expert on how ISA busses work...

Nope, it's like PCI memory, but different. You have to use isa_readb() and
friends to access it.

While ISA I/O space and PCI I/O space are the same on many machines with memory
mapped I/O (with a size limitation for ISA I/O), ISA memory space and PCI
memory space are different. Cfr. on my CHRP LongTrail:

| callisto$ cat /proc/iomem 
| 00000000-08000000 : RAM
| c0000000-f6ffffff : GG2 PCI mem
|   c0000000-c0000fff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
|   c1000000-c107ffff : Apple Computer Inc. Hydra Mac I/O
|   c1080000-c108007f : Digital Equipment Corporation DECchip 21041 [Tulip Pass 3]
|     c1080000-c108007f : eth0
|   c2000000-c2ffffff : ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT]
|     c2000000-c2ffffff : atyfb
|   c3000000-c30000ff : Symbios Logic Inc. (formerly NCR) 53c875
|   c3001000-c3001fff : Symbios Logic Inc. (formerly NCR) 53c875
|   c4000000-c7ffffff : S3 Inc. 86c764/765 [Trio32/64/64V+]
| f7000000-f7ffffff : GG2 ISA mem
|   f70e0000-f70e7fff : NVRAM
| f8000000-f8ffffff : GG2 PCI I/O
| fec00000-fec7ffff : GG2 PCI cfg
| ff000000-ff7fffff : ROM exp
| fff80000-ffffffff : Flash ROM
| callisto$ 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

