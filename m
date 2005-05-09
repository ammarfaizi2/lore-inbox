Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbVEINRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbVEINRs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 09:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVEINRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 09:17:48 -0400
Received: from imap.gmx.net ([213.165.64.20]:54736 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261359AbVEINRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 09:17:44 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: suse-amd64@suse.com
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Mon, 9 May 2005 15:17:24 +0200
User-Agent: KMail/1.8
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <20050508134035.GC15724@wotan.suse.de> <200505091253.21252.bernd.paysan@gmx.de>
In-Reply-To: <200505091253.21252.bernd.paysan@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1767371.bq4UhXEzDv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200505091517.30555.bernd.paysan@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1767371.bq4UhXEzDv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 09 May 2005 12:53, Bernd Paysan wrote:
> On Sunday 08 May 2005 15:40, Andi Kleen wrote:
> > Your system should be using the HPET timer to work exactly around
> > this. AMD 8000 has HPET. Can you post a boot.log?
>
> Ok, boot.log attached. The only entry with hpet seems to indicate some
> problems.

I went through the BIOS setup, and found a disabled feature "ACPI 2.0",=20
which I enabled. Now Linux finds the HPET timer.

# grep -i hpet boot.log=20
ACPI: HPET (v001 A M I  OEMHPET  0x04000518 MSFT 0x00000097) @=20
0x00000000e8ff3c30
ACPI: HPET id: 0x102282a0 base: 0xfec01000
time.c: Using 14.318180 MHz HPET timer.
time.c: Using HPET based timekeeping.
hpet0: at MMIO 0xfec01000, IRQs 2, 8, 0
hpet0: 69ns tick, 3 32-bit timers
hpet_acpi_add: no address or irqs in _CRS

and everything appears to work (though there's still no designated CPU to=20
handle the timer interrupts). xntpd syncs quickly, I'm happy (so far ;-).

So that explains why nobody sees this problem. But the TSC-based fallback=20
timekeeping is still broken on SMP systems with PowerNow and distributed=20
IRQ handling, which both together seem to be rare enough ;-).

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--nextPart1767371.bq4UhXEzDv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCf2Lqi4ILt2cAfDARAiE+AJ4lz7bp7c/vhGrfiU1cp6DJyuFx1wCdGDG5
zXJwO4stGoZXM3Jx+N8T3Po=
=3SWB
-----END PGP SIGNATURE-----

--nextPart1767371.bq4UhXEzDv--
