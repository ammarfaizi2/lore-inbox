Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbVAGWeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVAGWeG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 17:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVAGWdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 17:33:15 -0500
Received: from fysh.org ([83.170.75.51]:58349 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S261666AbVAGW3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 17:29:48 -0500
Date: Fri, 7 Jan 2005 22:29:40 +0000
From: Athanasius <link@miggy.org>
To: linux-os@analogic.com, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050107222940.GE22324@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>, linux-os@analogic.com,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Lukasz Trabinski <lukasz@wsisiz.edu.pl>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <Pine.LNX.4.61.0501071519330.21405@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501071519330.21405@chaos.analogic.com>
User-Agent: Mutt/1.3.28i
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2005 at 03:27:05PM -0500, linux-os wrote:
> On Fri, 7 Jan 2005, Marcelo Tosatti wrote:
> >>Hello
> >>
> >>
> >>http://isec.pl/vulnerabilities/isec-0021-uselib.txt
> >>
> >>[...]
> >>Locally  exploitable  flaws  have  been found in the Linux binary format
> >>loaders'  uselib()  functions  that  allow  local  users  to  gain  root
> >>privileges.
> >>[...]
> >>Version:   2.4 up to and including 2.4.29-rc2, 2.6 up to and including=
=20
> >>2.6.10
> >>[...]
> >>
> >>It's was fixed by Marcelo on 2.4.29-rc1. Thank's :)
> >>What about 2.6.X? Is any patch available? I don't see any changes
> >>around binfmt_elf in 2.6.10-bk10?
> >
> >2.6.10-ac contains a version of the fix.
> >
> >Attached is what going to be merged in mainline, most likely.
> >
> >
>=20
> FYI, the provided source-code won't build with the 2.6.x kernel
> because one of the structures is no longer defined. However,
> building on 2.4.20 and attempting to exploit the alleged bug
> results in:
>=20
> Script started on Fri 07 Jan 2005 03:22:24 PM EST
> LINUX> ./isec
>=20
> [+] SLAB cleanup
> [+] moved stack bfffe000, task_size=3D0xc0000000, map_base=3D0xbf800000
> [+] vmalloc area 0xef800000 - 0xffffd000
>=20
> [-] FAILED: try again (No such device)=20

  It's trying to use /dev/shm/_elf_lib, which doesn't work too well if
you don't have tmpfs/shm support and /dev/shm mounted.  Changing this to
a normal filename doesn't get much further in the exploit.  It just
repeatedly fails:

22:26:41 0$ ./elflbl_v108=20

[+] SLAB cleanup
    child 1 VMAs 31876
    child 2 VMAs 250
[+] moved stack bfffd000, task_size=3D0xc0000000, map_base=3D0xbf800000
[+] vmalloc area 0xfec00000 - 0xffffd000
    Wait... -
[-] FAILED: 502: try again (Cannot allocate memory)=20
Killed

Oh, and in 2.6.x it seems struct modify_ldt_ldt_s is now struct
user_desc, not that making that change and running the exploit results
in any further luck.

  There are comments in the code about a 'race' though, so I assume it's
a race condition being exploited and it might work eventually if you
loop the thing.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAkHfDVQACgkQIr2uvLNOS8NuawCeJrjsD0Zqns0RrVvvAErU+AZq
+k4An2ySGUXGp9i5NF6lG2vJxlwaOebb
=Z4sK
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
