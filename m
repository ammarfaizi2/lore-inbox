Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUEWP3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUEWP3p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 11:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbUEWP3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 11:29:45 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:14183 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263000AbUEWP3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 11:29:23 -0400
Date: Sun, 23 May 2004 08:29:15 -0700
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: consistent ioctl for getting all net interfaces?
Message-ID: <20040523152914.GH25346@triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	Tigran Aivazian <tigran@veritas.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <pan.2004.05.23.04.28.28.143054@triplehelix.org> <Pine.LNX.4.44.0405231616290.3600-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405231616290.3600-100000@einstein.homenet>
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6i
From: joshk@triplehelix.org (Joshua Kwan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 23, 2004 at 04:20:57PM +0100, Tigran Aivazian wrote:
> Note that a more simple solution is also possible but is less portable
> (because will depend on glibc version).

That uses if_nameindex, right? It's also affected by kernel version.

> 		if(ioctl(fd, SIOCGIFCONF, &ifc) < 0) {
> 			DPRINTF("ioctl(SIOCGIFCONF), errno=3D%d (%s)\n",
> 					errno, strerror(errno));
> 			if (ifc.ifc_buf)
> 				free(ifc.ifc_buf);
> 			ret =3D TERR_IOCTL;
> 			goto outclose;
> 		}

As I said, when I tried SIOCGIFCONF, results varied..
I think it's slightly more reliable to just keep using /proc/net/dev for
now. (My parser is more robust than viro's ;))

I took a look at the net-tools ifconfig source and saw that it also
parsed /proc/net/dev to pick up what SIOCGIFCONF didn't. Shudder.

--=20
Joshua Kwan

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQLDDSaOILr94RG8mAQJYiQ//VlNxoAoMlCxBFUFJiV0R014TYi/Dn60G
6dVKyQAfFBScC4tAYYOGhdxpN4RlivmerEOqwfgpc2Aj5E0UE0O/CT5w2MeHmUsF
EvVVP0K+C3bSbfGSGhnH1/2KLQNWO9gmGg+cSFQjyiRKGQZ4rh1GoRaqrie116X+
tlzmYzKqU2hWmYXrLmByTH+MZqOjVN2v4i47/JdP7FWgQBvBTZlbvNahSFq+3Iac
uwaJl+1Uey9yx71T6JbgP7ppUmJItxzIXSO/wQb8t/V6rh1Vwr+n88sewUzLOReJ
bjDJC+i8XaThxHrpbV3lv2eDmRhfiKb1sDIE2xCAQ6m/KPs7C/4wDthLuImCaGxX
iZafTieAxqPo5u7IUQL2FaPuaSAT69fiHrn0ClvcAPa6kBTzjaFoWvPTc/z7pG9A
E2W/XQWIP3qs6Fo5O6h94KY1GQMB3726/KB8UvpugLhgzFtC6dto9/Lv9MjLzf4F
jms/70wbP7NrxR+50GDhC/AiEWDiIxyBTRubjcIraO0qc9Ego6fIApejIG+0kKo8
6SPDol0ZNLpMTW/mirUUbL4IWVdXSziGZ5dRZLeCSlMAqT1NjxojoEaLsB/N6XT8
uWeqz2wUklizC4kfZzEO/hpEbTzKk16wnDpA2EhCmjzM8+uy1NuhaaQqbxnSo1+s
IYRvUrJ3Pgc=
=YPFl
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
