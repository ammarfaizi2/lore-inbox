Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTFOEgm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 00:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFOEgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 00:36:42 -0400
Received: from niobium.golden.net ([199.166.210.90]:42718 "EHLO
	niobium.golden.net") by vger.kernel.org with ESMTP id S261845AbTFOEgk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 00:36:40 -0400
Date: Sun, 15 Jun 2003 00:50:18 -0400
From: Paul Mundt <lethal@linux-sh.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SH Port - Makefile
Message-ID: <20030615045017.GA29131@linux-sh.org>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <20030614193055.GA3673@mars.ravnborg.org> <20030614194510.GD2216@linux-sh.org> <20030614200744.GA3921@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <20030614200744.GA3921@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2003 at 10:07:44PM +0200, Sam Ravnborg wrote:
> On Sat, Jun 14, 2003 at 02:45:12PM -0500, Paul Mundt wrote:
> > Okay, the main reason why I needed to do this was so that a make clean
> > would get the proper directory path. The problem was that machdir-y
> > wasn't getting the board name correctly since at make clean time the
> > CONFIG_SH_xxx names weren't being resolved.
>=20
> The following should do the trick.
> I also rearranged a few things.
>=20
Unfortunately this still yields the same problem as before when it comes to
resolving machdir-y properly at make clean time:

[lethal@unusual linux-sh-2.5.71]$ make ARCH=3Dsh CROSS_COMPILE=3Dsh-uclibc-=
 clean
scripts/Makefile.clean:10: arch/sh/boards/Makefile: No such file or directo=
ry
make[1]: *** No rule to make target `arch/sh/boards/Makefile'.  Stop.
make: *** [_clean_arch/sh/boards] Error 2

At make clean time, .config isn't available properly due to it not being
included since its a noconfig_targets target, which causes the above proble=
m.
This will also happen for the rest of the noconfig_targets, hence the manual
inclusion of .config to fixup the path lookup issue.

Any other suggestions?

> Whith respect to removing the framepointer from CFLAGS.
> There is already a CONFIG option for that CONFIG_FRAME_POINTER.
> It would be much cleaner using that one in combination
> with CONFIG_SH_KGDB
>=20
Agreed, I'll add this in. Thanks.


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+6/sJ1K+teJFxZ9wRAgooAKCCmRKK0w79K1ekDDntguzIsGTyygCdEPYx
5UQzQw7Guo8/KUTa6NSCqkw=
=Y6wS
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
