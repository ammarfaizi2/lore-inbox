Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbUKEQD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbUKEQD2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 11:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbUKEQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 11:03:28 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:4480 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262704AbUKEQDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 11:03:21 -0500
Message-Id: <200411050649.iA56nxFi003211@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Jens Axboe <axboe@suse.de>
Cc: Mathieu Segaud <matt@minas-morgul.org>, Andrew Morton <akpm@osdl.org>,
       jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch) 
In-Reply-To: Your message of "Tue, 02 Nov 2004 15:55:41 +0100."
             <20041102145541.GV6821@suse.de> 
From: Valdis.Kletnieks@vt.edu
References: <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de> <877jpcgolt.fsf@barad-dur.crans.org> <20041102143919.GT6821@suse.de>
            <20041102145541.GV6821@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-815045085P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 05 Nov 2004 01:49:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-815045085P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 02 Nov 2004 15:55:41 +0100, Jens Axboe said:

> Ehm, that should be
>=20
> 		if ((isize - offset))
> 			bytes_todo =3D isize - offset;
> 		else if (bytes_todo > PAGE_SIZE)
> 			bytes_todo =3D PAGE_SIZE;

(Sorry for delay in testing this one...)

This version fixes my LVM issues on 2.6.10-rc1-mm2 as well...

>=20
> --- /opt/kernel/linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-10-27 08:29:51=
.000
000000 +0200
> +++ linux-2.6.10-rc1-mm1/fs/direct-io.c	2004-11-02 15:55:27.918459070 +=

0100
> =40=40 -985,10 +985,12 =40=40
>  	=7D
> =20
>  	isize =3D i_size_read(inode);
> -	if (bytes_todo > (isize - offset))
> -		bytes_todo =3D isize - offset;
> -	if (=21bytes_todo)
> -		return 0;
> +	if (bytes_todo > (isize - offset)) =7B
> +		if ((isize - offset))
> +			bytes_todo =3D isize - offset;
> +		else if (bytes_todo > PAGE_SIZE)
> +			bytes_todo =3D PAGE_SIZE;
> +	=7D
> =20
>  	for (seg =3D 0; seg < nr_segs && bytes_todo; seg++) =7B
>  		user_addr =3D (unsigned long)iov=5Bseg=5D.iov_base;
> =40=40 -1008,10 +1010,9 =40=40
>  		dio->curr_page =3D 0;
> =20
>  		dio->total_pages =3D 0;
> -		if (user_addr & (PAGE_SIZE-1)) =7B
> +		if (user_addr & (PAGE_SIZE-1))
>  			dio->total_pages++;
> -			bytes -=3D PAGE_SIZE - (user_addr & (PAGE_SIZE - 1));
> -		=7D
> +
>  		dio->total_pages +=3D (bytes + PAGE_SIZE - 1) / PAGE_SIZE;
>  		dio->curr_user_address =3D user_addr;
>  =09
>=20
> --=20
> Jens Axboe
>=20
> -
> To unsubscribe from this list: send the line =22unsubscribe linux-kerne=
l=22 in
> the body of a message to majordomo=40vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--==_Exmh_-815045085P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBiyKXcC3lWbTT17ARArO1AKDY7dRp6R6x6UB9SwN6mWmNuPnq+gCgwMJI
HfGGIhmfQRh2brn3nwcEE8Q=
=tMXF
-----END PGP SIGNATURE-----

--==_Exmh_-815045085P--
