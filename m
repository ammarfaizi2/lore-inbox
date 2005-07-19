Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVGSLXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVGSLXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 07:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVGSLXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 07:23:47 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:5522 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261967AbVGSLXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 07:23:46 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Date: Tue, 19 Jul 2005 13:27:33 +0200
User-Agent: KMail/1.8.1
Cc: Jiri Slaby <jirislaby@gmail.com>, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       support@comtrol.com, Rogier Wolff <R.E.Wolff@bitwizard.nl>,
       nils@kernelconcepts.de, cjtsai@ali.com.tw, Lionel.Bouton@inet6.fr,
       benh@kernel.crashing.org, mchehab@brturbo.com.br, laredo@gnu.org,
       rbultje@ronald.bitfreak.net, middelin@polyware.nl, philb@gnu.org,
       tim@cyberelk.net, campbell@torque.net, andrea@suse.de,
       linux@advansys.com, lnz@dandelion.com, chirag.kantharia@hp.com,
       mike@i-connect.net, mulix@mulix.org
References: <42DC4873.2080807@gmail.com>
In-Reply-To: <42DC4873.2080807@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1601854.FJcG6sCsyP";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507191327.44415@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1601854.FJcG6sCsyP
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jiri Slaby wrote:
>The patch is for mixed files from all over the tree.
>
>Kernel version: 2.6.13-rc3-git4
>
>* This patch removes from kernel tree pci_find_device and changes
>it with pci_get_device. Next, it adds pci_dev_put, to decrease reference
>count of the variable.
>* Next, there are some (about 10 or so) gcc warning problems (i. e.
>variable may be unitialized) solutions, which were around code with old
>pci_find_device.

Is this the reason why you initialize members of static structs? If this is=
=20
uninitialized it will end in the bss section and will be zeroed before the=
=20
kernel uses is. If you do it will go into data section and add more bloat t=
o=20
the binary. At least this is the explanation I got once why not to do this.

Many of the callers of pci_find_device() look like they are not ported to t=
he=20
2.6 driver API and do the scanning for devices themself. I think it would b=
e=20
a good idea to try to convert them to the new driver model instead of=20
replacing this. When you mark this deprecated and they still use the old=20
function everyone using this will see that there is some work to do.

>* Some code was unpretty, or ugly, so the patch provides more readable
>code, in some cases.

If you try to beautify code then please use for_each_pci_dev() macro from=20
include/linux/pci.h where possible.

When you want something of this getting included you have to split that int=
o=20
pieces. Use extra patches for changes in coding style and functionality.

>* Marks the function as deprecated in pci.h

This is a very good idea in my eyes.

Eike

--nextPart1601854.FJcG6sCsyP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC3OOwXKSJPmm5/E4RAj4XAJwN9kH9oP9h7Tkyp00GcrTLV+mK6gCgjjUZ
nizpMgG1NHBXEQ+eeTlT5UM=
=Ay3I
-----END PGP SIGNATURE-----

--nextPart1601854.FJcG6sCsyP--
