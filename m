Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261516AbSIZVJ4>; Thu, 26 Sep 2002 17:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261519AbSIZVJ4>; Thu, 26 Sep 2002 17:09:56 -0400
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:20797 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S261516AbSIZVJy>;
	Thu, 26 Sep 2002 17:09:54 -0400
Date: Thu, 26 Sep 2002 23:15:05 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mingo@redhat.com, davem@redhat.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] gfp_t
Message-ID: <20020926211505.GE1892@jaquet.dk>
References: <20020926044401.9C60D2C3CC@lists.samba.org> <20020926185924.GA1892@jaquet.dk> <20020926192931.GB1892@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20020926192931.GB1892@jaquet.dk>
User-Agent: Mutt/1.3.28i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2002 at 09:29:32PM +0200, Rasmus Andersen wrote:
> On Thu, Sep 26, 2002 at 08:59:24PM +0200, Rasmus Andersen wrote:
> > On Thu, Sep 26, 2002 at 02:35:30PM +1000, Rusty Russell wrote:
> > > This creates a mythical gfp_t for passing gfp states, and conversion
> > > macros __GFP() and __UNGFP(), to give warnings, It's 55k, so
> > > compressed and attached.
> >=20
> > This breaks ntfs/malloc.h which is doing the following:
> > 49:       return __vmalloc(size, GFP_NOFS | __GFP_HIGHMEM, PAGE_KERNEL);
> [...]
>=20
> After having had a bit more caffeine, I guess I would like to
> change my previous mail to: These two patches for mm/numa.c and
> ntfs/malloc.h needs to be in your patchset as well.

Another one:


--- linux-2.5.38/drivers/char/synclink.c	Sun Sep 22 06:25:06 2002
+++ linux-2.5.38-gfp/drivers/char/synclink.c	Thu Sep 26 23:01:57 2002
@@ -3975,7 +3975,7 @@
 		/* inspect portions of the buffer while other portions are being */
 		/* updated by the adapter using Bus Master DMA. */
=20
-		info->buffer_list =3D kmalloc(BUFFERLISTSIZE, GFP_KERNEL | GFP_DMA);
+		info->buffer_list =3D kmalloc(BUFFERLISTSIZE, gfp_sub(GFP_KERNEL, __UNGF=
P(GFP_DMA)));
 		if ( info->buffer_list =3D=3D NULL )
 			return -ENOMEM;
 		=09
@@ -4087,7 +4087,7 @@
 		} else {
 			/* ISA adapter uses system memory. */
 			BufferList[i].virt_addr =3D=20
-				kmalloc(DMABUFFERSIZE, GFP_KERNEL | GFP_DMA);
+				kmalloc(DMABUFFERSIZE, gfp_sub(GFP_KERNEL, __UNGFP(GFP_DMA)));
 			if ( BufferList[i].virt_addr =3D=3D NULL )
 				return -ENOMEM;
 			phys_addr =3D isa_virt_to_bus(BufferList[i].virt_addr);
@@ -4159,7 +4159,7 @@
  */
 int mgsl_alloc_intermediate_rxbuffer_memory(struct mgsl_struct *info)
 {
-	info->intermediate_rxbuffer =3D kmalloc(info->max_frame_size, GFP_KERNEL =
| GFP_DMA);
+	info->intermediate_rxbuffer =3D kmalloc(info->max_frame_size, gfp_sub(GFP=
_KERNEL, __UNGFP(GFP_DMA)));
 	if ( info->intermediate_rxbuffer =3D=3D NULL )
 		return -ENOMEM;
=20
Regards,
  Rasmus

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9k3jYlZJASZ6eJs4RAhoZAJ9IP4qAmTOxdEM+d/4z6cp+chAqogCeNxP9
488+gq3JKQRuqd2G6dShN9Q=
=xYvN
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
