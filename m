Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSJYOaH>; Fri, 25 Oct 2002 10:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261435AbSJYOaH>; Fri, 25 Oct 2002 10:30:07 -0400
Received: from draal.physics.wisc.edu ([128.104.137.82]:10181 "EHLO
	draal.physics.wisc.edu") by vger.kernel.org with ESMTP
	id <S261433AbSJYO3h>; Fri, 25 Oct 2002 10:29:37 -0400
Date: Fri, 25 Oct 2002 09:35:42 -0500
From: Bob McElrath <bob+linux-kernel@mcelrath.org>
To: linux-kernel@vger.kernel.org
Subject: process load and swapping
Message-ID: <20021025143541.GC13482@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S1BNGpv0yoYahz37"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--S1BNGpv0yoYahz37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have been experiencing the following behavior on my alpha with many
kernel versions (2.4 series, latest is 2.4.19 with Ingo's O(1) scheduler
patch).

I'm running apache and zope, and when I load a zope page, the load jumps
to ~12 and the computer starts skipping.  That is, about once every 2s
the music (xmms) stops for ~0.5s and then comes back.  This repeats
every 2s until zope is finished creating the page (which takes sometimes
longer than a minute).  When the computer "skips", not only does the
music stop, but the mouse stops moving (i.e. I move it continuously and
it pauses for 0.5s every 2s).  This happens both at the console in X and
on virtual terminals (ssh'ed from another computer).  It's as if it's
not servicing interrupts for 0.5s.  Or does scheduling not occur when
the kernel decides to load N pages from swap, no matter how large N is?

This is totally due to swap use.  If I turn off all swap ('swapoff -a'),
the response of zope is speedy.  This behavior has happened with all
kernel versions I have used, at least since 2.4.17.

So, any ideas?  I know there have been arguments about the 'swappiness'
of this kernel, but the load going to 12 and interrupts not being
serviced is totally quantitative and totally repeatable...

Cheers,
-- Bob

Bob McElrath
Univ. of Wisconsin at Madison, Department of Physics

    "The surest way to corrupt a youth is to instruct him to hold in higher
    esteem those who think alike than those who think differently."=20
        -- Nietzsche

--S1BNGpv0yoYahz37
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj25Vr0ACgkQjwioWRGe9K0IQQCfVoAtKpixoM+KkcHr5pauKgjQ
DJcAoORods/oWPNkxxSE0oR50B9c3vjB
=xHTG
-----END PGP SIGNATURE-----

--S1BNGpv0yoYahz37--
