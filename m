Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266197AbUGOP3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266197AbUGOP3M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 11:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266215AbUGOP3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 11:29:12 -0400
Received: from tapuz.safe-mail.net ([212.68.149.115]:10467 "EHLO
	tapuz.safe-mail.net") by vger.kernel.org with ESMTP id S266197AbUGOP3F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 11:29:05 -0400
X-SMType: Regular
X-SMRef: N1-WfUZvq4M
Subject: address of int80 idt
From: bugghy <bugghy@SAFe-mail.net>
To: linux-kernel@vger.kernel.org, bugghy@SAFe-mail.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DMOxDOL72W4PP1rieXZ/"
Message-Id: <1089916056.15617.14.camel@illusion.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 15 Jul 2004 18:27:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DMOxDOL72W4PP1rieXZ/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


	Hy, I'm working on an improved rk detector and I've got some problems.
I use this code to get the address of int80's idt (interrupt description
table)

struct idtr
{
  unsigned short limit;
  unsigned int base;
} __attribute__ ((packed));


void find_int80()
{
  struct idtr idtr;
  memset(&idtr, 0, sizeof(struct idtr));
  asm ("sidt %0" : "=3Dm" (idtr));
  printf("idtr.base=3D0x%08x\n", idtr.base);
  kmem_read(fd, &idt, sizeof(idt), idtr.base + 0x80 * sizeof(struct
idt));
  ...
}

The problem is that on some kernels 2.4.22 (and I think on 2.6.7, 2.2.26
and 2.4.26 too) on vmware sidt returns a bogus address for idtr.base:
idtr.base=3D0xffc6a370 (2.4.22)=20


If I try to read from /dev/kmem from this address it doesn't work.

I printed the contents of struct idtr after the sidt call, here it is:
ff 07 70 a3 c6 ff

What could be the problem? Is there any solution for this? Most of the
time works but not on my (2.4.22) vmware. And if this is not a bug, what
would be another method of doing this ?

PS: Please cc me the answer as I'm not on this mailling list.

	Thanks in advance,
		Bugghy


--=20
------------------------
- Software is like sex -
-     it's better when -
-          it's free   -
-     Linus Torvalds   -
------------------------

--=-DMOxDOL72W4PP1rieXZ/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (FreeBSD)

iD8DBQBA9syXkROrn8NnxIoRAvaRAJ9KWxrIbUqaQ5hOpPsfDz4FJQHdlgCfeBNB
SbxFGJABiAOjg6x6VUH6dKo=
=TgnQ
-----END PGP SIGNATURE-----

--=-DMOxDOL72W4PP1rieXZ/--

