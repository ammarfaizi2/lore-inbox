Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268532AbUIGUdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268532AbUIGUdb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 16:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUIGUc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 16:32:27 -0400
Received: from ranger.kyivstar.net ([193.41.60.22]:13576 "EHLO
	ranger.kyivstar.net") by vger.kernel.org with ESMTP id S268580AbUIGU30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 16:29:26 -0400
Date: Tue, 7 Sep 2004 23:22:12 +0300
From: "Vitaly V. Bursov" <vitalyvb@ukr.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>
Subject: Linux-2.6.8.1 input/serio/serport local unprivileged panic/dos
Message-Id: <20040907232212.1e967598.vitalyvb@ukr.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__7_Sep_2004_23_22_12_+0300_WyN5h0i5Yn8O=gTF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__7_Sep_2004_23_22_12_+0300_WyN5h0i5Yn8O=gTF
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello,

drivers/input/serio/serport.c can lead to kernel panic in serio code
followed by jbd's panic (probably due to random memory write, I don't
now) and/or system lockup.

Another drivers with the same desing (are there any?) can be vulnerable too.

Steps to exploit it:

process 1:
 open() a tty device;
 TIOCSETD it to N_MOUSE;
 read() it. it will block.

after that, process 2:
 open() the same device;
 TIOCSETD it to 0;
 TIOCSETD it to N_MOUSE; (not sure if it's necessary)
 kill() process 1;

If some code or more info is needed, please contact me, I'm not
at the list.

-- 
Thanks,
Vitaly
GPG Key ID: F95A23B9

--Signature=_Tue__7_Sep_2004_23_22_12_+0300_WyN5h0i5Yn8O=gTF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBPhh073PAj/laI7kRArvtAJwLxWW70OWUDP7XA7HqDz9HkviPVACdFQvy
SpaHTmu9rdbqW+B1RAeNHNo=
=sPXM
-----END PGP SIGNATURE-----

--Signature=_Tue__7_Sep_2004_23_22_12_+0300_WyN5h0i5Yn8O=gTF--
