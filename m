Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVGaD0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGaD0Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 23:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVGaD0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 23:26:25 -0400
Received: from 208-151-246-43.dq1sn.easystreet.com ([208.151.246.43]:37718
	"EHLO lizaveta.nxnw.org") by vger.kernel.org with ESMTP
	id S261597AbVGaD0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 23:26:23 -0400
Date: Sat, 30 Jul 2005 20:22:26 -0700
From: Steve Beattie <sbeattie@suse.de>
To: Tony Jones <tonyj@suse.de>
Cc: serge@hallyn.com, serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
Message-ID: <20050731032226.GC25629@immunix.com>
References: <20050727181732.GA22483@serge.austin.ibm.com> <20050730050701.GA22901@immunix.com> <20050730190222.GA12473@vino.hallyn.com> <20050730201852.GA8223@immunix.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20050730201852.GA8223@immunix.com>
Organization: Novell
X-Face: "1~xOFm~DYTOI([HBN^1#l_'KM2Aq#q4BcQ|[SeJArfT]p;Ozwul/kxlDq/WS{&;pznorY|}j?&8W+2\a'v1OmD4|B_7vbg?O,/"6YsK7`&o]+@],`sa87$RC#A&fA*%X`ZZ.x{g~>OFe'nx`}>)m/\x*5zPUOKY\-u]XI$j4ptk8}G"5zFi?,Qsjj&(XRH.kZ=yo{suM4o|1oN9*_h,ot,klBS
X-Paranoia: Greetings CIA, FBI, MI5, NSA, ATF, Immigration!
X-Message-Flag: Repeal the DMCA! Real security is only possible when subject to open critical review.
X-PGP-Key: http://www.NxNW.org/~steve/3B986AF3.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 30, 2005 at 01:18:52PM -0700, Tony Jones wrote:
> Of more concern is ps -Z (pstools).
>=20
> We had to have the pstools maintainer extend the set of characters that it
> considered valid from the getprocattr.    I forget the details but IIRC h=
e=20
> wanted to know (for ?documentation?) every character that could be return=
ed=20
> by our getprocattr hook (which for us is pretty much any character thats=
=20
> valid in a pathname -- though IIRC we forgot one).
>=20
> Anyway, I'm guessing (at least with pstools 3.2.5) that '(' is not one of
> the valid characters. IIRC ps gives up when it sees a "non-valid" charact=
er.
>=20
> I wrote a trivial little lsm which just returns 'foobar' for any getproca=
ttr.
>=20
> # cat /proc/2322/attr/current=20
> unconstrained (subdomain)
> foobar (foobar)
>=20
> # ps -Z -p 2322
> LABEL                             PID TTY          TIME CMD
> unconstrained                    2322 ttyS0    00:00:00 bash

Actually, no, it is the space preceding the open paren that is invalid;
see this patch for the expanded allowed character set in procps 3.2.5:

  http://cvs.sourceforge.net/viewcvs.py/procps/procps/ps/output.c?r1=3D1.51=
&r2=3D1.52

When I discussed this with Albert Cahalan, he *strongly* objected to
allowing whitespace in security contexts, as he felt it would break
scripts that parsed 'ps -Z' output.

--=20
Steve Beattie
SUSE Labs, Novell Inc.=20
<sbeattie@suse.de>
http://NxNW.org/~steve/

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFC7EPxquBH+DuYavMRAvaFAJ4rtzRYkzaXZXiKLglqjCNB/Vqk7gCgmSOG
4uolz5cxXtRKnYb+xL+SPug=
=gyW3
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
