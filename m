Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTA0WNB>; Mon, 27 Jan 2003 17:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267321AbTA0WNA>; Mon, 27 Jan 2003 17:13:00 -0500
Received: from very.disjunkt.com ([195.167.192.238]:40363 "EHLO disjunkt.com")
	by vger.kernel.org with ESMTP id <S263899AbTA0WMv> convert rfc822-to-8bit;
	Mon, 27 Jan 2003 17:12:51 -0500
Date: Mon, 27 Jan 2003 23:21:37 +0100 (CET)
From: Jean-Daniel Pauget <jd@disjunkt.com>
X-X-Sender: jd@mint
To: lkml <linux-kernel@vger.kernel.org>
cc: Tom Winkler <tom@qwws.net>
Subject: Re: poor IDE performance on ASUS P4PE with WD800JB
In-Reply-To: <Pine.LNX.3.96.1030127162113.27928A-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.51.0301272308431.466@mint>
References: <Pine.LNX.3.96.1030127162113.27928A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    I'm using some maxtor on the same motherboard and I had to struggle a
    bit before getting some decent perf, basically I kept only the minimum
    IDE,ATA.. drivers in my kernel, for my P4PE it's the Intel PIIXn and
    also the PIIXn tuning option.
    I also added idebus=66 in my command-line kernel option...
    I disabled the Promise Raid controller in the bios that was responsible
    for some 2.4.20 kernels to hang at detection (?)

    now I get this :

# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.30 seconds =426.67 MB/sec
 Timing buffered disk reads:  64 MB in  1.38 seconds = 46.38 MB/sec

# hdparm -I /dev/hda

/dev/hda:

non-removable ATA device, with non-removable media
        Model Number:           Maxtor 6Y120P0
        Serial Number:          Y40FKPWE
        Firmware Revision:      YAR41VW0
Standards:
        Supported: 1 2 3 4 5 6 7
        Likely used: 7
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        bytes/track:    0               (obsolete)
        bytes/sector:   0               (obsolete)
        current sector capacity: 16514064
        LBA user addressable sectors = 240121728
Capabilities:
        LBA, IORDY(can be disabled)
        Buffer size: 7936.0kB   ECC bytes: 57   Queue depth: 1
        Standby timer values: spec'd by standard, no device specific
minimum
        r/w multiple sector transfer: Max = 16  Current = 16
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    NOP cmd
           *    READ BUFFER cmd
           *    WRITE BUFFER cmd
           *    Host Protected Area feature set
           *    look-ahead
           *    write cache
           *    Power Management feature set
                Security Mode feature set
                SMART feature set
                SET MAX security extension
                Advanced Power Management feature set
           *    DOWNLOAD MICROCODE cmd
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
        not     supported: enhanced erase
HW reset results:
        CBLID- above Vih
        Device num = 0 determined by the jumper
Checksum: correct


this disk seems equivalent to your western digital.


my lspci :

00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 02)
00:01.0 PCI bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset AGP Bridge (rev 02)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 82)
00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 02)
00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 02)
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4200] (rev a3)
02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
02:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)

a lot of device don't appear here because I disabled them whilst looking
for what is causing my maching to hang once every three days...

--
Quand les plombs pêtent : « Ðïsjüñ£t.¢¤× »
