Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbVAIO1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbVAIO1O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 09:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVAIO1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 09:27:13 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:31230 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261442AbVAIO1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 09:27:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [PATCH] futex: s/0/NULL/ in pointer context
Date: Sun, 9 Jan 2005 15:19:28 +0100
User-Agent: KMail/1.6.2
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <200501091123.31402.adobriyan@mail.ru>
In-Reply-To: <200501091123.31402.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_01T4BF12tLAgP6K";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501091519.33202.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_01T4BF12tLAgP6K
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 09 Januar 2005 10:23, Alexey Dobriyan wrote:
> @@ -236,7 +236,7 @@
>   */
>  static inline void get_key_refs(union futex_key *key)
>  {
> -	if (key->both.ptr !=3D 0) {
> +	if (key->both.ptr !=3D NULL) {
>  		if (key->both.offset & 1)
>  			atomic_inc(&key->shared.inode->i_count);
>  		else

Actually, many consider the preferred way to write this

	if (key->both.ptr) {

instead, since the condition you want to check is 'is key->both.ptr
a valid pointer', not 'is key->both.ptr inequal to the invalid
pointer'. The normal use for NULL is only in assignments and=20
initializations, not in comparisons.

	Arnd <><

--Boundary-02=_01T4BF12tLAgP6K
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB4T105t5GS2LDRf4RAkb+AJ0Z3w44064RQDIVG8IfLsYRaJtgRwCgk7Pa
3HZAFVD0dEORaDcOodTUGDQ=
=ks7s
-----END PGP SIGNATURE-----

--Boundary-02=_01T4BF12tLAgP6K--
