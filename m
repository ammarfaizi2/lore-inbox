Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263501AbSJGWBL>; Mon, 7 Oct 2002 18:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263500AbSJGWBL>; Mon, 7 Oct 2002 18:01:11 -0400
Received: from cabal.xs4all.nl ([213.84.101.140]:27696 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263501AbSJGWBK>;
	Mon, 7 Oct 2002 18:01:10 -0400
Date: Tue, 8 Oct 2002 00:06:49 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: [2.5.41] sleeping function called from illegal context at mm/slab.c:1374
Message-ID: <20021007220649.GF14953@wiggy.net>
Mail-Followup-To: Wichert Akkerman <wichert@wiggy.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I seem to have hit a debug trigger while booting in 2.5.41. The
calltrace suggests it is an IDE problem:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MHJ2181AT, ATA DISK drive
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c01138f4>] __might_sleep+0x54/0x60
 [<c012e1d3>] kmem_cache_alloc+0x23/0xd0
 [<c01f8b50>] blk_init_free_list+0x4c/0xd0
 [<c0108998>] request_irq+0x8c/0xa8
 [<c01f8be0>] blk_init_queue+0xc/0xd4
 [<c01fd7f0>] ide_init_queue+0x28/0x68
 [<c0203a20>] do_ide_request+0x0/0x18
 [<c01fdaad>] init_irq+0x27d/0x334
 [<c01fde06>] hwif_init+0x112/0x258
 [<c01fd71c>] probe_hwif_init+0x1c/0x6c
 [<c0209b4d>] ide_setup_pci_device+0x3d/0x68
 [<c01fc77f>] piix_init_one+0x37/0x40
 [<c010508b>] init+0x33/0x188
 [<c0105058>] init+0x0/0x188
 [<c01054a9>] kernel_thread_helper+0x5/0xc


-- 
  _________________________________________________________________
 /wichert@wiggy.net         This space intentionally left occupied \
| wichert@deephackmode.org                    http://www.wiggy.net/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
