Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbQLaOV3>; Sun, 31 Dec 2000 09:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLaOVT>; Sun, 31 Dec 2000 09:21:19 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:3316 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S129324AbQLaOVM>; Sun, 31 Dec 2000 09:21:12 -0500
Date: Sun, 31 Dec 2000 13:49:41 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: PCI serial card
Message-ID: <20001231134941.C30393@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've got a PCI serial card here that I'm not sure how to add support
for.  It's resource map is like this:

Product name   | Ven.ID | Dev.ID |[Base+10]|[Base+14]|[Base+18]|[Base+20]|
---------------+--------+--------+---------+---------+---------+---------+
VScom PCI-400L |  14D2  |  8040  |         | Uart #1 | Uart #2 | Uart 3,4|
VScom PCI-800L |  14D2  |  8080  |         | Uart #1 | Uart #2 | Uart 3-8|

(UARTs 3 onwards are spaced 8 bytes apart.) In other words, two of the
400L's ports would be encoded like this:

{ PCI_VENDOR_..., PCI_DEVICE_..., PCI_ANY_ID, PCI_ANY_ID,
  SPCI_FL_BASE_1 | SPCI_FL_BASE_TABLE, 2, 921600 },

but the other two would be described by:

{ PCI_VENDOR_..., PCI_DEVICE_..., PCI_ANY_ID, PCI_ANY_ID,
  SPCI_FL_BASE_3, 2, 921600 },

and I can't seem to find a way of supporting both lots at once.
Similarly, for the 800L I can only support up to six of the eight
ports at once.

Is there a trick I can use, or doesn't this kind of thing work yet?
(I'm looking at 2.4 for this.)

Tim.
*/

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Tzl1ONXnILZ4yVIRAlOEAJ9E++d8Wy2mF+8q1qoR7O8FFa0Q4QCfXQmb
8fGp14nntyrWmQX4D3Qj5E8=
=hGNx
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
