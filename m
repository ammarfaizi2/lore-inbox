Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbTCGAQF>; Thu, 6 Mar 2003 19:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261319AbTCGAQF>; Thu, 6 Mar 2003 19:16:05 -0500
Received: from ns.suse.de ([213.95.15.193]:41996 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261316AbTCGAQD>;
	Thu, 6 Mar 2003 19:16:03 -0500
Date: Thu, 6 Mar 2003 22:28:45 +0100
From: Kurt Garloff <garloff@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] work around gcc-3.x inlining bugs
Message-ID: <20030306212845.GA2292@nbkurt>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Andi Kleen <ak@suse.de>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030306032208.03f1b5e2.akpm@digeo.com.suse.lists.linux.kernel> <p73fzq067an.fsf@amdsimf.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <p73fzq067an.fsf@amdsimf.suse.de>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-UL1 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Thu, Mar 06, 2003 at 12:52:48PM +0100, Andi Kleen wrote:
> Andrew Morton <akpm@digeo.com> writes:
>=20
> > This patch:
> [...]
>=20
> I experimented with -finline-limit=3D<huge number> to get it to obey inli=
ne,=20
> but that doesn't fully work. The only way to get it to work in 3.2 and 3.=
3=20
> is to specify various long and weird --param arguments. In 3.0 the only
> way is to change the values in the compiler source and recompile.

--param max-inline-insns-single
The fact that this parameter does not get initialized by using
-finline-limit is a bug. A fix for this has already gone into CVS HEAD
(3.4) and is pending for 3.3.

[...=A0]
> I think it is the right thing to do. In kernel land when we say inline
> we mean inline. Don't expect the compiler to second guess that,
> especially since it doesn't seem to be very good at that.

The compiler solely judges by the size of the function to be inlined,
no magic involved.
There are two reasons, why this may not be what you expect:
- The allowable size can get smaller if in the function from that
  you're calling and the one above and ... were already inlined.
  At some moment this recursive inlining has to be stopped to
  not results in excessive compile time resource requirements
- When calculating the size of a function, the compiler counts
  tree tokens, each estimated to yield 10 RTL instructions.
  It does unfortunately not take into account code that will
  be eliminated by optimization (constant propagation, dead
  code elimination, ...) nor does it have a very good idea
  about the size of inline assembly.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers                        SuSE Labs
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQE+Z72MxmLh6hyYd04RAtJXAKCeuyoX2bWEeCNDFmaGye0anf8hRwCgkZXl
g0gkTUIgAxCzbvKNtahiSUw=
=gw0I
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
