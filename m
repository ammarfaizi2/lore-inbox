Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262187AbUBXGrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 01:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbUBXGrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 01:47:08 -0500
Received: from [217.7.64.198] ([217.7.64.198]:22672 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id S262187AbUBXGrA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 01:47:00 -0500
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.3: tg3: can't set full duplex
Date: Tue, 24 Feb 2004 07:46:58 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402240746.58494.earny@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Moin.

tweaky ~ # dmesg | tail
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Adding 2000084k swap on /dev/sda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
tweaky ~ # ethtool eth0
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Half
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Current message level: 0x000000ff (255)
        Link detected: yes
tweaky ~ # ethtool -s eth0 duplex full
tweaky ~ # ethtool eth0
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full
                                100baseT/Half 100baseT/Full
                                1000baseT/Half 1000baseT/Full
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Half
        Port: Twisted Pair
        PHYAD: 1
        Transceiver: internal
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: d
        Current message level: 0x000000ff (255)
        Link detected: yes
tweaky ~ # dmesg | tail
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
Adding 2000084k swap on /dev/sda2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
tg3: eth0: Link is up at 100 Mbps, half duplex.
tg3: eth0: Flow control is off for TX and off for RX.
tg3: eth1: Link is up at 1000 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.

-----------------

Nothings happens. Was working with 2.4.21 

-----------------

tweaky ~ # ethtool
ethtool version 1.7
[..]

tweaky ~ # lspci
00:00.0 Host bridge: ServerWorks CMIC-HE (rev 22)
00:00.1 Host bridge: ServerWorks CMIC-HE
00:00.2 Host bridge: ServerWorks CMIC-HE
00:00.3 Host bridge: ServerWorks CMIC-HE
00:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
00:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
00:0f.0 Host bridge: ServerWorks CSB5 South Bridge (rev 93)
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 05)
00:0f.3 ISA bridge: ServerWorks GCLE Host Bridge
00:10.0 Host bridge: ServerWorks CIOB30 (rev 03)
00:10.2 Host bridge: ServerWorks CIOB30 (rev 03)
00:11.0 Host bridge: ServerWorks CIOB30 (rev 03)
00:11.2 Host bridge: ServerWorks CIOB30 (rev 03)
00:12.0 Host bridge: ServerWorks CIOB30 (rev 03)
00:12.2 Host bridge: ServerWorks CIOB30 (rev 03)
03:01.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
04:00.0 PCI bridge: Intel Corp. 21154 PCI-to-PCI Bridge
04:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel Ultra3 
SCSI Processor (rev 06)
05:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
0a:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 Gigabit 
Ethernet (rev 14)
0a:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5700 Gigabit 
Ethernet (rev 14)

---------------------------------


Problem is: With this switch this card hangs sometimes if fullduplex is not 
switched on. And the port on the Switch supports full duplex ;-)

~Earny
