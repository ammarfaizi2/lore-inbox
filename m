Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313622AbSDQJQM>; Wed, 17 Apr 2002 05:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313716AbSDQJQL>; Wed, 17 Apr 2002 05:16:11 -0400
Received: from mail.sonytel.be ([193.74.243.200]:53156 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S313622AbSDQJQL>;
	Wed, 17 Apr 2002 05:16:11 -0400
Date: Wed, 17 Apr 2002 11:13:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@redhat.com>, david.lang@digitalinsight.com,
        vojtech@suse.cz, dalecki@evision-ventures.com, rgooch@ras.ucalgary.ca,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <20020416174022.25545@smtp.wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0204171029040.1258-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2002, Benjamin Herrenschmidt wrote:

> >   I could be wrong, it's a 2.1.x kernel that they started with. I thought
> >   that was around the time the fix went in.
> >   
> >Again, I did the fix 6 years ago, thats pre-2.0.x days
> >
> >EXT2 has been little-endian only with proper byte-swapping support
> >across all architectures, since that time.
> 
> My understanding it that Tivo behaves like some Amiga's here
> and has broken swapping of the IDE bus itself, not the ext2
> filesystem.

You mean Ataris and Q40/Q60s?

I'm not aware if any Amiga IDE interface with byteswapped IDE interface. Or it
must be a very rare interface not supported by Linux anyway ;-)

> On PPC, we still have some historical horrible macros redefinitions
> in asm/ide.h to let APUS (PPC Amiga) deal with these.

In asm-ppc/ide.h? Didn't see them there.

The main problem is that IDE use[sd] `inb' et al. for accesses, which is not
valid for I/O on something other than ISA/PCI I/O space. So for m68k and APUS
we have to do weird things. The new IN_BYTE() etc. should help a bit there,
though.

> Now, the problem of dealing with DMA along with the swapping is
> something scary. I beleive the sanest solution that won't please
> affected people is to _not_ support DMA on these broken HW ;)

Agreed. And you have to disable DMA when accessing a disk that originates from
such a system on a sane box.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

