Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314079AbSEYH4f>; Sat, 25 May 2002 03:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEYH4e>; Sat, 25 May 2002 03:56:34 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:1681 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S314078AbSEYH4d>; Sat, 25 May 2002 03:56:33 -0400
Message-ID: <3CEF4396.8080705@wanadoo.fr>
Date: Sat, 25 May 2002 09:56:06 +0200
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.5.18 and HPT366
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.18 hangs at partition check. A workaround is to comment hpt366.c:868 
config_chipset_for_pio(drive) in the function config_chipset_for_dma().

In this case the partition check looks to be done twice :

ATA: Triones Technologies, Inc. HPT366 / HPT370: controller, PCI slot 
00:13.0
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
     ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
ATA: Triones Technologies, Inc. HPT366 / HPT370 (#2): controller, PCI 
slot 00:13.1
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
ATA: chipset rev.: 1
ATA: non-legacy mode: IRQ probe delayed
     ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:DMA, hdh:pio
hda: SAMSUNG DVD-ROM SD-616F, ATAPI CD/DVD-ROM drive
hde: ST310212A, ATA DISK drive
hdg: SAMSUNG SV0322A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd800-0xd807,0xdc02 on irq 11
  hde: 20005650 sectors w/512KiB Cache, CHS=19846/16/63, UDMA(66)
Partition check:
  /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
  hdg: 6250608 sectors w/478KiB Cache, CHS=11024/9/63, UDMA(33)
  /dev/ide/host3/bus0/target0/lun0: p1
  /dev/ide/host2/bus0/target0/lun0: p1 p2 p3 p4
  /dev/ide/host3/bus0/target0/lun0: p1


Pierre
-- 
------------------------------------------------
  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------

