Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287176AbRL2Ktt>; Sat, 29 Dec 2001 05:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287174AbRL2Ktj>; Sat, 29 Dec 2001 05:49:39 -0500
Received: from mail.sonytel.be ([193.74.243.200]:15755 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S287179AbRL2Kt0>;
	Sat, 29 Dec 2001 05:49:26 -0500
Date: Sat, 29 Dec 2001 11:49:19 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Sym53c8xx tape corruption squashed! (was: Re: SCSI Tape corruption
 - update)
In-Reply-To: <20011229004430.Y1507-100000@gerard>
Message-ID: <Pine.GSO.4.21.0112291132270.277-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, [ISO-8859-1] Gérard Roudier wrote:
> On Fri, 28 Dec 2001, Geert Uytterhoeven wrote:
> > The problem is introduced in 1.5pre-g2 by the following change:

  [...]

> > This change causes the PCI latency timer to be changed from 0 to 80.
> >
> > The sym-2 driver has a define for modifying the PCI latency timer
> > (SYM_SETUP_PCI_FIX_UP), but it is never used, so I see no corruption.
> 
> By default sym-2 use value 3 for the pci_fix_up (cache line size + memory
> write and invalidate). The latency timer fix-up has been removed, since it
> is rather up to the generic PCI driver to tune latency timers.
> 
> > Is this a hardware bug in my SCSI host adapter (53c875 rev 04) or my host
> > bridge (VLSI VAS96011/12 Golden Gate II for PPC), or a software bug in the
> > driver (wrong burst_max)?
> 
> Great bug hunting!
> 
> It is about certainly not a software bug in the driver. Any latency timer
> value should not give any trouble if hardware was flawless. Just the PCI
> performances could be affected.
> 
> Anyway, value 0 looks way stupid for devices capable of bursting more than
> 1 data phase, thus the improvement above. :)

OK.

> > To recapitulate, the bug causes error bursts of (almost always) 32 bytes long.
> > The incorrect bytes are always a copy of previous data, at a fixed offset (10
> > kiB on my (now dead) DDS-1 tape drive, 32 kiB on my Plexwriter).
> 
> Unfortunately, I haven't the errata listing for teh 53c875 rev 4. I have
> the DEL for 875 rev. 3 and for 876 rev. 5.

And I'm afraid I won't be able to get errata for the VLSI VAS96011/12 :-( Of
course I can always give it a try...

> If we assume that rev 4 hasn't more bugs than rev 3, then you may try to
> disable MEMORY WRITE and INVALIDATE (and not tell the driver to fix this
> up) but allow the driver to fix the bogus zero latency timer. The 875 rev
> 3 may, under certain conditions, execute unaligned PCI MEMORY WRITE and
> INVALIDATE transactions. Note that this may explain data corruptions
> occurring for SCSI READ commands not WRITE commands. No other items can
> explain, on paper, data corruptions of the form you describe due to 875
> chip misbehaviour.

I'll give that a try...

> Btw, latency timer zero should not change the likelyhood of this item.
> This let me think that the host bridge is likely to be the culprit.

Hmmm... I'm still wondering why I see the problem when writing to tape or
CD-R(W), while I can't provoke it when writing to disk (Quantum Viking II U2W).

What's so special about tape and CD-R?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

