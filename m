Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRHFH4T>; Mon, 6 Aug 2001 03:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267419AbRHFH4K>; Mon, 6 Aug 2001 03:56:10 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:27283 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S267418AbRHFHz7>;
	Mon, 6 Aug 2001 03:55:59 -0400
Date: Mon, 6 Aug 2001 09:56:38 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Felix von Leitner <leitner@fefe.de>
Subject: kernel headers & userland
Message-ID: <20010806095638.A5638@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Felix von Leitner <leitner@fefe.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 9:43am  up 12 days, 22 min,  2 users,  load average: 0.00, 0.00, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Apparently Linus told Felix von Leitner (the author of dietlibc - a small,
no nonsense glibc replacement C library) a while ago _not_ to include any
linux kernel headers in userland (i.e. the C library headers in this case).

This imho is obviously wrong since there are definitely a need for including
kernel headers on a linux platform.

Just the basic stuff for instance:

keyboard: sys/kd.h - needs linux/kd.h
sound: sys/soundcard.h - need linux/soundcard.h
sysctl: sys/sysctl.h - need linux/sysctl.h
vt: sys/vt.h - need linux/vt.h

and so on. Then there's the whole sys/types.h issue which needs
linux/types.h, etc.

Even if you go through the trouble of making a generic sys/types.h and
carefully avoid kernel headers by not defining things like sys/soundcard.h
at all (boy, is this going to break things), you are going to run into lots
of trouble when applications include kernel headers on their own and your
headers (duplicate type definitions - you can hack this that linux kernel
headers override this, but it's a nightmare to manage).

Now, you may argue that userland apps should not include linux kernel
headers either, but sometimes it does. Just look at all userland apps that
needs to interface with kernel subsystems such as v4l, mtd, oss, etc.

Then there's all the ioctl() definitions (e.g. ioctl()'s for ext2, keyboard
leds, etc.)

In short, there is simply too many things that will break if you don't
include linux kernel headers in the C library headers (just look at glibc
for instance).

--=20

Regards
 Abraham

Iron Law of Distribution:
	Them that has, gets.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bk22zNXhP0RCUqMRAplzAKCN9BNDIdqC+emUvFmRoEVt43VksACggJvM
HB1ptoC/mGnyAVaM/3WIXsM=
=IaLL
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
