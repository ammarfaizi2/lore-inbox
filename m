Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbVI3TIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbVI3TIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbVI3TIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 15:08:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59010 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965052AbVI3TIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 15:08:16 -0400
Date: Fri, 30 Sep 2005 12:07:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Francois Romieu <romieu@fr.zoreil.com>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.14-rc2-mm2 (PHY reset until link up)
Message-Id: <20050930120723.07d42517.akpm@osdl.org>
In-Reply-To: <200509302049.45143.dominik.karall@gmx.net>
References: <20050929143732.59d22569.akpm@osdl.org>
	<200509302049.45143.dominik.karall@gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall <dominik.karall@gmx.net> wrote:
>
> On Thursday 29 September 2005 23:37, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/2.
> >6.14-rc2-mm2/
> 
> hi,
> I'm not sure if this bug is in 2.6.14-rc2 too. I get hundreds of these 
> messages:
> Sep 30 20:12:28 amd64box eth2: PHY reset until link up
> Sep 30 20:12:38 amd64box eth2: PHY reset until link up
> Sep 30 20:12:48 amd64box eth2: PHY reset until link up
> Sep 30 20:12:58 amd64box eth2: PHY reset until link up
> 
> eth2 uses the r8169 driver. _No_ network cable was connected at that moment!
> here is lspci output:
> 0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 
> Gigabit Ethernet (rev 10)
>         Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
>         Flags: 66Mhz, medium devsel, IRQ 217
>         I/O ports at b000 [size=256]
>         Memory at fde00000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at fdd00000 [disabled] [size=128K]
>         Capabilities: [dc] Power Management version 2
> 
> and dmesg:
> r8169 Gigabit Ethernet driver 2.2LK-NAPI loaded
> ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 19 (level, low) -> IRQ 217
> eth2: Identified chip type is 'RTL8169s/8110s'.
> eth2: RTL8169 at 0xffffc200009ca000, 00:0c:f6:04:87:c0, IRQ 217
> r8169: eth2: link down
> 

That seems a bit dumb - R8169_MSG_DEFAULT has NETIF_MSG_LINK enabled, so
yes, that driver's going to spam logs when there's no cable connected.

I'd suggest that R8169_MSG_DEFAULT be toned down a bit.
