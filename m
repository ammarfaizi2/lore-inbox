Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTJ3Kr1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 05:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTJ3Kr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 05:47:27 -0500
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:65124 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S262331AbTJ3KrW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 05:47:22 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: "Michael Labuschke" <michael@labuschke.de>
Subject: Re: WG:  EIO DM-8401H ATA133 IDE Controller Card ( Silicon Image Chip ?!?)
Date: Thu, 30 Oct 2003 11:40:56 +0100
User-Agent: KMail/1.5
References: <S261606AbTJ3JsA/20031030094800Z+24028@vger.kernel.org>
In-Reply-To: <S261606AbTJ3JsA/20031030094800Z+24028@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200310301040.56498.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


If its anything like the card I have (i have the 8401-R) , it should work out 
of the box:

- From dmesg:

SiI680: IDE controller at PCI slot 02:09.0
SiI680: chipset revision 1
SiI680: not 100% native mode: will probe irqs later
SiI680: BASE CLOCK == 133
    ide2: MMIO-DMA at 0xe09f5800-0xe09f5807, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xe09f5808-0xe09f580f, BIOS settings: hdg:pio, hdh:pio
hde: host protected area => 1
hde: 80418240 sectors (41174 MB) w/1863KiB Cache, CHS=79780/16/63, UDMA(100)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, 
UDMA(133)

- From lspci -vv:

02:09.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 01)
        Subsystem: Unknown device 1771:1680
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64, cache line size 01
        Interrupt: pin A routed to IRQ 18
        Region 0: I/O ports at e8f8 [size=8]
        Region 1: I/O ports at e8f0 [size=4]
        Region 2: I/O ports at e8e0 [size=8]
        Region 3: I/O ports at e8d8 [size=4]
        Region 4: I/O ports at e8c0 [size=16]
        Region 5: Memory at fd6fb800 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fd700000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-


If I can help any more, give me a shout.

Mark.

> Hi
> I bought an IDE Controller the other day ( non RAID version)
> See  http://www.ivmm.com/eio/products_dm8401h.html
> As ist stated there should be linux support.
> No the problem is
> (output from  cat /proc/pci
>
>   Bus  0, device  17, function  0:
>     Unknown mass storage controller: PCI device 1283:8212 (Integrated
> Technology Express, Inc.) (rev 17).
>       IRQ 11.
>       Master Capable.  No bursts.  Min Gnt=8.Max Lat=8.
>       I/O at 0xd800 [0xd807].
>       I/O at 0xdc00 [0xdc03].
>       I/O at 0xe000 [0xe007].
>       I/O at 0xe400 [0xe403].
>       I/O at 0xe800 [0xe80f].
>
> The device is unknown
> So i have patched the kernel and changed the old silicon image device
> number to match my
> „unknown“ device.
>
> --- linux-2.4.22/include/linux/pci_ids.h        2003-10-30
> 01:09:21.000000000 +0100
> +++ linux-2.4.22-org/include/linux/pci_ids.h    2003-08-25
> 13:44:44.000000000 +0200
> @@ -811,7 +811,7 @@
>  #define PCI_DEVICE_ID_SUN_SABRE                0xa000
>  #define PCI_DEVICE_ID_SUN_HUMMINGBIRD  0xa001
>
> -#define PCI_VENDOR_ID_CMD              0x1283
> +#define PCI_VENDOR_ID_CMD              0x1095
>  #define PCI_DEVICE_ID_SII_1210SA       0x0240
>
>  #define PCI_DEVICE_ID_CMD_640          0x0640
> @@ -822,7 +822,7 @@
>  #define PCI_DEVICE_ID_CMD_649          0x0649
>  #define PCI_DEVICE_ID_CMD_670          0x0670
>
> -#define PCI_DEVICE_ID_SII_680          0x8212
> +#define PCI_DEVICE_ID_SII_680          0x0680
>  #define PCI_DEVICE_ID_SII_3112         0x3112
>
>  #define PCI_VENDOR_ID_VISION           0x1098
>
>
> Dmesg gives me now
> SiI680: IDE controller at PCI slot 00:11.0
> SiI680: chipset revision 17
> SiI680: not 100% native mode: will probe irqs later
> SiI680: BASE CLOCK == 100
>     ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:pio, hdh:pio
>
> and it finds both die drives connected to the controller
> ide2 at 0xd800-0xd807,0xdc02 on irq 11
> hde: attached ide-disk driver.
> hde: host protected area => 1
> hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
> UDMA(33)
> hdf: attached ide-disk driver.
> hdf: host protected area => 1
> hdf: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=194158/16/63,
> UDMA(33)
>
> hdparm –dt /dev/hde /dev/hdf
>
> /dev/hde:
>  using_dma    =  1 (on)
>  Timing buffered disk reads:   86 MB in  3.04 seconds =  28.29 MB/sec
>
> /dev/hdf:
>  using_dma    =  1 (on)
>  Timing buffered disk reads:   90 MB in  3.03 seconds =  29.70 MB/sec
>
> So it works.. kinda..
> As you see there is only UDMA 33 enabled ( both drive can do at least udma
> 100)
> The driver seems right but the hack is REALLY bad ( works for me)
> You guys know much more about that stuff than i do.. maybe i could help.
>
> Michael
> PS: please CC to me since i’m not subscribed ;)
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/oOq4Bn4EFUVUIO0RAvQHAJ0ZusQgpDWhGIhTjhKRd3YF6gYevgCfVgvn
IiMeeO0Ub6i9NJt771LPIm8=
=MRRf
-----END PGP SIGNATURE-----

