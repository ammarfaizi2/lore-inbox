Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbWC1IJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbWC1IJj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWC1IJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:09:39 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:22232 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1751372AbWC1IJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:09:38 -0500
Date: Tue, 28 Mar 2006 10:09:26 +0200
From: Harald Welte <laforge@netfilter.org>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: failed to configure iptables with 2.6.16 kernel
Message-ID: <20060328080925.GE28782@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Hubert Tonneau <hubert.tonneau@fullpliant.org>,
	linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
References: <064FKGY12@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <064FKGY12@briare1.heliogroup.fr>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2006 at 04:00:33AM +0000, Hubert Tonneau wrote:
> When upgrading from 2.6.15 to 2.6.16 I noticed iptables not working anymo=
re.
>
> I traced the problem down to a new 'CONFIG_NETFILTER_XTABLES' compile opt=
ion
> that must be set, but I still get some rules rejected as soon as
> '--destination-port' option is used.
>=20
> As an example, the following command:
>   iptables -A eth0in -p udp --destination-port 111 -j DROP

this sounds like you're missing support for the tcp/udp match.
This functionality is implemented in xt_tcpudp.{c,ko}, which is compiled
as soon as x_tables is compiled.

What does cat /proc/netip_tables_matches show before and after executing
your iptables command, and before/after manually executing modprobe
xt_tcpudp.

Also, what is your iptables program version?

Please follow-up-to netfilter@lists.netfilter.org, but keep me in Cc

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEKO81XaXGVTD0i/8RAs8SAJ0btAexlhAFnE8zHobLiI62AiPSAwCfe0eu
8OlsybppMfuNFDhPbr9s/fU=
=dVTD
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
