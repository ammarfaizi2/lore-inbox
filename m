Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWEIJLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWEIJLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 05:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbWEIJLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 05:11:20 -0400
Received: from ozlabs.org ([203.10.76.45]:58757 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751740AbWEIJLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 05:11:19 -0400
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
In-Reply-To: <44605396.40507@shadowen.org>
References: <20060509070343.57853679F2@ozlabs.org>
	 <44605396.40507@shadowen.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PWkEnQbti6xtyANU4HtV"
Date: Tue, 09 May 2006 19:11:11 +1000
Message-Id: <1147165871.8704.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PWkEnQbti6xtyANU4HtV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-09 at 09:32 +0100, Andy Whitcroft wrote:
> Michael Ellerman wrote:
> > I can't believe I'm the first person to see this, so I imagine I'm miss=
ing
> > something. Perhaps it's only an issue on powerpc?
> >=20
> > I have a machine with some memory at 0, then a hole, and then some more=
 memory
> > which doesn't start on a section boundary. This is causing the followin=
g
> > crash:
> >=20
> > add_region nid 1 start_pfn 0x77c0 pages 0x840
> > add_region nid 1 start_pfn 0x0 pages 0x6000
>=20
> Nasty, could you send me your full boot log and your config and I'll
> have a look at it.  I can say this code has been booted on a lot of
> power boxes and I've never seen that before!  :)

Ah yeah, I seem to have neglected to mention it's a kdump boot :} Sorry.
That's why we get the strangely aligned memory sections. The section
starting at 0 is for the kdump kernel, the bit at 0x77c0 covers some
firmware that's allocated there by the first kernel.

I can still give you a .config and log if you want it, but not 'til
tomorrow morning.

> Anyhow, will take a look and see if we can avoid iterating over the area
> to find it.

Yeah it's a bit nasty having the loop. I figure on most configs it'll
pop on the first iteration, but still.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PWkEnQbti6xtyANU4HtV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEYFyvdSjSd0sB4dIRAl6lAJ9anv7MHG83vO/idvgcWI6XMAGKGACdFZp7
Gpn5Di/Xm1FDdUwmKSIcH9M=
=t4je
-----END PGP SIGNATURE-----

--=-PWkEnQbti6xtyANU4HtV--

