Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273981AbRI0WQb>; Thu, 27 Sep 2001 18:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273977AbRI0WQL>; Thu, 27 Sep 2001 18:16:11 -0400
Received: from anime.net ([63.172.78.150]:53254 "EHLO anime.net")
	by vger.kernel.org with ESMTP id <S273975AbRI0WQA>;
	Thu, 27 Sep 2001 18:16:00 -0400
Date: Thu, 27 Sep 2001 15:16:18 -0700 (PDT)
From: Dan Hollis <goemon@anime.net>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: AMD viper chipset and UDMA100
In-Reply-To: <20010927235946.B18423@suse.cz>
Message-ID: <Pine.LNX.4.30.0109271506030.19289-100000@anime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2001, Vojtech Pavlik wrote:
> On Thu, Sep 27, 2001 at 02:26:50PM -0700, Sean Swallow wrote:
> > I just got a tyan tiger w/ the AMD Viper chipset on it. For some reason
> > Linux will only set the onboard (AMD viper) chains to UDMA33.
> > I'm using linux 2.4.9, and I have also tried 2.4.10. Is there a limitation
> > to the AMD Viper driver?
> > PS. The cables (2) are BRAND new ata100 cables.
> The Viper can do UDMA66 max. At least it's doing it for me quite well.

If he's got the Tyan Tiger i'm thinking of, it's the Tyan S2460 with
AMD766 southbridge. Tyan says it will do U100:
http://www.tyan.com/products/html/tigermp.html

AMD does too:
http://www.amd.com/us-en/Processors/TechnicalResources/0,,30_182_873,00.html

And I've got the same problem with my S2460:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7411: IDE controller on PCI bus 00 dev 39
AMD7411: chipset revision 1
AMD7411: not 100% native mode: will probe irqs later
AMD7411: disabling single-word DMA support (revision < C4)
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: 20010816 sectors (10246 MB) w/2048KiB Cache, CHS=1245/255/63, UDMA(33)
hdc: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63, UDMA(33)

But these drives will do U66/U100:

# /sbin/hdparm -i /dev/hda

/dev/hda:

 Model=Maxtor 51024U2, FwRev=DA620CQ0, SerialNo=K203Z2WC
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=20010816
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2 mode3 mode4

# /sbin/hdparm -i /dev/hdc

/dev/hdc:

 Model=Maxtor 98196H8, FwRev=ZAH814Y0, SerialNo=V803V81C
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
 DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=0
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=160086528
 tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
 UDMA modes: mode0 mode1 *mode2 mode3 mode4 mode5

And yes, I *DO* have the proper cables. These same drives connected to a
Promise 20267 or a VIA KT133 with the same cables will do U66/U100
perfectly.

-Dan
-- 
[-] Omae no subete no kichi wa ore no mono da. [-]

