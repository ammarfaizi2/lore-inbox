Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267335AbTAGHxS>; Tue, 7 Jan 2003 02:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267336AbTAGHxS>; Tue, 7 Jan 2003 02:53:18 -0500
Received: from diamond.madduck.net ([66.92.234.132]:40198 "EHLO
	diamond.madduck.net") by vger.kernel.org with ESMTP
	id <S267335AbTAGHxQ>; Tue, 7 Jan 2003 02:53:16 -0500
Date: Tue, 7 Jan 2003 09:01:35 +0100
From: martin f krafft <madduck@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 'D' processes on a healthy system?
Message-ID: <20030107080135.GA21307@fishbowl.madduck.net>
References: <20021219124043.GA28617@fishbowl.madduck.net> <1040319832.28973.4.camel@irongate.swansea.linux.org.uk> <20021219182359.GA29366@fishbowl.madduck.net> <1040326031.28973.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <1040326031.28973.23.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Debian GNU/Linux
X-OS: Debian GNU/Linux testing/unstable kernel 2.4.19-grsec+freeswan-fishbowl i686
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Alan Cox <alan@lxorguk.ukuu.org.uk> [2002.12.19.2027 +0100]:
> Its more to do with the controller and configuration. Eg if your disk
> isnt in DMA mode it'll certainly show up

i know took the system offline to test a little more. the harddrive is
operating fine without errors. i defined runlevel 4 to be single user
mode + sshd, now the system is running 14 processes including the
kernel processes.

hdparm shows this for /dev/hda:

/dev/hda:
 multcount    =3D 16 (on)
 I/O support  =3D  1 (32-bit)
 unmaskirq    =3D  1 (on)
 using_dma    =3D  1 (on)
 keepsettings =3D  0 (off)
 nowerr       =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 2491/255/63, sectors =3D 40021632, start =3D 0
 busstate     =3D  1 (on)

correct me if i am wrong, but it is properly tweaked. moreover, lspci
shows that there is a VT82C598 [Apollo MVP3] VIA Chipset in there, and
my kernel config is optimized for that:

  CONFIG_BLK_DEV_IDEPCI=3Dy
  CONFIG_IDEPCI_SHARE_IRQ=3Dy
  CONFIG_BLK_DEV_IDEDMA_PCI=3Dy
  CONFIG_IDEDMA_PCI_AUTO=3Dy
  CONFIG_BLK_DEV_IDEDMA=3Dy
  CONFIG_BLK_DEV_ADMA=3Dy
  CONFIG_BLK_DEV_VIA82CXXX=3Dy
  CONFIG_IDEDMA_AUTO=3Dy
  CONFIG_BLK_DEV_IDE_MODES=3Dy

Nevertheless, with 14 processes running and none of them accessing
the disk, i started an rsync process over ssh for the home partition.
and performance is ridiculous. rsync will transfer about 40k before
the rsync process enters 'D' state as shown by top. this takes about
10 seconds, then rsync gets to transfer another 40k.

this is on an AMD K6-2 500 MHz machine with 160 Mb RAM, 256Mb of swap
and a Maxtor 10Gb drive spinning at 5,400 I believe.

What's the problem?

--=20
Please do not CC me! Mutt (www.mutt.org) can handle this automatically.
=20
 .''`.     martin f. krafft <madduck@debian.org>
: :'  :    proud Debian developer, admin, and user
`. `'`
  `-  Debian - when you have better things to do than fixing a system
=20
NOTE: The pgp.net keyservers and their mirrors are broken!
Get my key here: http://people.debian.org/~madduck/gpg/330c4a75.asc

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+GolfIgvIgzMMSnURAtj0AJ9GV6lavVFV+CMPonEeRxkhKezQ5QCg28mo
7UEAdcVdQ9kkxSoKaaWiMYU=
=GFTA
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
