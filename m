Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268992AbRHFUQy>; Mon, 6 Aug 2001 16:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268998AbRHFUQq>; Mon, 6 Aug 2001 16:16:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:61202 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S268992AbRHFUQj>;
	Mon, 6 Aug 2001 16:16:39 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108062016.f76KGmG117015@saturn.cs.uml.edu>
Subject: Re: tulip driver problem
To: trini@kernel.crashing.org (Tom Rini)
Date: Mon, 6 Aug 2001 16:16:48 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <20010806100319.C833@cpe-24-221-152-185.az.sprintbbd.net> from "Tom Rini" at Aug 06, 2001 10:03:19 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:
> On Mon, Aug 06, 2001 at 12:19:10PM -0400, Albert D. Cahalan wrote:

>> This is the Force PowerCore 6750 single-board computer with
>> a PowerPC processor and the DEC 21143 Ethernet chip.
>
> Just wondering, but when booting 2.4.x, do you see something like:
> "Unknown bridge resource %d: assuming transparent"
> for the tulip?

Nope. The closest is "Memory resource not set for host bridge 0".

This is the VME 6750 BTW, not the CompactPCI 6750.
I'll put my IRQ table adjustments below, in case they are wrong.

Right now, a 2.4.8-pre4 boot gives this:

ip_conntrack (2048 buckets, 16384 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.16.101.112
eth0: Setting half-duplex based on MII#1 link partner capability of 0021.
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out

That "eth0: Setting half-duplex" line doesn't show if I use the
other driver or forget to adjust the IRQ mappings; the rest is
the same no matter what.


        static char pci_irq_table[][4] =
        /*
         *      PCI IDSEL/INTPIN->INTLINE
         *      A       B       C       D
         */
        {
                {11,    14,     5,      10},    /* IDSEL 24 - Universe II */
                {0,     0,      0,      0},     /* IDSEL 25 - unused */
                {10,    11,     14,     5},     /* IDSEL 26 - Winbond */
                {10,    11,     14,     5},     /* IDSEL 27 - DEC 21143 */
                {14,    5,      10,     11},    /* IDSEL 28 - PMC I */
                {11,    14,     5,      10},    /* IDSEL 29 - PMC II */
                {0,     0,      0,      0},     /* IDSEL 30 - unused */
#if 0
                {9,     10,     11,     12},    /* IDSEL 24 - DEC 21554 */
                {10,    0,      0,      0},     /* IDSEL 25 - DEC 21143 */
                {11,    12,     9,      10},    /* IDSEL 26 - PMC I */
                {12,    9,      10,     11},    /* IDSEL 27 - PMC II */
                {0,     0,      0,      0},     /* IDSEL 28 - unused */
                {0,     0,      9,      0},     /* IDSEL 29 - unused */
                {0,     0,      0,      0},     /* IDSEL 30 - Winbond */
#endif
                };
