Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWAPNBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWAPNBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 08:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWAPNBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 08:01:12 -0500
Received: from ozlabs.org ([203.10.76.45]:4795 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750730AbWAPNBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 08:01:12 -0500
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: linuxppc64-dev@ozlabs.org
Subject: Re: 2.6.15-mm4 failure on power5
Date: Tue, 17 Jan 2006 00:00:54 +1100
User-Agent: KMail/1.8.3
Cc: Andrew Morton <akpm@osdl.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       paulus@au1.ibm.com, anton@au1.ibm.com, linux-kernel@vger.kernel.org
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org>
In-Reply-To: <20060115230557.0f07a55c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2003026.T5e2PD4Uhi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601170000.58134.michael@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2003026.T5e2PD4Uhi
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Mon, 16 Jan 2006 18:05, Andrew Morton wrote:
> "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > On my power5 partition, 2.6.15-mm4 hangs on boot
>
> It might be worth reverting the changes to arch/powerpc/mm/hash_utils_64.=
c,
> see if that unbreaks it.
>
> -		base =3D lmb.memory.region[i].base + KERNELBASE;
> +		base =3D (unsigned long)__va(lmb.memory.region[i].base);

You can try it, but if that fixes the problem I'll buy a sombrero and then =
eat=20
it.

> The nice comment in page.h:
>
>  * KERNELBASE is the virtual address of the start of the kernel, it's oft=
en
>  * the same as PAGE_OFFSET, but _might not be_.
>  *
>  * The kdump dump kernel is one example where KERNELBASE !=3D PAGE_OFFSET.
>  *
>  * To get a physical address from a virtual one you subtract PAGE_OFFSET,
>  * _not_ KERNELBASE.
>
> Tells us that was not an equivalent transformation.

True, not equivalent in all cases, but correct. For non-kdump kernels (whic=
h I=20
assume this is) KERNELBASE =3D=3D PAGE_OFFSET, and for a kdump kernel that =
code=20
wants to use PAGE_OFFSET, not KERNELBASE.

Try enabling early debugging (see arch/powerpc/kernel/setup_64.c) and then=
=20
turning on DEBUG in hash_utils_64.c, setup_64.c etc.

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart2003026.T5e2PD4Uhi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDy5kKdSjSd0sB4dIRAm60AKCNxhXapOqZFZYGcpnfbeAOP/x5gwCfcutn
DaIGwaQbeV8aEMEa/6tDUiQ=
=zDbw
-----END PGP SIGNATURE-----

--nextPart2003026.T5e2PD4Uhi--
