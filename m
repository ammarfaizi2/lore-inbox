Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUGDRXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUGDRXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 13:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265219AbUGDRXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 13:23:45 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:7640 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S265215AbUGDRXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 13:23:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: move O_LARGEFILE forcing to filp_open()
Date: Sun, 4 Jul 2004 19:22:42 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com> <200407041422.57614.arnd@arndb.de> <20040704161530.GF21066@holomorphy.com>
In-Reply-To: <20040704161530.GF21066@holomorphy.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_lzD6AB/ZtTnSvUc";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407041922.45976.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_lzD6AB/ZtTnSvUc
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sonntag, 4. Juli 2004 18:15, William Lee Irwin III wrote:
> Your patch is also necessary; thanks for covering these cases.

I'm not sure if you understood the intention of compat_sys_open
right. Old 32 bit applications assume they are not using O_LARGEFILE,
so you can't switch it on unconditionally in filp_open() for those
cases. With your patch applied, sys_open and compat_sys_open would
be identical again, which reverses the point of my patch.

What is need is a way to turn on O_LARGEFILE on 64 bit archs for
every use of filp_open _except_ from compat_sys_open.

	Arnd <><

--Boundary-02=_lzD6AB/ZtTnSvUc
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA6Dzl5t5GS2LDRf4RAkngAJ9X5Ms8l9JjVwuJcjMcIIycOMkqBgCfVq7d
/w/w61jaosi4YukRXdZ/2NE=
=WImz
-----END PGP SIGNATURE-----

--Boundary-02=_lzD6AB/ZtTnSvUc--
