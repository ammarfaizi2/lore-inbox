Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbSKSLX3>; Tue, 19 Nov 2002 06:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSKSLX3>; Tue, 19 Nov 2002 06:23:29 -0500
Received: from gwsystems-4.d.gtn.com ([194.231.113.36]:46093 "EHLO
	hydra.colinet.de") by vger.kernel.org with ESMTP id <S265201AbSKSLX0>;
	Tue, 19 Nov 2002 06:23:26 -0500
Subject: DAC960, 2.4.19 alpha problems
To: linux-kernel@vger.kernel.org
Cc: kirk@colinet.de
Message-Id: <kirk-1021119120625.A0116470@hydra.colinet.de>
X-Mailer: TkMail 4.0beta9
From: "T. Weyergraf" <kirk@colinet.de>
Date: Tue, 19 Nov 2002 12:06:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
i failed to get a Mylex controller running in my alpha system.
Details:
Controller: Mylex eXtremeraid 3000 ( dual channel FC-AL )
System: Alpha UP2000 ( dp264-machine, dual CPU, 2gig RAM )
Kernels: 2.4.20-rc2 and 2.4.19
Compiler: 2.95.2
Debian potato with enhancements for the use of 2.4.x
according to Documentation/Changes

Compiling the DAC960 driver on alpha, using 2.95.2 fails,
since the optimizer apparently stumbles. In my naive/novice
attempts to get the driver compiling, I changed all
function declarations from "static inline" to "static"
The driver then compiles and is linked to the kernel, rather
than compiled as a module. ( Leaving some static inline 
declarations avoid compile-time warnings, so no
warnings are given ).
Proper device-nodes exist.

Upon boot, the driver emits the following message:
DAC960: ***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
DAC960: Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
DAC960#0: Unable to Enable Memory Mailbox Interface for Controller at
DAC960#0: PCI Bus 1 Device 8 Function 0 I/O Address N/A PCI Address 0xA000000

This applies to 2.4.19 and 2.4.20-rc2

In addition, I have tried the following, all with no change in result:
- turn on/off Mylex' BIOS
- move Mylex accoss PCI-buses ( the machine has two )
- move Mylex from 64 to 32bit slot

Additional info:
PCI device database reports the following:
PCI: dev Mylex Corporation eXtremeRAID 2000/3000 support Device type 64-bit

/proc/pci reports the following:
Bus  1, device   8, function  0:
RAID bus controller: Mylex Corporation eXtremeRAID 2000/3000 support Device (rev 0).
IRQ 27.
Master Capable.  Latency=32.  
Non-prefetchable 32 bit memory at 0xa000000 [0xbffffff].
I/O at 0x9000 [0x907f].
Prefetchable 64 bit memory at 0x10000000 [0x1fffffff].

My questions:
Are there any fixes to this problem ?
Why does the driver report "I/O Adress N/A", while there seems to be
a valid I/O range in /proc/pci ?
Are there any fixes to the DAC960, which makes it compile using 2.95.2 ?

Please note, that i am aware, that the alpha will not boot from that device,
since it's firmware does not see the controller. It will not be used for
booting. Upgrading to a newer/different distro ist problematic, since the system
cannot be taken out of service easily ( I can reboot it for testing purposes ).

I would have reported this problem the "proper way" to the maintainer of the
driver, but in this case, it's Leonard Zubkoff, who unfortunatelt died in an
accident.

Thanks in advance for any advice/help. I am willing/happy to test any proposed
patches. In order to avoid cluttering the list, i did not send any .config's and
friends. I will on request, of course.

Regards,
T. Weyergraf


-- 
Thomas Weyergraf                                                kirk@colinet.de
My Favorite IA64 Opcode-guess ( see arch/ia64/lib/memset.S )
"br.ret.spnt.few" - got back from getting beer, did not spend a lot.


