Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132003AbRCVMFc>; Thu, 22 Mar 2001 07:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132004AbRCVMF1>; Thu, 22 Mar 2001 07:05:27 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:23376 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132003AbRCVMEx>; Thu, 22 Mar 2001 07:04:53 -0500
Date: Thu, 22 Mar 2001 13:00:29 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SMP on assym. x86
Message-ID: <20010322130029.A4212@garloff.casa-etp.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10103211122500.10337-100000@coffee.psychology.mcmaster.ca> <E14fsET-0001Mg-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14fsET-0001Mg-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Mar 21, 2001 at 11:41:33PM +0000
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2001 at 11:41:33PM +0000, Alan Cox wrote:
> > > handle the situation with 2 different CPUs (AMP =3D Assymmetric
> > > multiprocessing ;-) correctly.
> >=20
> > "correctly".  Intel doesn't support this (mis)configuration:
> > especially with different steppings, not to mention models.

I wouldn't call it misconfiguration, just because it's a bit more difficult
to handle.
On the iontel side: You should watch out for matching APICs, voltages and
cache coherency (MESI) protocol. Actually, Deschutes and Coppermine just
work fine in spite of slightly different voltage.

> Actually for a lot of cases its quite legal.

It should be always legal to have the same CPU with different speeds. (FSB
must be the same for obvious reasons), e.g.. The TSC part of the patch
addresses this.

> > Alan has, or is working on, a workaround to handle differing=20
> > multipliers by turning off the use of RDTSC.  this is the right approac=
h=20
> > to take in the kernel: disable features not shared by both processors,=
=20
> > so correctly-configured machines are not penalized.=20

TSC is supported by both CPUs ... so why not use the nice rdtsc based time
routine.
The penalty:
It is 5 (20 bytes) ints more in the struct cpuinfo_x86, so you have
a kernel with (NR_CPUS*20 - 12) =3D 628 bytes more kernel data ...
Your bootup time may be a fraction of a second longer, as every CPU
calibrates the TSC on its own; OTOH they do it in parallel ...
The timer interrupt does an extra copy of xtime (2 ints) to the to the per
CPU struct. And one extra indirection for accessing the per CPU struct.
Something like 4 CPU cycles per timer interrupt.
gettimeofday() also has this extra indirection; OTOH not accessing global
data saves a cache line flush the next time the structure is written to ...
So this is probably a net cost of zero.

> > and the kernel should LOUDLY WARN ABOUT this stuff on boot.
>=20
> I've been working on reading the multipliers directly from the MSR 0x2A d=
ata,
> Kurt is redoing the timing each run - possibly thats not so clean but its=
=20
> more robust.
>=20
> I rather like Kurt's patch

Thx!=20
If you have some requests to make it suitable for -ac kernels, I'll do my
best.

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>   [SuSE Nuernberg, FRG]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6uelcxmLh6hyYd04RAnLPAKDSbS0UM+ty0aDs1h370/7jQDF1jwCgtXk/
gwJYx8b0WbqgQYeLRp09M/0=
=FhoH
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
