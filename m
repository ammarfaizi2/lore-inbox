Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750708AbWJ0UbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbWJ0UbL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 16:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752443AbWJ0UbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 16:31:11 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20232 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750708AbWJ0UbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 16:31:10 -0400
Date: Fri, 27 Oct 2006 22:31:09 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: Re: linux-2.6.19-rc2 tg3 problem
Message-ID: <20061027203109.GZ27968@stusta.de>
References: <b6a2187b0610230824m38ce6fb2j65cd26099e982449@mail.gmail.com> <20061025013022.GG27968@stusta.de> <b6a2187b0610251754x7dc2c51aoad2244b8cdcb1c09@mail.gmail.com> <20061026152455.GI27968@stusta.de> <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6a2187b0610270649t4cc71781y8e1695f02e1c608e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2006 at 09:49:54PM +0800, Jeff Chua wrote:
> On 10/26/06, Adrian Bunk <bunk@stusta.de> wrote:
> 
> >That wasn't clear from your bug report.
> 
> Sorry. Didn't want to bombard with too much unnecessary info.

linux-kernel has a 100 kB size limit - everything below this limit
is OK...

> >You said 2.6.18-rc2 -> 2.6.19-rc2 broke.
> >Can you identify between which -rc kernels it broke?
> 
> Ok, I managed to trace down to ..
> 
>      2.6.18 ok
>      2.6.19-rc1 bad
> 
> 
> >Please send complete "dmesg -s 1000000" for the time after tg3 loads for
> >both the last working and the first non-working -rc kernel.
> 
> 
> 2.6.18 (good) ...
> 
> tg3.c:v3.65 (August 07, 2006)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> PCI: Setting latency timer of device 0000:02:00.0 to 64
> eth0: Tigon3 [partno(BCM5751PKFBG) rev 4001 PHY(5750)] (PCI Express)
> 10/100/1000BaseT Ethernet 00:13:72:7b:2a:f0
> eth0: RXcsums[1] LinkChgREG[1] MIirq[1] ASF[0] Split[0] WireSpeed[1] 
> TSOcap[1]
> eth0: dma_rwctrl[76180000] dma_mask[64-bit]
> ip_tables: (C) 2000-2006 Netfilter Core Team
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 224 bytes per conntrack
> tg3: eth0: Link is up at 100 Mbps, full duplex.
> tg3: eth0: Flow control is on for TX and on for RX.
> 
> 
> 
> 2.6.19 (bad) ...
> 
> tg3.c:v3.66 (September 23, 2006)
> ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> tg3: Cannot find proper PCI device base address, aborting.
> ACPI: PCI interrupt for device 0000:02:00.0 disabled
> ip_tables: (C) 2000-2006 Netfilter Core Team
> ip_conntrack version 2.4 (8192 buckets, 65536 max) - 228 bytes per conntrack
>...

That's still pretty terse...

If there is anything interesting in the dmesg, it's above this point
(Please send complete "dmesg -s 1000000" for both cases).

If this won't help, the next step will be to bisect for the commit that 
broke it for you.

> Thanks,
> Jeff.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

