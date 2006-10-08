Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWJHTV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWJHTV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWJHTV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:21:57 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33754 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1751352AbWJHTV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:21:56 -0400
X-Sasl-enc: A5PtNj4e2Kf+2klOc9CY/jJu0fDXHZCZMJ/v7KvQG4vf 1160335316
Message-ID: <45295046.8000602@imap.cc>
Date: Sun, 08 Oct 2006 21:23:50 +0200
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc1: INFO: possible recursive locking detected
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE35B4D19BBF651CF999ED603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE35B4D19BBF651CF999ED603
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I still get the following, apparently ReiserFS related lockdep message
shortly after boot on:
ts@gx110:~> uname -a
Linux gx110 2.6.19-rc1-noinitrd #2 PREEMPT Sat Oct 7 01:03:48 CEST 2006 i=
686 i686 i386 GNU/Linux
with the root filesystem being ReiserFS v3.

Oct  7 21:16:42 gx110 kernel: [  217.130153]
Oct  7 21:16:42 gx110 kernel: [  217.130159] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Oct  7 21:16:42 gx110 kernel: [  217.130185] [ INFO: possible recursive l=
ocking detected ]
Oct  7 21:16:42 gx110 kernel: [  217.130195] 2.6.19-rc1-noinitrd #2
Oct  7 21:16:42 gx110 kernel: [  217.130202] ----------------------------=
-----------------
Oct  7 21:16:42 gx110 kernel: [  217.130211] kdm/3270 is trying to acquir=
e lock:
Oct  7 21:16:42 gx110 kernel: [  217.130221]  (&inode->i_mutex){--..}, at=
: [<c0340702>] mutex_lock+0x1c/0x1f
Oct  7 21:16:42 gx110 kernel: [  217.130267]
Oct  7 21:16:42 gx110 kernel: [  217.130269] but task is already holding =
lock:
Oct  7 21:16:42 gx110 kernel: [  217.130277]  (&inode->i_mutex){--..}, at=
: [<c0340702>] mutex_lock+0x1c/0x1f
Oct  7 21:16:42 gx110 kernel: [  217.130296]
Oct  7 21:16:42 gx110 kernel: [  217.130298] other info that might help u=
s debug this:
Oct  7 21:16:42 gx110 kernel: [  217.130308] 3 locks held by kdm/3270:
Oct  7 21:16:42 gx110 kernel: [  217.130315]  #0:  (&inode->i_mutex){--..=
}, at: [<c0340702>] mutex_lock+0x1c/0x1f
Oct  7 21:16:42 gx110 kernel: [  217.130335]  #1:  (&REISERFS_I(inode)->x=
attr_sem){----}, at: [<c01bc851>] reiserfs_acl_chmod+0xe1/0x180
Oct  7 21:16:42 gx110 kernel: [  217.130373]  #2:  (&REISERFS_SB(s)->xatt=
r_dir_sem){----}, at: [<c01bc886>] reiserfs_acl_chmod+0x116/0x180
Oct  7 21:16:42 gx110 kernel: [  217.130395]
Oct  7 21:16:42 gx110 kernel: [  217.130398] stack backtrace:
Oct  7 21:16:43 gx110 kernel: [  217.130691]  [<c0103ccc>] dump_trace+0x6=
4/0x1c9
Oct  7 21:16:43 gx110 kernel: [  217.130745]  [<c0103e43>] show_trace_log=
_lvl+0x12/0x25
Oct  7 21:16:43 gx110 kernel: [  217.130790]  [<c010411f>] show_trace+0xd=
/0x10
Oct  7 21:16:43 gx110 kernel: [  217.130834]  [<c0104139>] dump_stack+0x1=
7/0x19
Oct  7 21:16:43 gx110 kernel: [  217.130878]  [<c012e40c>] __lock_acquire=
+0x74f/0x9ac
Oct  7 21:16:43 gx110 kernel: [  217.131127]  [<c012e8eb>] lock_acquire+0=
x4a/0x6b
Oct  7 21:16:43 gx110 kernel: [  217.131428]  [<c034057f>] __mutex_lock_s=
lowpath+0xa7/0x20e
Oct  7 21:16:43 gx110 kernel: [  217.131662]  [<c0340702>] mutex_lock+0x1=
c/0x1f
Oct  7 21:16:43 gx110 kernel: [  217.131890]  [<c01bb8f2>] reiserfs_xattr=
_set+0xda/0x2b0
Oct  7 21:16:43 gx110 kernel: [  217.132744]  [<c01bc2f1>] reiserfs_set_a=
cl+0x184/0x1fd
Oct  7 21:16:43 gx110 kernel: [  217.133394]  [<c01bc894>] reiserfs_acl_c=
hmod+0x124/0x180
Oct  7 21:16:43 gx110 kernel: [  217.134035]  [<c019e41b>] reiserfs_setat=
tr+0x20b/0x243
Oct  7 21:16:43 gx110 kernel: [  217.134622]  [<c016f23d>] notify_change+=
0x135/0x2bc
Oct  7 21:16:43 gx110 kernel: [  217.135090]  [<c015bcb1>] sys_fchmodat+0=
x9f/0xc6
Oct  7 21:16:43 gx110 kernel: [  217.135498]  [<c015bcea>] sys_chmod+0x12=
/0x14
Oct  7 21:16:43 gx110 kernel: [  217.135888]  [<c0102d1d>] sysenter_past_=
esp+0x56/0x8d
Oct  7 21:16:43 gx110 kernel: [  217.135934] DWARF2 unwinder stuck at sys=
enter_past_esp+0x56/0x8d
Oct  7 21:16:43 gx110 kernel: [  217.135950]
Oct  7 21:16:43 gx110 kernel: [  217.135963] Leftover inexact backtrace:
Oct  7 21:16:43 gx110 kernel: [  217.135966]
Oct  7 21:16:43 gx110 kernel: [  217.135988]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

HTH

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enigE35B4D19BBF651CF999ED603
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFKVBPMdB4Whm86/kRArH5AJ0UeqFeYuTAS+kzJ/mGVMvve+nuRwCdFjcC
Y17Nf9BFv7j/S/gY3u7PCTc=
=nOgo
-----END PGP SIGNATURE-----

--------------enigE35B4D19BBF651CF999ED603--
