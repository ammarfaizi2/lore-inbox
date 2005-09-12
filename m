Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVILUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVILUBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVILUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:01:54 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54764 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751118AbVILUBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:01:53 -0400
Message-Id: <200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Assar <assar@permabit.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow 
In-Reply-To: Your message of "Mon, 12 Sep 2005 15:37:46 EDT."
             <784q8qrsad.fsf@sober-counsel.permabit.com> 
From: Valdis.Kletnieks@vt.edu
References: <78irx6wh6j.fsf@sober-counsel.permabit.com> <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu>
            <784q8qrsad.fsf@sober-counsel.permabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126555306_2852P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 16:01:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126555306_2852P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Sep 2005 15:37:46 EDT, Assar said:
> Valdis.Kletnieks@vt.edu writes:
> > Odd, as it has similar code - 2.6.13-mm1 nfs2xdr.c has:
> >         /* Convert length of symlink */
> >         len = ntohl(*p++);
> >         if (len >= rcvbuf->page_len || len <= 0) {
> 
> To my reading, the 2.6.13 code does not copy the 4 bytes of length to
> rcvbuf.

Hmm... it still does this:
	kaddr[len+rcvbuf->page_base] = '\0';
which still has a possible off-by-one? (Was that why you have -1 -4?)

> > Am I the only one who finds an uncommented "-1 -4" construct scary beyond belief?
> 
> Probably not.  What do you think looks better?  sizeof(u32) ?

sizeof(actual_var) is even better, as that way it's clear what you're allowing
space for.


--==_Exmh_1126555306_2852P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDJd6qcC3lWbTT17ARAvapAKDBh6JwVgqNdo7lUgbwA5rSskuosgCguJSy
FNNGVk2wdEp07DdDtw9GSXw=
=B+Rz
-----END PGP SIGNATURE-----

--==_Exmh_1126555306_2852P--
