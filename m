Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCWVSP>; Fri, 23 Mar 2001 16:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129443AbRCWVSF>; Fri, 23 Mar 2001 16:18:05 -0500
Received: from dfw-smtpout2.email.verio.net ([129.250.36.42]:21682 "EHLO
	dfw-smtpout2.email.verio.net") by vger.kernel.org with ESMTP
	id <S129393AbRCWVRz>; Fri, 23 Mar 2001 16:17:55 -0500
Message-ID: <3ABBBD56.9D70D995@bigfoot.com>
Date: Fri, 23 Mar 2001 13:17:10 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: UDMA 100 / PIIX4 question
In-Reply-To: <Pine.LNX.4.10.10103201628390.8689-100000@coffee.psychology.mcmaster.ca>
		<3AB8FDAD.BF71A5F@bigfoot.com> <20010323102603Z130485-407+2891@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am afraid that I do not know how to change my partition type.  I can confirm. however, that the BIOS is set to Auto / LBA and that BIOS confirms UDMA 5 is set (and cannot be set unless the correct cabling is detected).

[tim@abit tim]# fdisk /dev/hdc

Command (m for help): t
Partition number (1-4): 1
Hex code (type L to list codes): c
Changed system type of partition 1 to c (Win95 FAT32 (LBA))
...

> But is my controller, though detected as a PIIX4 (and described as such in the Asus manual), really a PIIX4?  lspci :
> 
> 00:00.0 Host bridge: Intel Corporation: Unknown device 1130 (rev 02)
> 00:01.0 PCI bridge: Intel Corporation: Unknown device 1131 (rev 02)
> 00:1e.0 PCI bridge: Intel Corporation: Unknown device 244e (rev 01)
> 00:1f.0 ISA bridge: Intel Corporation: Unknown device 2440 (rev 01)
> 00:1f.1 IDE interface: Intel Corporation: Unknown device 244b (rev 01)
> 00:1f.2 USB Controller: Intel Corporation: Unknown device 2442 (rev 01)
> ...
> 
> On the other hand, cat /proc/ide/piix :
> 
>                                Intel PIIX4 Ultra 100 Chipset.
> --------------- Primary Channel ---------------- Secondary Channel -------------
>                  enabled                          enabled
> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
> DMA enabled:    yes              no              yes               no
> UDMA enabled:   yes              no              yes               no
> UDMA enabled:   5                X               2                 X
> UDMA
> DMA
> PI

ICH2 is marked '80821BA' and is rated ATA/100 by intel, PIIX4 is '82371AB'
so you can look on your motherboard.  Andre is the one to say if the driver
is compatible.  I can't find a single reference to the 80821 in
drivers/block/*.c for 2.2.19pre17 + ide.2.2.18.1221.

Here's what a PIIX4 looks like.

[tim@smp ide]# cat /proc/ide/ide0/config
pci bus 00 device 39 vid 8086 did 7111 channel 0
86 80 11 71 05 00 80 02 01 80 01 01 00 20 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
07 a3 00 80 00 00 00 00 01 00 02 00 00 00 00 00
...
00 00 00 00 00 00 00 00 30 0f 00 00 00 00 00 00

[tim@smp ide]# cat /proc/ide/piix

                                Intel PIIX4 Ultra 33 Chipset.
--------------- Primary Channel ---------------- Secondary Channel
-------------
                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1
------
DMA enabled:    yes              no              no                no 
UDMA enabled:   yes              no              no                no 
UDMA enabled:   2                X               X                 X
UDMA
DMA
PIO

[tim@smp tim]# lspci | grep IDE
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
[tim@smp tim]# lspci -n | grep 7.1
00:07.1 Class 0101: 8086:7111 (rev 01)

--
