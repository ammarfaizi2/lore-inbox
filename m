Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbTAOFoI>; Wed, 15 Jan 2003 00:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTAOFoI>; Wed, 15 Jan 2003 00:44:08 -0500
Received: from h80ad267b.async.vt.edu ([128.173.38.123]:3712 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261375AbTAOFoH>; Wed, 15 Jan 2003 00:44:07 -0500
Message-Id: <200301150552.h0F5qTm1001174@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Patrick Mochel <mochel@osdl.org>
Cc: ivangurdiev@attbi.com, LKML <linux-kernel@vger.kernel.org>,
       James.Bottomley@steeleye.com
Subject: Re: 2.5.58 Oops when booting from initrd - kobject_del 
In-Reply-To: Your message of "Tue, 14 Jan 2003 15:53:26 CST."
             <Pine.LNX.4.33.0301141552130.1025-100000@localhost.localdomain> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.33.0301141552130.1025-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-88914492P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 15 Jan 2003 00:52:28 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-88914492P
Content-Type: text/plain; charset=us-ascii

On Tue, 14 Jan 2003 15:53:26 CST, Patrick Mochel said:
> Could you please try the following patch and see if it fixes the problem?

This fix worked for me.. am on 2.5.58 right now....  Many thanks..

/Valdis 

> ===== drivers/block/elevator.c 1.36 vs edited =====
> --- 1.36/drivers/block/elevator.c	Sun Jan 12 08:10:40 2003
> +++ edited/drivers/block/elevator.c	Tue Jan 14 15:46:00 2003
> @@ -431,10 +431,13 @@
>  void elv_unregister_queue(struct gendisk *disk)
>  {
>  	request_queue_t *q = disk->queue;
> -	elevator_t *e = &q->elevator;
> +	elevator_t *e;
>  
> -	kobject_unregister(&e->kobj);
> -	kobject_put(&disk->kobj);
> +	if (q) {
> +		e = &q->elevator;
> +		kobject_unregister(&e->kobj);
> +		kobject_put(&disk->kobj);
> +	}
>  }
>  
>  elevator_t elevator_noop = {
> 
> 


--==_Exmh_-88914492P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+JPcccC3lWbTT17ARAkn7AKDrOnN4g7/9grR8U/cLKI+9nDjdlgCeL09b
NndYwVBuUVXxs0612DzxCn0=
=9XzB
-----END PGP SIGNATURE-----

--==_Exmh_-88914492P--
