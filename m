Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130167AbRAaJtN>; Wed, 31 Jan 2001 04:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbRAaJtE>; Wed, 31 Jan 2001 04:49:04 -0500
Received: from mail08.voicenet.com ([207.103.0.34]:44780 "HELO mail08")
	by vger.kernel.org with SMTP id <S131245AbRAaJst>;
	Wed, 31 Jan 2001 04:48:49 -0500
Message-ID: <3A77DF79.2C1F5A7@voicenet.com>
Date: Wed, 31 Jan 2001 04:48:41 -0500
From: safemode <safemode@voicenet.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Raufeisen <david@fortyoz.org>
CC: Vojtech Pavlik <vojtech@suse.cz>,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: VT82C686A corruption with 2.4.x
In-Reply-To: <Pine.LNX.4.21.0101301716490.3105-100000@ns-01.hislinuxbox.com> <Pine.LNX.4.21.0101301755330.3205-200000@ns-01.hislinuxbox.com> <20010131083642.A964@suse.cz> <20010130235525.A7513@fortyoz.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Raufeisen wrote:

> On Wednesday, 31 January 2001, at 08:36:42 (+0100),
> Vojtech Pavlik wrote:
>
> > Hi!
> >
> > 1) You don't seem to have any drives on the VIA controller. If this is
> > true, I don't think this can be a VIA IDE driver problem.
> >
>
> Hi, Are you referring to Mark or me?
>
> I have drives on my VIA (only..) IDE controller:
>
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 16
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c686a IDE UDMA66 controller on pci0:7.1
> VP_IDE: ATA-66/100 forced bit set (WARNING)!!
>     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:DMA
> VP_IDE: ATA-66/100 forced bit set (WARNING)!!
>     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
> hda: Maxtor 51536H2, ATA DISK drive
> hdb: Maxtor 94098U8, ATA DISK drive
> hdc: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 30015216 sectors (15368 MB) w/2048KiB Cache, CHS=1868/255/63, UDMA(66)
> hdb: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=4982/255/63, UDMA(66)
> hdc: ATAPI 52X CD-ROM drive, 192kB Cache, UDMA(33)
> Uniform CD-ROM driver Revision: 3.12
> Partition check:
>  hda: hda1 hda2
>  hdb: hdb1
>
> > 2) In your original message you suggest bs=1024M, which isn't a very
> > good idea, even on a 768 MB system. Here with bs=1024k it seems to run
> > fine.
> >
> > 3) You sent next to none VIA related debugging info. lspci -v itself
> > isn't much valuable because I don't get the register contents. Also
> > hdparm -i of the drives attached to the VIA chip would be useful. Plus
> > also the contents of /proc/ide/via.
>
> I didn't supply anything either, even though my configuration works great it
> might prove useful to someone comparing:
>
> bash-2.04# hdparm -i /dev/hda
>
> /dev/hda:
>
>  Model=Maxtor 51536H2, FwRev=JAC61HU0, SerialNo=F203VTHC
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=30015216
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4 udma5
> bash-2.04# hdparm -i /dev/hdb
>
> /dev/hdb:
>
>  Model=Maxtor 94098U8, FwRev=FA500S60, SerialNo=G8066RQC
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes, LBAsects=80041248
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes: pio0 pio1 pio2 pio3 pio4
>  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 *udma4
> bash-2.04#
>
> bash-2.04# cat /proc/ide/via
> ----------VIA BusMastering IDE Configuration----------------
> Driver Version:                     2.1e
> South Bridge:                       VIA vt82c686a rev 0x22
> Command register:                   0x7
> Latency timer:                      32
> PCI clock:                          33MHz
> Master Read  Cycle IRDY:            0ws
> Master Write Cycle IRDY:            0ws
> FIFO Output Data 1/2 Clock Advance: off
> BM IDE Status Register Read Retry:  on
> Max DRDY Pulse Width:               No limit
> -----------------------Primary IDE-------Secondary IDE------
> Read DMA FIFO flush:           on                  on
> End Sect. FIFO flush:          on                  on
> Prefetch Buffer:               on                  on
> Post Write Buffer:             on                  on
> FIFO size:                      8                   8
> Threshold Prim.:              1/2                 1/2
> Bytes Per Sector:             512                 512
> Both channels togth:          yes                 yes
> -------------------drive0----drive1----drive2----drive3-----
> BMDMA enabled:        yes       yes       yes        no
> Transfer Mode:       UDMA      UDMA      UDMA   DMA/PIO
> Address Setup:       30ns      30ns      30ns     120ns
> Active Pulse:        90ns      90ns      90ns     330ns
> Recovery Time:       30ns      30ns      30ns     270ns
> Cycle Time:          30ns      30ns      60ns     600ns
> Transfer Rate:   66.0MB/s  66.0MB/s  33.0MB/s   3.3MB/s
>
> bash-2.04# lspci -v (trimmed)
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
>         Flags: bus master, medium devsel, latency 8
>         Memory at e0000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: [a0] AGP version 2.0
>         Capabilities: [c0] Power Management version 2
>
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
>         Flags: bus master, 66Mhz, medium devsel, latency 0
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 00009000-00009fff
>         Memory behind bridge: dde00000-dfefffff
>         Prefetchable memory behind bridge: cdc00000-ddcfffff
>         Capabilities: [80] Power Management version 2
>
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
>         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
>         Flags: bus master, stepping, medium devsel, latency 0
>
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10) (prog-if 8a [Master SecP PriP])
>         Flags: bus master, medium devsel, latency 32
>         I/O ports at ffa0 [size=16]
>         Capabilities: [c0] Power Management version 2
>
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 64, IRQ 9
>         I/O ports at cc00 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 10) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 64, IRQ 9
>         I/O ports at d000 [size=32]
>         Capabilities: [80] Power Management version 2
>
> 00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
>         Flags: medium devsel
>         Capabilities: [68] Power Management version 2
>
> > 4) Did you check the problem you're experiencing isn't a memory problem?
> > That'd go away with removing some RAM.
>
> I assume this was to Mark, I have no problem:)
>
> > Vojtech Pavlik
> > SuSE Labs
>
> --
> David Raufeisen <david@fortyoz.org>
> Cell: (604) 818-3596

>From what I gather this chipset on 2.4.x is only stable if you cripple just about everything that makes
it worth having (udma, 2nd ide channel  etc etc)  ?    does it even work when all that's done now or is
it fully functional?
I used some pre 2.4.1 kernel before it thrashed my disk and i had UDMA disabled in bios and kernel and
the corruption persisted.  I heard somewhere that it may have been linked to swap ?     Anyway, I'm
using 2.2.19-pre7 right now with DMA and it's doing perfect ...with better responsiveness than 2.4.x .
Could this be because of via problems on the 2.4.x kernel or is it 2.4.x arch ?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
