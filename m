Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWIXUoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWIXUoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWIXUoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:44:44 -0400
Received: from mail.gmx.de ([213.165.64.20]:40071 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932078AbWIXUoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:44:44 -0400
X-Authenticated: #590723
From: Fabian Franz <FabianFranz@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Use zero-copy (aka pipe/splice) for skbuff to enhance socketpair performance?
Date: Sun, 24 Sep 2006 19:38:31 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1824869.DXcXQSfxco";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609241938.38378.FabianFranz@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1824869.DXcXQSfxco
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

as far as I know pipe() is now much faster than socketpair(), because pipe(=
)=20
uses the zero-copy mechanism.

However there are numerous applications using socketpair() instead of two=20
pipe()s, because they need exactly _one_ fd for read/write instead of 2.

Over 180 open unix domain sockets are on my system right now.

Many of this applications could gain a speedup if only they could change to=
 a=20
different system call like epipe().

epipe() would behave like socketpair(), but internally use two pipes (one f=
or=20
each direction).

It seems so easy to do, so I'm really wondering, why it hasn't been done, y=
et?

However new system calls always have the problem of portability. Though in=
=20
this case an epipe -> socketpair fallback would work.

So perhaps a better idea would be to enhance skbuff to use the new zero-cop=
y=20
mechanism ... ?

The reason why I had the idea is that I had huge socketpair performance=20
problems, but with an old 2.4.27 kernel and a custom kernel module:

Almost 1 sec of latency!

Changing the fds provided from userspace to pipe()s did result in good=20
performance.

Might be a bug in my module though ...

cu

=46abian

PS: Please CC me as I'm not subscribed.

=2D-=20
      *** Consulting - Training - Workshops - Troubleshooting ***
   @@@ LiveCDs (Knoppix), Debian, Remote Desktop Access (FreeNX) @@@

=2D-- Fabian Franz --- www.fabian-franz.de --- consulting@fabian-franz.de

--nextPart1824869.DXcXQSfxco
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFFsKeI0lSH7CXz7MRAikPAJ9S2gXRlGQdZt6pyKEGQNEJMDNTJACcC1Ab
qwAL4B7I9TDAnjgEvQonzno=
=C5TJ
-----END PGP SIGNATURE-----

--nextPart1824869.DXcXQSfxco--
