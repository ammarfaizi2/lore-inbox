Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbULONwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbULONwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 08:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbULONwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 08:52:38 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48593 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262349AbULONwf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 08:52:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Date: Wed, 15 Dec 2004 14:46:01 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, pavel@suse.cz,
       discuss@x86-64.org, gordon.jin@intel.com
References: <20041215065650.GM27225@wotan.suse.de> <20041215082917.GW27225@wotan.suse.de> <20041215114246.GB12187@mellanox.co.il>
In-Reply-To: <20041215114246.GB12187@mellanox.co.il>
MIME-Version: 1.0
Message-Id: <200412151446.01913.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ZAEwBtvB5wiZqAM";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ZAEwBtvB5wiZqAM
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Middeweken 15 Dezember 2004 12:42, Michael S. Tsirkin wrote:
> +=A0=A0=A0=A0=A0=A0=A0/* The two calls ioctl_native and ioctl_compat desc=
ribed below
> +=A0=A0=A0=A0=A0=A0=A0 * can be used as a replacement for the ioctl call =
above. They
> +=A0=A0=A0=A0=A0=A0=A0 * take precedence over ioctl: thus if they are set=
, ioctl is
> +=A0=A0=A0=A0=A0=A0=A0 * not used. =A0Unlike ioctl, BKL is not taken: dri=
vers manage
> +=A0=A0=A0=A0=A0=A0=A0 * their own locking. */

I don't really understand how this should deal with drivers that have
both generic and private ioctl conversion handlers. E.g.=20
drivers/s390/block/dasd*.c want to go through the handlers in=20
fs/compat_ioctl.c for stuff like BLKGETSIZE, while it also allows
third party modules to dynamically register additional ioctls.
See drivers/s390/block/dasd_cmb.c for an example, I think EMC are
doing something similar to support their drives.

If the dasd driver now implements an ioctl_compat() method, who will
call the standard conversion handlers?

 Arnd <><



--Boundary-02=_ZAEwBtvB5wiZqAM
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBwEAZ5t5GS2LDRf4RAqWvAJ9090BRVthjX9JDHGFr1ZEwI+AFTgCeJIPX
gj0X2dKVisAsM0dRJ12zxy8=
=YUqC
-----END PGP SIGNATURE-----

--Boundary-02=_ZAEwBtvB5wiZqAM--
