Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266826AbUBGLXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266830AbUBGLXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:23:44 -0500
Received: from puffbird.pelicanmanufacturing.com.au ([203.59.220.18]:15744
	"EHLO pelicanmanufacturing.com.au") by vger.kernel.org with ESMTP
	id S266826AbUBGLXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:23:39 -0500
Date: Sat, 7 Feb 2004 19:23:02 +0800
From: James Bromberger <james@rcpt.to>
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 && md raid1 && reiserfs panic
Message-ID: <20040207112302.GA2401@phobe.internal.pelicanmanufacturing.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kORqDWCi7qDJ0mEj"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--kORqDWCi7qDJ0mEj
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Hello all,

Can someone point me towards the right mailing list to help get this=20
issue resolved; I think I've hit something in either the MD, block or=20
reiserfs sections, but I could be completely wrong.

The symptoms: rm a file from a working RAID1 md reiserfs filesystem,=20
and I get a panic, rm(1) segfaults, and all further I/O to any interactive=
=20
shells stop. The entire system is rednered incapable; reboot (via=20
ctrl-alt-del) doesnt shutdown and the only action is to hard reset the box.

Attached is a copy of the oops as recorded by syslog, the script I run to=
=20
start the error. The exact line that Segfaults is the rm() on a 2.2 GB=20
tar file.

For reference, the system is documented at=20
	http://www.james.rcpt.to/programs/debian/raid1/

This is only using the Debian packages of the kernel.=20
kernel-image-2.4.23-686_2.4.23-1.

If there is any further info I can send, please let me know.

Please CC me as I am not subscribed to LKML. Ta.

Regards,
  James
--=20
 James Bromberger <james_AT_rcpt.to> www.james.rcpt.to
 Remainder moved to http://www.james.rcpt.to/james/sig.html

I am in London on UK mobile +44 7952 042920.

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="error-2.4.23-1-686-md-reiserfs.txt"
Content-Transfer-Encoding: quoted-printable

The kernel: 2.4.23-1-686-

The script:

DAY=3D`date +%d`
MONTH=3D`date +%m`
YEAR=3D`date +%Y`
FROM=3D"/usr/local/fileshare /usr/local/psql"
TO=3D"/usr/local/share/${YEAR}-${MONTH}-${DAY}-fileshare-backup.tbz"
TAR=3D"/bin/tar"
CMD=3D"$TAR -Pcjlf $TO $FROM"
/bin/echo -n "Removing old backup..."
/bin/rm /usr/local/share/????-??-??-fileshare-backup.tbz

The script running:

++ date +%d
+ DAY=3D07
++ date +%m
+ MONTH=3D02
++ date +%Y
+ YEAR=3D2004
+ FROM=3D/usr/local/fileshare /usr/local/psql
+ TO=3D/usr/local/share/2004-02-07-fileshare-backup.tbz
+ TAR=3D/bin/tar
+ CMD=3D/bin/tar -Pcjlf /usr/local/share/2004-02-07-fileshare-backup.tbz /u=
sr/local/fileshare /usr/local/psql
+ /bin/echo -n 'Removing old backup...'
Removing old backup...+ /bin/rm /usr/local/share/2004-01-30-fileshare-backu=
p.tbz./makecompressedbackup.sh: line 23:  9729 Segmentation fault      /bin=
/rm /usr/local/share/????-??-??-fileshare-backup.tbz
++ date
+ NOW=3DSat Feb  7 17:21:19 WST 2004
+ echo 'Sat Feb  7 17:21:19 WST 2004 Doing /bin/tar -Pcjlf /usr/local/share=
/2004-02-07-fileshare-backup.tbz /usr/local/fileshare /usr/local/psql...'
Sat Feb  7 17:21:19 WST 2004 Doing /bin/tar -Pcjlf /usr/local/share/2004-02=
-07-fileshare-backup.tbz /usr/local/fileshare /usr/local/psql...
+ /bin/tar -Pcjf /usr/local/share/2004-02-07-fileshare-backup.tbz /usr/loca=
l/fileshare /usr/local/psql



=46rom /var/log/syslog:


Feb  7 17:21:19 phobe kernel: md(9,5):vs-4075: reiserfs_free_block: block 1=
076949926 is out of range on md(9,5)
Feb  7 17:21:19 phobe kernel: md(9,5):vs-4075: reiserfs_free_block: block 2=
212879009 is out of range on md(9,5)
Feb  7 17:21:19 phobe kernel: Unable to handle kernel NULL pointer derefere=
nce at virtual address 0000028c
Feb  7 17:21:19 phobe kernel:  printing eip:
Feb  7 17:21:19 phobe kernel: e085124d
Feb  7 17:21:19 phobe kernel: *pde =3D 00000000
Feb  7 17:21:19 phobe kernel: Oops: 0002
Feb  7 17:21:19 phobe kernel: CPU:    0
Feb  7 17:21:19 phobe kernel: EIP:    0010:[ide-floppy:__insmod_ide-floppy_=
O/lib/modules/2.4.23-1-686/kernel/drive+-1772979/96]    Not tainted
Feb  7 17:21:19 phobe kernel: EFLAGS: 00010282
Feb  7 17:21:19 phobe kernel: eax: 00000000   ebx: 0001d0a2   ecx: df47dc00=
   edx: e0ca624c
Feb  7 17:21:19 phobe kernel: esi: 0000146b   edi: e0c170d4   ebp: 000003f4=
   esp: d56b1b88
Feb  7 17:21:19 phobe kernel: ds: 0018   es: 0018   ss: 0018
Feb  7 17:21:19 phobe kernel: Process rm (pid: 9729, stackpage=3Dd56b1000)
Feb  7 17:21:19 phobe kernel: Stack: d56b1f1c d56b1f1c e851146b 00000000 e0=
855af0 df47dc00 e851146b e0c170d4
Feb  7 17:21:19 phobe kernel:        00005aa1 e08327ca d56b1f1c e851146b c7=
63be68 000003f4 e08328c6 d56b1f1c
Feb  7 17:21:19 phobe kernel:        df47dc00 e851146b e851146b 00000065 e0=
84d735 d56b1f1c e851146b cbf92b00
Feb  7 17:21:19 phobe kernel: Call Trace:    [ide-floppy:__insmod_ide-flopp=
y_O/lib/modules/2.4.23-1-686/kernel/drive+-1754384/96] [ide-floppy:__insmod=
_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1898550/96] [ide-flopp=
y:__insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1898298/96] =
[ide-floppy:__insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-17=
88107/96] [__make_request+892/1936]
Feb  7 17:21:19 phobe kernel:   [ide-floppy:__insmod_ide-floppy_O/lib/modul=
es/2.4.23-1-686/kernel/drive+-1541824/96] [ide-floppy:__insmod_ide-floppy_O=
/lib/modules/2.4.23-1-686/kernel/drive+-1541784/96] [ide-floppy:__insmod_id=
e-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1786838/96] [ide-floppy:_=
_insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1784312/96] [id=
e-floppy:__insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-17825=
30/96] [ide-floppy:__insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/dr=
ive+-1785591/96]
Feb  7 17:21:19 phobe kernel:   [ide-floppy:__insmod_ide-floppy_O/lib/modul=
es/2.4.23-1-686/kernel/drive+-1868477/96] [ide-floppy:__insmod_ide-floppy_O=
/lib/modules/2.4.23-1-686/kernel/drive+-1717594/96] [ide-floppy:__insmod_id=
e-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1868624/96] [ide-floppy:_=
_insmod_ide-floppy_O/lib/modules/2.4.23-1-686/kernel/drive+-1716640/96] [ip=
ut+304/640] [cached_lookup+27/112]
Feb  7 17:21:19 phobe kernel:   [vfs_unlink+242/448] [sys_unlink+186/288] [=
system_call+51/56]
Feb  7 17:21:19 phobe kernel:
Feb  7 17:21:19 phobe kernel: Code: 0f ab 30 8b 5c 24 04 31 c0 8b 74 24 08 =
8b 7c 24 0c 83 c4 10
=2E..
Feb  7 17:26:23 phobe sm-mta[1274]: rejecting connections on daemon MTA: lo=
ad average: 12
Feb  7 17:26:23 phobe sm-mta[1274]: rejecting connections on daemon MSA: lo=
ad average: 12

--PNTmBPCT7hxwcZjr--

--kORqDWCi7qDJ0mEj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJMqWpfJwKAkXqeQRAv/WAJ4tXsj98vk85QsXqy+6MY2FgRLU7gCfZ3dp
hYwkpUR5GRIWoEzG8+b3LTg=
=A+j8
-----END PGP SIGNATURE-----

--kORqDWCi7qDJ0mEj--
