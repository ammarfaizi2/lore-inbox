Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269131AbUHYBmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbUHYBmF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269124AbUHYBku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:40:50 -0400
Received: from mfep3.odn.ne.jp ([143.90.131.181]:8757 "EHLO t-mta3.odn.ne.jp")
	by vger.kernel.org with ESMTP id S269122AbUHYBkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:40:32 -0400
Date: Wed, 25 Aug 2004 10:40:28 +0900
From: acyr@alumni.uwaterloo.ca
To: linux-kernel@vger.kernel.org
Subject: ACPI + Floppy detection problem in 2.6.8.1-mm4
Message-ID: <20040825014028.GA14286@alumni.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since patching from 2.6.8.1 to -mm4 I noticed that I can no longer
modprobe the floppy driver.  It is failing to detect the floppy drive
and controller it seems.  Looking at the output from dmesg I have
this:

[-snip-]
inserting floppy driver for 2.6.8.1-mm4
acpi_floppy_resource: 6 ioports at 0x3f0
acpi_floppy_resource: 1 ioports at 0x3f7
floppy: controller ACPI FDC0 at I/O 0x3f0-0x3f5, 0x3f7-0x3f7 irq 6 dma chan=
nel 2
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
[-snip-]

I saw in the -mm4 changelog that ACPI-based floppy detection was
added, which seems to be working, but the floppy driver doesn't seem
to think the controller/drive exists once the ACPI enumeration is
done.  I just noticed the no_acpi floppy module param in the source,
so I will give that a try.  Since the ACPI code seems to be picking up
the controller and drive just fine, I doubt this is limited to just my
system (i.e. my ACPI tables are screwy etc.).

--=20
Aric Cyr <acyr at alumni dot uwaterloo dot ca>    (http://acyr.net)
gpg fingerprint: 943A 1549 47AC D766 B7F8  D551 6703 7142 C282 D542

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBK+4MZwNxQsKC1UIRAhAXAKDBCPKydCVufP59gjJbmgOpiAhCCACgjVYd
4wM3H+5DGkYLapDV1PcYCZI=
=WZ98
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
