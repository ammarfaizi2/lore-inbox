Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264993AbSKFL4K>; Wed, 6 Nov 2002 06:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264996AbSKFL4K>; Wed, 6 Nov 2002 06:56:10 -0500
Received: from fw.2d3d.co.za ([66.8.28.230]:5317 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S264993AbSKFL4J>;
	Wed, 6 Nov 2002 06:56:09 -0500
Date: Wed, 6 Nov 2002 14:02:22 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: Pannaga Bhushan <bhushan@multitech.co.in>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: A hole in kernel space!
Message-ID: <20021106140222.A17370@crystal.2d3d.co.za>
Mail-Followup-To: Pannaga Bhushan <bhushan@multitech.co.in>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <3DC903BE.F4CD5A52@multitech.co.in>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DC903BE.F4CD5A52@multitech.co.in>; from bhushan@multitech.co.in on Wed, Nov 06, 2002 at 17:27:50 +0530
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.17-pre4 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:58pm  up 26 days, 22:20, 11 users,  load average: 0.02, 0.01, 0.00
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pannaga!

Use the mem=3D parameter on the kernel command-line to specify less memory
than what is available. Then you can use the last unused chunk of memory,
e.g. if you have 256M memory and you want to "steal" a 40M chunk at the end:

mem=3D216M

> Hi all,
>         I am looking for a setup where I need to have a certain amount
> of data always available to the kernel. The size of data I am looking at
> is abt
> 40MB(preferably, but I will settle for 20MB too) . So the normal kmalloc
> will not help me. So what I did was, I created a hole in kernel space by
> putting
> the following line in vmlinux.lds
>=20
>     ALIGN(4096);
>  __hole_start =3D .;
>     . =3D . + 0xmy_size;
>  __hole_end =3D .;
>=20
> First, I put these lines in code segment and found that  'my_size'
> cannot go beyond 0x500000(5MB) . Any larger value , the kernel image
> refuses to
> boot up. I found the same problem with these lines being in data segment
> or in the bss segment.
>=20
> But putting these line after
>=20
> _end =3D .;
>=20
> line in vmlinux.lds, I am able to give 0x1700000(17MB) to my_size and
> still boot with that kernel image.
>=20
> My questions are :
>=20
> 1.   Is there any other way I can get to keep 40MB(or even 20MB) of
> contiguous kernel memory space ?
>=20
> 2.    Abt the 17MB hole, I am able to use after the   _end =3D .;
> ....     is this 17MB really there in kernel image?('cos it isn't in any
> segment and also it
> appears after _end).
>         if yes, are the pages corresponding to this region swappable or
> is it that since this hole appears in kernel image, it is locked to a
> physical space
> and this is never swapped. (basically, i want by data in kernel space
> always available to kernel without having to bother abt swapping the
> pages back)
>=20
> Thanx in advance,
> Pannaga Bhushan
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20

Regards
 Abraham

UNIX enhancements aren't.

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Aintree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9yQTOzNXhP0RCUqMRAreWAKCFnV4aPiYLrDk/yEjZzlhATTVSMQCgjTEr
Jmim6UfW7f5WnIaid1hUpMI=
=29Ki
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
