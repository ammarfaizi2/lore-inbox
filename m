Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932561AbWHLQwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbWHLQwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 12:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWHLQwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 12:52:37 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:996 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S932561AbWHLQwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 12:52:36 -0400
Date: Sat, 12 Aug 2006 12:52:28 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: input: evdev.c EVIOCGRAB semantics question
Message-ID: <20060812165228.GA5255@aehallh.com>
Mail-Followup-To: Magnus =?iso-8859-1?Q?Vigerl=F6f?= <wigge@bigfoot.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <200608121724.16119.wigge@bigfoot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <200608121724.16119.wigge@bigfoot.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2006 at 05:24:16PM +0200, Magnus Vigerl=F6f wrote:
> Hi,
>=20
> What is the purpose of the EVIOCGRAB ioctl in evdev.c? Is it to prevent t=
he=20
> device driver from sending events to other event handlers? Is it to preve=
nt=20
> other applications from receiving events that has the device handler open=
?=20
> First, last, or both?

As things stand, both.
>=20
> I discovered the following behavior when I fired up a second X-server on =
my=20
> machine with my Wacom tablet connected: The second X-server opened the ta=
blet=20
> as well and everything worked as it should. However when I switched back =
to=20
> the first X-server the tablet didn't work at all. Only when I stopped the=
=20
> second X-server did the tablet start working in the first X-server again.=
 If=20
> I changed the code in evdev to ignore the EVIOCGRAB-ioctl the tablet work=
s in=20
> both X-servers, but that caused other problems.

That is, unusual.  Unless each X server has it's own display, then when
switching VCs away from an X server the driver should be turned off, and
the device ungrabbed and possibly closed, at which point the other
should be able to open and grab the device.

The wacom X driver may not be handling that properly though, annoying.
>=20
> Now, having two X-servers might not be the most common thing to have, but=
=20
> having other applications that depends on the movement from the tablet mi=
ght=20
> be more common.
>=20
> As is it now, it's useless (more or less) to run wacdump to display the t=
ablet=20
> specific events in a understandable manner. An application that generates=
=20
> events through uinput based on tablet events and some other qualifiers=20
> (mouseemu, simulating mouse scroll wheel) will not work either.

That one has been mentioned a few times, but rarely complained about
loudly.

When I drew up the first evdev grab patches I made a masking patch
shortly later which helped divide things, however that never made it
into code and that leaves us here.
>=20
> And yes, the X-server must grab the tablet. Otherwise events will go=20
> through /dev/input/mice as well and mess up applications that depend on t=
he=20
> tablet-specific absolute events.

This is close to the original reason for grabbing, specificly that there
was no safe way to use evdev for the keyboard at all without it.


I can dust off the masking patch sometime here if Dmitry thinks that
he'd be willing to see a second method for this in addition to grabbing,
adding support to xf86-input-evdev would be trivial, and the same could
probably be said for the wacom driver that does grabbing at the moment.

Regards.
Zephaniah E. Hull.
(Original author of the evdev grab patch and xf86-input-evdev
maintainer, among other things.)

--=20
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

>OK, fine. You're arguing semantics, though.

"arguing semantics" is not the same as "arguing nomenclature".  My DI
was very good at arguing semantics. He had this funny idea  that an
"unloaded" weapon was one that you had personally inspected  and that
the semantic difference mattered. Something about not  wanting to do
the paperwork of one of us killed someone with an  unloaded weapon.
Most technical debates are ultimately about semantics,  but that
doesn't mean that they are unimportant.
  -- Shmuel Metz and Steve Sobol on ASR.

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE3gdMRFMAi+ZaeAERAkKJAKCjJ8sxrjq2zHBz9fn5/fXb3Zc8xACg7d5O
lqp9sXimX2feuqcbW5+nNJI=
=ZvKB
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
