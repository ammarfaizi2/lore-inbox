Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUHSHMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUHSHMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 03:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUHSHMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 03:12:40 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:39779 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261987AbUHSHMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 03:12:33 -0400
Date: Thu, 19 Aug 2004 00:12:29 -0700
To: linux-kernel@vger.kernel.org
Subject: config language shortcomings in 2.4
Message-ID: <20040819071229.GA7598@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040803i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Recently the Debian kernel team has been discussing 2.4's configuration
system. We have a patched tg3.c which removes the firmware and adds a
dependency on CONFIG_FW_LOADER for cases where operation is impossible
without the firmware.

Initially, we changed this:

dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI

to this:

dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI $CONFIG_FW=
_LOADER

But this would still be selectable if CONFIG_FW_LOADER were not set at
all. Selecting it would not enable CONFIG_FW_LOADER either.

So, we tried this:

if [ "$CONFIG_FW_LOADER" !=3D "n" -a "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
   dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI $CONFIG=
_FW_LOADER
fi

and this STILL doesn't seem to work in the case that CONFIG_FW_LOADER
isn't set but CONFIG_EXPERIMENTAL is y.

Eventually we continued droning through the corner cases until reaching

if [ "$CONFIG_EXPERIMENTAL" =3D "y" -a \
     "$CONFIG_HOTPLUG" =3D "y" -a \
     "$CONFIG_FW_LOADER" =3D "y" -o "$CONFIG_FW_LOADER" =3D "m" -a \
     "$CONFIG_CRC32" =3D "y" -o "$CONFIG_CRC32" =3D "m" ]; then
       dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI $CO=
NFIG_FW_LOADER $CONFIG_CRC32
fi

which finally has the desired effect.

But is there really no way to say

config TIGON3
       select FW_LOADER

in 2.4?

CONFIG_PCMCIA_ATMEL also suffers from this problem.

Any ideas? Is it just that the old Configure scripts suck?

--=20
Joshua Kwan

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSRS3aOILr94RG8mAQIVsxAA7ByP6ig75m0Oa6kGnA9fISmFnuFONVyH
5TyCPcvAWXlqf4EpUMumO5knO3bV+WZhwKPgEi+BrqZZcdMTTP4vkXELcK8N6mTz
LQ7D8dZANpla52dxXzutZwrnfTkOjgl8ApGY/4a7AzMPLD6jCu0LCUA4kXSviHjX
ue3bnJhup8+oy6TYOpV7GxbRs4D8RkFSyDSwrCS+i7pqkLB72v3FB/5KK0lZKcyi
2QNnACCTJ93aXzcMp30eZN14xjQlMUcDR/OILvLMr49Wb8qu7DmGE6aQL8ZMwGbc
viJuk608UmaB2MU3LUqCYsB9mcmDPsa7Zotx4dnXDM9fXM1uUfQ3JPmz0aPcnJES
kG3Mpd7QKs55c4HXFE0o5m5QZYIf8LgB202Tk55injYFloK7qJmi2gyRYASFdnHl
wOjbDLlYvocThyCM759F9TmuzHbuuoxc5NGpVS5o/AbufaCu6CSJIhtENmjbhEuu
KEZi0p/bg2bq1k6TVYVKpxjcVF2Bx5ECI7gaRXUqFNmj3TEG54mOaN4fxOKfPyq2
13o9uAy1W4i9ngSWK20G3VVxROfc8i37erz4U2A+6pQLHbXVHEa2H14TmI5BPNIg
zuSkdfdw2Ue+C7gnQD8BaxrFZeNOR/PvkJWUN9GS+iSx1r8ZD2fHbJN3vDAxYrc/
IHcu0G27j0c=
=0qS2
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
