Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130240AbRBIP7f>; Fri, 9 Feb 2001 10:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130193AbRBIP7P>; Fri, 9 Feb 2001 10:59:15 -0500
Received: from expanse.dds.nl ([194.109.10.118]:23815 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S130015AbRBIP7G>;
	Fri, 9 Feb 2001 10:59:06 -0500
Date: Fri, 9 Feb 2001 16:58:37 +0100
From: Ookhoi <ookhoi@dds.nl>
To: elmer@ylenurme.ee
Cc: linux-kernel@vger.kernel.org
Subject: aironet4500_card (2.4.1-ac8), The PCI BIOS has not enabled this device!
Message-ID: <20010209165837.K4103@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
X-Uptime: 3:35pm  up 10 days,  2:39, 15 users,  load average: 0.07, 0.35, 0.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I insmod aironet4500_core and aironet4500_card, the last one
disables the pci342 nic (the leds go out).

root@tilde:~# uname -r
2.4.1-ac8
root@tilde:~# insmod aironet4500_core
Using /lib/modules/2.4.1-ac8/kernel/drivers/net/aironet4500_core.o
Warning: /lib/modules/2.4.1-ac8/kernel/drivers/net/aironet4500_core.o
symbol for parameter rx_queue_len not found
root@tilde:~# insmod aironet4500_card
Using /lib/modules/2.4.1-ac8/kernel/drivers/net/aironet4500_card.o

This is in /var/log/syslog:

Feb  9 16:43:25 tilde kernel: aironet4500.c v0.1 1/1/99 Elmer Joandi, elmer@ylenurme.ee.
Feb  9 16:43:34 tilde kernel: aironet4500_cards.c v0.2  Feb 27, 2000  Elmer Joandi, elmer@ylenurme.ee.
Feb  9 16:43:34 tilde kernel:
Feb  9 16:43:34 tilde kernel:  <6>  The PCI BIOS has not enabled this device!  Updating PCI command 0003->0103.
Feb  9 16:43:34 tilde kernel: eth1: 340 Series 802.11 Direct Sequence found @ 0x6100 irq 10 firmwareVersion 920


Until I insmod the aironet4500_card, the yellow led is on. A rmmod
doesn't change a thing. According to the documentation, both leds off
means "no power" or "an error". -ac7 is the same (there is extra stuff
for aironet4500 in -ac8).

I compile the kernel on a different computer, and then transfer bzImage,
the modules directory and System.map to the computer with the pci card. 
I don't think it should make a difference though.

root@tilde:~# lspci -v
00:00.0 Host bridge: Intel Corporation 430VX - 82437VX TVX [Triton VX] (rev 01)
        Flags: bus master, medium devsel, latency 32

00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II] (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 32
        I/O ports at f000 [size=16]

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54) (prog-if 00 [VGA])
        Flags: medium devsel, IRQ 11
        Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0b.0 Network controller: AIRONET Wireless Communications: Unknown device 4800 (rev 01)
        Flags: medium devsel, IRQ 10
        Memory at e4000000 (32-bit, non-prefetchable) [size=128]
        I/O ports at 6000 [size=128]
        I/O ports at 6100 [size=64]

Can I provide more info on this? What can I do to help to solve this?

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
