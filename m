Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTJBLiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 07:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbTJBLiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 07:38:11 -0400
Received: from smtp2.actcom.co.il ([192.114.47.15]:2436 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263288AbTJBLiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 07:38:09 -0400
Date: Thu, 2 Oct 2003 14:37:55 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Bader <miles@gnu.org>, Jamie Lokier <jamie@shareable.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20031002113755.GQ29313@actcom.co.il>
References: <20030929090629.GF29313@actcom.co.il> <20030929153437.GB21798@mail.jlokier.co.uk> <20030930071005.GY729@actcom.co.il> <buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030930074138.GG729@actcom.co.il> <buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030930092403.GR29313@actcom.co.il> <buon0cm1tpm.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BN1FuguMf1o6kBCi"
Content-Disposition: inline
In-Reply-To: <buon0cm1tpm.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BN1FuguMf1o6kBCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2003 at 07:00:53PM +0900, Miles Bader wrote:
> Muli Ben-Yehuda <mulix@mulix.org> writes:
> > I like code that is "future proof", especially when it doesn't cost
> > anything.
>=20
> Sure, it's not always worth the trouble/pain to do so unless you've
> actually got some reason to think it will be mis-used.
>=20
> This is seeming more and more like such a case: it's a very special
> purpose macro which is only used by two other small functions, both of
> which are located immediately adjacent to the macro's definition.

After taking the time to cool down from the testosterone rush commonly
induced by micro optimizations, I recon you're right. Andrew, please
apply this documentation only patch against 2.6.0-t6-mm2: =20

--- linux-2.5/include/linux/mman.h	Sun Sep  7 10:05:18 2003
+++ optimizing-macro-2.6.0-t6/include/linux/mman.h	Tue Sep 30 09:47:19 2003
@@ -28,8 +28,13 @@
 	vm_acct_memory(-pages);
 }
=20
-/* Optimisation macro. */
-#define _calc_vm_trans(x,bit1,bit2) \
+/*=20
+ * Optimisation macro.  It is equivalent to:=20
+ *      (x & bit1) ? bit2 : 0
+ * but this version is faster. =20
+ * ("bit1" and "bit2" must be single bits).=20
+ */
+#define _calc_vm_trans(x, bit1, bit2) \
   ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
    : ((x) & (bit1)) / ((bit1) / (bit2)))
=20

--=20
Muli Ben-Yehuda
http://www.mulix.org


--BN1FuguMf1o6kBCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fA4TKRs727/VN8sRAtZ9AJ4w/uLidKCPMHq5scBYrbIVDXNrigCbBJ6U
dTcQgV+rurOey+eBCGLWwkc=
=n7vz
-----END PGP SIGNATURE-----

--BN1FuguMf1o6kBCi--
