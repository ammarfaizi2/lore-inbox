Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWFTRPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWFTRPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWFTRPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:15:19 -0400
Received: from main.gmane.org ([80.91.229.2]:61379 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751431AbWFTRPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:15:18 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: PATA driver patch for 2.6.17
Date: Tue, 20 Jun 2006 21:12:14 +0400
Message-ID: <e79a9e$2kt$1@sea.gmane.org>
References: <1150740947.2871.42.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ppp85-141-133-126.pppoe.mtu-net.ru
User-Agent: KNode/0.10.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> http://zeniv.linux.org.uk/~alan/IDE
> 
> This is basically a resync versus 2.6.17, the head of the PATA tree is
> now built against Jeffs tree with revised error handling and the like.
> 

Running vanilla 2.6.17 + ide1 patch on ALi M5229 does not find CD-ROM.
Notice "ata2: command 0xa0 timeout" below.

ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0xEFF0 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:49a8 84:4003 85:f469 86:0808 87:4003
88:103f
ata1: dev 0 ATA-5, max UDMA/100, 39070080 sectors: LBA
ata1: dev 0 configured for UDMA/33
scsi0 : ali
š Vendor: ATA š š š Model: IC25N020ATDA04-0 šRev: DA3O
š Type: š Direct-Access š š š š š š š š š š šANSI SCSI revision: 05
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xEFF8 irq 15
ata2: dev 0 cfg 49:0f00 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000
88:0407
ata2: dev 0 ATAPI, max UDMA/33
ata2: dev 0 configured for UDMA/33
scsi1 : ali
ata2: command 0xa0 timeout, stat 0x58 host_stat 0x21
ata2: translated ATA stat/err 0x58/00 to SCSI SK/ASC/ASCQ 0xb/47/00
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 39070080 512-byte hdwr sectors (20004 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
šsda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda

Otherwise I am pretty much impressed.

00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev
01)
00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link
Controller Audio Device (rev 01)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:0a.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100]
(rev 08)
00:10.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller
(rev 01)
00:11.0 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus
Bridge with ZV Support (rev 32)
00:11.1 CardBus bridge: Toshiba America Info Systems ToPIC100 PCI to Cardbus
Bridge with ZV Support (rev 32)
00:12.0 System peripheral: Toshiba America Info Systems SD TypA Controller
(rev 03)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade XPAi1
(rev 82)


And running "classical" IDE:

{pts/0}% sudo cat /proc/ide/hdc/model
TOSHIBA DVD-ROM SD-C2502
{pts/0}% sudo cat /proc/ide/hdc/identify
85c0 0000 0000 0000 0000 0000 0000 0000
0000 0000 3031 3030 3230 3839 3338 2020
2020 2020 2020 2020 0000 0100 0000 3133
3133 2020 2020 544f 5348 4942 4120 4456
442d 524f 4d20 5344 2d43 3235 3032 2020
2020 2020 2020 2020 2020 2020 2020 0000
0000 0f00 0000 0400 0200 0006 0000 0000
0000 0000 0000 0000 0000 0000 0007 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0004 0009 0000 0000 0000 0000 0000
003c 0013 0000 0000 0000 0000 0000 0000
0407 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000

-andrey

