Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVDPRiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVDPRiX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 13:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbVDPRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 13:38:23 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:27302 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S262709AbVDPRiO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 13:38:14 -0400
Date: Sun, 17 Apr 2005 03:38:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       steved@redhat.com, Bryan Henderson <hbryan@us.ibm.com>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Add 32-bit compatibility for NFSv4 mount
Message-Id: <20050417033806.65a5786a.sfr@canb.auug.org.au>
In-Reply-To: <26687.1113576302@redhat.com>
References: <26687.1113576302@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sun__17_Apr_2005_03_38_06_+1000_T=ky_ue9yWgyH3s+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__17_Apr_2005_03_38_06_+1000_T=ky_ue9yWgyH3s+
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, 15 Apr 2005 15:45:02 +0100 David Howells <dhowells@redhat.com> wrot=
e:
>
> @@ -746,10 +747,79 @@ static void *do_smb_super_data_conv(void
>  	return raw_data;
>  }
> =20
> +struct compat_nfs_string {
> +	compat_uint_t len;
> +	compat_uptr_t __user data;
                      ^^^^^^
This __user (and the others later) add nothing (I think) as compat_uptr_t is
generally just u32 and compat_ptr() does the right casting.

Otherwise, the patch looks fine for a minimal fix.  I agree with David and
Bryan that we need to get the fs specific stuff out of compat.c in the
longer term.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__17_Apr_2005_03_38_06_+1000_T=ky_ue9yWgyH3s+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCYU2E4CJfqux9a+8RAjw0AJ0chJsqYIeG8I05IgywtoYucxvvrACcDx3W
+MliWLgi/XyTRi1sgK4UmjI=
=1SC4
-----END PGP SIGNATURE-----

--Signature=_Sun__17_Apr_2005_03_38_06_+1000_T=ky_ue9yWgyH3s+--
