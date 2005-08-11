Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVHKQTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVHKQTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 12:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbVHKQTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 12:19:06 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:8685 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932293AbVHKQTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 12:19:05 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.5 - Compaq Fibre Channel 64-bit/66Mhz HBA
Date: Thu, 11 Aug 2005 18:19:38 +0200
User-Agent: KMail/1.8.2
References: <42FB72DE.8000703@aub.nl>
In-Reply-To: <42FB72DE.8000703@aub.nl>
Cc: Bolke de Bruin <bdbruin@aub.nl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2615143.1ZRpbFhkjv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508111819.45325@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2615143.1ZRpbFhkjv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Bolke de Bruin wrote:
>So the basic question is. Does this controller work on kernel 2.6.5?

The problem is that the default stack size was reduced to 4kB. The local=20
arrays allocated by the driver eat 2kB each, so a stack overflow is very=20
likely. Even with 8kB stack it is still not impossible. Using the version=20
from 2.6.5 will not be a very good idea I think, it's likely to crash your=
=20
machine one day.

The right solution would be fixing the driver to use kmalloc()/kfree() when=
 he=20
really needs the memory. There was a patch only a few days ago that tried t=
o=20
do that, but it was not really well done and would have crashed. If you are=
=20
really interested in I can do such a patch. The code of this driver sucks=20
universes through nanotubes, but one day someone _will_ have to start=20
cleaning this up.

Eike

--nextPart2615143.1ZRpbFhkjv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC+3qhXKSJPmm5/E4RAkdtAJ9vKsMTC/7lVG9KEF287oSJUCEdrgCgibxs
2aQllmcjsspDWn8KArbCLJg=
=VHmU
-----END PGP SIGNATURE-----

--nextPart2615143.1ZRpbFhkjv--
