Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUCRSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 13:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262812AbUCRSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 13:07:57 -0500
Received: from mivlgu.ru ([81.18.140.87]:33428 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S262827AbUCRSHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 13:07:48 -0500
Date: Thu, 18 Mar 2004 21:07:44 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: mlord@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: vmalloc fix buggy again?
Message-ID: <20040318180744.GE16242@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

> # ChangeSet
> #   2004/03/14 13:16:58-03:00 mlord...
> #   [PATCH] Yet another vmalloc() fixup
> # 
> diff -Nru a/mm/vmalloc.c b/mm/vmalloc.c
> --- a/mm/vmalloc.c	Thu Mar 18 09:44:53 2004
> +++ b/mm/vmalloc.c	Thu Mar 18 09:44:53 2004
> @@ -184,7 +184,7 @@
>  	spin_unlock(&init_mm.page_table_lock);
>  	flush_cache_all();
>  	if (address > start)
> -		vmfree_area_pages((address - start), address - start);
> +		vmfree_area_pages(address, address - start);
>  	return -ENOMEM;
>  }
>  

Looks like this should be

		vmfree_area_pages(start, address - start);

-- 
Sergey Vlasov

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAWeVwW82GfkQfsqIRAjoBAJ4xLTvj6EmGTca33YYC6JlskYmwJwCfQ8PW
oDEtqWHlt1Vxe5HiUqjUeoA=
=hwGb
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--
