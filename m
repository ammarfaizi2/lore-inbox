Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129537AbRBYSj6>; Sun, 25 Feb 2001 13:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBYSji>; Sun, 25 Feb 2001 13:39:38 -0500
Received: from toscano.org ([64.50.191.142]:13042 "HELO bubba.toscano.org")
	by vger.kernel.org with SMTP id <S129534AbRBYSjR>;
	Sun, 25 Feb 2001 13:39:17 -0500
Date: Sun, 25 Feb 2001 13:39:16 -0500
From: Pete Toscano <pete.lkml@toscano.org>
To: linux-kernel@vger.kernel.org
Subject: Mysterious lockups with 2.4.X (Help w/KDB)
Message-ID: <20010225133916.A1329@bubba.toscano.org>
Mail-Followup-To: Pete Toscano <pete.lkml@toscano.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Unexpected: The Spanish Inquisition
X-Uptime: 12:46pm  up 17 min,  4 users,  load average: 0.08, 0.30, 0.25
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I've been experiencing some strange lock ups and I hope someone can
help.  I don't remember exactly when they started, but I know it was
happening around the release of 2.4.0, possibly earlier with the test
2.4.0 kernels too.  Around 2.4.0 time, I started patching in KDB to help
find the problem as it helped find an emu10k issue a while ago.

First, my hardware:
I'm using a Tyan Tiger 133a motherboard (Via Apollo Pro 133a chipset)
with dual P3 600s, 512M RAM, Soundblaster Live, Matrox G[24]00 (was
using the G400, had a hardware problem, went back to a G200), Promise
Ultra66 PCI IDE card, ADS Tech IEEE 1394 PCI card, Adaptec 2940 PCI SCSI
card, and a Linksys 10/100 NIC.  I'm also using a few USB devices: USB
mouse, USB compact flash reader, and USB Rio500.  Because of the
continuing problems with PCI routing, SMP-enabled kernels, and the Via's
APIC, I need to disable APIC (with "noapic") when I boot if I wish to
use my USB devices.  Finally, I have a serial console hooked to this
machine so that I can capture dump info and use KDB.

When I get a crash (it happened 3 times yesterday), a message like this
appears on the serial console:

Unable to handle kernel NULL pointer dereference at virtual address 0000017c
 printing eip:
e08ac8bd
*pde =3D 00000000

Entering kdb (current=3D0xc7dbe000, pid 2513) on processor 0 Panic: Oops
due to panic @ 0xe08ac8bd
eax =3D 0xce39a400 ebx =3D 0x00000000 ecx =3D 0x0000000f edx =3D 0xc02daba0=
=20
esi =3D 0x00000282 edi =3D 0x00000000 esp =3D 0xc7dbff5c eip =3D 0xe08ac8bd=
=20
ebp =3D 0xc7dbff68 xss =3D 0x00000018 xcs =3D 0x00000010 eflags =3D 0x00010=
082=20
xds =3D 0xc02d0018 xes =3D 0x00000018 origeax =3D 0xffffffff &regs =3D 0xc7=
dbff28

and then the KDB prompt appears.  Back when I had my emu10k problems,
Keith Owen told me to (in a nutshell), go through the running processes
and "btp" their PID and look for "text.lock".  Back then, I'd eventually
find the process with the "text.lock", gather some more information, and
send it to this list where somebody would almost always be able to tell
me what the problem is.

Needless to say, I'd like to be able to do this again, but I can't find
any process with "text.lock".  When the crashes would first happen, I'd
go through the whole process table looking for the "text.lock" and not
find any.  This could take quite a while, but I'd repeat it thinking I
was missing something somewhere, but after doing this a few times, I
started to realize that it might not be me.

Another thing I noticed the last time I tried to use KDB to hunt down a
problem was that the process with "text.lock" would usually be the
process marked with a 1 in the "*" column of the process list.  This
time, though, I'm still finding only on process marked with a 1 in the
"*" column (klogd), but there's no "text.lock".

Finally, if I run what's dumped to the console (like what I showed
above) through ksymoops, it just returns the same text with no further
expansion.  (I guess this would make sense since "oops" never appears in
the text of my dump, so I guess it's not an oops, eh?)

Anyway, I'd like to try to track this bug down further -- it's making me
pull out what little hair I have =3D) -- but I don't know what to do next,
so I implore you, o great kernel hackers, to impart some of your
knowledge upon me so that I may debug too.  Any tips would be good too.
=3D;]

FWIW, I'm running 2.4.2 with the KDB patch, modutils-2.4.2, binutils
2.10.0.33, util-linux 2.10s, e2fsprogs 1.19, GNU make 3.79, and RedHat's
kgcc (egcs 2.91.66).

thanks,
pete

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6mVFUsMikd2rK89sRAiZEAJ9R1doQgd1BjvIJ/2M4SiEY34Ut7wCdH1kG
EaS9xygndvDRixHc8+ofQsE=
=+YDt
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
