Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLSMHN>; Tue, 19 Dec 2000 07:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLSMHC>; Tue, 19 Dec 2000 07:07:02 -0500
Received: from Cantor.suse.de ([194.112.123.193]:13331 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129289AbQLSMGz>;
	Tue, 19 Dec 2000 07:06:55 -0500
Date: Tue, 19 Dec 2000 12:34:15 +0100
From: Kurt Garloff <garloff@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Miquel van Smoorenburg <miquels@cistron.nl>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: TIOCGDEV ioctl
Message-ID: <20001219123415.O17777@garloff.suse.de>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Alexander Viro <viro@math.psu.edu>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001216124011.A14129@cistron.nl> <Pine.GSO.4.21.0012160652150.15518-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0012160652150.15518-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Dec 16, 2000 at 06:57:20AM -0500
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2000 at 06:57:20AM -0500, Alexander Viro wrote:
> On Sat, 16 Dec 2000, Miquel van Smoorenburg wrote:
> > According to Alexander Viro:
> > > OK, I can see the point of finding out where the console is redirected
> > > to. How about the following:
> > >=20
> > > 	/proc/sys/vc -> /dev/tty<n>
> > > 	/proc/sys/console -> where the hell did we redirect it or
> > > 			     vc if there's no redirect right now
> > > Will that be OK with you?
> >=20
> > Well, I'd prefer the ioctl, but I can see the general direction the
> > kernel is heading to: get rid of numeric ioctls and sysctl()s and
> > put all that info under /proc.

Yes; it looks nicer not to grow the number of ioctls more and more,
but to make things more visible in /proc.

On the other hand, there are some advantages of the ioctl:
It's fast, easy and does not need /proc. That cab be of relevance
for embedded devices, e.g., where ram is short.

> Huh? Oh, sorry. /proc/tty, indeed - it was a braino. BTW, I think
> that a mini-fs with a device node for each registered console +
> symlink (say it, "default") pointing to the default one might make
> sense too. Comments?

Yes, looks like a good solution to me.
But that's far more complicated than the ioctl.

Looking at the sources and starting to write some code, it's not so obvious
to me how to get the right device no all the time and how to create the
correct symlink also in 2.2. Yes, it needs to work on both 2.2 and 2.4=20
kernels.

So, I'd like to ask for inclusion of the original patch.
Or can we come up with the /proc/tty solution without adding too much code?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6P0e3xmLh6hyYd04RAv8BAKCZpoVfKI/62EB1Z8VX96xq4pPpmgCfVsj5
X1N+YORFWpihJcxbotdDA5Q=
=sSfb
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
