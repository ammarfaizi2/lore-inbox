Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312582AbSCVAmz>; Thu, 21 Mar 2002 19:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312583AbSCVAmq>; Thu, 21 Mar 2002 19:42:46 -0500
Received: from zeus.kernel.org ([204.152.189.113]:8668 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312582AbSCVAmd>;
	Thu, 21 Mar 2002 19:42:33 -0500
Date: Thu, 21 Mar 2002 19:41:18 -0500
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: Q: nesting do_IRQ's
Message-ID: <20020321194118.D24775@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I am running a system that is very heavily loaded with hardware
interrupts.  At the same time a single user-space app is constantly
calling an ioctl to get more data out of the kernel.

After some time (influenced by load) the system dies.  Usually the death
is in fget and the reason is an overwritten task_struct of the said
process.

I have put in tests in my interrupt handler to detect changes in a few
words of the task_struct.  While the changes are not as interesting I
see a lot of nesting of do_IRQ's, call_do_IRQ's, and handle_IRQ_event's.
All three are repeated about 10 times (on average) in by kdb back
trace.

I have looked at the ebp/esp when I detect the change in the
task_struct.  They seem to be within safe stack locations.  About 2k
above the task_struct of my process.  While I am fairly certain that it
was not my driver that ate the 2k of stack it may be something else.

So here is my question: is what I am seeing correct?  Are do_IRQ's
nested when the system is getting interrupts very rapidly?

Cheers,
Bart.

--=20
				WebSig: http://www.jukie.net/~bart/sig/

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE8mn2ukmD5p7UxHJcRAisJAJ9dGg5d/cPmCp5vCH2KGdUnhOW02gCWIDpk
yMRwqBUG07Ywa9OowYQQMQ==
=nKas
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
