Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTBJS4y>; Mon, 10 Feb 2003 13:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbTBJS4y>; Mon, 10 Feb 2003 13:56:54 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:4622 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262500AbTBJS4u>; Mon, 10 Feb 2003 13:56:50 -0500
Date: Mon, 10 Feb 2003 20:06:31 +0100
From: Bas Zoetekouw <bas@debian.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20 nfs bug
Message-ID: <20030210190631.GA3247@kalypso.caradhras.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
X-Operating-System: Linux kalypso 2.4.20
X-Loop: Bas Zoetekouw
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi guys!

Yesterday I encountered the following bug in my 2.4.20 kernel.  My
machine froze (not instaneously, but disk reads didn't work; I had to
hard resetmy machine), and the following entries were written to syslog:

Feb  9 17:40:31 localhost kernel: kernel BUG at inode.c:1034!
Feb  9 17:40:31 localhost kernel: invalid operand: 0000
Feb  9 17:40:31 localhost kernel: CPU:    0
Feb  9 17:40:31 localhost kernel: EIP:    0010:[iput+552/592]    Tainted: P=
=20
Feb  9 17:40:31 localhost kernel: EFLAGS: 00010246
Feb  9 17:40:31 localhost kernel: eax: 00000001   ebx: c5d01580   ecx: c5d0=
1724   edx: c5d01701
Feb  9 17:40:31 localhost kernel: esi: 00000000   edi: ccf19c00   ebp: ccb9=
b540   esp: cde1ff04
Feb  9 17:40:31 localhost kernel: ds: 0018   es: 0018   ss: 0018
Feb  9 17:40:31 localhost kernel: Process rpciod (pid: 183, stackpage=3Dcde=
1f000)
Feb  9 17:40:31 localhost kernel: Stack: c9da0d40 ca123e3c 00000046 c9da0cc=
0 c5d01580 c5d01724 d4ac4dfa c5d01580=20
Feb  9 17:40:31 localhost kernel:        c9da0cd0 c9da0cc0 c10db3e8 d4ac40c=
c c9da0cc0 c7d02294 cea647c0 ccb9b540=20
Feb  9 17:40:31 localhost kernel:        d4ac7c90 cf8ac618 d4a9b1a5 ccb9b66=
8 ccb9b5e4 ccb9b5c8 ccb9b594 ccb9b540=20
Feb  9 17:40:31 localhost kernel: Call Trace:    [nfs:__insmod_nfs_S.text_L=
58808+44410/58808] [nfs:__insmod_nfs_S.text_L58808+41036/58808] [nfs:__insm=
od_nfs_S.text_L58808+56336/58808] [nfs:__insmod_nfs_O/lib/modules/2.4.20/ke=
rnel/fs/nfs/nfs.o_M3E3E+-126555/128] [nfs:__insmod_nfs_O/lib/modules/2.4.20=
/kernel/fs/nfs/nfs.o_M3E3E+-112815/128]
Feb  9 17:40:31 localhost kernel:   [schedule+513/832] [nfs:__insmod_nfs_O/=
lib/modules/2.4.20/kernel/fs/nfs/nfs.o_M3E3E+-111907/128] [nfs:__insmod_nfs=
_O/lib/modules/2.4.20/kernel/fs/nfs/nfs.o_M3E3E+-109948/128] [nfs:__insmod_=
nfs_O/lib/modules/2.4.20/kernel/fs/nfs/nfs.o_M3E3E+-110112/128] [kernel_thr=
ead+46/64] [nfs:__insmod_nfs_O/lib/modules/2.4.20/kernel/fs/nfs/nfs.o_M3E3E=
+-69600/128]
Feb  9 17:40:31 localhost kernel:   [nfs:__insmod_nfs_O/lib/modules/2.4.20/=
kernel/fs/nfs/nfs.o_M3E3E+-110112/128]
Feb  9 17:40:31 localhost kernel:=20
Feb  9 17:40:31 localhost kernel: Code: 0f 0b 0a 04 43 4e 27 c0 e9 fb fd ff=
 ff c7 04 24 2c 00 00 00=20
F

This is an Athlon 1800+, 256MB memory, SiS mobo, IDE (SiS 5513), scsi
(advansys), running 2.4.20 with the 20021212-2.4.20 acpi patch from
acpi.sf.net.  The machine has nfs utils version 1.0.2 installed (Debian
unstable) and is running nfs-kernel-server.  There were nfs-mounted
disks from a client that was also running Debian unstable with nfs utils
1.0.2.  The mount options were rsize=3D8192,wsize=3D8192,nfsvers=3D3,bg,int=
r.

The NFS-related lines from my .config are:

CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy


I hope this is any help to you.

--=20
Kind regards,
+---------------------------------------------------------------+
| Bas Zoetekouw                  | Si l'on sait exactement ce   |
|--------------------------------| que l'on va faire, a quoi    |
| bas@o2w.nl, bas@debian.org     | bon le faire?                |
| GPG key: 0644fab7              |               Pablo Picasso  |
+---------------------------------------------------------------+=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+R/g2K67kHwZE+rcRApZNAJ4gC8KBWihVkE435+Xbb9c0SqRs3gCg8yQ1
fsmGA8A587w66vwLckSl07M=
=df2b
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
