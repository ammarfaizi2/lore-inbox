Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131588AbRDSRkU>; Thu, 19 Apr 2001 13:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131614AbRDSRkK>; Thu, 19 Apr 2001 13:40:10 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:9481 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131588AbRDSRjy>; Thu, 19 Apr 2001 13:39:54 -0400
Message-ID: <3ADF2314.7ADF7A8D@t-online.de>
Date: Thu, 19 Apr 2001 19:40:36 +0200
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Roskin <proski@gnu.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: PNP BIOS and parport_pc - dma found but not used
In-Reply-To: <Pine.LNX.4.33.0104190947320.1315-100000@fonzie.nine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Roskin wrote:
...
> 
> There is another interesting line in the log that you didn't quote. The
> driver actually knows about DMA 3:
> 
> 0x378: ECP settings irq=7 dma=3

The parport code only uses DMA when told by the user, so 
	insmod parport_pc dma=auto
should to the trick. Parport DMA transfers are considered experimental still,
so this is not the default.

> 
> Just in case, that board is Asus P5A-B with the latest BIOS:
> P5A-B BIOS ver. 1010, 05/31/2000
> 
> For comparison, I took a board with VIA chipset and PhoenixBIOS 4.0
> Release 6.0, and it works properly with another 2.4.3-ac9 kernel:

Fine. With PNPBIOS or ACPI you don't currently need dma=auto.
This is subject to change probably (see above).

> 
> Winbond Super-IO detection, now testing ports 3F0,370,250,4E,2E ...
> SMSC Super-IO detection, now testing Ports 2F0, 370 ...
> PnPBIOS: Parport found PNPBIOS PNP0401 at io=0378,0778 irq=7 dma=3
> 0x378: FIFO is 16 bytes
> 0x378: writeIntrThreshold is 8
> 0x378: readIntrThreshold is 8
> 0x378: PWord is 8 bits
> 0x378: Interrupts are ISA-Pulses
> 0x378: ECP port cfgA=0x10 cfgB=0x4b
> 0x378: ECP settings irq=7 dma=3
> parport0: PC-style at 0x378 (0x778), irq 7, dma 3
> [PCSPP,TRISTATE,COMPAT,ECP,DMA]
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
> parport0: cpp_daisy: aa5500ff(38)
> parport0: assign_addrs: aa5500ff(38)
