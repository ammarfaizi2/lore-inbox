Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264547AbVBELQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbVBELQH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 06:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264308AbVBELP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 06:15:59 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:28322 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262705AbVBELPQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 06:15:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] PPC/PPC64: Introduce CPU_HAS_FEATURE() macro
Date: Sat, 5 Feb 2005 12:04:34 +0100
User-Agent: KMail/1.6.2
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Tom Rini <trini@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>
References: <20050204072254.GA17565@austin.ibm.com> <200502050122.27254.arnd@arndb.de> <20050205013426.GC11318@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20050205013426.GC11318@krispykreme.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_GhKBCJkznSZL9xB";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502051204.38965.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_GhKBCJkznSZL9xB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnnavend 05 Februar 2005 02:34, Anton Blanchard wrote:
> Interesting :) However we already get bug reports with the current
> CONFIG_POWER4_ONLY option. I worry about adding more options that users
> could get wrong unless there is a noticeable improvement in performance.
>=20
The patch that I posted doesn't add any new user selectable options,
it only limits the supported CPUs to the ones that are available on
the supported platforms. If you select powermac or maple, the only
supported CPU will be PowerPC970, so the C compiler can optimize away
all runtime checks for CPU features.

I don't expect much noticeable performance advantage from the patch,
but it allows to make some of the source code nicer. E.g. you can
replace every instance of '#ifdef CONFIG_ALTIVEC' with 'if=20
(CPU_FTR_POSSIBLE & CPU_FTR_ALTIVEC)' or an inline function wrapping
that.

	Arnd <><

--Boundary-02=_GhKBCJkznSZL9xB
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCBKhG5t5GS2LDRf4RAkKbAKCXDT1IwF5F2WqcSsZl0FgZfgpTKACeL/gW
J5uKZEdOgtvSb/m5klF+ZGQ=
=iDSe
-----END PGP SIGNATURE-----

--Boundary-02=_GhKBCJkznSZL9xB--
