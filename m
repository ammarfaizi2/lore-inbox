Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262244AbVEYChZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262244AbVEYChZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262242AbVEYChZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:37:25 -0400
Received: from mail.gmx.de ([213.165.64.20]:58753 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262244AbVEYChM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:37:12 -0400
X-Authenticated: #21330363
From: Sven Schnelle <svens@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack_standalone / sprintf to buffer
Date: Mon, 23 May 2005 22:50:54 -0700
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4
X-From-Line: nobody Mon May 23 22:50:57 2005
Message-ID: <873bscuj3s.fsf@deprecated.intranet.astaro.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

Hi,

found the following code snippet in ip_conntrack_standalone.c:145
in function conntrack_iterate():
=2D------------------000000------8<-----------------------------
	newlen =3D print_conntrack(buffer + *len, hash->ctrack);
	printk("len + newlen: %d maxlen: %d\n", *len + newlen, maxlen);
	if (*len + newlen > maxlen)
		return 1;
	else *len +=3D newlen;
=2D------------000000------------8<-----------------------------

print_conntrack() uses sprintf without length checking. And now i'm
wondering what happens if for example, maxlen=3D3072 and
len=3D3071. print_conntrack uses sprintf, writes beyond the end the buffer,=
 and
after this the check (*len + newlen > maxlen) is done. Looks to me like
a bug.

Did i missed something?

Bye,

Sven.
=2D-=20
"If you can't make it good, at least make it look good." Bill Gates on
 the solid code base of Win9X


--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCk+TL86MdxiXaIbERAtsgAJ4gKlKNrWHVyen6FN+cpKaqMEbIbQCgxuMc
Ci0PbpelCjDQIjHxsNYaSXY=
=DsOz
-----END PGP SIGNATURE-----
--=-=-=--

