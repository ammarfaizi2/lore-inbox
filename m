Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbUKGRyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbUKGRyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 12:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbUKGRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 12:54:36 -0500
Received: from imap3.nextra.sk ([195.168.1.92]:8455 "EHLO tic.nextra.sk")
	by vger.kernel.org with ESMTP id S261671AbUKGRwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 12:52:21 -0500
Message-ID: <418E60F4.3090501@rainbow-software.org>
Date: Sun, 07 Nov 2004 18:52:52 +0100
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041105)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: parport not working in 2.6.9
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I've noticed that parallel port stopped working for me with 2.6.9. It works with 2.6.8.1 using the same .config - the relevant part:
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

I've noticed that there's "smsc parport" instead of parport0 in /proc/ioports and new smsc_check range but the 0778-077a range is no longer there. My board has SMC Super I/O chip.

Here's "diff ioports-2.6.8.1 ioports-2.6.9" output:
3c3,4
< 0040-005f : timer
---
> 0040-0043 : timer0
> 0050-0053 : timer1
19c20
< 0378-037a : parport0
---
> 0378-037a : smsc parport
22a24
> 03f0-03f2 : smsc_check
25d26
< 0778-077a : parport0
29c30,33
<   4008-400b : ACPI timer
---
>   4000-4003 : PM1a_EVT_BLK
>   4004-4005 : PM1a_CNT_BLK
>   4008-400b : PM_TMR
>   400c-400f : GPE0_BLK


I also see some new ACPI errors during 2.6.9 startup:
ACPI: Subsystem revision 20040816
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR1._PRW] (Node c7f89f40), AE_TYPE
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.UAR2._PRW] (Node c7f89e20), AE_TYPE
    ACPI-0205: *** Error: Return object type is incorrect [\_SB_.PCI0.ISA_.LPT_._PRW] (Node c7f89c40), AE_TYPE


and this:
parport: PnPBIOS parport detected.
pnp: Device 00:0e disabled.


In 2.6.8.1, it's correct:
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
lp0: using parport0 (interrupt-driven).

If more details are needed, just ask.

-- 
Ondrej Zary
