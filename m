Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313479AbSDLJrR>; Fri, 12 Apr 2002 05:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313480AbSDLJrQ>; Fri, 12 Apr 2002 05:47:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:20243 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313479AbSDLJrP>; Fri, 12 Apr 2002 05:47:15 -0400
Message-Id: <200204120944.g3C9i8X13441@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: New IDE code and DMA failures
Date: Fri, 12 Apr 2002 12:47:14 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>,
        Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <200204111341.g3BDfJX10546@Port.imtp.ilyichevsk.odessa.ua> <20020411174827.C14999@ucw.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 April 2002 13:48, Vojtech Pavlik wrote:
> > lspci:
> > 00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev
> > 03) 00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev
> > 03) 00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
> > 00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
> > 00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
> > 00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
> > 00:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone]
> > (rev 24) 00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA
> > 2164W [Millennium II] 00:0c.0 Ethernet controller: Realtek Semiconductor
> > Co., Ltd. RTL-8029(AS)
> >
> > /boot/2.4.7/config:
> > CONFIG_BLK_DEV_PIIX=y
>
> There's new PIIX code by me in the 2.5 kernels. Can you provide
> /proc/ide/piix data (and lspci -vvxxx) as well?

lspci -vvxxx:
00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcb0 [size=16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: b1 fc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 77 e3 47 e3 0b 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

/proc/ide/piix:
----------PIIX BusMastering IDE Configuration---------------
Driver Version:                     1.2
South Bridge:                       PCI device 8086:7111
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xfcb0
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Prefetch+Post:        yes       yes       yes       yes
Transfer Mode:       UDMA       DMA       DMA       PIO
Address Setup:       90ns      90ns      90ns      90ns
Cmd Active:         360ns     360ns     360ns     360ns
Cmd Recovery:       540ns     540ns     540ns     540ns
Data Active:         90ns      90ns      90ns     360ns
Data Recovery:       30ns      30ns      30ns     540ns
Cycle Time:          60ns     120ns     120ns     900ns
Transfer Rate:   33.3MB/s  16.6MB/s  16.6MB/s   2.2MB/s

--
vda
