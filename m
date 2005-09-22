Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030296AbVIVM53@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030296AbVIVM53 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVIVM52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:57:28 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:62409 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1030290AbVIVM51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:57:27 -0400
Date: Thu, 22 Sep 2005 14:57:24 +0200
From: Harald Welte <laforge@netfilter.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050922125724.GJ26520@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Eric Dumazet <dada1@cosmosbay.com>, linux-kernel@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org,
	Andi Kleen <ak@suse.de>
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de> <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de> <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com> <4331D0A9.3080801@cosmosbay.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <4331D0A9.3080801@cosmosbay.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "ganesha", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Wed, Sep 21, 2005 at 11:29:13PM +0200, Eric Dumazet
	wrote: > Patch 1/3 > > 1) No more one rwlock_t protecting the 'curtain'
	I have no problem with this change "per se", but with the
	implementation. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 TW_RW                  BODY: Odd Letter Triples with RW
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 21, 2005 at 11:29:13PM +0200, Eric Dumazet wrote:
> Patch 1/3
>=20
> 1) No more one rwlock_t protecting the 'curtain'

I have no problem with this change "per se", but with the
implementation.

As of now, we live without any ugly #ifdef CONFIG_SMP / #endif sections
in the code - and if possible, I would continue this good tradition.

For example the get_counters() function.  Wouldn't all the smp specific
code (for_each_cpu(), ...)  be #defined to nothing anyway?

And if we really need the #ifdef's, I would appreciate if those
sectionas are as small as possible.  in get_counters() the section can
definitely be smaller, rather than basically having the whole function
body separate for smp and non-smp cases.

Also, how much would we loose in runtime performance if we were using a
"rwlock_t *" even in the UP case?.  I mean, it's just one more pointer
dereference of something that is expected to be in cache anyway, isn't
it?  This gets rid of another huge set of #ifdefs that make the code
unreadable and prone to errors being introduced later on.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDMqo0XaXGVTD0i/8RAqmfAJ4wK16fo/z10f3AhLri+4P+LemXVACdFrDh
kp2OtLw2758hy9k1bsfZZuY=
=Plu3
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
