Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132246AbRCWAIT>; Thu, 22 Mar 2001 19:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132245AbRCWAHl>; Thu, 22 Mar 2001 19:07:41 -0500
Received: from [149.225.157.39] ([149.225.157.39]:63752 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id <S132246AbRCWADt>; Thu, 22 Mar 2001 19:03:49 -0500
Date: Fri, 23 Mar 2001 00:02:16 +0000
From: Thorsten Kranzkowski <th@Marvin.DL8BCU.ampr.org>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: serial driver question
Message-ID: <20010323000215.A15058@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@gmx.net
Mail-Followup-To: John Covici <covici@ccs.covici.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3ae6dpflj.fsf@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <m3ae6dpflj.fsf@ccs.covici.com>; from covici@ccs.covici.com on Thu, Mar 22, 2001 at 06:07:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 06:07:52PM -0500, John Covici wrote:
> I have been wondering about the serial drivers shared irq
> configuration parameter.  Will it allow two dumb serial ports which
> know nothing about sharing irq's to actually share the same irq, or

no.

> does the actual hardware have to support some kind of irq sharing for
> this to work?

yes.

For one there are multiport serial cards that combine every ports' irq
into one.

PCI cards should also be able to share their irqs (with other PCI cards).

But you can't share an ISA irq with a PCI one.

And you can't share one ISA card's irq with another ISA one nor the irqs of
a dumb ISA multiport card either ...
... without some modification, that is ;-)

Imagine the situation on a typical ISA card:

                   Card              ISA     Mainboard
                                  connector

-------+                              "      | to other ISA connectors
       |               Jumper         "      |
  IC   |-------------+--*=*-----------"------+
       |             |                "      |
-------+             +--* *------     "      | to IRQ-Controller-IC
                     |                "
                     +--* *------


Now replace the jumper for each irq sharing device with a diode and add one
resistor to the irq line:

-------+                    Diode     "      | to other ISA connectors
       |               e.g. 1n4148    "      |
  IC   |-------------+--*=*--|>|---+--"------+
       |             |      A   K  |  "      |
-------+             +--* *---     |  "      | to IRQ-Controller-IC
                     |             #  "
                     +--* *---     # Resistor 20kOhm
                                   #
                                   |
                                 __|__ GND

So for 4 serial ports sharing a single irq line you wuld use 4 diodes and 
1 resistor.


> I did try two ports on the same irq, but one of them isn't seem at all
> by Linux, so I am quite curious whether I am barking up the wrong
> line?

It should be seen. You won't be able to use them effectively (they'll be
transmitting only about 16 bytes every 30 seconds or something) but they
should definitively be detected both.
Did you use setserial to convince the kernel of their presence?

> 
> Thanks.
> 

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@gmx.net                        |
| Mobile: ++49 170 1876134       Snail: Niemannsweg 30, 49201 Dissen, Germany |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
