Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVEKSSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVEKSSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVEKSSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:18:35 -0400
Received: from lug-owl.de ([195.71.106.12]:39849 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261256AbVEKSRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:17:41 -0400
Date: Wed, 11 May 2005 20:17:40 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ioctl to keyboard device file
Message-ID: <20050511181740.GO8176@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.60.0505112207300.21632@lantana.cs.iitm.ernet.in> <1115831651.23458.74.camel@pegasus> <Pine.LNX.4.60.0505112301350.31722@lantana.cs.iitm.ernet.in> <1115834000.23458.77.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6CiRFyVmOOJ3DkBX"
Content-Disposition: inline
In-Reply-To: <1115834000.23458.77.camel@pegasus>
X-Operating-System: Linux mail 2.6.10-rc2-bk5lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6CiRFyVmOOJ3DkBX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-05-11 19:53:20 +0200, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> > >> 1) what is the device file corresponding to keyboard (is it
> > >> /dev/input/keyboard).
> > >> 2) where file operations structure is defined for that.
> > >> 3) where the those ioctls handled(not found in keyboard.c).
> > >>
> > >> Any small help is appreciated.
> > >
> > > why not using uinput for this job?
> >=20
> >    Thanks for the solution.  I did the above task, by defining a new
> > character device driver and sending ioctl to it. and calling
> > handle_scancode from it. Now I want
> > to do the same task with in the keyboard driver. For that I need to send
> > ioctl to keyboard device file.
> > For that only I asked the
> > above doubts.
>=20
> what your are trying to do looks wrong to me. Why don't you use uinput.
> It is there and it is the correct thing for the job.

I don't know what device the initial sender tries to support, but uinput
is only a solution for "normal" human input.  I yet fail to see how
you'd support eg. keyboard-based magnetic stripe readers or barcode
scanners with it. These devices don't play nicely with atkbd: they send
some "random" make and break codes so you'd get some garbage from stdin.
But in reality, you'd rather prefer to (like for /dev/input/event*)
select() for a fully received magnetic stripe or barcode or the like.

Also, you may need to write (in terms of raw bytes) to the keyboard port
of the i8042 eg. to use keyboards with built-in displays.

Right now, I'm writing a driver (for 2.6.x) for some MSR. I'm attempting
to do this by having a "relay" serio port which is a serio client wrt.
the serio port registered by i8042. It shall register another serio port
(to which atkbd then connects) and supply an interface for some other
module to intercept/filter the make/break codes. It *could* be done with
serio_raw, but then you'd need to implement a full atkbd implementation
in userspace (which I consider being quite ugly...).

So the resum=C3=A9e is that the Input API is *really* cool for normal
devices, but from my point of view, it cannot really handle these
complicated Point of Sale devices nicely.  Give us some days, we'll at
least put the serio_relay.c driver on the table. Maybe it's useful for
somebody else...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--6CiRFyVmOOJ3DkBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgkxDHb1edYOZ4bsRAlWoAJ9X+46H5SUCKPMULVKDFwwpb+ckWgCeKeTv
fE23NvJ5zy/YDzcQWaWsh8c=
=ZpJK
-----END PGP SIGNATURE-----

--6CiRFyVmOOJ3DkBX--
