Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276993AbRJHQfI>; Mon, 8 Oct 2001 12:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276987AbRJHQe5>; Mon, 8 Oct 2001 12:34:57 -0400
Received: from pD9E4AC01.dip.t-dialin.net ([217.228.172.1]:24745 "EHLO
	schiele.dyndns.org") by vger.kernel.org with ESMTP
	id <S276993AbRJHQes>; Mon, 8 Oct 2001 12:34:48 -0400
Date: Mon, 8 Oct 2001 18:32:40 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
        Adrian Bunk <bunk@fs.tum.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Linux-2.4.11-pre5
Message-ID: <20011008183240.A13046@schiele.local>
In-Reply-To: <3BC0C655.6C35DF43@oracle.com> <Pine.LNX.4.33.0110071643050.7542-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0110071643050.7542-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Oct 07, 2001 at 04:46:02PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 07, 2001 at 04:46:02PM -0700, Linus Torvalds wrote:
>=20
> On Sun, 7 Oct 2001, Alessandro Suardi wrote:
> >
> > Happens also for ieee1394 when built as module.
>=20
> Add "ohci1394.o" to the list of export-objs in ieee1349/Makefile.

To make this a bit more complete, I made a patch from all the
export-objs related changes I had to make to build my kernel. I don't
think that this list is complete, as I fixed only those parts that
prevented the kernel build on my system.

Robert

And now the patches:

--- linux-2.4.11-pre5/drivers/char/Makefile~	Sun Sep  9 19:43:02 2001
+++ linux-2.4.11-pre5/drivers/char/Makefile	Mon Oct  8 06:29:08 2001
@@ -23,7 +23,7 @@
=20
 export-objs     :=3D	busmouse.o console.o keyboard.o sysrq.o \
 			misc.o pty.o random.o selection.o serial.o \
-			sonypi.o tty_io.o tty_ioctl.o
+			sonypi.o tty_io.o tty_ioctl.o generic_serial.o
=20
 mod-subdirs	:=3D	joystick ftape drm pcmcia
=20
--- linux-2.4.11-pre5/drivers/ide/Makefile~	Tue Sep 18 08:23:40 2001
+++ linux-2.4.11-pre5/drivers/ide/Makefile	Mon Oct  8 06:48:09 2001
@@ -10,7 +10,7 @@
=20
 O_TARGET :=3D idedriver.o
=20
-export-objs		:=3D ide.o ide-features.o
+export-objs		:=3D ide.o ide-features.o ataraid.o
 list-multi		:=3D ide-mod.o ide-probe-mod.o
=20
 obj-y		:=3D
--- linux-2.4.11-pre5/drivers/ieee1394/Makefile~	Fri Jul 20 21:47:31 2001
+++ linux-2.4.11-pre5/drivers/ieee1394/Makefile	Mon Oct  8 07:02:34 2001
@@ -4,7 +4,7 @@
=20
 O_TARGET :=3D ieee1394drv.o
=20
-export-objs :=3D ieee1394_syms.o
+export-objs :=3D ieee1394_syms.o ohci1394.o
=20
 list-multi :=3D ieee1394.o
 ieee1394-objs :=3D ieee1394_core.o ieee1394_transactions.o hosts.o \
--- linux-2.4.11-pre5/drivers/video/sis/Makefile~	Fri Dec 29 23:07:23 2000
+++ linux-2.4.11-pre5/drivers/video/sis/Makefile	Mon Oct  8 17:30:28 2001
@@ -4,6 +4,8 @@
=20
 O_TARGET :=3D sisfb.o
=20
+export-objs :=3D sis_main.o
+
 obj-y  :=3D sis_main.o sis_300.o sis_301.o
 obj-m  :=3D $(O_TARGET)
=20

--=20
Robert Schiele			Tel.: +49-621-10059
Dipl.-Wirtsch.informatiker	mailto:rschiele@uni-mannheim.de

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO8HVKMQAnns5HcHpAQFsaAf/TsSbXlrcTC4RjurDwAvGzAe5w83ASMyQ
M5Afn+79njFh1bp/8DV6va09DPIQ+DaE4f6moucszQHf7ZEl1y+HOBexlzm4nauC
JfIO2pZ1pu3NnmFLpU4MprZuEh1v6Ch33tAJIl0yJUrVjAlp+WLzJgzxm46d1MYv
+8t8bz9e5wZEV3d3NIwhp1Ilf/GqloHOXZfNmc/Q6S6e3RlIHZW8tSDC7N194Gry
cz+zZT5wZgH99xrUiBmXcuMysvE5vNjTmajyF0tbq0Glo3c9hkTH2VNaKx37WFSy
oGy3pPedxFC5cqZkM4ku2Nb1rK1ajgBCbaNkFeWAN2lojlEc5asNLA==
=IF5v
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
