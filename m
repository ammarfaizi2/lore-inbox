Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264776AbUEETvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264776AbUEETvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 15:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEETvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 15:51:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28083 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264776AbUEETvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 15:51:37 -0400
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Steve Lord <lord@xfs.org>
Cc: Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40991A8D.5000008@xfs.org>
References: <20040505013135.7689e38d.akpm@osdl.org>
	 <200405051312.30626.dominik.karall@gmx.net>
	 <20040505043002.2f787285.akpm@osdl.org>  <40991A8D.5000008@xfs.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GN8LQbSjHp99QiHkw6N4"
Organization: Red Hat UK
Message-Id: <1083786663.3844.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 05 May 2004 21:51:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GN8LQbSjHp99QiHkw6N4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Is it less pain than making something like a memory allocation which come=
s
> out of a deep stack? Say, nfs server -> filesystem -> lvm/raid -> fiber c=
hannel,
> which itself does something like a writepage into an nfs filesystem and e=
nds
> up in the networking stack? OK, getting back into the filesystem on a
> memory allocation from the block layer should not happen, but you could
> certainly be down in

it's not really much different than the 2.4 kernel already has.
In 2.4 you have a 8Kb stack of which

First 1600 bytes (+/-) are for the task struct
about 4Kb of user context stack
>=3D 2Kb stack which is needed for irq context (both soft and hard)

In 2.6 with this patch you have

32 bytes for thread info
4Kb minus 32 bytes for context stack
SEPARATE softirq stack of 4K
SEPARATE hardirq stack of 4K

so in a way you have MORE stack space than in 2.4.

Now I'll fully admit the 2Kb is somewhat of a stochast, you only hit it
if you have iptable rules and 2 nic irq's arriving on the same cpu at an
unfortionate moment, but that doesn't mean it's a safe situation.


--=-GN8LQbSjHp99QiHkw6N4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAmUWnxULwo51rQBIRArsFAJ4vH/Evmq46bzVJscXHfGpmMiD+IwCcD8Ap
8NjHc6qyf9nJaC6GejmbbJA=
=MRTu
-----END PGP SIGNATURE-----

--=-GN8LQbSjHp99QiHkw6N4--

