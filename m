Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUEFRtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUEFRtn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEFRtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:49:43 -0400
Received: from lists.us.dell.com ([143.166.224.162]:55397 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261744AbUEFRtj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:49:39 -0400
Date: Thu, 6 May 2004 12:49:37 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040506174937.GB25499@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marcelo, below is a patch to lower the severity of this printk to
KERN_DEBUG, as there are devices which (properly) don't implement the
PCI_CACHE_LINE_SIZE register, and it's not a bug, so don't print at a
WARNING level.  GregKH accepted the equivalent patch for 2.6.

Thanks,
Matt


----- Forwarded message from Matt Domsch <Matt_Domsch@dell.com> -----

Date: Wed, 5 May 2004 17:50:53 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
In-Reply-To: <20040505223102.GF30003@kroah.com>

On Wed, May 05, 2004 at 03:31:02PM -0700, Greg KH wrote:
> On Thu, Apr 29, 2004 at 02:53:01PM -0500, Matt Domsch wrote:
> > a) need this be a warning, wouldn't KERN_DEBUG suffice, if a message
> > is needed at all?  This is printed in pci_generic_prep_mwi().
>=20
> Yes, we should make that KERN_DEBUG.  I don't have a problem with that.
> Care to make a patch?

Patch for 2.4.27-pre1 appended.

Thanks,
Matt

--=20
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

=3D=3D=3D=3D=3D drivers/pci/pci.c 1.47 vs edited =3D=3D=3D=3D=3D
--- 1.47/drivers/pci/pci.c	Mon Sep 22 07:27:35 2003
+++ edited/drivers/pci/pci.c	Wed May  5 17:49:13 2004
@@ -943,7 +943,7 @@
 	if (cacheline_size =3D=3D pci_cache_line_size)
 		return 0;
=20
-	printk(KERN_WARNING "PCI: cache line size of %d is not supported "
+	printk(KERN_DEBUG "PCI: cache line size of %d is not supported "
 	       "by device %s\n", pci_cache_line_size << 2, dev->slot_name);
=20
 	return -EINVAL;

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAmnqxIavu95Lw/AkRAvCZAJ4tbKiY/EE0qA6vdOI8aBkjP+YZxACbBpq3
wR7x4cB+cjeloUiUZOiN2+k=
=HEAa
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
