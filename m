Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTKWDXF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 22:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263241AbTKWDXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 22:23:05 -0500
Received: from h80ad24a3.async.vt.edu ([128.173.36.163]:20359 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263228AbTKWDXB (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 22:23:01 -0500
Message-Id: <200311230322.hAN3Me7a023773@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: David Wuertele <dave-gnus@bfnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do I need kswapd if I don't have swap? 
In-Reply-To: Your message of "Sat, 22 Nov 2003 17:35:57 PST."
             <m3d6bj3lz6.fsf@bfnet.com> 
From: Valdis.Kletnieks@vt.edu
References: <m3d6bj3lz6.fsf@bfnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1986722080P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 22 Nov 2003 22:22:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-1986722080P
Content-Type: text/plain; charset=us-ascii

On Sat, 22 Nov 2003 17:35:57 PST, David Wuertele <dave-gnus@bfnet.com>  said:

>     while (1) {
>       unsigned char *buf = (unsigned char *) malloc (UNIT);
>       if (!buf) return 0;
>       totalmalloc += UNIT; fprintf (stderr, "%u ", totalmalloc);
>       for (j=0; j<UNIT; j++) buf[j] = j % 256;
>       totalwrote += UNIT; fprintf (stderr, "%u ", totalwrote);
>       for (j=0; j<UNIT; j++) if (buf[j] != (j % 256)) return -1;
>       totalread += UNIT; fprintf (stderr, "%u\n", totalread);
>     }

>   M26916864
>   W26916864
>   R26916864

Hmm.. the output doesn't match the fprintf()s. Doesn't give me
warm fuzzies...

> The malloc call isn't even returning.  What could explain that?

Alternate theory - the last time through the loop, you get to the fprintf() of
totalread, you go INTO that call, the output makes it out, but some final
malloc() call *within fprintf* or something fails due to being out of memory
(or any number of other failure modes due to being almost but not totally out
of memory), so you never return to start the next iteration of the loop.


--==_Exmh_-1986722080P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/wCgAcC3lWbTT17ARAhpDAJ4yxAsqkPFJ4dO2WBWhx1URxip1KwCglGKc
oG+VNHIpTr6+ykf+MDAq4EI=
=swY+
-----END PGP SIGNATURE-----

--==_Exmh_-1986722080P--
