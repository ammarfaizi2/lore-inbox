Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVGGUnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVGGUnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGGUng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:43:36 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:17338 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S261376AbVGGUnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:43:14 -0400
Date: Thu, 7 Jul 2005 22:43:09 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: "'Jens Axboe'" <axboe@suse.de>, hdaps-devel@lists.sourceforge.net,
       "'Lenz Grimmer'" <lenz@grimmer.com>,
       "'Arjan van de Ven'" <arjan@infradead.org>,
       "'Jesper Juhl'" <jesper.juhl@gmail.com>,
       "'Dave Hansen'" <dave@sr71.net>,
       "'LKML List'" <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
	IBM HDAPS Someone interested? (Accelerometer))
Message-ID: <20050707204309.GB26802@vanheusden.com>
References: <200507071028.06765.spstarr@sh0n.net>
	<001901c58301$5d4b5070$600cc60a@amer.sykes.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r7U+bLA8boMOj+mD"
Content-Disposition: inline
In-Reply-To: <001901c58301$5d4b5070$600cc60a@amer.sykes.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Fri Jul  8 20:33:46 CEST 2005
X-MSMail-Priority: High
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Doesn't park here:

ehm:/home/folkert# ./park /dev/hda
head not parked 4c

ehm:/home/folkert# hdparm -i /dev/hda

/dev/hda:

 Model=3DIC25N060ATMR04-0, FwRev=3DMO3OAD5A, SerialNo=3DMRG357K3KKN0XH
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D7884kB, MaxMultSect=3D16, MultSect=3D=
16
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D117210240
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=3Dyes: mode=3D0x80 (128) WriteCache=3Denabled
 Drive conforms to: ATA/ATAPI-6 T13 1410D revision 3a:

 * signifies the current active mode

[   38.772050] hda: max request size: 1024KiB
[   38.792458] hda: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=3D163=
83/255/63, UDMA(100)

> > > #include <stdio.h>
> > > #include <unistd.h>
> > > #include <fcntl.h>
> > > #include <string.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/hdreg.h>
> > >
> > > int main(int argc, char *argv[])
> > > {
> > > 	unsigned char buf[8];
> > > 	int fd;
> > >
> > > 	if (argc < 2) {
> > > 		printf("%s <dev>\n", argv[0]);
> > > 		return 1;
> > > 	}
> > >
> > > 	fd =3D open(argv[1], O_RDONLY);
> > > 	if (fd =3D=3D -1) {
> > > 		perror("open");
> > > 		return 1;
> > > 	}
> > >
> > > 	memset(buf, 0, sizeof(buf));
> > > 	buf[0] =3D 0xe1;
> > > 	buf[1] =3D 0x44;
> > > 	buf[3] =3D 0x4c;
> > > 	buf[4] =3D 0x4e;
> > > 	buf[5] =3D 0x55;
> > >
> > > 	if (ioctl(fd, HDIO_DRIVE_TASK, buf)) {
> > > 		perror("ioctl");
> > > 		return 1;
> > > 	}
> > >
> > > 	if (buf[3] =3D=3D 0xc4)
> > > 		printf("head parked\n");
> > > 	else
> > > 		printf("head not parked %x\n", buf[3]);
> > >
> > > 	close(fd);
> > > 	return 0;
> > > }


Folkert van Heusden

--=20
Auto te koop, zie: http://www.vanheusden.com/daihatsu.php
Op zoek naar een IT of Finance baan? Mail me voor de mogelijkheden.
--------------------------------------------------------------------
 UNIX admin? Then give MultiTail (http://vanheusden.com/multitail/)=20
 a try, it brings monitoring logfiles to a different level! See    =20
 http://vanheusden.com/multitail/features.html for a feature-list. =20
--------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE
Get your PGP/GPG key signed at www.biglumber.com!

--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkLNk908Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuVocAniKxVl/i
beCWi9hLA5wKOsBcyXXEAKCLvq0EfQ4+Pv92lLYcOmxjYKy+tg==
=ogRd
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
