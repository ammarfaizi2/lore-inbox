Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWDWO6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWDWO6v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 10:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWDWO6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 10:58:51 -0400
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:62679 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id S1751407AbWDWO6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 10:58:50 -0400
Date: Sun, 23 Apr 2006 16:58:47 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Valdis.Kletnieks@vt.edu
Cc: Crispin Cowan <crispin@novell.com>, Pavel Machek <pavel@ucw.cz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-Id: <20060423145846.GA7495@thorium.jmh.mhn.de>
Mail-Followup-To: Valdis.Kletnieks@vt.edu,
	Crispin Cowan <crispin@novell.com>, Pavel Machek <pavel@ucw.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
	James Morris <jmorris@namei.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
	T?r?k Edwin <edwin@gurde.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@sous-sol.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz> <444AF977.5050201@novell.com> <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <200604230933.k3N9XTZ8019756@turing-police.cc.vt.edu>
X-Accept-Language: de, en
X-Operating-System: Linux 2.6.12-10-386 i686
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Valdis.Kletnieks@vt.edu [2006-04-23 11:35]:
> On Sat, 22 Apr 2006 20:50:15 PDT, Crispin Cowan said:
> >> What happens if I ln /bin/stty /tmp/evilstty, then exploit
> >> vulnerability in stty?=20
>=20
> A crucial point here is that the 'ln' and the actual exploit don't
> have to be firmly attached to each other...

Yes, it doesn't even have to be malicious. Consider the following
example:
An admin sets up an ftp-server with write access, running as root. He
chroots it and even creates AppArmor policy for it. However, he's a bit
sloppy and configures AppArmor so that the ftpd has write access to
everything in the chroot (even the stuff in bin/). The system is still
save, however, since the ftpd can't access anything outside of his
chroot.
Later, the admin decides to save space, deletes the bin/ directory and
instead links /bin/ls into the chroot. Suddenly the system is easily
exploitable.
I think that's what people mean when they say "impossible to analyze".
You have to look at the complete filesystem state to make sure you
didn't accidently compromise the whole system.

Thomas


--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFES5YmD9qpeVMU938RAmJfAJ9cnkfvdh7mIM4cLS7fJHu2nwry5wCfTBl2
N4j3pX+ZzTT5SYI7/jeILpI=
=QCUf
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
