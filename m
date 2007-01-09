Return-Path: <linux-kernel-owner+w=401wt.eu-S932402AbXAIW5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbXAIW5v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAIW5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 17:57:51 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51946 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbXAIW5u (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 17:57:50 -0500
Message-Id: <200701092257.l09MvM82029636@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Hua Zhong <hzhong@gmail.com>,
       Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
In-Reply-To: Your message of "Tue, 09 Jan 2007 11:02:35 PST."
             <88063.16727.qm@web55602.mail.re4.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <88063.16727.qm@web55602.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168383442_27952P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2007 17:57:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168383442_27952P
Content-Type: text/plain; charset=us-ascii

On Tue, 09 Jan 2007 11:02:35 PST, Amit Choudhary said:
> Correct. And doing kfree(x); x=NULL; is not hiding that. These issues can still be debugged by
> using the slab debugging options. One other benefit of doing this is that if someone tries to
> access the same memory again using the variable 'x', then he will get an immediate crash. And the
> problem can be solved immediately, without using the slab debugging options. I do not yet
> understand how doing this hides the bugs, obfuscates the code, etc. because I haven't seen an
> example yet, but only blanket statements.

char *broken() {
	char *x, *y;
	x = kmalloc(100);
	y = x;
	kfree(x);
	x = NULL;
	return y;
}

Setting x to NULL doesn't do anything to fix the *real* bug here, because
the problematic reference is held in y, not x.  So you never get a crash
because somebody dereferences x.


--==_Exmh_1168383442_27952P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFpB3ScC3lWbTT17ARAnfZAKCxg004s3VdvPUl9+hc+BrDKzCHQQCgznxz
sW0ND/XWul1s1vS3BL2T2bg=
=2XLS
-----END PGP SIGNATURE-----

--==_Exmh_1168383442_27952P--
