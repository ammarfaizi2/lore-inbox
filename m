Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbTJHPpb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTJHPpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:45:31 -0400
Received: from coruscant.franken.de ([193.174.159.226]:1233 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S261582AbTJHPp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:45:29 -0400
Date: Wed, 8 Oct 2003 17:32:37 +0200
From: Harald Welte <laforge@netfilter.org>
To: ookhoi@humilis.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: why does netfilter make upload very slow? (was: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction)
Message-ID: <20031008153237.GC25743@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>, ookhoi@humilis.net,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <20031008131320.GD16964@favonius>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PYvLm/IFaQmMAfx6"
Content-Disposition: inline
In-Reply-To: <20031008131320.GD16964@favonius>
X-Operating-system: Linux sunbeam 2.6.0-test5-nftest
X-Date: Today is Sweetmorn, the 62nd day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
X-Spam-Score: -7.5 (-------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PYvLm/IFaQmMAfx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2003 at 03:13:20PM +0200, ookhoi@humilis.net wrote:
> # > I have netfilter enabled, and will try another -test6 kernel with
> # > netfilter not compiled in to see if that indeed makes a difference.
> #=20
> # I can confirm now that disabling netfilter in 2.6.0-test6 makes the nic
> # perform oke wrt upload.
> # I (just like Florian) had no iptables rules active in the former
> # 2.6.0-test6 kernel, but netfilter was compiled in.
>=20
> Would somebody like to explain why netfilter (in kernel, but not in use)
> makes upload go very slow? I am by no means a network guru, but eager to
> learn :-)

let's get this straight.  There are five possible cases

a) CONFIG_NETFILTER disabled.  you won't even have the netfilter hooks
   in the network stack (so certainly no netfilter-using modules loaded)
b) CONFIG_NETFILTER enabled, but _no_ modules (iptable_filter,
   ip_conntrack, ...) attached to the netfilter hook
c) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.o)
   loaded, NO RULES in the table
d) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.o)
   loaded, RULES in the table
e) CONFIG_NETFILTER enabled and ip_conntrack.o loaded, iptable_filter
   loaded or not, rules or not

So if you want to give us an idea about where the bottleneck might be,
please clearly indicate between which of the two cases you see this
performance penalty.=20

This way we can isolate the culprit.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--PYvLm/IFaQmMAfx6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/hC4VXaXGVTD0i/8RAtDsAKCcLd+EGsxbMYkHYiIukVc+l2gcVQCfTZu2
4lV2QGVAuIXbm8LdGSvQVGQ=
=MeeS
-----END PGP SIGNATURE-----

--PYvLm/IFaQmMAfx6--
