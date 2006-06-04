Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932246AbWFDU6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWFDU6D (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 16:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWFDU6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 16:58:03 -0400
Received: from pool-72-66-198-190.ronkva.east.verizon.net ([72.66.198.190]:710
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932246AbWFDU6B (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 16:58:01 -0400
Message-Id: <200606042056.k54KuoKQ005588@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, mingo@elte.hu, arjan@linux.intel.com,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
In-Reply-To: Your message of "Sun, 04 Jun 2006 13:33:26 PDT."
             <20060604133326.f1b01cfc.akpm@osdl.org>
From: Valdis.Kletnieks@vt.edu
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
            <20060604133326.f1b01cfc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1149454606_2972P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 04 Jun 2006 16:56:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1149454606_2972P
Content-Type: text/plain; charset=us-ascii

On Sun, 04 Jun 2006 13:33:26 PDT, Andrew Morton said:

> Why does the locking validator complain about unlocking ordering?

Presumably, if the lock nesting *should* be "take A, take B, release B,
release A", if it sees "Take A, Take B, release A" it means there's
potentially a missing 'release B' that got forgotten (most likely an
error case that does a 'return;' instead of a 'goto end_of_function_cleanup'
like we usually code.

Having said that, I'm not sure it qualifies as a "BUG".  Certainly would
qualify for a "SMELLS_FISHY" though.  But we don't have one of those handy,
so maybe BUG is as good as it gets (given that the person who built the
kernel *asked* to be nagged about locking funkyness)....

--==_Exmh_1149454606_2972P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEg0kOcC3lWbTT17ARAoRGAJ97Yaem/CASOjsP0kQsqraG1adi4QCeLcD5
g4Y8CyUR+9qsx0dvqskXDlA=
=eT4f
-----END PGP SIGNATURE-----

--==_Exmh_1149454606_2972P--
