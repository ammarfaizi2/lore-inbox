Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbTKNRmt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 12:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264564AbTKNRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 12:42:48 -0500
Received: from noose.gt.owl.de ([62.52.19.4]:262 "EHLO noose.gt.owl.de")
	by vger.kernel.org with ESMTP id S264563AbTKNRmo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 12:42:44 -0500
Date: Fri, 14 Nov 2003 18:42:54 +0100
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test9 / EXT3-fs warning...ext3_unlink: Deleting nonexistent file
Message-ID: <20031114174254.GA5594@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Organization: rfc822 - pure communication
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i seem to have experienced some ext3 inconsistencys - After some reboots
today i was wondering why cron wasnt running and discovered that
starting cron failed because /var/run/crond.pid could not be written.
ls did not show and file under that name. touch showed i/o error on that
file although other file in that directory could be touched.

When i tried to rm crond.pid this showed up:

EXT3-fs warning (device hda8): ext3_unlink: Deleting nonexistent file (1076=
69), 0

After that i could touch the file again and crond did not refuse to start a=
nymore.
I havent experienced ANY ide failures on this disk so far

Some more debugging output:

Nov 14 14:17:12 touch /usr/sbin/cron[621]: (CRON) DEATH (can't open or crea=
te /var/run/crond.pid: Input/output error)

touch:/var/run# ls -la
total 96
drwxr-xr-x   13 root     root         4096 Nov 14 18:34 .
drwxr-xr-x   18 root     root         4096 May 22 13:45 ..
srw-rw-rw-    1 root     root            0 Nov 14 17:22 .acpid.socket
-rw-r--r--    1 root     root            4 Nov 14 17:22 atd.pid
drwxr-xr-x    2 root     root         4096 Mar 25  2002 autofs
-rw-r--r--    1 root     root            5 Nov 14 18:34 crond.pid
----------    1 root     root            0 Nov 14 18:34 crond.reboot
-rw-r--r--    1 root     root            4 Nov 14 17:22 dhclient.eth0.pid
drwxr-xr-x    2 freerad  freerad      4096 Sep 12 19:28 freeradius
-rw-r-----    1 root     root            4 Nov 14 17:22 ippl.pid
drwxr-xr-x    2 root     root         4096 Nov  6 14:24 iptraf
-rw-r--r--    1 root     root            4 Nov 14 17:23 kdm.pid
-rw-r--r--    1 root     root            4 Nov 14 17:22 klogd.pid
drwxr-xr-x    2 postgres postgres     4096 May  8  2003 postgresql
drwxr-xr-x    2 root     root         4096 Nov 14 17:24 samba
drwxrwxr-x    4 root     utmp         4096 Aug 24  2002 screen
-rw-------    1 root     root            4 Nov 14 17:22 smartd.pid
drwxr-xr-x    2 root     root         4096 Jun 24  2002 sshd
-rw-r--r--    1 root     root            4 Nov 14 17:22 sshd.pid
drwx------    3 root     root         4096 Oct  9 14:58 sudo
-rw-r--r--    1 root     root            4 Nov 14 17:22 syslogd.pid
drwx------    2 root     root         4096 Mar 26  2002 usb
-rw-rw-r--    1 root     utmp         4608 Nov 14 17:30 utmp
drwxr-xr-x    2 root     root         4096 Nov 14 17:23 xdmctl
drwxr-xr-x    3 root     root         4096 Sep  3 19:47 zope

touch:/var/run# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda6               489992    100238    364454  22% /
/dev/hda7              3375896   2669948    534456  84% /usr
/dev/hda8              1446780    635796    737492  47% /var
/dev/hda9               972404     18384    904624   2% /tmp
/dev/hda10            32724116  19934576  11127216  65% /home
//dump.mediaways.net/dump
                     142065664 139608064   2457600  99% /mnt/dump
touch:/var/run# mount
/dev/hda6 on / type ext3 (rw,errors=3Dremount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=3D5,mode=3D620)
/dev/hda7 on /usr type ext3 (rw)
/dev/hda8 on /var type ext3 (rw)
/dev/hda9 on /tmp type ext3 (rw)
/dev/hda10 on /home type ext3 (rw)
usbfs on /proc/bus/usb type usbfs (rw)
//dump.mediaways.net/dump on /mnt/dump type smbfs (rw)
touch:/var/run# df -i
Filesystem            Inodes   IUsed   IFree IUse% Mounted on
/dev/hda6             126976   10234  116742    9% /
/dev/hda7             429408  125260  304148   30% /usr
/dev/hda8             183936    9772  174164    6% /var
/dev/hda9             123648      53  123595    1% /tmp
/dev/hda10           4161536  111674 4049862    3% /home
//dump.mediaways.net/dump
                           0       0       0    -  /mnt/dump
touch:/var/run# tune2fs -l /dev/hda8
tune2fs 1.34-WIP (21-May-2003)
Filesystem volume name:   <none>
Last mounted on:          <not available>
Filesystem UUID:          4b930ab7-ed5f-4916-90e7-fca4f61e704b
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal filetype needs_recovery sparse_super =
large_file
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              183936
Block count:              367479
Reserved block count:     18373
Free blocks:              202934
Free inodes:              174205
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         15328
Inode blocks per group:   479
Filesystem created:       Thu May 22 13:02:48 2003
Last mount time:          Fri Nov 14 17:22:24 2003
Last write time:          Fri Nov 14 17:22:24 2003
Mount count:              49
Maximum mount count:      -1
Last checked:             Thu May 22 13:02:48 2003
Check interval:           0 (<none>)
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
First orphan inode:       107669
Default directory hash:   tea
Directory Hash Seed:      095c50da-7842-4c7e-9cb5-859a17832ee6

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/tRQeUaz2rXW+gJcRAlOFAJsEKiwSqhClNu//thlSC7gBzU5J5ACcCqBv
7aRFF0OTKGsSEJKwIP3Ciek=
=feHo
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
