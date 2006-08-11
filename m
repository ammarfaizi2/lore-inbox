Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWHKN42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWHKN42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWHKN42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:56:28 -0400
Received: from nef2.ens.fr ([129.199.96.40]:21516 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1751117AbWHKN41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:56:27 -0400
Date: Fri, 11 Aug 2006 15:56:25 +0200
From: Nicolas George <nicolas.george@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Automatic namespace switch
Message-ID: <20060811135625.GA18616@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 11 Aug 2006 15:56:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

I was wondering about one particular feature extending namespaces
functionalities: automatic namespace switching. The principle would be: a
process references several namespaces. One of these namespaces is the actual
namespace the process is living in. During the process lifespan, various
events can cause it to automatically switch to another of its namespaces.

The type of event I am especially interested in is the execve()ing of a
32bit file in the case of the x86_64 architecture: the init process creates
two namespaces, one mounting a 64bit /usr and a 32bit /usr/32 (or maybe
another name), the other mounting the 32bit in /usr and the 64bit in
/usr/64, both sharing /home, /tmp and part of /var. When a program available
only in 32bit is needed, it is exec()ed in /usr/32/bin/ (which is probably
in the PATH), and that fact causes the process to switch to the 32bit
namespace, where the program will find all its libraries and data at the
expected place.

Such a feature would require careful examination about the security
implication. But I believe it may help to make the transition to pure 64bit
systems (which, I fear, will be long) smoother.

Does anyone have remarks about such an idea, be it to explain why it is
stupid?

Regards,

--=20
  Nicolas George

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (SunOS)

iD8DBQFE3IyJsGPZlzblTJMRArsqAJ41zjeWGGrFFqv20Aih3B1sLEgIOgCgiOtL
VbMHogG6YepH+y/jZoXezJQ=
=Lv0V
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
