Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbTIEJRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTIEJRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:17:47 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:37504
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S262347AbTIEJRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:17:45 -0400
Date: Fri, 5 Sep 2003 11:17:44 +0200
To: linux-kernel@vger.kernel.org
Cc: Andries.Brouwer@cwi.nl
Subject: test4: loop deadlock
Message-ID: <20030905091744.GA2320@leto2.endorphin.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1063617464.b162@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Block-backed loop devices can cause a deadlock.

How to reproduce:

You need ~100mb partition.
Boot with mem=3D32m (otherwise the cache will be to big in the most cases)=
=20

swapoff -a
losetup /dev/loop0 /dev/hdXX
for i in `seq 1 10`; do
 dd if=3D/dev/zero of=3D/dev/loop0 &
done

Now the box "should" freeze. This doesn't happen with filebased read/write
or blockbased read. Jari's loop survives this stress test without problems.
So probably we should continue with merging his loop changes. Andries, are
you still interested in that?

(As long term solution for the indisputable ugliness of loop.c: just throw
away block-backend support and move the cryptostuff to device mapper:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D105967481007242&w=3D2=20
The patch is working great, btw, much more stable than loop+cryptoloop.
I'd really like to see it merged)

Regards, Clemens

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/WFS4W7sr9DEJLk4RAvdEAJ4xC1/9pUepE+YTUnUDrhGhYf5SIQCgjFvl
5mXCcyxSTHGh+1bqCOXreOw=
=rE5h
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
