Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTJOKIQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 06:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbTJOKIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 06:08:16 -0400
Received: from coruscant.franken.de ([193.174.159.226]:15843 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S262525AbTJOKIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 06:08:12 -0400
Date: Wed, 15 Oct 2003 11:48:06 +0200
From: Harald Welte <laforge@netfilter.org>
To: Florian Zwoch <zwoch@backendmedia.com>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Mailinglist <netfilter@lists.netfilter.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       netdev@oss.sgi.com
Subject: Re: why does netfilter make upload very slow? (was: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction)
Message-ID: <20031015094805.GH9880@obroa-skai.de.gnumonks.org>
Reply-To: netfilter-devel@lists.netfilter.org
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Florian Zwoch <zwoch@backendmedia.com>,
	linux-kernel@vger.kernel.org,
	Netfilter Mailinglist <netfilter@lists.netfilter.org>,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>,
	netdev@oss.sgi.com
References: <20031008153237.GC25743@sunbeam.de.gnumonks.org> <3F8D0542.1060101@backendmedia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="54ZiyWcDhi/7bWb8"
Content-Disposition: inline
In-Reply-To: <3F8D0542.1060101@backendmedia.com>
X-Operating-System: Linux obroa-skai.de.gnumonks.org 2.4.23-pre5-ben0
X-Date: Today is Boomtime, the 68th day of Bureaucracy in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--54ZiyWcDhi/7bWb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Florian!

I'm Cc'ing all the mailinglists in order to keep them posted about the
question you've raised there.  All further discussion will move to
netfilter-devel, so for those interested: Please continue there.

On Wed, Oct 15, 2003 at 10:28:50AM +0200, Florian Zwoch wrote:
> >a) CONFIG_NETFILTER disabled.  you won't even have the netfilter hooks
> >   in the network stack (so certainly no netfilter-using modules loaded)
> no problem
>=20
> >b) CONFIG_NETFILTER enabled, but _no_ modules (iptable_filter,
> >   ip_conntrack, ...) attached to the netfilter hook
> no problem
>=20
> >c) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.=
o)
> >   loaded, NO RULES in the table
> no problem
>=20
> >d) CONFIG_NETFILTER enabled and iptable_filter.o (which pulls ip_tables.=
o)
> >   loaded, RULES in the table
> no problem (as long as i dont load any rules that require ip_conntrack)
>=20
> >e) CONFIG_NETFILTER enabled and ip_conntrack.o loaded, iptable_filter
> >   loaded or not, rules or not
> *boink*

So It's clearly the connection tracking subsystem.  This is on one hand
good (because it means it's neither netfilter nor iptables). =20

> whenever i try to load ip_conntrack the nic performance drops from 5mb/s=
=20
> to 200k/s.

On the other hand, this is definitely way worse than you would expect.
Can you please tell me more information about:

- number of connections you have? (cat /proc/net/ip_conntrack | wc -l)
- number of buckets and ip_conntrack_max (printed at ip_conntrack
  loadtime
- your traffic pattern.  Are you spraying udp packets with random
  src/dst? What kind of connections (protocol, application) are you
  testing with?
- what about the hardware (cpu, memory, smp?)

Even the worst tests we've had so far (random UDP packets) 'only'
reduced the througput by about 50%.   Maybe we can do better than 50%
worst case behaviour, but you will always observe a visible impact as
soon as you start connection tracking for every single packet (which is
what 'insmod ip_conntrack' implies).

> still using 2.6.0-test6.

Have you observed this behaviour with other kernel versions?  Was there
a performance change between 2.4 and 2.6?  Or did you always observe
this grave performance loss?

> regards,
> Florian

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--54ZiyWcDhi/7bWb8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/jRfVXaXGVTD0i/8RAooiAJ9KsqxBOUWjMrm7zk5JHwiRL6cE4QCeMybJ
oDYc8U/PkIQqk89TXSHrf2Q=
=nLuA
-----END PGP SIGNATURE-----

--54ZiyWcDhi/7bWb8--
