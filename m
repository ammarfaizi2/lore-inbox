Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbTCCFEn>; Mon, 3 Mar 2003 00:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268351AbTCCFEn>; Mon, 3 Mar 2003 00:04:43 -0500
Received: from dsl093-244-091.ric1.dsl.speakeasy.net ([66.93.244.91]:53475
	"EHLO perl") by vger.kernel.org with ESMTP id <S268348AbTCCFEm>;
	Mon, 3 Mar 2003 00:04:42 -0500
Date: Mon, 3 Mar 2003 05:15:03 +0000
From: xsdg <xsdg@freenode.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.60-63 panic: unable to mount root
Message-Id: <20030303051503.7084ec0e.xsdg@freenode.org>
X-Mailer: Sylpheed version 0.8.10claws13 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.hWA7f_te=qF1V:"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.hWA7f_te=qF1V:
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi... I saw your post in the lkml archives (I'm not subscribed either).  I think I'm having either a very similar problem, or the same problem that you are.

Similarities:
	Can't mount root, kernel panic
	Only happening in 2.5.62-ac1 (I haven't tried any other 2.5.6x kernels)

Differences:
	Using IDE root disc
	Using devfs
	root, which contains /boot, is ext3

I think something about device handling may have changed which is causing this problem. (for me, devfs started needing a root= option since about 2.5.50).  Additionally, when the kernel panics, does it specify the correct major/minor device number?  Mine uses the wrong one unless I use rdev, and then panics with the correct one (/dev/hda2, 0x0302)

These are the relevant entries in grub's menu.lst:

timeout 5
default 0

title   2.5.62 ac1
root    (hd0,1)
kernel  /boot/kernel/62.5.2k-ac1 root=/dev/ide/host0/bus0/target0/lun0/part2

title   2.5.51
root    (hd0,1)
kernel  /boot/kernel/51.5.2k-br root=/dev/ide/host0/bus0/target0/lun0/part2

the second entry works fine, but the first entry panics and gives me the same message you described.

	--xsdg
-- 
| Every child asks questinos.  I'm just still a     |
|   child.                                          |
|   -- Steven Hawking                               |
) http://www.cuodan.net/~xsdg/    xsdg@freenode.org (


--=.hWA7f_te=qF1V:
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+YuTcLa8oArNOsUERAuk/AJ9yBlfvu9yG9jAopEwFqbfMelVkhQCgjRbf
TJjo/A28JP9Dc7mZUwaedJ8=
=ISPG
-----END PGP SIGNATURE-----

--=.hWA7f_te=qF1V:--
