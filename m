Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbTJHCKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 22:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTJHCKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 22:10:23 -0400
Received: from cpe-024-165-190-126.midsouth.rr.com ([24.165.190.126]:34772
	"EHLO groundzero.enchanted.net") by vger.kernel.org with ESMTP
	id S261321AbTJHCKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 22:10:18 -0400
From: Aaron Wrasman <awrasman@enchanted.net>
Date: Tue, 7 Oct 2003 21:10:18 -0500
To: linux-kernel@vger.kernel.org
Subject: Slow network and initial TCP connection
Message-ID: <20031008021018.GA17457@enchanted.net>
Reply-To: wrasman@cs.utk.edu
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
X-Url: http://www.cs.utk.edu/~wrasman
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm working with a 2.4 kernel and we have linux servers (over 3000) that ha=
ve=20
to talk over a slow satellite connection. We noticed that it was timing out
on the initial TCP connection and had to retry. Between the first time
out and the second try with a longer timeout it was actually taking
longer than it use to with a different OS and we had more traffic on our
network because of the retry.

We changed one thing in include/linux/tcp.h

Change:

#define TCP_TIMEOUT_INIT ((unsigned)(3*HZ))

to be

#define TCP_TIMEOUT_INIT ((unsigned)(5*HZ))


We did this and connections work the first time and we cut our traffic
in half.


Is there a better way than having to hardcode this in a header file and
having to recompile the kernel? I would have thought someone would have
run into this on a high latency network before now and this would be
tuneable from /proc


I know that there are some socket options that an application can set to
override this in some places but I need to do this for all TCP traffic.


All suggestions?

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/g3IK4d99qqyIJKERAkx4AJ91gZOJXcQDDOQbevxrCJ+FFzKKPwCdHbLK
///o4y8uhv2vaSjGpbuGy80=
=ruT0
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
