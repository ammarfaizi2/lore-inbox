Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSHUJdm>; Wed, 21 Aug 2002 05:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSHUJdm>; Wed, 21 Aug 2002 05:33:42 -0400
Received: from mail.mpi-sb.mpg.de ([139.19.1.1]:26282 "EHLO
	interferon.mpi-sb.mpg.de") by vger.kernel.org with ESMTP
	id <S318117AbSHUJdl>; Wed, 21 Aug 2002 05:33:41 -0400
Message-ID: <3D635F68.C30BE6CF@mpi-sb.mpg.de>
Date: Wed, 21 Aug 2002 11:37:44 +0200
From: Roman Dementiev <dementiev@mpi-sb.mpg.de>
Reply-To: dementiev@mpi-sb.mpg.de
Organization: MPI for Computer Science
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 stops at booting when I change PCI slot of a card
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched for relevant problems, but without success.

I have Supermicro P4DPE motherboard, 2-Xeons and four Ultra100 TX2 PCI
IDE conrollers.

The motherboard has several PCI buses. Mapping of PCI slots to the buses
is the following:

PCI Slot 1-3 (66 Mhz):  bus 5 (bus number reported by linux startup
messages)
PCI Slot 4   (66 Mhz):  bus 6
PCI-X Slot 5 (66 Mhz):  bus 3
PCI-X Slot 6 (100 Mhz): bus 2

PCI-X slots configured as plain PCI
100 Mhz slot configured to function at 66 Mhz

When I plug in 4 cards into slots 1-4 or 1-3 and 5 everything is fine,
Linux boots, I have ULTRA DMA 100 on each of them.

But I wanted to avoid bus bandwith saturation moving each controller to
the separate bus (now I can't get more then 240 Mb/s with 8 disk. With 4
disks parallel read rate is 190 Mb/s, seems to be bottleneck in the PCI
bus).

It failed (none of configurations except 1-4 and 1,2,3,5 work) linux
stops after the message, corresponding to the last controller (other
controllers are also reported):

PDC20268: IDE controller on PCI bus 06 dev 08
PDC20268: chipset revision 2
PDC20268: not 100% native mode: will probe irqs later
PDC20268: (U)DMA Burst Bit DISABLED Primary MASTER Mode Secondary MASTER
Mode.
PDC20268: FORCING BURST BIT 0x50 -> 0x51 INACTIVE
    ide8: BM-DMA at 0x4000-0x4007, BIOS settings: hdq:pio, hdr:pio
    ide9: BM-DMA at 0x4008-0x400f, BIOS settings: hds:pio, hdt:pio


Any ideas? Where is problem?

