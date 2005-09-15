Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbVIOO5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbVIOO5H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbVIOO5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:57:07 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:63701 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1030474AbVIOO5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:57:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 16:57:55 +0200
User-Agent: KMail/1.8.2
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
References: <4327EE94.2040405@kromtek.com> <200509151148.57779@bilbo.math.uni-mannheim.de> <4329877A.4090809@linuxtv.org>
In-Reply-To: <4329877A.4090809@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2009173.Zz0MyiG3F9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151658.01793@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2009173.Zz0MyiG3F9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Manu Abraham wrote:

>So it now looks like this but i have another problem now, after
>consecutive, load/unload, i get an oops ..

No idea, sorry.

>static int __devinit mantis_pci_probe(struct pci_dev *pdev,
>                const struct pci_device_id *mantis_pci_table)
>{
>    u8 revision, latency;
>//    u8 data[2];
>    struct mantis_pci *mantis;
>
>    dprintk(verbose, MANTIS_ERROR, 1, "<1:>IRQ=3D%d", pdev->irq);
>    if (pci_enable_device(pdev)) {
>        dprintk(verbose, MANTIS_ERROR, 1, "Mantis PCI enable failed");
>        goto err;
>    }
>    dprintk(verbose, MANTIS_ERROR, 1, "<2:>IRQ=3D%d", pdev->irq);
>
>    mantis =3D (struct mantis_pci *)
>                kmalloc(sizeof (struct mantis_pci), GFP_KERNEL);

mantis =3D kmalloc(sizeof(*mantis), GFP_KERNEL);

You don't have to cast a void* to any other pointer and this way you will=20
always get the correct size of memory allocated, even if mantis will become=
=20
another pointer type.

Eike

--nextPart2009173.Zz0MyiG3F9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKYv5XKSJPmm5/E4RAkuKAKCLcQ6AbGT3zQ/cOliUW48gzVM2BACffMwh
EMBSzMZ6s5FesuIzl7KMC8E=
=zheP
-----END PGP SIGNATURE-----

--nextPart2009173.Zz0MyiG3F9--
