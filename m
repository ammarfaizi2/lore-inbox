Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFTRww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTFTRww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:52:52 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27148 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263722AbTFTRws
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:52:48 -0400
Date: Fri, 20 Jun 2003 14:00:14 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrey Panin <pazke@donpac.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
In-Reply-To: <20030620061020.GC786@pazke>
Message-ID: <Pine.LNX.3.96.1030620135641.17926A-101000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/SIGNED; MICALG=pgp-sha1; PROTOCOL="application/pgp-signature"; BOUNDARY=jousvV0MzM2p6OtC
Content-ID: <Pine.LNX.3.96.1030620135641.17926B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--jousvV0MzM2p6OtC
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-ID: <Pine.LNX.3.96.1030620135641.17926C@gatekeeper.tmr.com>

On Fri, 20 Jun 2003, Andrey Panin wrote:

> On 171, 06 20, 2003 at 06:55:47AM +0100, Russell King wrote:
> > On Thu, Jun 19, 2003 at 11:42:49PM +0000, Adam Belay wrote:
> > > I removed avoid_irq_share because the current pnp code, like the previous, does 
> > > not allow irq sharing.  Also it corrupts the device rule structure by replacing 
> > > it with modified values that may not apply after devices are disabled etc.
> > > Is there a set of conditions I could follow to determine if a serial pnp device 
> > > is capable of irq sharing, and also with which other devices can a capable 
> > > device share an irq?  If so, I could have the resource manager handle this type 
> > > of situation when few irqs are available.
> > 
> > The problem is one of a lack of historical information on why it was
> > added.  The driver itself allows serial ports to share interrupts between
> > themselves.  Maybe tytso knows why the "Rockwell 56K ACF II Fax+Data+Voice
> > Modem" is unable to share IRQs?
> 
> It was me who added this crappy quirk.
> 
> My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+Voice Modem"
> was going mad when its IRQ was shared with any device. So I decided to add this
> quirk.
> 
> Personally I think that ISA IRQ sharing should be absolutely last resort technic,
> because ISA bus was never designed to support IRQ sharing sanely. If you have to
> enable ISA PnP device and do not have enough IRQ, you must print BIG FAT WARNING
> before doing this. May be kernel config options must be added for brave guys
> wanting to use ISA IRQ sharing.

But dumb multiport boards support sharing just fine:

0: uart:16550A port:3F8 irq:4 baud:1200 tx:6 rx:9587 RTS|CTS|DTR|DSR
1: uart:16550A port:2F8 irq:3 baud:9600 tx:9 rx:2 brk:2 
2: uart:unknown port:3E8 irq:4
3: uart:unknown port:2E8 irq:3
4: uart:16550A port:1A0 irq:5 baud:9600 tx:0 rx:0 CTS
5: uart:16550A port:1A8 irq:5 baud:9600 tx:0 rx:0 
6: uart:16550A port:1B0 irq:5 baud:9600 tx:0 rx:0 
7: uart:16550A port:1B8 irq:5 baud:9600 tx:0 rx:0 

There's more to it than just "it doesn't work." I note that 2.5.70 still
sets the NIC and AHA1540 to the same irq, while 2.4.18 doesn't. I gave up
on that, I can't change the hardware (specialty hardware) so I run 2.4
kernels. Someday I'll fight with it.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--jousvV0MzM2p6OtC
Content-Type: APPLICATION/PGP-SIGNATURE
Content-ID: <Pine.LNX.3.96.1030620135641.17926D@gatekeeper.tmr.com>
Content-Description: 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8qVMby9O0+A2ZecRAjOuAJ926pSMLYzKylHPYcKJmu9Dgg0eKgCgzqc/
RmB9Oj9W9Vj9M+G5nTJ8Fhc=
=mHO7
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
