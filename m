Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTE0PKS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263812AbTE0PKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:10:18 -0400
Received: from smtp-out.comcast.net ([24.153.64.109]:58008 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263805AbTE0PKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:10:10 -0400
Date: Tue, 27 May 2003 11:21:26 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: [2.5.70] oops when rmmod yenta_socket
In-reply-to: <20030527140805.D16734@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Message-id: <20030527152126.GA16383@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary="ikeVEW9yuYc//A+q";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <20030527124952.GB13051@butterfly.hjsoft.com>
 <20030527140805.D16734@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2003 at 02:08:05PM +0100, Russell King wrote:
> On Tue, May 27, 2003 at 08:49:52AM -0400, John M Flinchbaugh wrote:
> > i shutdown pcmcia and tried to rmmod yenta_socket, and i got the oops
> > below at the end of this dmesg.  so far, 2.5.70 has looked alot like
> > 2.5.69-bk11 that i'd been running before.
> Try this patch, thanks to Pavel Roskin for this.
> --- linux.orig/drivers/pcmcia/pci_socket.c
> +++ linux/drivers/pcmcia/pci_socket.c
> @@ -196,9 +196,9 @@ static void __devexit cardbus_remove (st
>  	pci_socket_t *socket =3D pci_get_drvdata(dev);
> =20
>  	/* note: we are already unregistered from the cs core */
> +	class_device_unregister(&socket->cls_d.class_dev);
>  	if (socket->op && socket->op->close)
>  		socket->op->close(socket);
> -	class_device_unregister(&socket->cls_d.class_dev);
>  	pci_set_drvdata(dev, NULL);
>  }

it worked nicely.  thank you.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+04J2CGPRljI8080RAsAXAJ9QGAcoxNR2ymJnknm8GXmmTlPc9gCaA7C+
bbvjHywYRuJVJYdwMM8ynro=
=tC0x
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
