Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVEBJZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVEBJZs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 05:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVEBJZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 05:25:48 -0400
Received: from smtp1.pp.htv.fi ([213.243.153.37]:21699 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261166AbVEBJZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 05:25:41 -0400
Date: Mon, 2 May 2005 12:25:39 +0300
From: Paul Mundt <lethal@linux-sh.org>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepage consolidation
Message-ID: <20050502092539.GA1766@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050502043035.GB12670@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20050502043035.GB12670@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2005 at 02:30:35PM +1000, David Gibson wrote:
> 	- does SH4 need s special huge_ptep_get_and_clear()??
>=20
It does if we are trying to do multiple ptes per hugepage, but we can
actually drop most of that stuff (including ARCH_HAS_SETCLEAR_HUGE_PTE),
and use ptep_get_and_clear() instead.

We only actual have one pte per hugepage, having multiple ptes for the
page range at least for sh/sh64 was roughly an experiment in trying to
get larger ranges working, but this turned out not to be useful, so we
can pretty much switch to the more generic way of handling this.

I have patches that drop this behaviour already, so I'll bounce these
along to Andrew if this goes in -mm.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCdfIT1K+teJFxZ9wRAjz3AJwMQEEr+lHsaS7aJ4zluihpBcxsRwCfXjD2
CgtNpOCcCCJx0VJlndmZF18=
=9uEW
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
