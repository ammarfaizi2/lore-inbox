Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbTKXS3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTKXS3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:29:47 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:55171 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263523AbTKXS3p (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:29:45 -0500
Message-Id: <200311241829.hAOITdKL014364@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Jakob Lell <jlell@JakobLell.de>
Cc: splite@purdue.edu, root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: hard links create local DoS vulnerability and security problems 
In-Reply-To: Your message of "Mon, 24 Nov 2003 19:18:56 +0100."
             <200311241918.56486.jlell@JakobLell.de> 
From: Valdis.Kletnieks@vt.edu
References: <200311241736.23824.jlell@JakobLell.de> <200311241857.41324.jlell@JakobLell.de> <20031124180838.GA8065@sigint.cs.purdue.edu>
            <200311241918.56486.jlell@JakobLell.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1376464207P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Nov 2003 13:29:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1376464207P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <9727.1069698579.1@turing-police.cc.vt.edu>

On Mon, 24 Nov 2003 19:18:56 +0100, Jakob Lell said:
> 
> Even if you put /usr on a separate partition, users can create a setuid (not 
> setuid-root) program in their home directory. Other users can create links to
 
> this program in their home directory. Even if this can't be used to become 
> root, it shouldn't be possible. To prevent this, you have to put every user's
 
> home directory on a separate partition.

mkdir ~/bin
chmod 700 ~/bin
cat > ~/bin/show-me
#!/bin/sh
whoami
^D
chmod 4755 ~/bin/show-me

No separate partitions needed.

If the link() syscall doesn't throw an EACCESS because of that chmod,
you have bigger problems.

In any case, if a user is *MAKING* a program set-UID, it's probably because
he *wants* it to run as himself even if others invoke it (otherwise, he
could just leave it in ~/bin and be happy).  So this is really a red herring,
as it's only a problem if (a) he decides to get rid of the binary, and fails
to do so because of hard links he doesn't know about, or (b) he's an idiot
programmer and it malfunctions if invoked with an odd argv[0]....

--==_Exmh_1376464207P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/wk4TcC3lWbTT17ARAmhOAKC2HmVcRT9to+AhTAoFa7AH+OmfLACgsr+t
LpolBOZw8gzJ/cRRGzeE6yk=
=ccU8
-----END PGP SIGNATURE-----

--==_Exmh_1376464207P--
