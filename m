Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUAKKFU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 05:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUAKKFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 05:05:20 -0500
Received: from coruscant.franken.de ([193.174.159.226]:22661 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S265823AbUAKKFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 05:05:10 -0500
Date: Sun, 11 Jan 2004 11:01:37 +0100
From: Harald Welte <laforge@netfilter.org>
To: Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH] Unaligend accesses nulldevname
Message-ID: <20040111100137.GH20706@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	netfilter-devel@lists.netfilter.org
References: <20040107230011.GG23133@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline
In-Reply-To: <20040107230011.GG23133@tpkurt.garloff.de>
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2004 at 12:00:11AM +0100, Kurt Garloff wrote:
> Hi,
>=20
> I found an excessive amount of unaligned accesses on my AXP workstation
> and tracked it down to ip_packet_match() in the ip_tables module.
> indev and outdev are not properly aligned if set to nulldevname in
> ipt_do_table().
> This destroys the benefits of comparing names in units of (long) and
> on architectures with expensive unaligned accesses (such as ia64 or
> alpha), it even hurts a lot.

Thanks for submitting your patch, this is the same bug report as
https://bugzilla.netfilter.org/cgi-bin/bugzilla/show_bug.cgi?id=3D84

> Find attached a patch against 2.6.0. A similar patch is needed for 2.4,
> also attached.

the fix is already in our patch-o-matic CVS tree, and I'm going to
submit this to davem together with some other fixes I have pending.

> Looking at ip_packet_match(), I have two more thoughts:
> * It should not be inlined. It's too large to benefit from inlining,
>   IMHO. (OTOH, it's only called from one place, so it does not
>   really matter.)

That is the idea.  It's just split in two functions to make it more
readable.  It's never intended to be called from somewhere else.

> * There's a comment about the compiler being able to unroll the 2/4
>   (64/32bit) iter loop which is not completely appropriate: We don't
>   pass -funroll-loops, so gcc does not do it :-(
>   It would be beneficial though.

I'm not a compiler geek.  Thanks for pointing this out, I will do some
testing and look at the compiler output to see what is happening.

> Regards,
> --=20
> Kurt Garloff  <garloff@suse.de>                            Cologne, DE=20
--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAAR8BXaXGVTD0i/8RAnAuAJ9qhRHsnQQI8azLx5p+I1S3vBKw0wCeKoio
v2pIw8coqEg5TomqGflYo70=
=D2yY
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--
