Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283429AbRK2XMM>; Thu, 29 Nov 2001 18:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283430AbRK2XMC>; Thu, 29 Nov 2001 18:12:02 -0500
Received: from pop.gmx.net ([213.165.64.20]:63597 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S283429AbRK2XLu>;
	Thu, 29 Nov 2001 18:11:50 -0500
Date: Fri, 30 Nov 2001 00:11:38 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: Valentin Ziegler <ziegler@informatik.hu-berlin.de>
Subject: IDE controller detection 2.4 +devfs
Message-Id: <20011130001138.78ab1242.rene.rebe@gmx.net>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I like to rereport that the IDE Controllers get strange device-
node-number in Linux-2.4 (currently vanilla 2.4.16) at least using DevFS.

I reported (~a year ago) that when I disable the primary channel of the
on-board controller of the Asus-K7M (Irongate based) the second channel
will be host1 - no host0 can be found.

My today's issue is our K6-2 based server with an Gigabyte Ali-Aladin5
board. The on-board controller is host0 but the additional Promisse
TX2 Ultra100 will be host2 ??? no host1 there ... :

server1:~ # l /dev/ide/
total 0
drwxr-xr-x   1 root     root            0 Jan  1  1970 .
drwxr-xr-x   1 root     root            0 Jan  1  1970 ..
drwxr-xr-x   1 root     root            0 Jan  1  1970 host0
drwxr-xr-x   1 root     root            0 Jan  1  1970 host2

>From /var/log/boot.msg:
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PDC20268: IDE controller on PCI bus 00 dev 58
<6>PCI: Found IRQ 11 for device 00:0b.0
<4>PDC20268: chipset revision 2
<4>PDC20268: not 100%% native mode: will probe irqs later
<4>PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
<4>    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
<4>    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
<4>ALI15X3: IDE controller on PCI bus 00 dev 78
<4>PCI: No IRQ known for interrupt pin A of device 00:0f.0. Please try using pci
=biosirq.
<4>ALI15X3: chipset revision 193
<4>ALI15X3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
<4>    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:pio, hdd:pio
<4>hda: TOSHIBA MK6015MAP, ATA DISK drive
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>hdc: IBM-DTLA-305040, ATA DISK drive
<4>hde: IBM-DTLA-305040, ATA DISK drive
<4>hdg: IBM-DTLA-305040, ATA DISK drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<4>ide1 at 0x170-0x177,0x376 on irq 15

It is really odd to see the Linux kernel mangling this different on each
Workstation ...

k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #127875 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
