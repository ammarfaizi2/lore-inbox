Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWCaRJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWCaRJS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWCaRJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:09:18 -0500
Received: from fysh.org ([83.170.75.51]:64217 "EHLO bowl.fysh.org")
	by vger.kernel.org with ESMTP id S1751334AbWCaRJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:09:17 -0500
Date: Fri, 31 Mar 2006 18:09:16 +0100
From: Athanasius <link@miggy.org>
To: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: 'make oldconfig' sub-optimal 2.6.15 -> 2.6.16(.1) (was Re: Linux v2.6.16(.1) - compile failure)
Message-ID: <20060331170916.GL28030@miggy.org>
Mail-Followup-To: Athanasius <link@miggy.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0603192216450.3622@g5.osdl.org> <20060328163932.GJ28030@miggy.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <20060328163932.GJ28030@miggy.org>
X-gpg-fingerprint: B34E4BC3
X-gpg-key: http://www.fysh.org/~athan/gpg-key
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2006 at 05:39:32PM +0100, Athanasius wrote:
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> net/built-in.o(.text+0x7c990): In function `ctnetlink_parse_nat_proto':
> : undefined reference to `ip_nat_proto_find_get'
> net/built-in.o(.text+0x7c9b2): In function `ctnetlink_parse_nat_proto':
> : undefined reference to `ip_nat_proto_put'
> net/built-in.o(.text+0x7d695): In function `ctnetlink_change_conntrack':
> : undefined reference to `ip_nat_setup_info'
> net/built-in.o(.text+0x7da9f): In function `ctnetlink_create_conntrack':
> : undefined reference to `ip_nat_setup_info'
> make: *** [.tmp_vmlinux1] Error 1
=2E..
> CONFIG_IP_NF_TARGET_TCPMSS=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_NAT_NEEDED=3Dy
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm

=2E..

  It looks like the problem was that "CONFIG_IP_NF_NAT=3Dm".  I changed
this to 'y' and things look to be compiling fine now.

  I do now note that despite using 'make oldconfig' on my 2.6.15 .config
file I had to reselect a load of Netfilter options, and it would seem I
decided this time around to have 'm' instead of 'y' there (this is for
my desktop machine where I'll only really use NAT if experimenting
before making changes to the router/firewall machine).

  Basically it's a failure with 'make oldconfig' in some way, but if we
can select 'm' for CONFIG_IP_NF_NAT then surely it should work.

-Ath
--=20
- Athanasius =3D Athanasius(at)miggy.org / http://www.miggy.org/
                  Finger athan(at)fysh.org for PGP key
	   "And it's me who is my enemy. Me who beats me up.
Me who makes the monsters. Me who strips my confidence." Paula Cole - ME

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFELWI8Ir2uvLNOS8MRAj2PAJ99cb+L8wWvQWJT0QYjO1v5VpA8GgCfamHS
Hgt0xIKHfVTpIXNy2GfavN8=
=QVQW
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
