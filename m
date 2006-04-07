Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWDGRT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWDGRT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964822AbWDGRT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:19:27 -0400
Received: from master.altlinux.org ([62.118.250.235]:37899 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S964824AbWDGRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:19:26 -0400
Date: Fri, 7 Apr 2006 21:19:10 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: David Liontooth <liontooth@cogweb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.16] saa7134 disable_ir oops
Message-ID: <20060407171910.GB8376@procyon.home>
References: <44246C0E.3080306@cogweb.net> <20060406202016.05db1eca.vsu@altlinux.ru> <4435BA58.4080709@cogweb.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <4435BA58.4080709@cogweb.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 06, 2006 at 06:03:20PM -0700, David Liontooth wrote:
> >Does the following patch fix things?
> > =20
> The patch fixes the oops -- thank you! Yet the ir modules get loaded in=
=20
> spite of the "disable_ir=3D1" parameter:
>=20
> # sudo modprobe -vvv saa7134 card=3D2 tuner=3D43 disable_ir=3D1
> insmod /lib/modules/2.6.16/kernel/drivers/media/common/ir-common.ko
> insmod /lib/modules/2.6.16/kernel/drivers/media/video/ir-kbd-i2c.ko
> insmod /lib/modules/2.6.16/kernel/drivers/media/video/video-buf.ko
> insmod /lib/modules/2.6.16/kernel/drivers/media/video/saa7134/saa7134.ko=
=20
> card=3D2 tuner=3D43 disable_ir=3D1

This is normal - saa7134 uses some symbols from these modules, and
such dependencies cannot be dynamic.  The disable_ir=3D1 option just
prevents saa7134 from enabling the IR input and registering the
corresponding input device with the kernel, therefore the IR code will
stay unused.

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFENp8OW82GfkQfsqIRAhvMAJ0fnSbfkU0GtIJGQPhhJlfNyrq7AQCePwSO
pcUxkgCF3mBtVY524rdfB2k=
=2mLI
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
