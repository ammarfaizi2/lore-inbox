Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVA3JiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVA3JiL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 04:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVA3JiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 04:38:11 -0500
Received: from witte.sonytel.be ([80.88.33.193]:53457 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261662AbVA3JiH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 04:38:07 -0500
Date: Sun, 30 Jan 2005 10:37:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Pierre Ossman <drzeus-list@drzeus.cx>
cc: Christoph Hellwig <hch@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
       wbsd-devel@list.drzeus.cx
Subject: Re: [Wbsd-devel] [PATCH 540] MMC_WBSD depends on ISA
In-Reply-To: <41FBAC44.9020502@drzeus.cx>
Message-ID: <Pine.GSO.4.61.0501301034310.1953@waterleaf.sonytel.be>
References: <200501072250.j07MonUe012310@anakin.of.borg> <41E22B4F.4090402@drzeus.cx>
 <41FB91A3.7060404@drzeus.cx> <20050129135714.GA320@infradead.org>
 <20050129145417.A12311@flint.arm.linux.org.uk> <20050129150023.GA959@infradead.org>
 <41FBAC44.9020502@drzeus.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005, Pierre Ossman wrote:
> Christoph Hellwig wrote:
> > > > Russell, please undo this patch. isa_virt_to_bus() is not dependent on
> > > > CONFIG_ISA. It causes problems on x86_64 platforms which cannot enable
> > > > ISA support.
> > 
> > Actually it is, x86_64 just refuses to set CONFIG_ISA despite having
> > isa-like devices.
> > 
> > Either way a new driver shouldn't use isa_virt_to_bus at all but rather
> > use the proper DMA API and all those problems go away.
> >  
> The problem was that the DMA API didn't work for x86_64 when I wrote the
> driver. I see now that it has been fixed.
> isa_virt_to_bus still works even though CONFIG_ISA is not configured. So I
> still think that the ISA dependency should be removed.

... which makes it selectable again on all platforms that don't have ISA and
don't provide isa_virt_to_bus(), where it still breaks.

Please don't remove the dependency...

> I'll move to the new API when I have the time to properly test it.

.. but change it to e.g. `depends on ISA || X86_64', until you have moved it to
the new API.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
