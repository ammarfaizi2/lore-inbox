Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265229AbTFURnV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265234AbTFURnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 13:43:21 -0400
Received: from pD9532908.dip.t-dialin.net ([217.83.41.8]:35589 "EHLO
	Marvin.DL8BCU.ampr.org") by vger.kernel.org with ESMTP
	id S265229AbTFURnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 13:43:19 -0400
Date: Sat, 21 Jun 2003 17:53:59 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030621175358.A2848@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Andrey Panin <pazke@donpac.ru>, linux-kernel@vger.kernel.org
References: <20030620061020.GC786@pazke> <Pine.LNX.3.96.1030620135641.17926A-101000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.3.96.1030620135641.17926A-101000@gatekeeper.tmr.com>; from davidsen@tmr.com on Fri, Jun 20, 2003 at 02:00:14PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 02:00:14PM -0400, Bill Davidsen wrote:
> On Fri, 20 Jun 2003, Andrey Panin wrote:
> 
> > On 171, 06 20, 2003 at 06:55:47AM +0100, Russell King wrote:
> > > The problem is one of a lack of historical information on why it was
> > > added.  The driver itself allows serial ports to share interrupts between
> > > themselves.  Maybe tytso knows why the "Rockwell 56K ACF II Fax+Data+Voice
> > > Modem" is unable to share IRQs?
> > 
> > It was me who added this crappy quirk.
> > 
> > My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+Voice Modem"
> > was going mad when its IRQ was shared with any device. So I decided to add this
> > quirk.
> > 
> > Personally I think that ISA IRQ sharing should be absolutely last resort technic,
> > because ISA bus was never designed to support IRQ sharing sanely. If you have to
> > enable ISA PnP device and do not have enough IRQ, you must print BIG FAT WARNING
> > before doing this. May be kernel config options must be added for brave guys
> > wanting to use ISA IRQ sharing.

Problem is, 'unprepared' ISA cards are electrically unable to share interrupts 
(like in: an interrupting card cant't drive the interrupt line high while at 
the same time another one actively drives it at a low level). You _can_ make 
things work when you replace the IRQ-selection-jumper on all sharing devices 
with a diode and add a pull down resistor.  BTDT - works sufficiently well.

> But dumb multiport boards support sharing just fine:

Yes, they usually contain the necessary sharing circuity onboard. But you 
can't share them with other instances of the same or other cards unless you 
make the modifications above.

Unfortunately on-board serial ports seldom have IRQ-jumpers - which makes them 
practically not shareable at all.

And for PNP devices, well they also don't have jumpers. It is possible
to find the necessary wires on the pcb though ..... ;-) 

Bye,
Thorsten

-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
