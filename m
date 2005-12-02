Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVLBQlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVLBQlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVLBQlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:41:09 -0500
Received: from wg.technophil.ch ([213.189.149.230]:50128 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1750813AbVLBQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:41:08 -0500
Date: Fri, 2 Dec 2005 17:40:47 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Daniel Aubry <kernel-acl@spam.kicks-ass.net>
Subject: ACL Problem
Message-ID: <20051202164047.GN32690@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Aubry <kernel-acl@spam.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I've problems settings ACLs on differnt hosts:

- ext3 does not work anywhere, error as in not supported ACLs
- reiserfs does not work either (does in support acls anyway?)
- jfs with ACLs works fine, jfs without ACLs behaves correctly not beeing a=
ble to
  set them
- On xfs it works everwhere

Here's the output of those machines:

-----------------------------Host1: srsyg01--------------------------------=
-----
srsyg01:/home/server/git# setfacl -R -m g:lw1:rwx walderlift-db-verifiziere=
n.git/description=20
setfacl: walderlift-db-verifizieren.git/description: Operation not supported
srsyg01:/home/server/git# uname -a
Linux srsyg01 2.6.12xenU #7 Sun Nov 6 13:54:56 CET 2005 i686 GNU/Linux
srsyg01:/home/server/git# zcat /proc/config.gz | grep ACL
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_FS_POSIX_ACL=3Dy
srsyg01:/home/server/git# mount | grep /home=20
/dev/sdb1 on /home type ext3 (rw)
srsyg01:/home/server/git# setfacl --version
setfacl 2.2.32
-----------------------------Host1: srsyg01 (End)--------------------------=
-----

-----------------------------Host2: bruehe --------------------------------=
-----
bruehe2# setfacl  -m d:m:rwx woech =20
setfacl: woech: Operation not supported
bruehe2# zcat /proc/config.gz | grep ACL
CONFIG_RSBAC_ACL=3Dy
# ACL Policy Options
# CONFIG_RSBAC_ACL_SUPER_FILTER is not set
CONFIG_RSBAC_ACL_AUTH_PROT=3Dy
CONFIG_RSBAC_ACL_UM_PROT=3Dy
CONFIG_RSBAC_ACL_GEN_PROT=3Dy
# CONFIG_RSBAC_ACL_BACKUP is not set
# CONFIG_RSBAC_ACL_LEARN is not set
CONFIG_RSBAC_ACL_NET_DEV_PROT=3Dy
CONFIG_RSBAC_ACL_NET_OBJ_PROT=3Dy
# CONFIG_RSBAC_SWITCH_ACL is not set
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
bruehe2# mount | head -n1
/dev/md0 on / type ext3 (rw)
[17:37] bruehe2:~% setfacl --version
setfacl 2.2.32
-----------------------------Host2: bruehe (END) --------------------------=
-----

-----------------------------Host3: idoru  --------------------------------=
-----
cs2-dev-01:/www/idoru.baselbiet.ch# setfacl -m d:m:rwx .
setfacl: .: Operation not supported
cs2-dev-01:/www/idoru.baselbiet.ch# mount | grep /var
/dev/mapper/vg01-var on /var type ext3 (rw)
cs2-dev-01:/www/idoru.baselbiet.ch# zcat /proc/config.gz | grep ACL=20
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFSD_V3_ACL is not set
cs2-dev-01:/www/idoru.baselbiet.ch# setfacl  --version
setfacl 2.2.32
-----------------------------Host3: idoru (END)  --------------------------=
-------

-----------------------------Host4: hydrogenium ---------------------------=
-----
# Test on XFS
[17:17] hydrogenium:~# mount
rootfs on / type rootfs (rw)
/dev/root on / type xfs (rw)
tmpfs on /etc/cinit/tmp type tmpfs (rw)
udev on /dev type tmpfs (rw)
sysfs on /sys type sysfs (rw)
proc on /proc type proc (rw,nodiratime)
/dev/mapper/home on /home type jfs (rw,integrity)
devpts on /dev/pts type devpts (rw)
[17:18] hydrogenium:~# mkdir /tmp/test
[17:19] hydrogenium:~# setfacl -m d:u:nico:rwx /tmp/test=20
[17:19] hydrogenium:~# setfacl -m u:root:rx /tmp/test=20
[17:20] hydrogenium:~# setfacl -m d:m:rwx /tmp/test =20
# Now test on JFS
[17:22] hydrogenium:~nico# cd ~nico=20
[17:22] hydrogenium:~nico# mkdir acl-test
[17:22] hydrogenium:~nico# setfacl -m d:u:nico:rwx acl-test
setfacl: acl-test: Operation not supported
[17:23] hydrogenium:~nico# uname -a
Linux hydrogenium 2.6.14 #2 PREEMPT Wed Nov 16 11:41:40 CET 2005 i686 GNU/L=
inux
[17:25] hydrogenium:~nico# cd /usr/src/linux
[17:25] hydrogenium:linux# grep ACL .config
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
# CONFIG_JFS_POSIX_ACL is not set
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
[17:35] hydrogenium:~% setfacl --version
setfacl 2.2.32
-----------------------------Host4: hydrogenium (END)----------------------=
-----

-----------------------------Host5: eiche ---------------------------------=
-----
[17:30] eiche:~# zcat /proc/config.gz| grep ACL
CONFIG_RSBAC_ACL=3Dy
# ACL Policy Options
# CONFIG_RSBAC_ACL_SUPER_FILTER is not set
CONFIG_RSBAC_ACL_AUTH_PROT=3Dy
CONFIG_RSBAC_ACL_UM_PROT=3Dy
CONFIG_RSBAC_ACL_GEN_PROT=3Dy
# CONFIG_RSBAC_ACL_BACKUP is not set
# CONFIG_RSBAC_ACL_LEARN is not set
CONFIG_RSBAC_ACL_NET_DEV_PROT=3Dy
CONFIG_RSBAC_ACL_NET_OBJ_PROT=3Dy
# CONFIG_RSBAC_SWITCH_ACL is not set
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS_POSIX_ACL=3Dy
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFSD_V3_ACL is not set
[17:30] eiche:~# mount
rootfs on / type rootfs (rw)
/dev/root on / type xfs (rw)
proc on /proc type proc (rw,nodiratime)
sysfs on /sys type sysfs (rw)
usbfs on /proc/bus/usb type usbfs (rw)
/dev/root on /dev/.static/dev type xfs (rw)
tmpfs on /dev type tmpfs (rw)
/dev/hda1 on /mnt/archiv type xfs (rw)
/dev/hdi on /mnt/backup type reiserfs (rw)
/dev/hdh on /mnt/datenklo type xfs (rw)
devpts on /dev/pts type devpts (rw)
tmpfs on /dev/shm type tmpfs (rw)
/dev/mapper/nirvana on /mnt/datennirvana type jfs (rw)
/dev/mapper/schwarzes-loch on /mnt/schwarzesloch type ext3 (rw)
# Test on XFS
[17:30] eiche:~# cd /
[17:31] eiche:/# mkdir acl-test
[17:31] eiche:/# setfacl -m d:m:rwx acl-test=20
# Successfull
# Test on reiserfs:
[17:32] eiche:archiv# cd /mnt/backup=20
[17:32] eiche:backup# mkdir acl-test
[17:32] eiche:backup# setfacl -m d:m:rwx acl-test
setfacl: acl-test: Operation not supported
# fails
# Test on jfs
[17:33] eiche:datennirvana# mkdir acl-test            =20
[17:33] eiche:datennirvana# setfacl -m d:m:rwx acl-test
# successfull
# Test on ext3 again
[17:34] eiche:schwarzesloch# mkdir acl-test            =20
[17:34] eiche:schwarzesloch# setfacl -m d:m:rwx acl-test
setfacl: acl-test: Operation not supported
# fails
[17:34] eiche:schwarzesloch# uname -a
Linux eiche 2.6.13.2-rsbac-eiche-rsbac #1 Mon Oct 3 11:48:43 CEST 2005 i686=
 GNU/Linux
[17:35] eiche:schwarzesloch# setfacl --version=20
setfacl 2.2.29
-----------------------------Host5: eiche (END) ---------------------------=
-----

What am I doing wrong?

Is there a special tool for ext3?

Nico

--=20
Latest project: cinit-0.2.1 (http://linux.schottelius.org/cinit/)
Open Source nutures open minds and free, creative developers.

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ5B5DrOTBMvCUbrlAQJPkxAAh11gkSNTMghJNdNp7g6z4/a38oGBIiSp
lBBUNqRPz33Xw574byWBO7YcxlEWgq4BtoCggBMrrWTtn3fNePC26asOACzqI1Xv
KQi1sX4DSSIIZt+B+swsF6+WxT+O2rXo55srsjVJtxUgcur8XJjkXeE5TQ84kkTd
3LONQ1djRH503JL0npECACqq8pf+xLbph7qg7/pE7jbtmF7/yt1UGpoPdG80OQSh
oyfGMIW0jK7HLn4Y9c4myT6/VhyZuWskmdflKFo7KA3mqSD0+Ib4X46/PweZDgsm
kcht1d5WIORaVcsKK2DaC3aYCqZadLd2aBE33kTshEmtDOhMSWI/rjfLlyd8vFe+
ZaytEEtwynkFWDGbg+z6CGxCZnLYcWt9Frk0XD/IIKc3MB/dvewu4ISNSRDtTyAm
NE+/prz9CIkfqsUVFZiqHhNBKhgWFvfhTAuf1jr8zt1Wp7/TPzpPYe1kdM4TKUoa
mdKZ6fEAI2Yeun3mufMvCpbDeeawsytaM/DLF5z5ItEgCghKJXT4YOBiNMtvCbdZ
gzcZ5UQUwosWWD6MVTGkgC7YCQRnawp+FI2CPLLNoitkF/IJNi6fVLY3ynLIOtp+
viaOKixfDdoTKalSLZW1OKhlZFUaD/+VcDNgklFT56YgNEl/tPTqxdAx8g4m1V8/
/yUqRQLUL28=
=OXok
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
