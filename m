Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263746AbRFNVbC>; Thu, 14 Jun 2001 17:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264008AbRFNVaw>; Thu, 14 Jun 2001 17:30:52 -0400
Received: from smtp-rt-13.wanadoo.fr ([193.252.19.223]:36280 "EHLO
	oxera.wanadoo.fr") by vger.kernel.org with ESMTP id <S263746AbRFNVaq>;
	Thu, 14 Jun 2001 17:30:46 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Tom Gall <tom_gall@vnet.ibm.com>
Subject: Re: Going beyond 256 PCI buses
Date: Thu, 14 Jun 2001 23:30:21 +0200
Message-Id: <20010614213021.3814@smtp.wanadoo.fr>
In-Reply-To: <15145.6960.267459.725096@pizda.ninka.net>
In-Reply-To: <15145.6960.267459.725096@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Bus 0 is controller 0, of whatever bus type that happens to be.
>If we want to do something special we could create something
>like /proc/bus/root or whatever, but I feel this unnecessary.

<old rant>

Mostly, except for one thing: legacy devices expecting ISA-like
ops on a given domain which currently need some way to know
what PCI bus hold the ISA bus. 

While we are at it, I'd be really glad if we could agree on a
way to abstract the current PIO scheme to understand the fact
that any domain can actually have "legacy ISA-like" devices.

One example is that any domain can have a VGA controller that
requires a bit of legacy PIO & ISA-mem stuff. In the same vein,
any domain can have an ISA-bridge used to wired 16bits devices

Another example is an embedded device which could use the
domain abstraction to represent different IO busses on which
old-style 16bits chips are wired.

I beleive there will always be need for some platform specific
hacking at probe-time to handle those, but we can at least make
the inx/outx functions/macros compatible with such a scheme,
possibly by requesting an ioremap equivalent to be done so that
we stop passing them real PIO addresses, but a cookie obtained
in various platform specific ways.

For the case of PCI (which would handle both the VGA case and
the multiple PCI<->ISA bridge case), one possibility is to
provide a function returning resources for the "legacy" PIO
and MMIO regions if any on a given domain. This is especially
true for ISA-memory (used mostly for VGA) as host controllers
for non-x86 platforms usually have a special window somewhere
in the bus space for generating <64k mem cycles on the PCI bus.

</old rant>

Ben.


