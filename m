Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131395AbRCUMyz>; Wed, 21 Mar 2001 07:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbRCUMyo>; Wed, 21 Mar 2001 07:54:44 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:1291 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131382AbRCUMy2>; Wed, 21 Mar 2001 07:54:28 -0500
Date: Wed, 21 Mar 2001 13:53:40 +0100
From: Joern Heissler <joern@heissler.de>
To: linux-kernel@vger.kernel.org
Subject: strange problem with /dev/isdninfo
Message-ID: <20010321135340.A11899@debian.heissler.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!
I'm new to the Mailinglist.

I've got a strange problem with /dev/isdninfo:

joern:~# cat /dev/isdninfo
idmap:  Hisax...
chmap: 0 1 ...
foo
bar
phone:  ??? ??? ...

--> cat /dev/isdninfo works :-)

Here's the problem:

joern:~# cat <<EOF >cat2.c
#include <unistd.h>
#include <fcntl.h>

int main(int argc, char **argv)
{
	char buf[500];
	int fd;

	if(argc!=3D2) {
		return(1);
	}
	fd=3Dopen(argv[1],O_RDONLY);
	write(1,buf,read(fd,buf,200));
	return(0);
}
EOF
joern:~# gcc -o cat2 -Wall -ansi cat2.c
joern:~# ./cat2 /dev/urandom ---> 200 bytes of random characters. works :-)
joern:~# ./cat2 /dev/isdninfo ---> nothing.=20

joern:~# strace ./cat2 /dev/isdninfo
=2E..
open("/dev/isdninfo", O_RDONLY) =3D 3
read(3, "", 200) =3D 0
write(1, "", 0) =3D 0
_exit(0) =3D ?


Could someone please tell me what's wrong? I (and some other people) do not=
 understand this.
Thanks in advance!


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEUEARECAAYFAjq4pFMACgkQs5jrxlfHa2YHAwCY0b+HO+mPNUkKNV+cMpsoE9jH
EwCfQUZcpFSi/V9MZyceP5vCfkkC8iw=
=5WVs
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
