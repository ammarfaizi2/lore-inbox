Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbSKXXg6>; Sun, 24 Nov 2002 18:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSKXXg6>; Sun, 24 Nov 2002 18:36:58 -0500
Received: from ppp-217-133-218-65.dialup.tiscali.it ([217.133.218.65]:36481
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S262023AbSKXXgz>; Sun, 24 Nov 2002 18:36:55 -0500
Subject: UHCI halts endpoint on control stalls: seems wrong
From: Luca Barbieri <ldb@ldb.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NdErCxNtk4nISKSfheqD"
Organization: 
Message-Id: <1038181437.1742.13.camel@home.ldb.ods.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 25 Nov 2002 00:43:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NdErCxNtk4nISKSfheqD
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Some time ago I reported some USB problems consisting of getting EPIPEs
when trying to read strings with lsusb.

I have done some more investigation and I think I solved the problem: I
get EPIPEs because the control endpoint is stalled due to a failure and
the halt is never cleared.

However drivers/usb/core/message.c contains the following paragraph:
"Note that control and isochronous endpoints don't halt, although
control endpoints report "protocol stall" (for unsupported requests)
using the same status code used to report a true stall."

Based on this, I tried to remove the call to usb_endpoint_halt in
uhci_result_control, and everything is now working.

Is this modification correct?


--=-NdErCxNtk4nISKSfheqD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA94WQ9djkty3ft5+cRAgGIAJ9MA1YfeJX+eFYZObpewaGBGB27RgCglxLp
RxX3Q7IWOEJdEmc7P1pU6so=
=kdZL
-----END PGP SIGNATURE-----

--=-NdErCxNtk4nISKSfheqD--
