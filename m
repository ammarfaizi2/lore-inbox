Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWJEF0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWJEF0Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 01:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWJEF0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 01:26:25 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:61893 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751121AbWJEF0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 01:26:24 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 3/4] Char: mxser_new, pci_request_region for pci regions
Date: Thu, 5 Oct 2006 07:27:07 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       support@moxa.com.tw
References: <83721356982173@wsc.cz> <200610041545.22173.eike-kernel@sf-tec.de> <4523DB59.7020600@gmail.com>
In-Reply-To: <4523DB59.7020600@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2766303.UMgrNoBr22";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610050727.17921.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2766303.UMgrNoBr22
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jiri Slaby wrote:
> Rolf Eike Beer wrote:
> > Jiri Slaby wrote:
> >> mxser_new, pci_request_region for pci regions
> >>
> >> Use pci_request_region instead of standard request_region for pci devi=
ce
> >> regions. More checking, simplier use.
> >>
> >> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
> >>
> >> ---
> >> commit 1a717bdb06cef859dfbd426f46ea24a9c740e5c5
> >> tree 85460f01008e9fa2edea675a73b394c48139df4a
> >> parent d4f99406c592fb7ce2a65645d7c1f98ebe599238
> >> author Jiri Slaby <jirislaby@gmail.com> Sat, 30 Sep 2006 01:20:12 +0200
> >> committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 30 Sep 2006
> >> 01:20:12 +0200
> >>
> >>  drivers/char/mxser_new.c |   10 ++++------
> >>  1 files changed, 4 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
> >> index dfef9ce..c566cd0 100644
> >> --- a/drivers/char/mxser_new.c
> >> +++ b/drivers/char/mxser_new.c
> >> @@ -526,8 +526,8 @@ static void __exit mxser_module_exit(voi
> >>  			pdev =3D mxser_boards[i].pdev;
> >>  			free_irq(mxser_boards[i].irq, &mxser_boards[i]);
> >>  			if (pdev !=3D NULL) {	/* PCI */
> >> -				release_region(pci_resource_start(pdev, 2), pci_resource_len(pdev,
> >> 2)); -				release_region(pci_resource_start(pdev, 3),
> >> pci_resource_len(pdev, 3)); +				pci_release_region(pdev, 2);
> >> +				pci_release_region(pdev, 3);
> >>  				pci_dev_put(pdev);
> >>  			} else {
> >>  				release_region(mxser_boards[i].ports[0].ioaddr, 8 *
> >> mxser_boards[i].nports);
> >> @@ -627,16 +627,14 @@ static int __init
> >> mxser_get_PCI_conf(int
> >>  	brd->board_type =3D board_type;
> >>  	brd->nports =3D mxser_numports[board_type - 1];
> >>  	ioaddress =3D pci_resource_start(pdev, 2);
> >> -	request_region(pci_resource_start(pdev, 2), pci_resource_len(pdev, 2=
),
> >> -			"mxser(IO)");
> >> +	pci_request_region(pdev, 2, "mxser(IO)");
> >>
> >>  	for (i =3D 0; i < brd->nports; i++)
> >>  		brd->ports[i].ioaddr =3D ioaddress + 8 * i;
> >>
> >>  	/* vector */
> >>  	ioaddress =3D pci_resource_start(pdev, 3);
> >> -	request_region(pci_resource_start(pdev, 3), pci_resource_len(pdev, 3=
),
> >> -			"mxser(vector)");
> >> +	pci_request_region(pdev, 3, "mxser(vector)");
> >>  	brd->vector =3D ioaddress;
> >>
> >>  	/* irq */
> >
> > Correct me if I'm wrong, but that use of ioaddress looks totally wrong =
to
> > me. Isn't there a pci_iomap() or something missing?
>
> Both brd->vector and brd->ports[i].ioaddr are used in inb and outb functi=
on
> calls. They themselves remap a small range (one byte in these cases) and
> require ulong addresses as a parameter, not pointer to virtual space,
> correct?

Possible. I try to ignore that interface completely :) I would feel much mo=
re=20
comfortable if this would be done the other way. But this would probably=20
introduce more code because this one seems to work on non-PCI devices also.=
=20
So just ignore me :)

Eike

--nextPart2766303.UMgrNoBr22
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFJJe1XKSJPmm5/E4RAqXwAJ9GWNugpNEpOwG7cr8PpgGjDqoH4QCeN8qo
NUX1ceT3HXgjeHzpCqm+ues=
=2sOH
-----END PGP SIGNATURE-----

--nextPart2766303.UMgrNoBr22--
