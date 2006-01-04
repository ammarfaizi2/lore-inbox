Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWADQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWADQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWADQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:28:34 -0500
Received: from host-84-9-200-140.bulldogdsl.com ([84.9.200.140]:7303 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1751245AbWADQ2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:28:34 -0500
Date: Wed, 4 Jan 2006 16:27:43 +0000
From: Ben Dooks <ben-linux@fluff.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15 EHCI hang on boot
Message-ID: <20060104162743.GA11794@home.fluff.org>
References: <20060104161844.GA28839@torres.l21.ma.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060104161844.GA28839@torres.l21.ma.zugschlus.de>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 05:18:44PM +0100, Marc Haber wrote:
> Hi,
> 
> I have rolled out 2.6.15 on a number of test hosts. On one of my
> boxes, which is by far the most recent one, has an i865 chipset, hangs
> on boot when the EHCI driver is loaded. USB is not compiled as module,
> so the system doesn't come up at all:
> 
> ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
> ehci_hcd 0000:00:1d.7: EHCI Host Controller
> ehci_hcd 0000:00:1d.7: debug port 1
> 
> These are the last lines of the boot log (which I have completely
> captured via serial console and can submit on request).
> 
> The EHCI controller's lspci output (obtained with 2.6.14.3):
> 0000:00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 EHCI
>  Controller (rev 02) (prog-if 20 [EHCI])
>         Subsystem: Micro-Star International Co., Ltd. 865PE Neo2 (MS-6728)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort - <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin D routed to IRQ 18
>         Region 0: Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [58] #0a [20a0]
> (complete lspci output available on request)
> 
> The 2.6.14.3 kernel which was installed on that box before works fine.
> The 2.6.15 configuration is the result of make oldconfig over that
> 2.6.14.3 kernel, so I suspect that the configurations are sufficiently
> similiar, and the same 2.6.15 binary works fine on other systems which
> have their EHCI as PCI cards.
> 
> I suspect an incompatibility with the i865 chipset. Is there anything
> I can do to help debugging?

I have the same (but only intermittently) on an Intel i875 based
board by MSI. In about 25% of the cases it manages to boot past
these lines, and initialise the mouse connected. 

The usb bus has a low-speed Microsoft mouse on it, and a
USB 1.1 Hub, with a card reader and serial dongle connected.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
