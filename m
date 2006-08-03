Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964777AbWHCURv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbWHCURv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbWHCURv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:17:51 -0400
Received: from thunk.org ([69.25.196.29]:15744 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964777AbWHCURu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:17:50 -0400
Date: Thu, 3 Aug 2006 16:17:41 -0400
From: Theodore Tso <tytso@mit.edu>
To: Michael Chan <mchan@broadcom.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH -rt DO NOT APPLY] Fix for tg3 networking lockup
Message-ID: <20060803201741.GA7894@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Michael Chan <mchan@broadcom.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net
References: <E1G8a0J-0002Pn-00@gondolin.me.apana.org.au> <1154630207.3117.17.camel@rh4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154630207.3117.17.camel@rh4>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 11:36:47AM -0700, Michael Chan wrote:
> On Thu, 2006-08-03 at 20:00 +1000, Herbert Xu wrote:
> > Theodore Tso <tytso@mit.edu> wrote:
> > > 
> > > I'm sending this on mostly because it was a bit of a pain to track down,
> > > and hopefully it will save time if anyone else hits this while playing
> > > with the -rt kernel.  It is NOT the right way to fix things, so please
> > > don't even think of applying this patch (unless you need it, in your own
> > > local tree :-).
> > > 
> > > One of these days when we have time to breath we'll look into fixing
> > > this the right way, if someone doesn't beat us to it first.  :-)
> > 
> Ted, what tg3 hardware is having this timer related problem?  Can you
> send me the tg3 probing output?

tg3.c:v3.49 (Feb 2, 2006)
ACPI: PCI Interrupt 0000:02:01.0[A] -> GSI 24 (level, low) -> IRQ 17
eth0: Tigon3 [partno(BCM95704s) rev 2100 PHY(serdes)] (PCIX:100MHz:64-bit) 10/100/1000BaseT Ethernet 00:14:5e:86:44:24
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[0] TSOcap[0]
eth0: dma_rwctrl[769f4000] dma_mask[64-bit]

02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704S Gigabit Ethernet (rev 10)
        Subsystem: IBM: Unknown device 0301
        Flags: bus master, 66Mhz, medium devsel, latency 64, IRQ 17
        Memory at efff0000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

The other interesting bit of information is that after networking card
goes dead and I do the "ifdown eth0; ifup eth0", the following printk
shows up:

tg3: tg3_abort_hw timed out for eth0, TX_MODE_ENABLE will not clear MAC_TX_MODE=ffffffff

This is from an IBM LS-20 blade.

Is this helpful?

							- Ted
