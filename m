Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWHRHSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWHRHSP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWHRHSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 03:18:15 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:60125 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750839AbWHRHSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 03:18:13 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: cdev documentation (was Drop second arg of unregister_chrdev())
Date: Fri, 18 Aug 2006 09:15:28 +0200
User-Agent: KMail/1.9.4
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060817212248.19853.qmail@lwn.net>
In-Reply-To: <20060817212248.19853.qmail@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1587963.HkYOHklsBE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608180915.28763.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1587963.HkYOHklsBE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jonathan Corbet wrote:
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > > Might this, instead, be an opportunity to get rid of the internal
> > > register_chrdev() and unregister_chrdev() calls in favor of the cdev
> > > interface?
> >
> > In this case I would suggest to add documentation to this functions fir=
st
> > to get people the chance to actually know how to use them.
>
> How's the following?  Quickly done but, I hope, useful.
>
> I've also put something more tutorial-oriented at:
>
> 	http://lwn.net/SubscriberLink/195805/b835f36d3b8ee266/
>
> This can be formatted up for the Documentation directory if so desired.

Thanks from the "other developer". What I would like to have is a function=
=20
that gives me the next (or even a random) available number from my range.=20
Currently I have to do it on my own AFAICS.=20

Nevertheless, I ported my driver to the new interface. I see it cdev_add()=
=20
succeeding, but the device never shows up in sysfs. Do I have to do any mor=
e=20
tricks with class devices and stuff?

While I was sneaking around in the code I found this drivers/char/tty_io:30=
93

        cdev_init(&driver->cdev, &tty_fops);
        driver->cdev.owner =3D driver->owner;
        error =3D cdev_add(&driver->cdev, dev, driver->num);
        if (error) {
                cdev_del(&driver->cdev);

Isn't the call to cdev_del() just wrong here?

Eike

--nextPart1587963.HkYOHklsBE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE5WkQXKSJPmm5/E4RAsm+AJ9QavefNr7Gr1izdq52M9Jzs7/o9gCfXiFI
v65V6mjWiZmcp/7QwlwOCtI=
=GJiY
-----END PGP SIGNATURE-----

--nextPart1587963.HkYOHklsBE--
