Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967717AbWK3A0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967717AbWK3A0H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 19:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967722AbWK3A0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 19:26:07 -0500
Received: from os.inf.tu-dresden.de ([141.76.48.99]:9366 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S967717AbWK3A0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 19:26:05 -0500
Date: Thu, 30 Nov 2006 01:26:00 +0100
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.19
Message-ID: <20061130012600.0dcb1337@laptop.hypervisor.org>
In-Reply-To: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
References: <Pine.LNX.4.64.0611291411300.3513@woody.osdl.org>
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_lNHeAuU2SpU9h3j26PeBDj+;
 protocol="application/pgp-signature"; micalg=PGP-SHA1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_lNHeAuU2SpU9h3j26PeBDj+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 29 Nov 2006 14:21:21 -0800 (PST) Linus Torvalds (LT) wrote:

LT> So go get it. It's one of those rare "perfect" kernels. So if it doesn'=
t=20
LT> happen to compile with your config (or it does compile, but then does=20
LT> unspeakable acts of perversion with your pet dachshund), you can rest e=
asy=20
LT> knowing that it's all your own d*mn fault, and you should just fix your=
=20
LT> evil ways.

Ok, so 2.6.18 used to get along fine with cryptoloop and 2.6.19 refuses to
cooperate. An strace of "losetup -e aes /dev/loop0 /dev/hda7" without all t=
he
terminal interaction shows:

open("/dev/hda7", O_RDWR|O_LARGEFILE)   =3D 3
open("/dev/loop0", O_RDWR|O_LARGEFILE)  =3D 4
mlockall(MCL_CURRENT|MCL_FUTURE)        =3D 0
...
munmap(0xb7fc8000, 4096)                =3D 0
ioctl(4, 0x4c00, 0x3)                   =3D 0
close(3)                                =3D 0
ioctl(4, 0x4c04, 0xbfc21670)            =3D -1 ENOENT (No such file or dire=
ctory)
ioctl(4, 0x4c02, 0xbfc215e0)            =3D -1 ENOENT (No such file or dire=
ctory)
dup(2)                                  =3D 3
fcntl64(3, F_GETFL)                     =3D 0x8002 (flags O_RDWR|O_LARGEFIL=
E)
fstat64(3, {st_mode=3DS_IFCHR|0720, st_rdev=3Dmakedev(4, 1), ...}) =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}=
) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0xb7fc8000
_llseek(3, 0, 0xbfc21040, SEEK_CUR)     =3D -1 ESPIPE (Illegal seek)
write(3, "ioctl: LOOP_SET_STATUS: No such "..., 50ioctl: LOOP_SET_STATUS: N=
o such file or directory) =3D 50
close(3)                                =3D 0
munmap(0xb7fc8000, 4096)                =3D 0
ioctl(4, 0x4c01, 0)                     =3D 0
close(4)                                =3D 0
exit_group(1)                           =3D ?

Linux 2.6.18 does not fail at

	ioctl(4, 0x4c04, ...)

I know that dm-crypt is now the preferred method of doing such things, but =
as
long as cryptoloop exists in the kernel I'd expect it to work.

Cheers,
	- Udo

--Sig_lNHeAuU2SpU9h3j26PeBDj+
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFbiUbnhRzXSM7nSkRAhTHAJ4rkooLVFko48Bg0gdYTDIRN9rx8ACcCqCz
xE6c+0RcmJN9LJfY+9+Geao=
=sZww
-----END PGP SIGNATURE-----

--Sig_lNHeAuU2SpU9h3j26PeBDj+--
