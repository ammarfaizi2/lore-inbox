Return-Path: <linux-kernel-owner+w=401wt.eu-S964782AbXASR5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbXASR5u (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 12:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964771AbXASR5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 12:57:50 -0500
Received: from threatwall.zlynx.org ([199.45.143.218]:33167 "EHLO zlynx.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964782AbXASR5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 12:57:49 -0500
Subject: linux-2.6.20-rc4-mm1 Reiser4 filesystem freeze and corruption
From: Zan Lynx <zlynx@acm.org>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-egadha93x63bRqo945nm"
Date: Fri, 19 Jan 2007 10:58:10 -0700
Message-Id: <1169229490.6266.11.camel@oberon>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
X-Envelope-From: zlynx@acm.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-egadha93x63bRqo945nm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I have been running 2.6.20-rc2-mm1 without problems, but both rc3-mm1
and rc4-mm1 have been giving me these freezes.  They were happening
inside X and without external console it was impossible to get anything,
plus I was reluctant to test it since the freeze sometimes requires a
full fsck.reiser4 --build-fs to recover the filesystem.

But I finally got some output in a console session.  I wasn't able to
get it all, I made some notes of what I think the problem is.  I may try
again later once I get netconsole working (netconsole fails as a
built-in, I'll try it as a module next).

1 lock held by pdflush/185:
#0: (&type->s_umount_key#15) ... writeback_inodes+0x89

3 locks held by realsync/12942:
#0: (&type->s_umount_key#15) at ... __sync_inodes+0x78
#1: (&mgr->commit_mutex) ... reiser4_txn_end+0x37a
#2: (&qp->mutex) ... synchronize_qrcu+0x19

So, I *think* the problem is two locks on s_umount_key#15.  Does that
sound likely?  I also noticed QRCU may be involved.

Perhaps someone will look at this and instantly know what the problem
is.

If not, I'll be following up with more details like .config and perhaps
a full sysrq-T dump as soon as that fsck finishes.

--=-egadha93x63bRqo945nm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFsQayG8fHaOLTWwgRAsm3AJ4olwpFn/9rrMvjc9fKuV7178sJzACeL/Ez
R/vqYlLg1XxkewWgnvQ+VQs=
=G6Uu
-----END PGP SIGNATURE-----

--=-egadha93x63bRqo945nm--

