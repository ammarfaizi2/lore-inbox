Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSLWPLU>; Mon, 23 Dec 2002 10:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSLWPLU>; Mon, 23 Dec 2002 10:11:20 -0500
Received: from c-24-99-36-145.atl.client2.attbi.com ([24.99.36.145]:3082 "HELO
	babylon.d2dc.net") by vger.kernel.org with SMTP id <S266514AbSLWPLT>;
	Mon, 23 Dec 2002 10:11:19 -0500
Date: Mon, 23 Dec 2002 10:19:24 -0500
From: "Zephaniah E\. Hull" <warp@babylon.d2dc.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.x console keyboard problem.
Message-ID: <20021223151924.GA5970@babylon.d2dc.net>
Mail-Followup-To: Vojtech Pavlik <vojtech@suse.cz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It took me a while to track this down, with a few false paths.

I have verified this is kernel side, so..

The basic problem goes like this, start X, switch away from X with
ctrl-alt-Fn, then switch back to X, this is where the fun starts.

Sometimes (this seems to be a race condition, but I have no idea what it
depends on) things go, interestingly wrong, X gets the message that it
has the VC, it takes control of the screen, and the kernel grabs the
ctrl-alt-Fn used to switch away from X, and does not tell X that it no
longer actually HAS the console.

Resulting in keyboard input going to the VC you switched out from X to,
and the kernel believing that it can print to the screen, but with X also
still trying to control the screen.

If you switch back to the VC X is on then things work from there,
however this is quite obviously quite broken.

Verification that this was kernel side was not too hard, removing the
console binds for ctrl-alt-Fn makes the problem go away.

This happens for 2.5.x, but not 2.4.20, I don't know where in 2.5.x it
started.

Thanks.

Zephaniah E. Hull.

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

[1] Yes, we ARE rather dull people.  We appreciate being dull people.
Exciting is only good when it happens to someone else ... as in "an
exciting wreck", "an exciting plane crash", "an exciting install of
Windows XP", et al.
  -- Ralph Wade Phillips in the Scary Devil Monastery.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+Byl8RFMAi+ZaeAERAmq0AJ49NSG5rVC7PJOUy09Hnmz3SzNkCACeOCeX
HulV3rsZgveOXvH7LabSNPw=
=eQjN
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
