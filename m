Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbULEWUM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbULEWUM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbULEWUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:20:12 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:10122 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S261348AbULEWUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:20:03 -0500
Date: Mon, 6 Dec 2004 00:20:01 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCH_SLAB_MINALIGN for 2.6.10-rc3
Message-ID: <20041205222001.GB25689@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Manfred Spraul <manfred@colorfullife.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41B37E06.3030702@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
In-Reply-To: <41B37E06.3030702@colorfullife.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Manfred,

On Sun, Dec 05, 2004 at 10:30:46PM +0100, Manfred Spraul wrote:
> >--- orig/include/asm-sh64/uaccess.h
> >+++ mod/include/asm-sh64/uaccess.h
> >@@ -313,6 +313,12 @@
> >   sh64 at the moment). */
> >#define ARCH_KMALLOC_MINALIGN 8
> >
> >+/*
> >+ * We want 8-byte alignment for the slab caches as well, otherwise we h=
ave
> >+ * the same BYTES_PER_WORD (sizeof(void *)) min align in=20
> >kmem_cache_create().
> >+ */
> >+#define ARCH_SLAB_MINALIGN 8
> >+
> >=20
> >
> Could you make that dependant on !CONFIG_DEBUG_SLAB? Setting align to a=
=20
> non-zero value disables some debug code.
>=20
align is only being set to ARCH_SLAB_MINALIGN in kmem_cache_create()
where it is otherwise being set to BYTES_PER_WORD as a default. Unless I
am missing something, that will always set it non-zero irregardless of
whether ARCH_SLAB_MINALIGN is set.

Are you suggesting that ARCH_SLAB_MINALIGN be set to 0 in the
CONFIG_DEBUG_SLAB case? In that case, the check should be in mm/slab.c
and not in the arch-specific code (as any other platform wishing to have
fixed slab min alignment would have to do the same checks).

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBs4mR1K+teJFxZ9wRAnJ6AJwNDpKuIj3YWBBQJ3ske7syO9gpqwCdFgvQ
5WM4+TVhSbk7E4Q0KPu2doA=
=PFaR
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--
