Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135571AbRDSGOa>; Thu, 19 Apr 2001 02:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135570AbRDSGOK>; Thu, 19 Apr 2001 02:14:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:60166 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S135569AbRDSGOF>; Thu, 19 Apr 2001 02:14:05 -0400
Date: Thu, 19 Apr 2001 02:14:03 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: <proski@portland>
To: <linux-kernel@vger.kernel.org>
Subject: PNP BIOS and parport_pc - dma found but not used
Message-ID: <Pine.LNX.4.33.0104190203320.10275-100000@portland>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've compiled 2.4.3-ac9 with support for PNP BIOS. I understand that this
is a new feature experimental and the feedback is requested.

The setting is BIOS is to use irq 7 and dma 3. I normally use "options
parport_pc io=0x378 irq=7 dma=3" in /etc/modules.conf, but this time I
commented them out hoping that the driver will ask BIOS.

Although the kernel can see those settings, the dma is not used by the
driver. This is the output from dmesg.

PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=-1
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 7
0x378: readIntrThreshold is 7
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x10 cfgB=0x4b
0x378: ECP settings irq=7 dma=3
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO
[PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, Canon BJC-1000
# cat /proc/dma
 4: cascade
# cat /proc/interrupts
           CPU0
  0:    1323677          XT-PIC  timer
  1:      20176          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:          0          XT-PIC  eth1
  4:     288111          XT-PIC
  7:          2          XT-PIC  parport0
  8:          1          XT-PIC  rtc
 12:      41138          XT-PIC  eth0
 14:      22503          XT-PIC  ide0
 15:          0          XT-PIC  ide1
NMI:          0
ERR:          0

The full output is here: http://www.red-bean.com/~proski/linux/dmesg
First time parport_pc was loaded with the explicit options.

-- 
Regards,
Pavel Roskin

