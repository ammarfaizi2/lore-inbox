Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277357AbRJELfi>; Fri, 5 Oct 2001 07:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277356AbRJELf2>; Fri, 5 Oct 2001 07:35:28 -0400
Received: from mail.2d3d.co.za ([196.14.185.200]:16068 "HELO mail.2d3d.co.za")
	by vger.kernel.org with SMTP id <S277357AbRJELfW>;
	Fri, 5 Oct 2001 07:35:22 -0400
Date: Fri, 5 Oct 2001 13:39:22 +0200
From: Abraham vd Merwe <abraham@2d3d.co.za>
To: DRI Patches <dri-patches@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: DRM bugfix
Message-ID: <20011005133922.A20358@crystal.2d3d.co.za>
Mail-Followup-To: Abraham vd Merwe <abraham@2d3d.co.za>,
	DRI Patches <dri-patches@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: 2d3D, Inc.
X-Operating-System: Debian GNU/Linux crystal 2.4.2 i686
X-GPG-Public-Key: http://oasis.blio.net/pgpkeys/keys/2d3d.gpg
X-Uptime: 1:34pm  up 3 days, 22:01,  9 users,  load average: 0.04, 0.29, 0.22
X-Edited-With-Muttmode: muttmail.sl - 2001-06-06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I found a small bug in drm_proc.h. DRM(_vm_info) tries to access
dev->maplist, but dev->maplist is only intitialized when the device is
opened, so if you do a cat /proc/dri/0/vm just after you load any DRM module
(just before loading X), you'll get an oops and mess up the whole proc
system in the process...

I've attached a fix for it. The patch is against the 2.4.10 kernel, but I
think drm_proc.h in the 2.4.10 kernel is the same as in the DRI CVS
repository.

--=20

Regards
 Abraham

One can never consent to creep when one feels an impulse to soar.
		-- Helen Keller

__________________________________________________________
 Abraham vd Merwe - 2d3D, Inc.

 Device Driver Development, Outsourcing, Embedded Systems

  Cell: +27 82 565 4451         Snailmail:
   Tel: +27 21 761 7549            Block C, Antree Park
   Fax: +27 21 761 7648            Doncaster Road
 Email: abraham@2d3d.co.za         Kenilworth, 7700
  Http: http://www.2d3d.com        South Africa


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maplist-fix.diff"

diff -Nrup linux-2.4.10.orig/drivers/char/drm/drm_proc.h linux-2.4.10/drivers/char/drm/drm_proc.h
--- linux-2.4.10.orig/drivers/char/drm/drm_proc.h	Wed Aug 15 23:21:47 2001
+++ linux-2.4.10/drivers/char/drm/drm_proc.h	Fri Oct  5 13:33:54 2001
@@ -186,7 +186,7 @@ static int DRM(_vm_info)(char *buf, char
 	DRM_PROC_PRINT("slot	 offset	      size type flags	 "
 		       "address mtrr\n\n");
 	i = 0;
-	list_for_each(list, &dev->maplist->head) {
+	if (dev->maplist != NULL) list_for_each(list, &dev->maplist->head) {
 		r_list = (drm_map_list_t *)list;
 		map = r_list->map;
 		if(!map) continue;

--zYM0uCDKw75PZbzx--

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7vZvqzNXhP0RCUqMRAoRkAJsGwbEudie6gUr79w+fglximJhjMwCeNrbU
GRXFAXiTFWgc35sPaK/LDh8=
=97v3
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
