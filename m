Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbULMDO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbULMDO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 22:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbULMDO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 22:14:57 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:11482 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262192AbULMDOw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 22:14:52 -0500
Message-Id: <200412130314.iBD3EnF4004369@albireo.free.fr>
Date: Mon, 13 Dec 2004 04:14:49 +0100 (CET)
From: frahm@irsamc.ups-tlse.fr
Reply-To: frahm@irsamc.ups-tlse.fr
Subject: Re: [Fwd: 2.6.10-rc3: tulip-driver: tulip_stop_rxtx() failed]
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry, I forgot the modification for "i" in the loop and teh udelay:

> I expect one of three things to fix this:
> o The comet card needs more time than we've allocated.
>   Could you also try larger values for "i" in the loop?
>   e.g. 2000/10 or 4000/10
> 
> o The loop is too "tight" and poking the card every 10us is interfering
>   with DMA.  The solution is to change the udelay(10) to 50 or 100
>   (and the corresponding "i" value initialization).

Here is the output of dmesg (I carefully removed the old tulip module and 
inserted its new version after each recompilation.)

--- i=2000/10, udelay(10)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
--- i=4000/10, udelay(10)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
--- i=1300/50, udelay(50)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
--- i=4000/50, udelay(50)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
--- i=1300/100, udelay(100)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)
--- i=4000/100, udelay(100)
Linux Tulip driver version 1.1.13 (May 11, 2002)
PCI: Found IRQ 10 for device 0000:00:0e.0
PCI: Sharing IRQ 10 with 0000:00:0a.0
tulip0:  MII transceiver #1 config 1000 status 786d advertising 05e1.
eth1: ADMtek Comet rev 17 at 0001a400, 00:0C:F6:03:DA:D3, IRQ 10.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc664010 CSR6 0xff972113)
eth1: Setting full-duplex based on MII#1 link partner capability of 4061.
0000:00:0e.0: tulip_stop_rxtx() failed (CSR5 0xfc06c012 CSR6 0xff970111)

There is no modification in the values of CSR5 and CSR6. I suppose this 
implies a Chip defect which is quite plausible since a I have cheap Sitecom 
card which is perhaps not 100% compatible with the tulip-driver ? 

> o Chip defect. When DMA is stopped, CSR5 Transmit State and Receive
>   State machines are expected to be zero. It's possible this chip
>   just never sets those states. I suppose we could check CSR6 bits
>   to confirm the ST and SR bits are clear before printing the message.
>   The CSR6 value above will tell me if that's feasible.

Greetings, Klaus.


