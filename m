Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129373AbRBXOcF>; Sat, 24 Feb 2001 09:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129374AbRBXObz>; Sat, 24 Feb 2001 09:31:55 -0500
Received: from netcore.fi ([193.94.160.1]:260 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S129373AbRBXObo>;
	Sat, 24 Feb 2001 09:31:44 -0500
Date: Sat, 24 Feb 2001 16:31:42 +0200 (EET)
From: Pekka Savola <pekkas@netcore.fi>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.19pre14 VP3 + Quantum: dma on hangs
Message-ID: <Pine.LNX.4.31.0102241544320.1149-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Using 2.2.19pre14 with:
 * software raid
 * raid1 readbalancing
 * i2c
 * lm_sensors
 * ipsec

My drives are as follows:

hda: QUANTUM FIREBALLP AS20.5, 19595MB w/1902kB Cache, CHS=2498/255/63
hdc: QUANTUM FIREBALLP AS20.5, 19595MB w/1902kB Cache, CHS=39813/16/63
hdd: IBM-DTTA-350840, 8063MB w/467kB Cache, CHS=16383/16/63
hdb: ATAPI 4X CD-ROM drive, 256kB Cache

[ Bios sees: HDA & HDC : udma5, HDD: udma2 ]

And the mainboard related stuff in lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 02)
00:07.3 Bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)

Now, if I turn on dma on hdd, and run hdparm benchmark, everything works
fine.

If I turn on dma with hdparm on hda or hdc, next disk activity will freeze
the system completely.  No keyboard interaction, not anything.  Only reset
helps.

Also, if I disable UDMA in bios completely on hda and hdc, hdparm will
work, but the speed is awful (only ~6 MB/s) even if DMA is enabled.

The most relevant kernel settings are, I think:

CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_VIA82C586=y
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_IDE_CHIPSETS is not set

Any ideas?

Please Cc:
-- 
Pekka Savola                  "Tell me of difficulties surmounted,
Netcore Oy                    not those you stumble over and fall"
Systems. Networks. Security.   -- Robert Jordan: A Crown of Swords



