Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUHLFEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUHLFEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHLFEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 01:04:11 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:22431 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S268381AbUHLFEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 01:04:04 -0400
Subject: Re: [PATCH 0/3] Transition /proc/cpuinfo -> sysfs
From: "Lamont R. Peterson" <lamont@gurulabs.com>
Reply-To: lamont@gurulabs.com
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040811224117.GA6450@plexity.net>
References: <20040811224117.GA6450@plexity.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pwKuKbVyF/GKy2vhxgJc"
Organization: Guru Labs
Message-Id: <1092287009.2250.9.camel@wraith.lrp.advansoft.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 23:03:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pwKuKbVyF/GKy2vhxgJc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-11 at 16:41, Deepak Saxena wrote:
> Following this email will be a set of patches that provide a first pass
> at exporting information currently in /proc/cpuinfo to sysfs for i386 and=
=20
> ARM. There are applications that are dependent on /proc/cpuinfo atm, so w=
e=20
> can't just kill it, but we should agree on a kill date and require all
> arches & apps to transition by that point. I've added code to
> proc_misc.c to remind the user that the cpuinfo interface is going
> away (currently using arbitrary date ~1 year from now). I've also
> added a pointer to struct cpu that can be used by arch code to=20
> store any information that might be needed during attribute printing.
>=20
> Couple of questions:
>=20
> - Do we want to standardize on a set of attributes that all CPUs
>   must provide to sysfs? bogomips, L1 cache size/type/sets/assoc (when
>   available), L2 cache (L3..L4), etc? This would make the output be the=20
>   same across architectures for those features and would simply require
>   adding some fields to struct cpu to carry this data and some generic
>   ATTR entries to drivers/base/cpu.c.  I am all for standardized
>   interfaces so I'll do a first pass at this if desired.

I vote yes, but only to a point.  You are right; standardized interfaces
are a good thing.  For any architecture specific information, additional
fields should be available.  Perhaps either always following the
standardized sysfs entries or as an "extra-cpuinfo" (or
"[arch]-cpuinfo"?) sysfs node.

> - On an HT setup, do we want link(s) pointing to sibling(s)?

I like this idea, even if it is not necessary because siblings should be
listed sequentially together.  i.e. two physical CPUs with HT would be
cpu0, cpu1, cpu2 & cpu3.  Obviously, cpu0 & cpu1 go together and cpu2 &
cpu3 also go together.

> - Currently the bug and feature fields on x86 have "yes" and "no".
>   Do we want the same in sysfs or 1|0?

If the flags are not going to be decoded, then I say definitely 1|0.

> - Instead of dumping the "flags" field, should we just dump cpu
>   registers as hex strings and let the user decode (as the comment
>   for the x86_cap_flags implies.

I like this.  In fact, if it goes this way, then I will write a
"cpuinfo" program that will do all the decoding as a generic tool.

> I'll try to do MIPS, SH, and PPC when I get a chance (all I have access=20
> to), but have other things to do for a while, so want comments on above=20
> questions first.=20

When you are ready, I can also get SPARC64 & AMD64 (Opteron 242).
--=20
Lamont R. Peterson <lamont@gurulabs.com>
Senior Instructor
Guru Labs, L.C. http://www.GuruLabs.com/

--=-pwKuKbVyF/GKy2vhxgJc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBGvogRK8Q4zt1QRURAjmQAKCwqhR4aSkaJuNpalUFCttwG7S23wCg4gxO
W3ybPr5NtxIXuFrGhOzLubI=
=/P1T
-----END PGP SIGNATURE-----

--=-pwKuKbVyF/GKy2vhxgJc--

