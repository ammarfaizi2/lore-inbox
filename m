Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261929AbTC0LE4>; Thu, 27 Mar 2003 06:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261930AbTC0LE4>; Thu, 27 Mar 2003 06:04:56 -0500
Received: from netmail02.services.quay.plus.net ([212.159.14.221]:17137 "HELO
	netmail02.services.quay.plus.net") by vger.kernel.org with SMTP
	id <S261929AbTC0LEy>; Thu, 27 Mar 2003 06:04:54 -0500
Date: Thu, 27 Mar 2003 11:16:00 +0000
From: Chris Sykes <chris@sigsegv.plus.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at sched.c:564! (2.4.20, 2.4.21-pre5-ac3)
Message-ID: <20030327111600.GI2695@spackhandychoptubes.co.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030326162538.GG2695@spackhandychoptubes.co.uk> <20030326185236.GE24689@kroah.com> <20030326192520.GH2695@spackhandychoptubes.co.uk> <20030326193437.GI24689@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <20030326193437.GI24689@kroah.com>
User-Agent: Mutt/1.4i
x-gpg-fingerprint: 1D0A 139D DDA3 F02F 6FC0  B2CA CBC6 5EC0 540A F377
x-gpg-key: wwwkeys.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2003 at 11:34:37AM -0800, Greg KH wrote:
> > Anyway I'll test out a 2.5 kernel when I'm back in the office
> > tomorrow, I can devote some time to tracking down the problem if you
> > can give me some pointers on where to start.  I'd like to be able to
> > feel confident that this will work reliably under 2.4, otherwise I
> > guess I need to look for alternate solutions.
>=20
> The problem is in the race on close() in the usb-serial.c code.  In 2.5
> that logic has been rewritten to (hopefully) get rid of the race.  That
> is what will need to be backported, once people test that this fixes the
> issue.

OK.  2.5.66 compiled and booted.

I've jumpered the hardware back to how it was originally when I
experienced the problem.
I've been working happily for about 10 mins with:

while /bin/true; do
        for i in *; do
                cat $i >/dev/ttyUSB0
        done
done

No Oopsen or errors in dmesg as yet. (Before I was getting many errors
about 0 size writes).

I can keep working under 2.5.66 for now to see if I experience any
problems, but it would appear that the race is gone in 2.5.66
(CONFIG_PREEMPT=3Dy)

If you'd like me to try any patches against 2.4 just let me know.

Thanks again,

--=20

(o-  Chris Sykes  -- GPG Key: http://www.sigsegv.plus.com/key.txt
//\       "Don't worry. Everything is getting nicely out of control ..."
V_/_                          Douglas Adams - The Salmon of Doubt


--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gt1wy8ZewFQK83cRAp4iAJ9Mlb+I6ot4hhsaq1wd/KlXGD9d7ACgl3Km
IBQJ771D2FqCdPRPUr2YIHM=
=wt9X
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
