Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWGQRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWGQRXq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWGQRXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 13:23:46 -0400
Received: from homer.mvista.com ([63.81.120.155]:2734 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S1751069AbWGQRXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 13:23:45 -0400
Message-ID: <44BBC75A.2000800@ru.mvista.com>
Date: Mon, 17 Jul 2006 21:22:34 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of HPT372A driver?
References: <20060717142705.GS1485@earth.li>
In-Reply-To: <20060717142705.GS1485@earth.li>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hail.

Jonathan McDowell wrote:

> I recently acquired a HighPoint RocketRaid 1520 SATA controller (I know,
> I know, bad choice but I just need something to tide me over until I can
> upgrade to a motherboard with AHCI love). This presents as a HPT372A:

> 00:09.0 RAID bus controller: Triones Technologies, Inc. HPT372A/372N (rev 01)
> 00:09.0 0104: 1103:0005 (rev 01)

    Sigh, I had no chance to test the driver on this chip myself... And I also
haven't tried the driver on SATA drives at all... :-/

> The 2.6.17 hpt366.c driver is at version 0.36. I also found your patches
> to l-k earlier this year, but I'm not sure whether I got them all as I
> had some rejects; I ended up with a version 1.00 driver as at:

    Some patch was recast, maybe this was the reason...

> http://the.earth.li/~noodles/hpt366.c

    I'm surprised that this has even compiled! It has check_in_drive_lists() 
defined twice...

> Is there somewhere I can get your latest work without having to try to
> pick the right patches from the l-k archives?

    You may find the summary patch in the -mm tree I guess if you hit the V 
link against the -mm patch at the top of www.kernel.org page, like this one:

http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fpeople%2Fakpm%2Fpatches%2F2.6%2F2.6.18-rc1%2F2.6.18-rc1-mm2%2F2.6.18-rc1-mm2.bz2;z=647

> Also I'm getting fairly appalling speeds; I don't know if this is thie
> card or not, but I have a SATA II capable drive (I know the controller
>  is only SATA I) attached that's getting detected as:

> hde: 488397168 sectors (250059 MB) w/16384KiB Cache, CHS=30401/255/63, UDMA(33)

    Hm, looks like the drive is wrongly reported as blacklisted or the cable 
being somehow misdetected... Ah, this was SATA drive, you say?

> I'd expect UDMA(133) or similar instead? hdparm -Tt gives:

    I also would, at least UDMA(100)... :-)

> /dev/sda:
>  Timing cached reads:   984 MB in  2.00 seconds = 491.58 MB/sec
>  Timing buffered disk reads:   90 MB in  3.00 seconds =  30.00 MB/sec
> 
> /dev/hda:
>  Timing cached reads:   940 MB in  2.00 seconds = 469.89 MB/sec
>  Timing buffered disk reads:  172 MB in  3.04 seconds =  56.66 MB/sec
> 
> /dev/hde:
>  Timing cached reads:   1012 MB in  2.01 seconds = 504.48 MB/sec
>  Timing buffered disk reads:   44 MB in  3.05 seconds =  14.43 MB/sec

> (sda is an old 36GB SCSI disk on an Adaptec 2940, hda is a Maxtor on the
> internal VIA PATA controller. I'd expected hde to at least outperform
> sda.)

    Output of hdparm -iI /dev/hde would also be helpful.

> Relevent dmesg output is:

> HPT372A: IDE controller at PCI slot 0000:00:09.0
> ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
> PCI: setting IRQ 11 as level-triggered ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKB] - > GSI 11 (level, low) -> IRQ 11
> HPT372A: chipset revision 1
> HPT372A: DPLL base: 66 MHz, f_CNT: 99, assuming 33 MHz PCI
> HPT372A: using 66 MHz DPLL clock
> HPT372A: 100%% native mode on irq 11
>     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:DMA, hdf:pio
>     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
> Probing IDE interface ide2...
> hde: WDC WD2500KS-00MJB0, ATA DISK drive
> ide2 at 0xa000-0xa007,0xa402 on irq 11

    Well, this looks sane...

WBR, Sergei
