Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263483AbUEMPF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUEMPF4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 11:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUEMPF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 11:05:56 -0400
Received: from lists.us.dell.com ([143.166.224.162]:46967 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S263483AbUEMPFt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 11:05:49 -0400
Date: Thu, 13 May 2004 10:03:40 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       matthew.e.tolentino@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm2: EFI_VARS=m is broken
Message-ID: <20040513150340.GA19597@lists.us.dell.com>
References: <20040513032736.40651f8e.akpm@osdl.org> <20040513133806.GD22202@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20040513133806.GD22202@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 13, 2004 at 03:38:06PM +0200, Adrian Bunk wrote:
> On Thu, May 13, 2004 at 03:27:36AM -0700, Andrew Morton wrote:
> >...
> > Changes since 2.6.6-mm1:
> >...
> > +efivars-fix.patch
> >=20
> >  Fix oops with efivars enabled but not avaialble.
>=20
> This patch broke EFI_VARS=3Dm:

Duh.  i386 needs to export efi_enabled.  ia64 doesn't as it's a
#define in linux/efi.h.  Matt T, are you working on EFI for x86_64
too?  Patch below for i386.


--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com


Export efi_enabled to modules such as efivars.  Only needed on i386 at
present, as ia64 has this as a #define in linux/efi.h, and EFI isn't
available for other arches.


=3D=3D=3D=3D=3D arch/i386/kernel/setup.c 1.118 vs edited =3D=3D=3D=3D=3D
--- 1.118/arch/i386/kernel/setup.c	Wed Apr 28 02:09:40 2004
+++ edited/arch/i386/kernel/setup.c	Thu May 13 09:58:01 2004
@@ -65,6 +65,7 @@
=20
 #ifdef CONFIG_EFI
 int efi_enabled =3D 0;
+EXPORT_SYMBOL(efi_enabled);
 #endif
=20
 /* cpu data as detected by the assembly code in head.S */

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAo45MIavu95Lw/AkRAvLSAJ9IX+OjbxxISXFp9rG5JePdALthbwCgjrfT
u9wiw4dZiGXD5AbxH7dFg68=
=dZTq
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
