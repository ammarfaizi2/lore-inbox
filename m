Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263225AbREaUpZ>; Thu, 31 May 2001 16:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbREaUpP>; Thu, 31 May 2001 16:45:15 -0400
Received: from colorfullife.com ([216.156.138.34]:42247 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S263224AbREaUpL>;
	Thu, 31 May 2001 16:45:11 -0400
Message-ID: <3B16AD5D.DEDB8523@colorfullife.com>
Date: Thu, 31 May 2001 22:45:17 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [lkml]Re: [lkml]Re: interrupt problem with MPS 1.4 / not with MPS 
 1.1 ?
In-Reply-To: <3B16A7E3.1BD600F3@colorfullife.com> <20010531222708.A8295@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:
> 
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
>         Subsystem: Unknown device 0925:1234
>         Flags: bus master, medium devsel, latency 32, IRQ 5
>         I/O ports at a000 [size=32]
>         Capabilities: [80] Power Management version 2
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 04 00 00
> 
> 0x3X is at 5, not at 3.
>
You still run with MPS 1.1.
It should be 3 or 19 after you reboot with MPS 1.4.

Could you please try the following commands as root, but just before
rebooting. It'll kill the USB controller.

#setpci -s 00:07.2 INTERRUPT_LINE=15
#lspci -vx -s 00:07.2
<<< 0x3C should be 15
#setpci -s 00:07.2 INTERRUPT_LINE=19
#lspci -vx -s 00:07.2
<<< 0x3C is now either 19 or 3

--
	Manfred
