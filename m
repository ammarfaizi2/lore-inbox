Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTFLW2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTFLW2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:28:44 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:50629 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S265026AbTFLW2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:28:42 -0400
Date: Thu, 12 Jun 2003 19:41:53 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: linux-kernel@vger.kernel.org
Subject: Changes made by fdisk not being written to disk (2.5-bk)
Message-ID: <20030612224153.GY4639@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MhP8cYafZlTESjGT"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MhP8cYafZlTESjGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


I have a SMP machine with a IDE hard disk running 2.5-bk20030611.

Today I changed the partition table of the disk, using fdisk, and
noticed, after reboot, that the new partition table was not written to
the disk. Before rebooting, 'fdisk -l /dev/hda' shows the new partition
table, as if it were written.

I've made a few more tests, and even if I sync() a dozen of times
before rebooting (using /bin/sync and sysrq), the data is not written.
Even when I've waited about 20 minutes after changing the partition table,
before rebooting, the problem persisted.

Although, after changing fdisk to call fsync() before closing the device,
everything worked, the changes were written, and the new partition table
were on the disk, after rebooting.

I think that changing fdisk to use fsync() would be a Good Thing, but
I guess that sync() should have the data be written, anyway.

Am I missing something?

If there is any additional information I could give, please let me know.

Regards,

--=20
Eduardo

--MhP8cYafZlTESjGT
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6QGxcaRJ66w1lWgRAujvAJ9m+jpLlfFHL1pto0WebBrDwBo6vgCgkM5b
Ra94n3pn6mfRwTL5O/MPdBs=
=FXcN
-----END PGP SIGNATURE-----

--MhP8cYafZlTESjGT--
