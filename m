Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290523AbSAYD3R>; Thu, 24 Jan 2002 22:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290527AbSAYD3I>; Thu, 24 Jan 2002 22:29:08 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:20973 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S290523AbSAYD3E>; Thu, 24 Jan 2002 22:29:04 -0500
Date: Thu, 24 Jan 2002 22:28:57 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: usb or video4linux problem
Message-ID: <20020125032857.GA671@online.fr>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: debian SID Gnu/Linux 2.4.17 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I send a mail few days ago about a problem with a usb webcam (Dlink
DCS100). I see the same thing with various webcam apps (gnomemeeting,
gqcam, camstream, xawtv, ...). So clearly it's not a user-level problem.
It can be a hardware one but i'm convinced it is not (or in the OHCI
chip in my toshiba satellite 2520cds).

With all app I can see the stream but suddenly it freezes.
Because of the following output from xawtv when the problem occurs:

v4l: timeout (got SIGALRM), hardware/driver problems?
ioctl: VIDIOCSYNC(0): Appel syst=E8me interrompu

I have checked out the code and the interesting part in drv1-v4l.c is :

    alarms=3D0;
    alarm(SYNC_TIMEOUT);

 retry:
    if (-1 =3D=3D (rc =3D xioctl(h->fd,VIDIOCSYNC,h->buf_v4l+frame))) {
   if (errno =3D=3D EINTR && !alarms)
       goto retry;
    }

=46rom which I conclude that SYNC_TIMEOUT could be to small. The value is
3 secondes which seems to be quite enough. To be sure I've tried with 30
and got the same thing.

So It's a justified timeout because the nextframe will never be there.
usbview sees the webcam before and after the problem.
Restarting the app is enough to get the stream.=20

I'm convinced that it's a problem with OHCI.
I think it's a soft problem because I can trigger it with cpu/io
activity.

What can I do to go further ?

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

People that hate cats will come back as mice in their next life.
--Faith Resnick

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8UND5j0UvHtcstB4RAjRgAJ4qZ6pHU+AQ1XEdRRLKPrGfyp+H0gCcD27e
2gXotpF477uUZqexSCV48KQ=
=cawO
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
