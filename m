Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWHAXES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWHAXES (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHAXES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:04:18 -0400
Received: from smtp.ono.com ([62.42.230.12]:20365 "EHLO resmta04.ono.com")
	by vger.kernel.org with ESMTP id S1750730AbWHAXER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:04:17 -0400
Date: Wed, 2 Aug 2006 01:04:15 +0200
From: "J.A. =?UTF-8?B?TWFnYWxsw7Nu?=" <jamagallon@ono.com>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org
Subject: [2.6.18-rc2-mm1] pata_via fails
Message-ID: <20060802010415.2bebc5fc@werewolf.auna.net>
X-Mailer: Sylpheed-Claws 2.4.0cvs11 (GTK+ 2.10.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, generic subject ;)

After solving the problems with ICH, one other stays. One box has a
VIA controller (in fact, this is a ApolloPro 266 chipset motherboard):

nada:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0a.0 SCSI storage controller: Adaptec AIC-7892B U160/m (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV18 [GeForce4 MX 440 AGP 8x] (rev a4)


I built -rc2-mm1 with modular support for the VT82Cxxxx both through IDE and
libata. The only thing hung there is the burner.

When drived through standard IDE, I got this:

VP_IDE: IDE controller at PCI slot 0000:00:11.1
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HL-DT-ST DVDRAM GSA-4040B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide1...

If I load pata-via, I just wait a lot and get this:

Jul 10 15:09:46 nada kernel: pata_via 0000:00:11.1: version 0.1.13
Jul 10 15:09:46 nada kernel: PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 0
Jul 10 15:09:46 nada kernel: ata9: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xD800 irq 14
Jul 10 15:09:46 nada kernel: scsi9 : pata_via
Jul 10 15:09:46 nada kernel: ata9.00: ATAPI, max UDMA/33
Jul 10 15:10:16 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 15:10:16 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 15:10:16 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 15:10:16 nada kernel: ata9.00: limiting speed to UDMA/25
Jul 10 15:10:16 nada kernel: ata9: failed to recover some devices, retrying in 5 secs
Jul 10 15:10:51 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 15:10:51 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 15:10:51 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 15:10:51 nada kernel: ata9: failed to recover some devices, retrying in 5 secs
Jul 10 15:11:27 nada kernel: ata9.00: qc timeout (cmd 0xa1)
Jul 10 15:11:27 nada kernel: ata9.00: failed to IDENTIFY (I/O error, err_mask=0x4)
Jul 10 15:11:27 nada kernel: ata9.00: revalidation failed (errno=-5)
Jul 10 15:11:27 nada kernel: ata9.00: disabled
Jul 10 15:11:27 nada kernel: ata10: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xD808 irq 15
Jul 10 15:11:27 nada kernel: scsi10 : pata_via
Jul 10 15:11:34 nada kernel: ata10: port is slow to respond, please be patient
Jul 10 15:11:57 nada kernel: ata10: port failed to respond (30 secs)
Jul 10 15:11:57 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 15:11:57 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 15:11:57 nada kernel: ata10: softreset failed, retrying in 5 secs
Jul 10 15:12:03 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 15:12:03 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 15:12:03 nada kernel: ata10: softreset failed, retrying in 5 secs
Jul 10 15:12:08 nada kernel: ata10: SRST failed (status 0xFF)
Jul 10 15:12:08 nada kernel: ata10: SRST failed (err_mask=0x100)
Jul 10 15:12:08 nada kernel: ata10: reset failed, giving up

Any ideas ?

TIA

--
J.A. Magallon <jamagallon()ono!com>     \               Software is like sex:
                                         \         It's better when it's free
Mandriva Linux release 2007.0 (Cooker) for i586
Linux 2.6.17-jam05 (gcc 4.1.1 20060724 (prerelease) (4.1.1-3mdk)) #2 SMP PREEMPT
