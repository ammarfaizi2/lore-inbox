Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVGTNxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVGTNxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 09:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbVGTNxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 09:53:21 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:30657 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261230AbVGTNwe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 09:52:34 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pci_find_device --> pci_get_device
Date: Wed, 20 Jul 2005 15:56:34 +0200
User-Agent: KMail/1.8.1
Cc: Jiri Slaby <jirislaby@gmail.com>, rth@twiddle.net, dhowells@redhat.com,
       kumar.gala@freescale.com, davem@davemloft.net, mhw@wittsend.com,
       Rogier Wolff <R.E.Wolff@bitwizard.nl>, nils@kernelconcepts.de,
       Lionel.Bouton@inet6.fr, benh@kernel.crashing.org,
       mchehab@brturbo.com.br, laredo@gnu.org, rbultje@ronald.bitfreak.net,
       middelin@polyware.nl, philb@gnu.org, tim@cyberelk.net,
       campbell@torque.net, andrea@suse.de, mulix@mulix.org
References: <42DC4873.2080807@gmail.com> <200507201319.42050@bilbo.math.uni-mannheim.de> <42DE3E03.1070401@gmail.com>
In-Reply-To: <42DE3E03.1070401@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1905358.CSPrCvT6Hb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507201556.45034@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1905358.CSPrCvT6Hb
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jiri Slaby wrote:
>Rolf Eike Beer napsal(a):
>>Am Mittwoch, 20. Juli 2005 12:40 schrieb Jiri Slaby:
>>>Rolf Eike Beer napsal(a):
>>>>Your patch to arch/sparc64/kernel/ebus.c is broken, the removed and add=
ed
>>>>parts do not match in behaviour.
>>>
>>>I can't still see the difference.
>>
>>diff --git a/arch/sparc64/kernel/ebus.c b/arch/sparc64/kernel/ebus.c
>>--- a/arch/sparc64/kernel/ebus.c
>>+++ b/arch/sparc64/kernel/ebus.c
>>@@ -527,8 +527,15 @@ static struct pci_dev *find_next_ebus(st
>> {
>> 	struct pci_dev *pdev =3D start;
>>
>>-	do {
>>-		pdev =3D pci_find_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev);
>>+    while (pdev =3D pci_get_device(PCI_VENDOR_ID_SUN, PCI_ANY_ID, pdev))
>>+		if (pdev->device =3D=3D PCI_DEVICE_ID_SUN_EBUS ||
>>+			pdev->device =3D=3D PCI_DEVICE_ID_SUN_RIO_EBUS)
>>+			break;
>>+	*is_rio_p =3D !!(pdev && (pdev->device =3D=3D PCI_DEVICE_ID_SUN_RIO_EBU=
S));
>>+
>>+/*	do { // BEFORE \/           AFTER ^

This looks like some sed command went wrong. And I missed that you were=20
starting a comment here.

>Is there any difference? I don't see any, but... The reading of diff
>file in this case is not the best, maybe...

Yes, that was the problem. I would prefer if you could just remove the code=
=20
instead of commenting it out. This would have made this clearer.

If my editor doesn't fool me you are using spaces for indentation of the=20
while. There has to be a tab.

Question to the sparc folks: is it really needed to preserve the order of t=
he=20
ebusses? Or would it be possible to do

pdev =3D pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_EBUS)

first and if this returns NULL start again with=20

pdev =3D pci_find_device(PCI_VENDOR_ID_SUN, PCI_DEVICE_ID_SUN_RIO_EBUS)

?

Eike

--nextPart1905358.CSPrCvT6Hb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBC3lgcXKSJPmm5/E4RAvtpAJ9/fre/oOTcNjsaGmiesLiWlPI/xgCcCx5G
h6Y3Lx35fb6HKNUX5lzkqDg=
=3G7x
-----END PGP SIGNATURE-----

--nextPart1905358.CSPrCvT6Hb--
