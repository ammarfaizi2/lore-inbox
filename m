Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132516AbRDUHDR>; Sat, 21 Apr 2001 03:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132517AbRDUHDH>; Sat, 21 Apr 2001 03:03:07 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:27911
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S132516AbRDUHC6>;
	Sat, 21 Apr 2001 03:02:58 -0400
Date: Sat, 21 Apr 2001 00:02:56 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linux Kernel <linux-kernel@vger.kernel.org>, autofs@linux.kernel.org
Subject: Re: Fix for SMP deadlock in autofs4
Message-ID: <20010421000256.A14074@goop.org>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	autofs@linux.kernel.org
In-Reply-To: <20010420184613.B12962@goop.org> <Pine.LNX.4.31.0104202253010.15553-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104202253010.15553-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Apr 20, 2001 at 10:59:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2001 at 10:59:43PM -0700, Linus Torvalds wrote:
> It's untested, but looks fairly obvious. It removes the increment, and
> changes autofs4_expire() to properly bump the count of the returned dentry
> (and callers will dput() it when done). This may be unnecessarily careful,
> but it's the RightThing(tm) to do.

I suppose so.  It is pretty paranoid, because of autofs4's extra reference it
can't (shouldn't) ever drop to zero until the filesystem allows it to drop to
zero.  In other words, if it helps, it's hiding another bug.  But you're right,
if this were a general routine, it should definitely return with an elevated
count.

> Jeremy, would you mind verifying that this WorksForYou(tm)?

Looks fine to me.  I'll give it a spin.

	J

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjrhMKAACgkQf6p1nWJ6IgKLOQCeMAveWjjn9C4UFUWNa31b75QR
XrgAn0XKzfY4zG5iYSjgc+OLZpyTjVQc
=nYh5
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
