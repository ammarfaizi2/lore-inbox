Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbUKJJzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbUKJJzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUKJJzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:55:47 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:29327 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261581AbUKJJzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:55:40 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH x86_64]: Setup PER_LINUX32 on x86_64
Date: Wed, 10 Nov 2004 10:51:37 +0100
User-Agent: KMail/1.6.2
Cc: "Jin, Gordon" <gordon.jin@intel.com>, <linux-kernel@vger.kernel.org>
References: <8126E4F969BA254AB43EA03C59F44E84BBECA2@pdsmsx404>
In-Reply-To: <8126E4F969BA254AB43EA03C59F44E84BBECA2@pdsmsx404>
MIME-Version: 1.0
Message-Id: <200411101051.37702.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_pSekBNiT/FbOubi";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_pSekBNiT/FbOubi
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Dinsdag 02 November 2004 09:47, Jin, Gordon wrote:
> On x86_64, PER_LINUX32 is not setup but used by syscall personality and uname.
> This patch sets PER_LINUX32 when x86 binary loaded so it can be used correctly.
> - Set personality to PER_LINUX32 when x86 binary loaded.
> - Set personality to PER_LINUX when x86_64 binary loaded.
> - Use sys32_personality instead of sys_personality.
> - Add sys32_newuname() for syscall newuname.
> - Remove the unnecessary check for PER_LINUX32 in sys_uname().

That behavior would be significantly different from the current one,
which is also used on all other biarch architectures. This probably
breaks lots of user setups.

I also think the current behavior is the right one. For things like
configure, you need a way to set the uname independent of the binary
format of your shell. Another example is building rpm packages
on a mixed system, where should be able to set the personality
to decide which target architecture to build for.

	Arnd <><



--Boundary-02=_pSekBNiT/FbOubi
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBkeSp5t5GS2LDRf4RAhX6AJ43AQkam4S9xL/uRbS8U7dyeD35wACfREHb
jE0cLsjcuaW//VnzCZxkgGk=
=0Vda
-----END PGP SIGNATURE-----

--Boundary-02=_pSekBNiT/FbOubi--
