Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbVI2Hlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbVI2Hlx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 03:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVI2Hlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 03:41:53 -0400
Received: from wg.technophil.ch ([213.189.149.230]:48843 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S932084AbVI2Hlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 03:41:53 -0400
Date: Thu, 29 Sep 2005 09:41:40 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-hotplug-devel@lists.sourceforge.net
Subject: udev/modprobe issue
Message-ID: <20050929074140.GD2886@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-hotplug-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Ycz6tD7Th1CMF4v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning everybody!

I've a small problem with loading the sata_sil module, but it could be a
general issue: We use this sata-kontroller with sata-harddisks to backup
our systems. The harddisk is exchanged (while the system is running) every
day. So we load/unload sata_sil in our backup scripts, so 'hotplugging' is =
possible.

My problem is, that modprobe returns earlier than the attached device is us=
able:

----------------------------------------------------------------------
srwali01:/# modprobe sata_sil; mount /dev/sda1 /mnt/hdbackup/
mount: you must specify the filesystem type
srwali01:/# rmmod sata_sil
srwali01:/# modprobe sata_sil; ls -l /dev/sda1              =20
ls: /dev/sda1: No such file or directory
----------------------------------------------------------------------

So I have to do

----------------------------------------------------------------------
srwali01:/# modprobe sata_sil
srwali01:/# sleep 2
srwali01:/# mount /dev/sda1 /mnt/hdbackup
----------------------------------------------------------------------

The problem is most likely that udev is too slow or that modprobe does not
know/wait for udev:

----------------------------------------------------------------------
srwali01:/# mount | grep tmpfs | grep -v /dev/shm
tmpfs on /dev type tmpfs (rw,size=3D10M,mode=3D0755)
srwali01:/# cat /proc/sys/kernel/hotplug=20
/sbin/udevsend
----------------------------------------------------------------------

My questions:

- Should modprobe wait for whatever current hotplug is so that
  the system can definitly use the device after modprobe?
- Or should there be a command-line switch to modprobe to tell it to wait
  for hotplug?
- Is the 'wait for hotplug'-idea possible to do or would it have to be a di=
rty
  hack in the kernel?
- Is there clean solution to wait exactly as long as
  it needs to load sata_sil and create /dev/sda*?
  Using while+ls monitoring /dev/sda* is not a solution imho.

Greetings,

Nico

P.S.: Sorry for crossposting, I am not really sure which list would have be=
en
      the correct one to ask.

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iQIVAwUBQzuas7OTBMvCUbrlAQIJsw/+LVyhsY8Qzxq5XAI7kxEgzr3I5czFimTW
9F89qjabvHMSEkjrx81oyjOfMmwQTJGolTt2N9CRsBto4e+ymHST/rZvPXw9oLOv
DD7vAA8wsn8tXjAi1cQzSXn/SP973W4wBCm+chrB2TVr2GF4ILndVes6C2bou57i
nOHUXa4Q6GjmnVboXWnf2FxQWIV0QteLYEGV0tuuMeMNz6IB3rV2ED/Xs+A+AYRI
LH+ks4LhwJ5Gto6zeNRZriWWQh6oNqtm4pSPy8QAQgK3LVpNfxdbonF98zpMjeuF
lKWq4MttaQkUDz0UsbS3OJ0Y2TIsax4xZpRwgDY55onObmgjhV4g7mgC5C8cCrwW
z+yFePPUaxWXLWu31TfD7Dbtw4NW2O4qrQRGclo5edKXGqSF9FAOD/JR9+sEHhZr
cINs1j2QQP7jojhGuEHWtQhcz8puVNXW5HVXy4MBpxHuiTAnu1eQb/V5lcwZchhK
jB00pHUX3k9s0ArXas2AMJ7UN2QtJxU1pkgffdoIk0fxOMbJhi5wDoP6B3x4NfZ+
hRmSmg9gC8C4fRPw5/+PkGAQ5cOo0tic5JjML9lJPtNvWx6rhnrNfW2i0X/qp8Wb
OGqZXb4yJ3849PsIY2LxWgep9tOTl/r8Thk0PsQHpleKN5/5A3PKNt9A8dGxaQ1I
Fx0SSKVcirU=
=HrMe
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--
