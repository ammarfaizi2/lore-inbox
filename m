Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263625AbRFAR2x>; Fri, 1 Jun 2001 13:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263630AbRFAR2e>; Fri, 1 Jun 2001 13:28:34 -0400
Received: from colorfullife.com ([216.156.138.34]:50697 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S263625AbRFAR23>;
	Fri, 1 Jun 2001 13:28:29 -0400
Message-ID: <3B17D0C1.5FC21CFB@colorfullife.com>
Date: Fri, 01 Jun 2001 19:28:33 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: interrupt problem with MPS 1.4 / not with MPS 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere> <3B16AD5D.DEDB8523@colorfullife.com> <20010601071414.A871@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:
> 
> :setpci -s 00:07.2 INTERRUPT_LINE=15
> :lspci -vx -s 00:07.2
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at a000 [size=32]
>         Capabilities: [80] Power Management version 2
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 15 04 00 
> :setpci -s 00:07.2 INTERRUPT_LINE=19
> :lspci -vx -s 00:07.2
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         I/O ports at a000 [size=32]
>         Capabilities: [80] Power Management version 2
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 19 04 00 00
> 
> So that is correct. I'll attach all the information from the MPS 1.4
> reboot, in which 00:07.2 happily points at 05, while everything else
> thinks it's at 19.....
>

Could you compile uhci as a module, set the configuration to MPS1.4 and
find out with which interrupt line setting it works.
I'd try both

setpci -s 00:07.2 INTERRUPT_LINE=13
setpci -s 00:07.2 INTERRUPT_LINE=3
[even if 13 works, please try 03 as well. 13 is hexadecimal==19]

The via ac97 sound driver contains an irq fixup for this problem. Either
a similar fixup is necessary in the uhci driver, or the fixup from the
ac97 driver could be moved to the pci-quirks and applied to all devices
in the southbridge.

--
	Manfred
