Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVIOIRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVIOIRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIOIRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:17:30 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:52169 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751026AbVIOIR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:17:29 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Manu Abraham <manu@linuxtv.org>
Subject: Re: PCI driver
Date: Thu, 15 Sep 2005 10:18:13 +0200
User-Agent: KMail/1.8.2
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
References: <4327EE94.2040405@kromtek.com> <200509150843.33849@bilbo.math.uni-mannheim.de> <4329269E.1060003@linuxtv.org>
In-Reply-To: <4329269E.1060003@linuxtv.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1144555.i5qzIo6RvQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509151018.20322@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1144555.i5qzIo6RvQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Manu Abraham wrote:
>Rolf Eike Beer wrote:
>>Manu Abraham wrote:

>>>static int __devinit mantis_pci_probe(struct pci_dev *pdev, const struct
>>>pci_device_id *mantis_pci_table)
>>>{
>>>	u8 revision, latency;
>>>	u8 data[2];
>>>	struct mantis_pci *mantis;
>>>	mantis =3D (struct mantis_pci *) kmalloc(sizeof (struct mantis_pci),
>>>GFP_KERNEL);
>>>	if (mantis =3D=3D NULL) {
>>>		dprintk(verbose, MANTIS_ERROR, 1, "Out of memory");
>>>		return -ENOMEM;
>>>	}
>>>
>>>	pdev =3D pci_get_device(PCI_VENDOR_ID_MANTIS, PCI_DEVICE_ID_MANTIS_R11,
>>>NULL);
>>
>>This is not needed anymore then. Your probe function will get called with
>> for any pci dev your driver can handle.
>
>I will just check it up again to see what went wrong ..
>
>>>	if (pdev) {
>>>		dprintk(verbose, MANTIS_ERROR, 1, "Got a device");
>>>		mantis->mantis_addr =3D pci_resource_start(pdev, 0);
>>>		if (!request_mem_region(pci_resource_start(pdev, 0),
>>>			pci_resource_len(pdev, 0), DRIVER_NAME)) {
>>>			dprintk(verbose, MANTIS_ERROR, 1, "Request for memory region failed");

[...]

>>>		pci_set_drvdata(pdev, mantis);
>>>		dprintk(verbose, MANTIS_ERROR, 0, "Mantis Rev %d, ", mantis->revision);
>>>		dprintk(verbose, MANTIS_ERROR, 0, "irq: %d, latency: %d\nmemory:
>>>0x%04x, mmio: %p\n", pdev->irq, mantis->latency,
>>>			mantis->mantis_addr, mantis->mantis_mmio);
>>>
>>>		pci_dev_put(pdev);
>>
>>No, DON'T DO THAT! This will drop the a reference count from the struct
>>pci_dev, which means it can get freed while your driver still wants to wo=
rk
>>with it.
>
>Hmm.. I thought after i make a call to pci_get_device(), i have to do a
>pci_dev_put() after the usage ..
>I was a bit lost when to use pci_dev_put() in this case.

That is true, but you should not call pci_get_device() in this function at=
=20
all.

Eike

--nextPart1144555.i5qzIo6RvQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDKS5MXKSJPmm5/E4RAibuAJ9f/5fryF6kdfp4PRr6FVq3annRhwCfWk2M
OX7SIVViTOeAXbdXrD3xq4M=
=r9ck
-----END PGP SIGNATURE-----

--nextPart1144555.i5qzIo6RvQ--
