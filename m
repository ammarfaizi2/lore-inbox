Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311735AbSDAOvx>; Mon, 1 Apr 2002 09:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDAOve>; Mon, 1 Apr 2002 09:51:34 -0500
Received: from mail.sonytel.be ([193.74.243.200]:15002 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S311735AbSDAOvZ>;
	Mon, 1 Apr 2002 09:51:25 -0500
Date: Mon, 1 Apr 2002 16:51:13 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Graham Cobb <g+linux@cobb.uk.net>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>, mj@ucw.cz
Subject: Re: [PATCH] PCI fixup for old NCR 53C810 SCSI chips, kernel 2.4.18
In-Reply-To: <3CA7A37F.3060600@cobb.uk.net>
Message-ID: <Pine.GSO.4.21.0204011648420.18846-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Graham Cobb wrote:
> This patch fixes a problem which prevents any version of the 2.4 kernel 
> running on DECpc XL systems (from c. 1993).  On that system, the NCR 
> 53C810 SCSI subsystem integrated on the motherboard does not have a PCI 
> class code, which breaks PCI resource allocation in all 2.4 kernels. 
>  The symptom is "resource collisions" reported for the SCSI device:
> 
> PCI: Device 00:01.0 not available because of resource collisions
> 
> These systems typically only have SCSI disks so the 2.4 kernel cannot be 
> booted.
> 
> If you are running an earlier kernel and want to know if you will have 
> this problem when upgrading, use lspci -vvv and look for output similar 
> to this:
> 
> 00:01.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 
> 53c810 (rev 01)
>     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
> Stepping- SERR- FastB2B-
>     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
> <TAbort- <MAbort- >SERR- <PERR-
>     Latency: 4 set
>     Interrupt: pin A routed to IRQ 11
>     Region 0: I/O ports at d000
> 
> If the listing says "Non-VGA unclassified device" for the 53c810, it 
> will not work with the 2.4 kernel.
> 
> The workround is to add fixup code for this device in 
> arch/i386/kernel/pci-pc.c.  The patch is small and is included below.  I 
> would appreciate anyone who uses NCR 53c810-based SCSI devices testing 
> this patch to make sure it doesn't break any other configurations.
> Graham Cobb

This problem seems not to be limited to ia32: on my DEC UDB AXP-box (on which I
never tried 2.4.x so far), lspci shows:

| 00:06.0 Non-VGA unclassified device: Symbios Logic Inc. (formerly NCR) 53c810 (rev 01)
|	Flags: bus master, medium devsel, latency 255, IRQ 11
|	I/O ports at 8000
|	Memory at 0000000004200000 (32-bit, non-prefetchable)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

