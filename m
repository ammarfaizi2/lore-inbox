Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUF2TOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUF2TOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUF2TOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:14:06 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:25314 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265965AbUF2TN5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:13:57 -0400
Date: Tue, 29 Jun 2004 21:09:48 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040629190948.GA8659@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20040628200224.GE5175@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Adam,

First of all I'd like to say that I'm glad you're taking interest in=20
the PCMCIA core, and that your experience and patch-writing skills will
surely be a valuable addition in the joint effort of transforming the=20
PCMCIA subsystem to "kernel standards", e.g. hotplug, driver model and=20
sysfs.

Second, you might not know about the linux-pcmcia list=20
http://lists.infradead.org/mailman/listinfo/linux-pcmcia
yet -- it's where most PCMCIA-core-in-2.{6,7} stuff is discussed, and it is=
 quite
low-traffic. Please CC this list on PCMCIA-core-in-2.{6,7} matters in
future.

Third, about your patches:
- I like many ideas in your patches -- large parts of them, though, are
  "double work" as similar things have already been submitted (by me)=20
  to Russell on the linux-pcmcia mailing list. What's missing in my current
  patches [proof-of-concepts do exist and had been announced both on lkml
  and on said linux-pcmcia list, though] is the exporting of product and
  manufactor ID and "vers_1" strings, because that needs better resource
  handling.
- the resource_ready handling is "racy", at least. Resources can disappear
  again.
- what I don't like in your patches is that they add an aditional "layer"
  and thus additional complexity on top of PCMCIA. It already has a multitu=
de of
  structs with different lifetime rules. Your additions don't make it easier
  to simplify this complexity. That's why my patchsets [*] try to reduce the
  complexity first, add struct pcmcia_device next, and reduce complexity by
  merging other stuff into struct pcmcia_device in the third step. I'd need
  to re-check whether the step (1) you're leaving out does _not_ cause
  lifetime headaches and races in strange circumstances [and I don't mean
  PCMCIA net drivers here, as they're in a comparably good shape.]

	Dominik

[*] these patchsets have been announced in these messages:
1) http://lists.infradead.org/pipermail/linux-pcmcia/2004-May/000877.html
2) http://lists.infradead.org/pipermail/linux-pcmcia/2004-May/000878.html
3) http://lists.infradead.org/pipermail/linux-pcmcia/2004-May/000880.html
4) http://lists.infradead.org/pipermail/linux-pcmcia/2004-May/000881.html
5) http://lists.infradead.org/pipermail/linux-pcmcia/2004-May/000882.html

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4b58Z8MDCHJbN8YRApVgAJ4mHC2QjShuto0TkuIpQoocv0jvJgCfaxTO
86qE7i19jcrAHRWqgbiqKGs=
=Pk7e
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
