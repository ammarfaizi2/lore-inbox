Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267946AbUH2OiE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbUH2OiE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267992AbUH2Ohz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:37:55 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:18626 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S267973AbUH2ObG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:31:06 -0400
Subject: Re: Possible dcache BUG [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: gene.heskett@verizon.net
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tom Vier <tmv@comcast.net>
In-Reply-To: <200408290948.47890.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	 <20040825014937.GC15901@zero>
	 <200408250913.23840.vda@port.imtp.ilyichevsk.odessa.ua>
	 <200408290948.47890.gene.heskett@verizon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7A5F8jhrnOWKdCg3jqG2"
Message-Id: <1093790088.27951.29.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 16:34:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7A5F8jhrnOWKdCg3jqG2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-29 at 15:48, Gene Heskett wrote:

> I think, based on the last 25 hours of running both memburn and=20
> setiathome at a -nice 19, and there have been no errors, that I might=20
> have stumbled onto a fix.
>=20
> It seems the dram is marked DDR400, so I was trying to run it that=20
> way.  Unforch, on checking the invoice for the umpteenth time, it=20
> finally dawned on me that this particular AMD 2800XP is supposedly a=20
> 333mhz FSB chip, and not rated for use with DDR400 memory.  Switching=20
> the bios setting for the memory to 'auto' from 'spd' seems to effect=20
> this particular item, and the memory now signs in as DDR333 Dual=20
> Channel.
>=20
> And after 25 hours, no errors, nothing unusual in the logs.
>=20

I work for a supplier here in ZA, and out of experience memory
compatibility can be a vast gray area.

For instance:
1) You have exactly the same Chipset (say nforce2 400's or whatever),
   but different vendors that assembles the board (say Asus/MSI and
   Gigabyte).  You take PC3200 CL3 sticks, and they work fine on the
   Asus and MSI, but dont work on the Gigabyte (only one of the long
   list of memory issues Gigabyte boards have - in my experience). It
   has a lot to do with how the vendor does the timings, etc.
2) You have 4 sticks of Hynix memory, all for have the exact chips on.
   Two have the older pcboard layout, and the other two have the newer.
   The older ones give intermittant issues on D865GBR (Bayfield boards -
   cant remember the exact code) if you try to run them in dual channel
   mode, but works fine with only one stick.  The board works fine in
   dual channel mode with the new revision pcb sticks.
3) P4 SiS chipsets have a bad habit of only running two sticks together
   (non-dual channel chipsets ... 645, 650, 651, with identical sticks)
   if you clock the memory down to to the bus of the cpu (400mhz cpu
   only runs fine with memory at 200 fsb, and 533 with memory at 266 -
   remember, its the true speed of the cpu/memory, not the '4x pumped'
   one Intel likes to advertise with, or the 'double data rate' speed
   memory is advertised with).  With a single chip, it usually runs fine
   at 333mhz on 533mhz fsb cpu - cant remember with 400mhz cpu.


That was just some examples to show that vendor/revision/config can make
a huge difference, and lots of headaces.  In your case, here is a few
points you could look at.

In general the boards I worked with, worked fine with a 333fsb cpu,
running memory at 400mhz.  Last I checked, this might be issues:
1) All nforce2 chipsets had a certain errata that caused timing issues
   with ddr400 memory with a CL latency of 2.  You had to tipically
   downclock the memory to 333mhz, or set the CL latency up to 2.5 or
   3. Good example is the popular Kingston Hyper-X sticks.  I am not
   sure if they might have sorted it out on later chipsets.
2) Hynix memory tipically did not work too great, especially in dual
   channel mode.  The best memory to use was usually the Samsung PC3200
   CL3 ones if you did not want to fork too much (except if you had some
   of the Gigabyte boards customers brought to us when they only got the
   memory from us - do they ever learn not to shop around if it comes to
   board and memory?)
3) *sometimes* a bios update did help.


Anyhow, just a few things I ran into that you might have a look at -
sorry its a bit late in this thread.


--=20
Martin Schlemmer

--=-7A5F8jhrnOWKdCg3jqG2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBMemIqburzKaJYLYRAhlwAJ46VC2RT0oWkUGJiY6wj6tyX/qhnACdFoZT
EGsLZgJ6wwr2k/LwbpPTzaA=
=jBtL
-----END PGP SIGNATURE-----

--=-7A5F8jhrnOWKdCg3jqG2--

