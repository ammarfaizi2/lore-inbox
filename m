Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVJ0IHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVJ0IHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 04:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbVJ0IHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 04:07:46 -0400
Received: from h80ad2453.async.vt.edu ([128.173.36.83]:7333 "EHLO
	h80ad2453.async.vt.edu") by vger.kernel.org with ESMTP
	id S964989AbVJ0IHp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 04:07:45 -0400
Message-Id: <200510270807.j9R87DCQ015462@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andrew Morton <akpm@osdl.org>, Nicolas Pitre <nico@cam.org>
Cc: linux-kernel@vger.kernel.org, Laurent Riffard <laurent.riffard@free.fr>
Subject: 2.6.14-rc5-mm1 crypto issues (was Re: intel-agp and yenta-socket issues (was Re: 2.6.14-rc5-mm1 
In-Reply-To: Your message of "Tue, 25 Oct 2005 10:07:15 EDT."
             <200510251407.j9PE7LtK014903@turing-police.cc.vt.edu> 
From: Valdis.Kletnieks@vt.edu
References: <20051024014838.0dd491bb.akpm@osdl.org> <200510250513.j9P5DjGv004612@turing-police.cc.vt.edu> <20051024223223.267d46ec.akpm@osdl.org>
            <200510251407.j9PE7LtK014903@turing-police.cc.vt.edu>
In-Reply-To: <200510251407.j9PE7LtK014903@turing-police.cc.vt.edu> (Tue, 25 Oct 2005 10:07:15 EDT)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1130400431_2704P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Oct 2005 04:07:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1130400431_2704P
Content-Type: text/plain; charset=us-ascii

I finally tracked down the root cause of the hangs - I had applied the modsign
patches from the Fedora kernel, and hit several bugs.

1) The hangs in modprobe were caused by a bug in RedHat code (a function returned
a bum pointer instead of NULL, and things went pear-shaped).  I've reported this
as bug 171835 in RedHat's bugzilla system. Redhat problem, not yours or lkml's.

2) It turns out that the issue in 171835 only bites if other things have already
gone bad.  It turns out that a patch in -rc5-mm1 causes the indigestion.

clean-crypto-sha1c-up-a-bit.patch gives the modsign patches indigestion. I'm not
sure why yet, or who's code is busticated.  All I've verified for sure is that
modsign allocates a 20-byte buffer, and with the cleanup patch applied, I'm
seeing different values in buffer[12..19].

It's 4AM, and I'm not going to chase this any further until evening. *yawn* ;)

--==_Exmh_1130400431_2704P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDYIqvcC3lWbTT17ARAn/TAKDFqTzKkNCiiwPdBGO1Weg7Nbau5QCgib8z
1NriT9IjGLdiljsMKQELTQs=
=aNeI
-----END PGP SIGNATURE-----

--==_Exmh_1130400431_2704P--
