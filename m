Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269754AbUICUnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269754AbUICUnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 16:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269788AbUICUnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 16:43:11 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:18889 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S269807AbUICUjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 16:39:10 -0400
Message-Id: <200409032039.i83Kd1ZR028638@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 07/26/2004 with nmh-1.1-RC3
To: =?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?= <ks@cs.aau.dk>
Cc: umbrella-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Umbrella-devel] Re: Getting full path from dentry in LSM hooks 
In-Reply-To: Your message of "Fri, 03 Sep 2004 22:05:03 +0200."
             <4138CE6F.10501@cs.aau.dk> 
From: Valdis.Kletnieks@vt.edu
References: <41385FA5.806@cs.aau.dk> <1094220870.7975.19.camel@localhost.localdomain>
            <4138CE6F.10501@cs.aau.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_318214536P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 03 Sep 2004 16:39:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_318214536P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 03 Sep 2004 22:05:03 +0200, =3D?UTF-8?B?S3Jpc3RpYW4gU8O4cmVuc2Vu?=
=3D said:

> Also simple bufferoverflows in suid-root programs may be avoided. The=20
> simple way would to set the restriction =22no fork=22, and thus if an=20
> attacker tries to fork a (root) shell, this would be denied.

All this does is stop fork().  I'm not sure, but most shellcodes I've see=
n
don't bother forking, they just execve() a shell....

It doesn't stop a buffer overflow that does this:

	f1 =3D open(=22/bin/bash=22);
	f2 =3D open(=22/tmp/bash=22, O_CREAT);
	while ((bytes =3D read(f1,buffer,sizeof(buffer))) > 0)
		write(f2,buffer,bytes);
	fchmod(f2,4775);
	close(f1); close(f2);

Papering over *that* one by restricting fchmod just means the exploit nee=
ds to
append a line to /etc/passwd, or create a trojan inetd.conf or crontab en=
try,
or any of the other myriad ways a program can leave a backdoor (there's a=

*reason* SELinux ends up with all those rules - this isn't an easy task).=
..

Remember - just papering over the fact that most shellcodes just execve()=
 a
shell doesn't fix the fundemental problem, which is that the attacker is =
able
to run code of his choosing as root.


--==_Exmh_318214536P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBONZkcC3lWbTT17ARAuU0AKC1jqxeO2a56R+pua/T0eVEBIPFLwCgrYO7
u1L+9ZwDN+WVHGQYifTSNao=
=EP/G
-----END PGP SIGNATURE-----

--==_Exmh_318214536P--
