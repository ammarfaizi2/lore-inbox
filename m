Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269107AbUIHLM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269107AbUIHLM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269105AbUIHLM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:12:57 -0400
Received: from witte.sonytel.be ([80.88.33.193]:62405 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269107AbUIHLLs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:11:48 -0400
Date: Wed, 8 Sep 2004 13:11:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Jesse Barnes <jbarnes@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, willy@debian.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: multi-domain PCI and sysfs
In-Reply-To: <9e47339104090723554eb021e4@mail.gmail.com>
Message-ID: <Pine.GSO.4.58.0409081302040.20726@waterleaf.sonytel.be>
References: <9e4733910409041300139dabe0@mail.gmail.com>
 <200409072115.09856.jbarnes@engr.sgi.com> <20040907211637.20de06f4.davem@davemloft.net>
 <200409072125.41153.jbarnes@engr.sgi.com> <9e47339104090723554eb021e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2004, Jon Smirl wrote:
> Another part I don't understand... PCI VGA hardware is designed to
> respond to IN/OUT instructions to port space. ppc64/ia64 don't have
> IN/OUT port instructions. Is there some special hardware on ppc64/ia64
> that declares part of the PCI IO space "legacy space" and turns
                            ^^^^^^^^^^^^  ^^^^^^^^^^^^
What you call `legacy space' above is called `PCI I/O space'.
What you call `PCI IO space' above is CPU address (memory) space.

> read/writes there into IN/OUT port cycles on the PCI bus so that the
> legacy hardware can see the accesses?

Like Dave already said:
| Those are IO ports in port space.  IO ports and PCI memory space just
| live in different physical memory windows, no special instructions
| for IO port space access as on x86.

PCI has I/O space and memory space (and config space).

On ia32, you access PCI I/O space (`I/O ports') using IN/OUT instructions.
On non-ia32, you access PCI I/O space by accessing a special region of the CPU
address space.

You access PCI memory space by accessing a special region of the CPU
address space on all platforms I'm aware of. On ia32, it starts at CPU address
zero, and there's no offset between CPU physical addresses and PCI bus
addresses. On other platforms, there may be offsets.

The first (first in PCI bus space!) 16 MiB of PCI memory space is special in
that it's ISA memory space. On ia32, it's always at CPU address zero. On other
platforms, it may be at offset zero of PCI memory space, or it may be in a
completely different region of CPU address space. Or it may not be accessible
at all (cfr. some PowerMacs).

For access to PCI config space, there are even more possibilities. On ia32 it's
usually done using indirect access to PCI I/O space 0xcf8 etc. On other
platforms it's usually done by accessing a special region of the CPU address
space. Or in a different way ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
