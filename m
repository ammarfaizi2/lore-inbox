Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUITVQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUITVQW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 17:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUITVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 17:16:22 -0400
Received: from mail.aei.ca ([206.123.6.14]:44253 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267361AbUITVQM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 17:16:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S1
From: Shane Shrybman <shrybman@aei.ca>
To: mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1095714967.3646.14.camel@mars>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 20 Sep 2004 17:16:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having what appears to be IDE DMA problems with 2.6.9-rc2-mm1-S1.
2.6.9-rc2-mm1 does not show this problem and runs fine. Before this I
was happily using 2.6.8-rc3-O5.

I tried booting with acpi=off but was unable to enter my user name at
the login prompt, it just hung with no response to sysreq. I also tried
turning off irq threading for that irq but it made no difference.

There is one drive on the secondary channel of this Promise TX133. This
is what appears in the log after a minute or two of using the drive.

hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
hdg: DMA interrupt recovery
hdg: lost interrupt
hdg: dma_timer_expiry: dma status == 0x24
PDC202XX: Secondary channel reset.
[..many repeats..]

It sometimes recovers but it immediately happens again. This leaves apps
touching that drive stuck in an un-killable D state and eventually I
have to reboot.

Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PDC20269: IDE controller at PCI slot 0000:00:0d.0
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 16
PDC20269: chipset revision 2
PDC20269: 100% native mode on irq 16
    ide2: BM-DMA at 0xa000-0xa007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa008-0xa00f, BIOS settings: hdg:pio, hdh:pio
hdg: MAXTOR 6L080J4, ATA DISK drive
requesting new irq thread for IRQ16...
ide3 at 0xa800-0xa807,0xa402 on irq 16
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 20
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x7400-0x7407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x7408-0x740f, BIOS settings: hdc:DMA, hdd:pio
hdc: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
requesting new irq thread for IRQ15...
ide1 at 0x170-0x177,0x376 on irq 15
hdg: max request size: 128KiB
IRQ#16 thread started up.
hdg: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=65535/16/63,
UDMA(133)
hdg: hdg1
IRQ#15 thread started up.
hdc: ATAPI 63X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 19 (level, low) -> IRQ 19

Regards,

Shane

