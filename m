Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbUCJWRY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 17:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262859AbUCJWRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 17:17:24 -0500
Received: from studorgs.rutgers.edu ([128.6.24.131]:38875 "EHLO
	ruslug.rutgers.edu") by vger.kernel.org with ESMTP id S262856AbUCJWRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 17:17:17 -0500
Date: Wed, 10 Mar 2004 17:17:16 -0500
To: jt@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
       "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Prism54-devel] Re: [PATCH 2.6] Intersil Prism54 wireless driver
Message-ID: <20040310221716.GD26496@ruslug.rutgers.edu>
Mail-Followup-To: jt@hpl.hp.com,
	Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
	"David S. Miller" <davem@redhat.com>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@oss.sgi.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20040310172114.GA8867@bougret.hpl.hp.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: 2.4.18-1-686
Organization: Rutgers University Student Linux Users Group
From: mcgrof@ruslug.rutgers.edu (Luis R. Rodriguez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 10, 2004 at 09:21:14AM -0800, Jean Tourrilhes wrote:
> On Wed, Mar 10, 2004 at 04:55:48PM +0000, Christoph Hellwig wrote:
> > On Wed, Mar 03, 2004 at 06:35:24PM -0800, Jean Tourrilhes wrote:
> > > 	Hi Dave & Jeff,
> > >=20
> > > 	The attached .bz2 file is a patch for 2.6.3 adding the
> > > Intersil Prism54 wireless driver. Sorry for the attachement, the file
> > > is rather big, if you want inline+plaintext, I'll send that personal
> > > to you.
> > > 	I've been using this driver with great success on 2.6.3 and
> > > 2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
> > > 802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
> > > chipset.
> > > 	I would like this driver to go into 2.6.X. However, I
> > > understand that it's lot's of code to review.
> >=20
> > Here's a few things I found.
>=20
> 	I'm forwarding to prism54-devel where the real developpers can
> answer your questions.
>=20
> >  It's not exactly a full review, there's
> > too much new snow to spend lots of time in front of a computer here :)
>=20
> 	Grrr... This year, no snow for me.
>=20
> > diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireles=
s/prism54/Makefile linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile
> > --- linux-2.6.3/drivers/net/wireless/prism54/Makefile	Thu Jan  1 00:00:=
00 1970
> > +++ linux-2.6.3-prism54/drivers/net/wireless/prism54/Makefile	Thu Mar  =
4 02:00:01 2004
> > @@ -0,0 +1,10 @@
> > +# $Id: Makefile.k26,v 1.7 2004/01/30 16:24:00 ajfa Exp $
> > +
> > +prism54-objs :=3D islpci_eth.o islpci_mgt.o \
> > +                isl_38xx.o isl_ioctl.o islpci_dev.o \
> > +		islpci_hotplug.o isl_wds.o oid_mgt.o
> >=20
> > 	please use foo-y for new drivers.

TODO

> >=20
> > +
> > +obj-$(CONFIG_PRISM54) +=3D prism54.o
> > +
> > +EXTRA_CFLAGS =3D -I$(PWD) #-DCONFIG_PRISM54_WDS
> >=20
> > 	This is bogus, especially with srcdir !=3D objdir.
> > 	please fixup the includes instead
> >=20
> > +#define __KERNEL_SYSCALLS__
> >=20
> > 	this shouldn't be used anymore.

Done

> >=20
> > +
> > +#include <linux/version.h>
> > +#include <linux/module.h>
> > +#include <linux/types.h>
> > +#include <linux/delay.h>
> > +
> > +#include "isl_38xx.h"
> > +#include <linux/firmware.h>
> > +
> > +#include <asm/uaccess.h>
> > +#include <asm/io.h>
> >=20
> > 	Please include headers in the following order <linux/*.h>,
> > 	<asm/*.h>, driver-specific.

Done

> >=20
> > +#if (LINUX_VERSION_CODE > KERNEL_VERSION(2,5,75))
> > +#include <linux/device.h>
> > +# define _REQ_FW_DEV_T struct device *
> > +#else
> > +# define _REQ_FW_DEV_T char *
> > +#endif
> >=20
> > 	Eeek, why don't you simply pass the pci_dev down?

TODO

> >=20
> >=20
> > +typedef struct isl38xx_cb isl38xx_control_block;
> >=20
> > 	No useless typedefs please.
> >=20
> > +MODULE_PARM(init_mode, "i");
> > +MODULE_PARM_DESC(init_mode,
> > +		 "Set card mode:\n0: Auto\n1: Ad-Hoc\n2: Managed Client (Default)\n3=
: Master / Access Point\n4: Repeater (Not supported yet)\n5: Secondary (Not=
 supported yet)\n6: Monitor");
> >=20
> > 	Please use module_param

Done

>=20
> 	I would even say that this is useless because the driver
> support WE, and WE scripts set the mode before the card is up.

True, we can just remove the param for iw_mode.

>=20
> > diff -Naur -X /home/mcgrof/lib/dontdiff linux-2.6.3/drivers/net/wireles=
s/prism54/isl_wds.c linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wd=
s.c
> > --- linux-2.6.3/drivers/net/wireless/prism54/isl_wds.c	Thu Jan  1 00:00=
:00 1970
> > +++ linux-2.6.3-prism54/drivers/net/wireless/prism54/isl_wds.c	Thu Mar =
 4 02:00:01 2004
> >=20
> > 	WDS doesn't belong into a driver but in higher-level code.

The driver features some firmware-specific WDS functionality, such as
adding/removing WDS links. We haven't looked much into it yet though since
it's not high priority. Where exactly should this code go to then?

Elements noted as DONE were just committed into our CVS repository. You
can always find our latest 2.6 kernel patch at:

http://prism54.org/pub/linux/snapshot/kernel/v2.6/patch-2.6-prism54-cvs-lat=
est.bz2

FWIW, the same driver code base supports 2.4:
http://prism54.org/pub/linux/snapshot/kernel/v2.4/patch-2.4-prism54-cvs-lat=
est.bz2

	Luis

--=20
GnuPG Key fingerprint =3D 113F B290 C6D2 0251 4D84  A34A 6ADD 4937 E20A 525E

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAT5Psat1JN+IKUl4RAjAnAJ4v7f4FQ3lIOmmhylZoK31xuM4ztQCgntSI
qtnuNdaT1a3Hi9XPfZPBpyE=
=O0Wo
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
