Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbTANWbT>; Tue, 14 Jan 2003 17:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTANWbS>; Tue, 14 Jan 2003 17:31:18 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:65194
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S265369AbTANWbP>; Tue, 14 Jan 2003 17:31:15 -0500
Message-ID: <3E2491C7.80408@tupshin.com>
Date: Tue, 14 Jan 2003 14:40:07 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en
MIME-Version: 1.0
To: Simon Posnjak <simon@activetools.si>
CC: linux-kernel@vger.kernel.org
Subject: Re: Disk very slow with VIA KT400 in 2.4.18 (stock RedHat 8.0)
References: <1042583307.1422.20.camel@klada.dyndns.org>
In-Reply-To: <1042583307.1422.20.camel@klada.dyndns.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other people know substantially more about this than I do, but there 
were a number of fixes for KT400 problems, especially IDE in recent 
kernels. I would give 4.2.21-pre3 or 4.2.21-pre3-ac4 a try. I've used 
both of those with relatively few problems on a KT400 machine.

-Tupshin

Simon Posnjak wrote:

>Hi all,
>
>I have a Kudoz 7x board (VIA KT400 (VT8377 and VT8235)) and a WD 80 GB
>disk (7200, UDMA (http://www.wdc.com/products/Products.asp?DriveID=32)).
>
>The problem is that disk operations are rally slow. Copying files goes
>on with 1 MB/sec. 
>
>At start up kernel complained:
> 
>VP_IDE: IDE controller on PCI bus 00 dev 89
>PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
>VP_IDE: chipset revision 6
>
>So I added pci=biosirq to kernel parameters at boot. An then I got:
>
>Uniform Multi-Platform E-IDE driver Revision: 6.31
>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>VP_IDE: IDE controller on PCI bus 00 dev 89
>PCI: No IRQ known for interrupt pin A of device 00:11.1.
>VP_IDE: chipset revision 6
>VP_IDE: not 100% native mode: will probe irqs later
>VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci00:11.1
>    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:pio
>    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
>hda: WDC WD800JB-00CRA1, ATA DISK drive
>hdc: SAMSUNG CD-R/RW SW-216B BS05 20010727, ATAPI CD/DVD-ROM drive
>hdd: SAMSUNG CD-ROM SC-152L, ATAPI CD/DVD-ROM drive
>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
>ide1 at 0x170-0x177,0x376 on irq 15
>hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=9729/255/63, UDMA(100)
>
>hdparm says:
>
>/dev/hda:
> multcount    = 16 (on)
> IO_support   =  1 (32-bit)
> unmaskirq    =  1 (on)
> using_dma    =  1 (on)
> keepsettings =  0 (off)
> readonly     =  0 (off)
> readahead    =  8 (on)
> geometry     = 9729/255/63, sectors = 156301488, start = 0
>
>hdparm -iI /dev/hda
>
>/dev/hda:
>
> Model=WDC WD800JB-00CRA1, FwRev=17.07W17, SerialNo=WD-WCA8E5325146
> Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
> RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=40
> BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
> CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
> IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
> PIO modes:  pio0 pio1 pio2 pio3 pio4
> DMA modes:  mdma0 mdma1 mdma2
> UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
> AdvancedPM=no WriteCache=enabled
> Drive conforms to: device does not report version:  1 2 3 4 5
>
>
>ATA device, with non-removable media
>        Model Number:       WDC WD800JB-00CRA1
>        Serial Number:      WD-WCA8E5325146
>        Firmware Revision:  17.07W17
>Standards:
>        Supported: 5 4 3 2
>        Likely used: 6
>Configuration:
>        Logical         max     current
>        cylinders       16383   16383
>        heads           16      16
>        sectors/track   63      63
>        --
>        CHS current addressable sectors:   16514064
>        LBA    user addressable sectors:  156301488
>        device size with M = 1024*1024:       76319 MBytes
>        device size with M = 1000*1000:       80026 MBytes (80 GB)
>Capabilities:
>        LBA, IORDY(can be disabled)
>        bytes avail on r/w long: 40     Queue depth: 1
>        Standby timer values: spec'd by Standard, with device specific minimum
>        R/W multiple sector transfer: Max = 16  Current = 16
>        Recommended acoustic management value: 128, current value: 254
>        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
>             Cycle time: min=120ns recommended=120ns
>        PIO: pio0 pio1 pio2 pio3 pio4
>             Cycle time: no flow control=120ns  IORDY flow control=120ns
>Commands/features:
>        Enabled Supported:
>           *    READ BUFFER cmd
>           *    WRITE BUFFER cmd
>           *    Host Protected Area feature set
>           *    Look-ahead
>           *    Write cache
>           *    Power Management feature set
>                Security Mode feature set
>           *    SMART feature set
>           *    Device Configuration Overlay feature set
>                Automatic Acoustic Management feature set
>                SET MAX security extension
>           *    DOWNLOAD MICROCODE cmd
>           *    SMART self-test
>           *    SMART error logging
>Security:
>                supported
>        not     enabled
>        not     locked
>        not     frozen
>        not     expired: security count
>        not     supported: enhanced erase
>HW reset results:
>        CBLID- above Vih
>        Device num = 0 determined by CSEL
>Checksum: correct
>
>lspci
>00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 3189
>00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device b168
>00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
>00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 02)
>00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 02)
>00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
>00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
>00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
>00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
>00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
>00:11.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE (rev 06)
>00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 Audio Controller (rev 50)
>01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX] (rev b2)
>
>lspci -n
>00:00.0 Class 0600: 1106:3189
>00:01.0 Class 0604: 1106:b168
>00:09.0 Class 0200: 10ec:8139 (rev 10)
>00:0a.0 Class 0200: 10ec:8139 (rev 10)
>00:0b.0 Class 0400: 109e:036e (rev 02)
>00:0b.1 Class 0480: 109e:0878 (rev 02)
>00:10.0 Class 0c03: 1106:3038 (rev 80)
>00:10.1 Class 0c03: 1106:3038 (rev 80)
>00:10.2 Class 0c03: 1106:3038 (rev 80)
>00:10.3 Class 0c03: 1106:3104 (rev 82)
>00:11.0 Class 0601: 1106:3177
>00:11.1 Class 0101: 1106:0571 (rev 06)
>00:11.5 Class 0401: 1106:3059 (rev 50)
>01:00.0 Class 0300: 10de:0110 (rev b2)
>
>Im using RedHat 8.0 stock kernel (the updated version) 2.4.18-19.8.0.
>
>	Regards Simon
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>


