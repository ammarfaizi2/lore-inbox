Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265516AbUFSBFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265516AbUFSBFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 21:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbUFSBFO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 21:05:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:11912 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S265726AbUFSBDH (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 21:03:07 -0400
Message-Id: <200406190103.i5J13WWr010687@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Ashwin Rao <ashwin_s_rao@yahoo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Subject: Re: Atomic operation for physically moving a page 
In-Reply-To: Your message of "Fri, 18 Jun 2004 17:37:12 PDT."
             <20040619003712.35865.qmail@web10904.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040619003712.35865.qmail@web10904.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_2143241308P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 18 Jun 2004 21:03:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_2143241308P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Jun 2004 17:37:12 PDT, Ashwin Rao <ashwin_s_rao@yahoo.com>  said:
> I want to copy a page from one physical location to
> another (taking the appr. locks).

At the risk of sounding stupid, what problem are you trying to solve by copying
a page? Not only (as you note) could the page be referenced by multiple
processes, it could (conceivably) belong to a kernel slab or something, or be a
buffer for an in-flight I/O request, or any number of other possibly-racy
situations.

If it's only a specific *type* of page, or explaining why you're trying to do
it, or what timing/etc constraints you have (if it's a sufficiently rare(*) case,
it might make sense to just grab the BKL and copy the page with a memcpy().)

(*) Yes, I know the BKL isn't something you want to grab if you can help it.
However, if we're on an unlikely error path or similar and other options aren't suitable...

--==_Exmh_2143241308P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA05DkcC3lWbTT17ARAtIwAKDIDKx6Dr1h/YWjiK9vQa1fqiNBEQCffNhl
JM0kZtJZXlIqCtmwCofKEqI=
=CR+5
-----END PGP SIGNATURE-----

--==_Exmh_2143241308P--
