Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289406AbSAOUXa>; Tue, 15 Jan 2002 15:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289636AbSAOUXX>; Tue, 15 Jan 2002 15:23:23 -0500
Received: from 203-79-66-98.adsl-wns.paradise.net.nz ([203.79.66.98]:53376
	"HELO volcano.kiwa.co.nz") by vger.kernel.org with SMTP
	id <S289406AbSAOUXH>; Tue, 15 Jan 2002 15:23:07 -0500
Date: Wed, 16 Jan 2002 09:23:03 +1300
From: Nicholas Lee <nj.lee@plumtree.co.nz>
To: linux-kernel@vger.kernel.org
Subject: Disk corruption - Abit KT7, 2.2.19+ide patches
Message-ID: <20020115202302.GA598@inktiger.kiwa.co.nz>
Mail-Followup-To: Nicholas Lee <nj.lee@plumtree.co.nz>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Following up on=20
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D99889965423508&w=3D2

Still running the same kernel:

nic@hoppa:/var/log$ uname -a
Linux hoppa 2.2.19 #1 Mon Sep 17 12:56:24 NZST 2001 i686 unknown
nic@hoppa:/var/log$ cat /proc/ide/drivers
ide-cdrom version 4.58
ide-disk version 1.09

New HDD:
nic@hoppa:/var/log$ cat /proc/ide/hda/model
FUJITSU MPG3307AH E

nic@hoppa:/var/log$ sudo hdparm -v /dev/hda

/dev/hda:
 multcount    =3D  0 (off)
 I/O support  =3D  0 (default 16-bit)
 unmaskirq    =3D  0 (off)
 using_dma    =3D  0 (off)
 keepsettings =3D  0 (off)
 nowerr       =3D  0 (off)
 readonly     =3D  0 (off)
 readahead    =3D  8 (on)
 geometry     =3D 3737/255/63, sectors =3D 60046560, start =3D 0



I've discovered what seems like some disk corruption.

nic@hoppa:/var/log$ ls -l /var/log/messages
-rw-r-----    1 root     adm        996992 Jan 16 08:56 /var/log/messages

is full of:

an 16 08:54:42 hoppa kernel: hda: read_intr: status=3D0x59 { DriveReady See=
kComplete DataRequest Error }
Jan 16 08:54:42 hoppa kernel: hda: read_intr: error=3D0x40 { UncorrectableE=
rror }, LBAsect=3D28084900, sector=3D2959177
Jan 16 08:54:42 hoppa kernel: end_request: I/O error, dev 03:07 (hda), sect=
or 2959177
Jan 16 08:54:48 hoppa kernel: hda: read_intr: status=3D0x59 { DriveReady Se=
ekComplete DataRequest Error }
Jan 16 08:54:48 hoppa kernel: hda: read_intr: error=3D0x40 { UncorrectableE=
rror }, LBAsect=3D28084900, sector=3D2959177
Jan 16 08:54:48 hoppa kernel: end_request: I/O error, dev 03:07 (hda), sect=
or 2959177
Jan 16 08:56:14 hoppa kernel: hda: read_intr: status=3D0x59 { DriveReady Se=
ekComplete DataRequest Error }
Jan 16 08:56:14 hoppa kernel: hda: read_intr: error=3D0x40 { UncorrectableE=
rror }, LBAsect=3D28084900, sector=3D2959177
Jan 16 08:56:14 hoppa kernel: end_request: I/O error, dev 03:07 (hda), sect=
or 2959177



also:



Jan 13 09:29:29 hoppa kernel: hda: write_intr: ^@^@^@^@^@^@^@^@^@^@.....

and



Dec 23 06:25:07 hoppa squid[200]: Pinger socket opened on FD 13=20
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^=
@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@=
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@Package: gdm
Status: install ok unpacked
Priority: optional
Section: x11
[...]


plus some other binary data.

This Dec 23 entries come 'AFTER' the initial Jan 13 entries at the start of=
 the log.


This rotation of message has been running since:
nic@hoppa:/var/log$ ls -l messages.0
-rw-r-----    1 root     adm        185510 Jan 13 06:25 messages.0


message.0 also seems to include corrupted data.


lsof output:

nic@hoppa:/var/log$ sudo lsof | grep "log/message"
syslogd     143  root   17w   REG        3,7  997296    172812 /var/log/mes=
sages


uptime:

nic@hoppa:/var/log$ w
  9:11am  up 40 days,  3:59,  2 users,  load average: 1.03, 1.02, 1.00
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU  WHAT
nic      pts/1    inktiger.kpac.co  8:53am  0.00s  0.11s  0.02s  w=20


Only things of note running are a distributed net client, samba and
squid cache.

Although for the last three days there has been some higher IO load with
some 100Mb+ files been copied across our WAN via "rsync -vp -aze ssh
{...}".



The Fujitsu drive which replaced the Seagate drive definitely handles
the rough conditions a lot better. Previously the seagate bus would just
lock, and require a hard power reset.


The IDE cables have been replaced, checked to make sure they are
end-to-end installed in each socket. There are NO other IDE devices on
either IDE channel.  ie.  HDD is only IDE device.


The BIOS on this Abit KT7 is recent as of November when the system had
the hard drive replaced and was last rebooted.




I have another system with much more load, and the same motherboard. Two
HDDs and CDROM and large application load.

It periodic (once a week on average) has a=20
Jan 13 22:44:35 woodcut kernel: hda: dma_intr: status=3D0x51 { DriveReady S=
eekComplete Error }
Jan 13 22:44:35 woodcut kernel: hda: dma_intr: error=3D0x84 { DriveStatusEr=
ror BadCRC }
Jan 13 22:55:40 woodcut kernel: hda: dma_intr: status=3D0x51 { DriveReady S=
eekComplete Error }
Jan 13 22:55:40 woodcut kernel: hda: dma_intr: error=3D0x84 { DriveStatusEr=
ror BadCRC }




--=20
Nicholas Lee - nj.lee at plumtree.co dot nz, somewhere on the fish Maui cau=
ght.
gpg. 8072 4F86 EDCD 4FC1 18EF  5BDD 07B0 9597 6D58 D70C            icq. 161=
2865=20

                         Quixotic Eccentricity

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8RI+mB7CVl21Y1wwRAjgzAJ4xZcDrzjMM0og3d2+UwCfRmcjQ+gCfYMq5
EuqXVykSHMHGF27bqNEP8WU=
=BY/H
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
