Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbUD1UEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUD1UEJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUD1UDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:03:33 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:1921 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261159AbUD1TSb (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 15:18:31 -0400
Message-Id: <200404281918.i3SJIPPR005391@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Goran Cengic <cengic@s2.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Special place for tird-party modules. 
In-Reply-To: Your message of "Wed, 28 Apr 2004 18:14:24 +0200."
             <200404281814.24991.cengic@s2.chalmers.se> 
From: Valdis.Kletnieks@vt.edu
References: <200404281814.24991.cengic@s2.chalmers.se>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1834002709P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Apr 2004 15:18:25 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1834002709P
Content-Type: text/plain; charset=us-ascii

On Wed, 28 Apr 2004 18:14:24 +0200, Goran Cengic <cengic@s2.chalmers.se>  said:

> I do understand that many developers have several kernel version installed at
> the same time but is it possible to share between the versions at least the 
> modules that are not developed as the part of the kernel?
> 
> If I'm missing something cruical please point it out to me.

What you're missing is the reason for modversions to exist - the fact that the
kernel API *does* change between releases, and even within the same source tree
(UP vs SMP builds, for instance).  If we supported what you're suggesting, then
the following *will* happen:

1) Binary module for 2.6.N is released that uses an API that takes 5 parameters.
2) 2.6.N+1 comes out, and said API has another parameter added (see the recent
tweak-fest for elf_map() for an actual example).
3) User loads old binary into kernel.
4) Kernel OOPs when it dereferences the non-existent 6th parameter that wasn't
passed by the un-updated binary.



--==_Exmh_1834002709P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAkAOAcC3lWbTT17ARAs3eAKDTt6GjYOdp6xDysfpstnF17bbKggCg/sX5
s1xV6JdWNwQzuU5RupVMA4Y=
=mqpZ
-----END PGP SIGNATURE-----

--==_Exmh_1834002709P--
