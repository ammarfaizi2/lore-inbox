Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVAGL4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVAGL4b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVAGL4b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:56:31 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:36524 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261274AbVAGL41
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:56:27 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH] macros to detect existance of unlocked_ioctl and ioctl_compat
Date: Fri, 7 Jan 2005 12:49:19 +0100
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
References: <20041217014345.GA11926@mellanox.co.il> <20050106172613.GI5772@vana.vc.cvut.cz> <20050106175342.GA28889@wotan.suse.de>
In-Reply-To: <20050106175342.GA28889@wotan.suse.de>
MIME-Version: 1.0
Message-Id: <200501071249.20767.arnd@arndb.de>
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Adn3BUal9/GOHMx";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Adn3BUal9/GOHMx
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dunnersdag 06 Januar 2005 18:53, Andi Kleen wrote:

> > * USB.  usbfs API is written in a way which does not allow you to safel=
y wrap
> > it in "generic" 32->64 layer, and attempts to do it in non-generic way =
in usbfs
> > code itself did not look feasible year ago.  Even on current 64bit kern=
els it is not
> > possible to issue raw USB operations from 32bit apps, and I do not beli=
eve that
> > it is going to change - after all, just issuing ioctl through 64bit pat=
h from application
> > which is aware of 64bit kernel is quite simple, much simpler than any a=
ttempt to
> > make kernel dual-interface.
>=20
> Agree that's a problem. We just need an alternative interface here
> or I try to come up with an x86-64 specific hack (I think it's possible
> to do the compatibility x86-64 specific, just not in compat code for
> all architectures who have truly separated user/kernel address spaces)=20
>=20
> I hope the USB people will eventually add a better interface here.
> Greg?

As a quick fix, wouldn't it be easy enough to just mark USBDEVFS_IOCTL as
COMPATIBLE_IOCTL()? The number is actually different for 32 and 64 bit kern=
els,
so a 32 bit application that knows about this could use 64 bit data structu=
res
and then just call ioctl(fd, USBDEVFS_IOCTL64, data) instead of using a wei=
rd
hack to achieve exactly the same.
Applications trying to call the 32 bit USBDEVFS_IOCTL would still see -EINV=
AL
because there is no wrapper for this.
Maybe the same can be done for some of the other ioctl calls. It effectively
means moving part of the compat layer to user space from fs/compat_ioctl.c,
but it appears that applications are already doing this.

	Arnd <><



--Boundary-02=_Adn3BUal9/GOHMx
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB3ndA5t5GS2LDRf4RAh1QAKCijbHiMreRvVAutpnQU42gAhANmACcDbD3
Rl85sY4BOlDKsKOj1+wCt1k=
=oaH/
-----END PGP SIGNATURE-----

--Boundary-02=_Adn3BUal9/GOHMx--
