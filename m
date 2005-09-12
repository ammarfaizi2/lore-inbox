Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVILUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVILUyE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVILUyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:54:04 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21144 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932234AbVILUyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:54:03 -0400
Message-Id: <200509122053.j8CKrvxP032593@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Assar <assar@permabit.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] nfs client, kernel 2.4.31: readlink result overflow 
In-Reply-To: Your message of "Mon, 12 Sep 2005 16:41:19 EDT."
             <788xy2qas0.fsf@sober-counsel.permabit.com> 
From: Valdis.Kletnieks@vt.edu
References: <78irx6wh6j.fsf@sober-counsel.permabit.com> <200509121846.j8CIk5YE025124@turing-police.cc.vt.edu> <784q8qrsad.fsf@sober-counsel.permabit.com> <200509122001.j8CK1kpW028651@turing-police.cc.vt.edu>
            <788xy2qas0.fsf@sober-counsel.permabit.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1126558436_2852P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 16:53:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1126558436_2852P
Content-Type: text/plain; charset=us-ascii

On Mon, 12 Sep 2005 16:41:19 EDT, Assar said:
> Valdis.Kletnieks@vt.edu writes:
> > > To my reading, the 2.6.13 code does not copy the 4 bytes of length to
> > > rcvbuf.
> > 
> > Hmm... it still does this:
> > 	kaddr[len+rcvbuf->page_base] = '\0';
> > which still has a possible off-by-one? (Was that why you have -1 -4?)
> 
> The check is different.  2.6.13 is using ">=" instead of ">", so hence
> I think that's fine.

Argh.  Where's my reading glasses? ;)  Yes, a >= check works there....

> +	if (len > rcvbuf->page_len - sizeof(*strlen) - 1)
> +		len = rcvbuf->page_len - sizeof(*strlen) - 1;

OK, looks saner to me, but Trond and Marcelo probably get to make the final decision ;)

--==_Exmh_1126558436_2852P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDJerkcC3lWbTT17ARAujnAJsFvO1dl4EQ++T+Qq5mXbQ1dku2mgCbBzjf
i8y71rxxxxXODxa6/4JfYPg=
=oa1T
-----END PGP SIGNATURE-----

--==_Exmh_1126558436_2852P--
