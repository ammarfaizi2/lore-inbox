Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317181AbSFRAII>; Mon, 17 Jun 2002 20:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317184AbSFRAIH>; Mon, 17 Jun 2002 20:08:07 -0400
Received: from joergland.wh-hms.uni-ulm.de ([134.60.220.110]:64898 "EHLO
	joergland.wh-hms.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S317181AbSFRAIG>; Mon, 17 Jun 2002 20:08:06 -0400
Date: Tue, 18 Jun 2002 02:07:54 +0200
To: linux-kernel@vger.kernel.org
Subject: [2.4.18/2.4.19 IDE] cannot read(2) from IDE-DVD-ROM drive
Message-ID: <20020618000754.GA8357@joergland.wohnheim.uni-ulm.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Joerg Wendland <jorgland@sol.wh-hms.uni-ulm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,
I have a MATSHITADVD-ROM SR-8176 (as reported in /proc) on a i830 chipset=
=20
integrated IDE controller running with PIIX4 drivers in a 2.4.18 or=20
2.4.19-pre10 kernel. Everything works fine except read()ing and e.g.=20
llseek()ing on that drive when a DVD-ROM is inserted. CD-ROM make now=20
problems but DVD-ROMs (_not_ video DVDs with that RPC crap but data DVDs).=
=20
I can mount them and use them but I simply cannot use basic file operations=
.=20
I verified the following:

sam:~# mount /dev/hdc -t iso9660 /cdrom/
mount: block device /dev/hdc is write-protected, mounting read-only
sam:~# ls /cdrom/
audio_ts     desktop  dvd	gamestarter.exe  patches    start.exe
autorun.inf  directx  extras	leser		 programme  treiber
demos	     dlh      gamestar	mods		 screens    video_ts
sam:~# umount /cdrom/
sam:~# dd if=3D/dev/hdc of=3D/tmp/test
0+0 records in
0+0 records out
sam:~# cat /dev/hdc
# test.c is quoted at the end of that mail
sam:~# ./test /dev/hdc
read 0 bytes

All that works with CD-ROMs in that drive and google had nothing to say
about that phenomenon.
Any objections?

Thanks in advance,
  Joerg

PS: please CC me as I am currently not subscribed to lkml.

test.c as used for the test above:
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#define __USE_LARGEFILE64
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>

int main(int argc, char **argv)
{
        int fd, c;
        char buf[4096];

        if(argc < 2)
                exit(1);

        if((fd =3D open(argv[1], O_RDONLY|O_LARGEFILE)) =3D=3D -1) {
                printf("open failed: %s\n", strerror(errno));
                exit(1);
        }

        if((c =3D read(fd, buf, 4096)) =3D=3D -1) {
                printf("read failed: %s\n", strerror(errno));
                close(fd);
                exit(1);
        }

        printf("read %d bytes\n", c);
        close(fd);

        return 0;
}

--=20
Joerg "joergland" Wendland
GPG: 51CF8417 FP: 79C0 7671 AFC7 315E 657A  F318 57A3 7FBD 51CF 8417

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9DnnaV6N/vVHPhBcRAv2XAKCNU7Jn30f9Vzlcz8lhTKU7QQvBhwCfTHGm
Mv1cdTrFRBSjBPFck9xHLus=
=i9SJ
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
