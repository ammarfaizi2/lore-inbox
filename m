Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVCBLoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVCBLoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbVCBLoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:44:11 -0500
Received: from mivlgu.ru ([81.18.140.87]:18333 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S262275AbVCBLhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:37:32 -0500
Date: Wed, 2 Mar 2005 14:37:17 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Panagiotis Issaris <panagiotis.issaris@mech.kuleuven.ac.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raw1394 missing failure handling
Message-Id: <20050302143717.1ea9f57e.vsu@altlinux.ru>
In-Reply-To: <42259F3A.8000206@mech.kuleuven.ac.be>
References: <42259F3A.8000206@mech.kuleuven.ac.be>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__2_Mar_2005_14_37_17_+0300_fjukvIWwjgJikp1T"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__2_Mar_2005_14_37_17_+0300_fjukvIWwjgJikp1T
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 02 Mar 2005 12:10:50 +0100 Panagiotis Issaris wrote:

> In the raw1394 driver the failure handling for
> a __copy_to_user call is missing.
> 
> With friendly regards,
> Takis
> 
> -- 
>   K.U.Leuven, Mechanical Eng.,  Mechatronics & Robotics Research Group
>   http://people.mech.kuleuven.ac.be/~pissaris/
> 
> 
> 
> [pi-20050302T114855-linux_2_6_11-raw1394_copy_to_user_failure_handling.diff  text/x-patch (922 bytes)]
> diff -pruN linux-2.6.11/drivers/ieee1394/raw1394.c linux-2.6.11-pi/drivers/ieee1394/raw1394.c
> --- linux-2.6.11/drivers/ieee1394/raw1394.c	2005-03-02 11:44:26.000000000 +0100
> +++ linux-2.6.11-pi/drivers/ieee1394/raw1394.c	2005-03-02 11:47:38.000000000 +0100
> @@ -443,7 +443,8 @@ static ssize_t raw1394_read(struct file 
>                          req->req.error = RAW1394_ERROR_MEMFAULT;
>                  }
>          }
> -        __copy_to_user(buffer, &req->req, sizeof(req->req));
> +        if (__copy_to_user(buffer, &req->req, sizeof(req->req)))
> +                return -EFAULT;

Bug: "req" is not freed in the failure case.

>  
>          free_pending_request(req);
>          return sizeof(struct raw1394_request);
> 

--Signature=_Wed__2_Mar_2005_14_37_17_+0300_fjukvIWwjgJikp1T
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCJaVwW82GfkQfsqIRAqwDAJ9nIkVFmkrWB8eCKVdDxKxOSiCbZQCgjqII
/4WRwUdRSJuXr4WRWAB4rs8=
=IhXF
-----END PGP SIGNATURE-----

--Signature=_Wed__2_Mar_2005_14_37_17_+0300_fjukvIWwjgJikp1T--
