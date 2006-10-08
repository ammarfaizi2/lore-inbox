Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWJHGdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWJHGdd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 02:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWJHGdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 02:33:33 -0400
Received: from lug-owl.de ([195.71.106.12]:8430 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750699AbWJHGdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 02:33:32 -0400
Date: Sun, 8 Oct 2006 08:33:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sct@redhat.com, adilger@clusterfs.com, ext2-devel@lists.sourceforge.net
Subject: Re: 2.6.18-mm2: ext3 BUG?
Message-ID: <20061008063330.GA30283@lug-owl.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Jiri Slaby <jirislaby@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	sct@redhat.com, adilger@clusterfs.com,
	ext2-devel@lists.sourceforge.net
References: <45257A6C.3060804@gmail.com> <20061005145042.fd62289a.akpm@osdl.org> <4525925C.6060807@gmail.com> <20061005171428.636c087c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1G2Bc0EDIhoSmEt"
Content-Disposition: inline
In-Reply-To: <20061005171428.636c087c.akpm@osdl.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1G2Bc0EDIhoSmEt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-10-05 17:14:28 -0700, Andrew Morton <akpm@osdl.org> wrote:
> On Fri, 06 Oct 2006 01:16:21 +0159
> Jiri Slaby <jirislaby@gmail.com> wrote:
> > Andrew Morton wrote:
> > > On Thu, 05 Oct 2006 23:34:13 +0159
> > > Jiri Slaby <jirislaby@gmail.com> wrote:
> > > > while yum update-ing, yum crashed and this appeared in log:
> > > > [ 2840.688718] EXT3-fs error (device hda2): ext3_free_blocks_sb: bi=
t already=20
> > > > cleared for block 747938
> > > > [ 2840.688732] Aborting journal on device hda2.
> > > > [ 2840.688858] ext3_abort called.
> > > >
> > > > ...
> > > >
> > > > I don't know how to reproduce it and really have no idea what versi=
on of -mm=20
> > > > could introduce it (if any).
> > >=20
> > > I don't necessarily see a bug in there.  The filesystem got a bit noi=
sy but
> > > did appropriately detect and handle the metadata inconsistency.
> >=20
> > Perhaps, but why did it occur? S.m.a.r.t. doesn't tell me anything susp=
icious.
>=20
> Don't know.  The usual diagnosis for this sort of thing is "your disk shat
> itself".  Could be a bad disk, bad power supply, bad memory, some piece of
> kernel code went and trashed some memory, bug in the driver.  It's a
> mystery, sorry.

Just to add, I've seen right this, too, on Debian's 2.6.17-2-686, with
a 00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE
(rev 01) (8086:7111) PATA controller with a ST3300822A disk. That's
healthy from smartmontool's point of view. The machine has 192MB RAM, an
Intel P3 processor and is idle during daytime, busy with fetching
backups at night. I'm using this filesystem with faubackup, lots of
small files, lots of hard links and a number of large files.  Some of
the posts below mention large files, too.  My impression would be that
it happens when unlink()ing large files.  Oh, and it's a LV, not a
direct partition.

memtest86 didn't reveal anything, too (ran it for nearly 24h.)

http://www.issociate.de/board/post/157775/Linux_2.6.10_/_RAID1_problem.html
	January 5, 2005
	2.6.10, UP, no PREEMPT, 2.4.25 was a lot more stable. Problem
	disappeared by changing the mainboard.
=09
	And a test case:
	~ dd if=3D/dev/zero of=3Dtest0 bs=3D1M count=3D300
	~ while :; do cp test0 test1; cp test1 test2; cp test2 test0; od test0; do=
ne
	Problem is RAID1 related and doesn't show up on bare disks.

http://www.unixshell.com/forum/archive/index.php/t-208.html
	April 26, 2005
	Author thinks this was 2.6.11.

http://www.liangfok.com/blog/archives/2005/07/file_system_bec.html
	July 4, 2005
	No specific information given.

http://comments.gmane.org/gmane.linux.kernel/353757
	December 10, 2005
	2.6.15-rc5, happens when exiting qemu.

http://www.nabble.com/-BUG-2.6.15-rc5--EXT3-fs-error-and-soft-lockup-detect=
ed-t723639.html
	December 10, 2005
	2.6.15-rc5

http://www.ubuntuforums.org/archive/index.php/t-106260.html
	Dec 20, 2005, plus Dec 21, 2005 (another guy with the same problem)
	Disk works in one machine (P2), but not in a different box
	(P3). Breaks Ubuntu installation.

http://lkml.org/lkml/2006/4/3/212
	April 3, 2006
	No specific information given.

http://ebergen.net/wordpress/2006/04/
	April 12, 2006
	kubuntu user, drive is 4 years old and probably PATA.

http://myrddin.org/2006/02/
	February 14, 2006
	The author sees a problem like this when deleting large
	(1GB..2GB) files. ": > $file" before removing them helps. This
	results in an open(x, O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE)

http://forum.hardware.fr/hardwarefr/OSAlternatifs/Resolu-Debian-Ext3-FS-Err=
or-pour-partition-sujet-58230-1.htm
	June 19, 2006


In one case, there was a test case mentioned. I'll run that on my
affected box in a non-productive LV, like this:

dd bs=3D1M count=3D200 if=3D/dev/zero of=3Dtest0
while :; do
	echo "cp 0-1"; cp test0 test1 || break
	echo "cp 1-2"; cp test1 test2 || break
	echo "cp 2-3"; cp test2 test3 || break
	echo "cp 3-4"; cp test3 test4 || break
	echo "od 0" ; od test0 || break
	echo "rm 1"; rm test1 || break
	echo "rm 2"; rm test2 || break
	echo "rm 3"; rm test3 || break
	echo "rm 4"; rm test4 || break
done

After about 30h runtime, I got:

EXT3-fs error (device dm-5): ext3_free_blocks_sb: bit already cleared for b=
lock 194810
Aborting journal on device dm-5.
ext3_abort called.
EXT3-fs error (device dm-5): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device dm-5) in ext3_truncate: Journal has aborted
EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device dm-5) in ext3_orphan_del: Journal has aborted
EXT3-fs error (device dm-5) in ext3_reserve_inode_write: Journal has aborted
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data
__journal_remove_journal_head: freeing b_committed_data


Last echoes from the testcase above:

rm 1
rm 2
rm: cannot remove `test2': Read-only file system

kolbe34-backup:/mnt# dumpe2fs /dev/kolbe34_backup/ext3crash 2>/dev/null | g=
rep features
Filesystem features:      has_journal resize_inode dir_index filetype needs=
_recovery sparse_super large_file

kolbe34-backup:/mnt# e2fsck -fy /dev/kolbe34_backup/ext3crash=20
e2fsck 1.39 (29-May-2006)
/dev/kolbe34_backup/ext3crash: recovering journal
Pass 1: Checking inodes, blocks, and sizes
Deleted inode 49154 has zero dtime.  Fix? yes

Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Block bitmap differences:  -(100884--124927) -(178242--194174)
Fix? yes

Free blocks count wrong for group #3 (1037, counted=3D25081).
Fix? yes

Free blocks count wrong for group #5 (2432, counted=3D18366).
Fix? yes

Free blocks count wrong (15190753, counted=3D15230731).
Fix? yes

Inode bitmap differences:  -49154
Fix? yes

Free inodes count wrong for group #3 (16382, counted=3D16383).
Fix? yes

Free inodes count wrong (7864304, counted=3D7864305).
Fix? yes


/dev/kolbe34_backup/ext3crash: ***** FILE SYSTEM WAS MODIFIED *****
/dev/kolbe34_backup/ext3crash: 15/7864320 files (6.7% non-contiguous), 4979=
09/15728640 blocks
kolbe34-backup:/mnt# mount /dev/kolbe34_backup/ext3crash test/
kolbe34-backup:/mnt# ls -li test/
total 820032
    11 drwx------ 2 root root     16384 2006-10-06 10:42 lost+found
 49153 -rw-r--r-- 1 root root 209715200 2006-10-07 16:42 test0
147457 -rw-r--r-- 1 root root 209715200 2006-10-08 02:21 test2
147458 -rw-r--r-- 1 root root 209715200 2006-10-08 02:21 test3
147459 -rw-r--r-- 1 root root 209715200 2006-10-08 02:22 test4

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                     Eine Freie Meinung in einem Freien Kopf
the second  :                   f=C3=BCr einen Freien Staat voll Freier B=
=C3=BCrger.

--k1G2Bc0EDIhoSmEt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKJu6Hb1edYOZ4bsRAoBtAKCCdPrgk3ZWsh+lG8kIVk933zoJeACfV4EC
CCln1DM1MApncPpHneiaJbw=
=J+n0
-----END PGP SIGNATURE-----

--k1G2Bc0EDIhoSmEt--
