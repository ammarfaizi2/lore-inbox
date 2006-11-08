Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753730AbWKHACM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbWKHACM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753733AbWKHACM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:02:12 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:23006 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1753730AbWKHACK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:02:10 -0500
X-Sasl-enc: ZMpoURiZwoJb1iMop3hFcgldT1PZWv0OOud1ryYh2ojg 1162944129
Message-ID: <45511F20.6000705@imap.cc>
Date: Wed, 08 Nov 2006 01:04:48 +0100
From: Tilman Schmidt <tilman@imap.cc>
Organization: me - organized??
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Srinivasa Ds <srinivasa@in.ibm.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re:[2.6.19-rc4] "possible recursive locking detected"
 in reiserfs_xattr_set
References: <454B6A64.1000107@imap.cc> <454EFDD8.4020608@in.ibm.com> <454F8AAE.2000705@imap.cc> <4550819C.10403@in.ibm.com>
In-Reply-To: <4550819C.10403@in.ibm.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1C85D32A46DE08F1C97F5E0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1C85D32A46DE08F1C97F5E0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 07.11.2006 13:52 schrieb Srinivasa Ds:
> This looks like a different problem which got revealed after my patch=20
> got applied. Please test below patch and let me know your comments.

This reveals another one. Now I get:

Nov  8 00:47:27 gx110 kernel: [  285.838595]
Nov  8 00:47:27 gx110 kernel: [  285.838602] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Nov  8 00:47:27 gx110 kernel: [  285.838628] [ INFO: possible circular lo=
cking dependency detected ]
Nov  8 00:47:27 gx110 kernel: [  285.838639] 2.6.19-rc4-noinitrd #3
Nov  8 00:47:27 gx110 kernel: [  285.838646] ----------------------------=
---------------------------
Nov  8 00:47:27 gx110 kernel: [  285.838656] kdm/3237 is trying to acquir=
e lock:
Nov  8 00:47:27 gx110 kernel: [  285.838664]  (&inode->i_mutex/2){--..}, =
at: [<c01c29d2>] reiserfs_xattr_set+0xe9/0x2c3
Nov  8 00:47:27 gx110 kernel: [  285.838709]
Nov  8 00:47:27 gx110 kernel: [  285.838711] but task is already holding =
lock:
Nov  8 00:47:27 gx110 kernel: [  285.838719]  (&REISERFS_SB(s)->xattr_dir=
_sem){----}, at: [<c01c3992>] reiserfs_acl_chmod+0x116/0x180
Nov  8 00:47:27 gx110 kernel: [  285.838744]
Nov  8 00:47:27 gx110 kernel: [  285.838746] which lock already depends o=
n the new lock.
Nov  8 00:47:27 gx110 kernel: [  285.838749]
Nov  8 00:47:27 gx110 kernel: [  285.838758]
Nov  8 00:47:27 gx110 kernel: [  285.838760] the existing dependency chai=
n (in reverse order) is:
Nov  8 00:47:27 gx110 kernel: [  285.838769]
Nov  8 00:47:27 gx110 kernel: [  285.838771] -> #3 (&REISERFS_SB(s)->xatt=
r_dir_sem){----}:
Nov  8 00:47:27 gx110 kernel: [  285.838785]        [<c012fcb7>] add_lock=
_to_list+0x62/0x7e
Nov  8 00:47:27 gx110 kernel: [  285.838814]        [<c0130577>] __lock_a=
cquire+0x8a4/0x99c
Nov  8 00:47:27 gx110 kernel: [  285.838834]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  8 00:47:27 gx110 kernel: [  285.838853]        [<c012c8c5>] down_rea=
d+0x3a/0x4b
Nov  8 00:47:27 gx110 kernel: [  285.838891]        [<c01c3820>] reiserfs=
_cache_default_acl+0x43/0x9f
Nov  8 00:47:27 gx110 kernel: [  285.838912]        [<c01a2824>] reiserfs=
_create+0x68/0x1e3
Nov  8 00:47:27 gx110 kernel: [  285.838936]        [<c016a559>] vfs_crea=
te+0xd1/0x149
Nov  8 00:47:27 gx110 kernel: [  285.839030]        [<c016a738>] open_nam=
ei+0x167/0x57f
Nov  8 00:47:27 gx110 kernel: [  285.839056]        [<c0160ba4>] do_filp_=
open+0x26/0x3b
Nov  8 00:47:27 gx110 kernel: [  285.839086]        [<c0160cc3>] do_sys_o=
pen+0x43/0xc2
Nov  8 00:47:27 gx110 kernel: [  285.839112]        [<c0160d79>] sys_open=
+0x1a/0x1c
Nov  8 00:47:27 gx110 kernel: [  285.839138]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  8 00:47:27 gx110 kernel: [  285.839170]        [<ffffffff>] 0xffffff=
ff
Nov  8 00:47:27 gx110 kernel: [  285.839224]
Nov  8 00:47:27 gx110 kernel: [  285.839226] -> #2 (&REISERFS_I(inode)->x=
attr_sem){----}:
Nov  8 00:47:27 gx110 kernel: [  285.839253]        [<c012fcb7>] add_lock=
_to_list+0x62/0x7e
Nov  8 00:47:27 gx110 kernel: [  285.839280]        [<c0130577>] __lock_a=
cquire+0x8a4/0x99c
Nov  8 00:47:27 gx110 kernel: [  285.839307]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  8 00:47:27 gx110 kernel: [  285.839333]        [<c012c8c5>] down_rea=
d+0x3a/0x4b
Nov  8 00:47:27 gx110 kernel: [  285.839360]        [<c01c380a>] reiserfs=
_cache_default_acl+0x2d/0x9f
Nov  8 00:47:27 gx110 kernel: [  285.839388]        [<c01a2824>] reiserfs=
_create+0x68/0x1e3
Nov  8 00:47:27 gx110 kernel: [  285.839415]        [<c016a559>] vfs_crea=
te+0xd1/0x149
Nov  8 00:47:27 gx110 kernel: [  285.839441]        [<c016a738>] open_nam=
ei+0x167/0x57f
Nov  8 00:47:27 gx110 kernel: [  285.839467]        [<c0160ba4>] do_filp_=
open+0x26/0x3b
Nov  8 00:47:27 gx110 kernel: [  285.839493]        [<c0160cc3>] do_sys_o=
pen+0x43/0xc2
Nov  8 00:47:27 gx110 kernel: [  285.839519]        [<c0160d79>] sys_open=
+0x1a/0x1c
Nov  8 00:47:27 gx110 kernel: [  285.839544]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  8 00:47:27 gx110 kernel: [  285.839571]        [<ffffffff>] 0xffffff=
ff
Nov  8 00:47:27 gx110 kernel: [  285.839597]
Nov  8 00:47:27 gx110 kernel: [  285.839599] -> #1 (&inode->i_mutex){--..=
}:
Nov  8 00:47:27 gx110 kernel: [  285.839625]        [<c012fcb7>] add_lock=
_to_list+0x62/0x7e
Nov  8 00:47:27 gx110 kernel: [  285.839651]        [<c0130577>] __lock_a=
cquire+0x8a4/0x99c
Nov  8 00:47:27 gx110 kernel: [  285.839678]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  8 00:47:27 gx110 kernel: [  285.839704]        [<c035ab6d>] __mutex_=
lock_slowpath+0xc6/0x23a
Nov  8 00:47:27 gx110 kernel: [  285.839739]        [<c035acfd>] mutex_lo=
ck+0x1c/0x1f
Nov  8 00:47:27 gx110 kernel: [  285.839765]        [<c01685fc>] vfs_rena=
me+0x2d2/0x489
Nov  8 00:47:27 gx110 kernel: [  285.839805]        [<c016a01d>] sys_rena=
meat+0x174/0x1d9
Nov  8 00:47:27 gx110 kernel: [  285.839831]        [<c016a0aa>] sys_rena=
me+0x28/0x2a
Nov  8 00:47:27 gx110 kernel: [  285.839856]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  8 00:47:27 gx110 kernel: [  285.839883]        [<ffffffff>] 0xffffff=
ff
Nov  8 00:47:27 gx110 kernel: [  285.839964]
Nov  8 00:47:27 gx110 kernel: [  285.839966] -> #0 (&inode->i_mutex/2){--=
=2E.}:
Nov  8 00:47:27 gx110 kernel: [  285.839994]        [<c012fc1f>] print_ci=
rcular_bug_tail+0x30/0x66
Nov  8 00:47:27 gx110 kernel: [  285.840022]        [<c0130476>] __lock_a=
cquire+0x7a3/0x99c
Nov  8 00:47:27 gx110 kernel: [  285.840049]        [<c0130930>] lock_acq=
uire+0x5b/0x7b
Nov  8 00:47:27 gx110 kernel: [  285.840075]        [<c035add9>] mutex_lo=
ck_nested+0xd9/0x24d
Nov  8 00:47:27 gx110 kernel: [  285.840102]        [<c01c29d2>] reiserfs=
_xattr_set+0xe9/0x2c3
Nov  8 00:47:27 gx110 kernel: [  285.840129]        [<c01c33fb>] reiserfs=
_set_acl+0x18d/0x204
Nov  8 00:47:27 gx110 kernel: [  285.840157]        [<c01c39a0>] reiserfs=
_acl_chmod+0x124/0x180
Nov  8 00:47:27 gx110 kernel: [  285.840185]        [<c01a3c49>] reiserfs=
_setattr+0x20b/0x243
Nov  8 00:47:27 gx110 kernel: [  285.840214]        [<c0173963>] notify_c=
hange+0x135/0x2c2
Nov  8 00:47:27 gx110 kernel: [  285.840254]        [<c015fbbf>] sys_fchm=
odat+0xa5/0xcf
Nov  8 00:47:27 gx110 kernel: [  285.840280]        [<c015fc0a>] sys_chmo=
d+0x21/0x23
Nov  8 00:47:27 gx110 kernel: [  285.840306]        [<c0102dfd>] sysenter=
_past_esp+0x56/0x8d
Nov  8 00:47:27 gx110 kernel: [  285.840333]        [<ffffffff>] 0xffffff=
ff
Nov  8 00:47:27 gx110 kernel: [  285.840360]
Nov  8 00:47:27 gx110 kernel: [  285.840362] other info that might help u=
s debug this:
Nov  8 00:47:27 gx110 kernel: [  285.840365]
Nov  8 00:47:27 gx110 kernel: [  285.840397] 3 locks held by kdm/3237:
Nov  8 00:47:27 gx110 kernel: [  285.840410]  #0:  (&inode->i_mutex/1){--=
=2E.}, at: [<c015fb8b>] sys_fchmodat+0x71/0xcf
Nov  8 00:47:28 gx110 kernel: [  285.840438]  #1:  (&REISERFS_I(inode)->x=
attr_sem){----}, at: [<c01c395d>] reiserfs_acl_chmod+0xe1/0x180
Nov  8 00:47:28 gx110 kernel: [  285.840468]  #2:  (&REISERFS_SB(s)->xatt=
r_dir_sem){----}, at: [<c01c3992>] reiserfs_acl_chmod+0x116/0x180
Nov  8 00:47:28 gx110 kernel: [  285.840497]
Nov  8 00:47:28 gx110 kernel: [  285.840499] stack backtrace:
Nov  8 00:47:28 gx110 kernel: [  285.840526]  [<c0103dc4>] dump_trace+0x6=
4/0x1cc
Nov  8 00:47:28 gx110 kernel: [  285.840554]  [<c0103f45>] show_trace_log=
_lvl+0x19/0x2e
Nov  8 00:47:28 gx110 kernel: [  285.840578]  [<c01042a2>] show_trace+0x1=
2/0x14
Nov  8 00:47:28 gx110 kernel: [  285.840601]  [<c01042bb>] dump_stack+0x1=
7/0x19
Nov  8 00:47:28 gx110 kernel: [  285.840623]  [<c012fc4c>] print_circular=
_bug_tail+0x5d/0x66
Nov  8 00:47:28 gx110 kernel: [  285.840646]  [<c0130476>] __lock_acquire=
+0x7a3/0x99c
Nov  8 00:47:28 gx110 kernel: [  285.840668]  [<c0130930>] lock_acquire+0=
x5b/0x7b
Nov  8 00:47:28 gx110 kernel: [  285.840691]  [<c035add9>] mutex_lock_nes=
ted+0xd9/0x24d
Nov  8 00:47:28 gx110 kernel: [  285.840713]  [<c01c29d2>] reiserfs_xattr=
_set+0xe9/0x2c3
Nov  8 00:47:28 gx110 kernel: [  285.840736]  [<c01c33fb>] reiserfs_set_a=
cl+0x18d/0x204
Nov  8 00:47:28 gx110 kernel: [  285.840760]  [<c01c39a0>] reiserfs_acl_c=
hmod+0x124/0x180
Nov  8 00:47:28 gx110 kernel: [  285.840783]  [<c01a3c49>] reiserfs_setat=
tr+0x20b/0x243
Nov  8 00:47:28 gx110 kernel: [  285.840806]  [<c0173963>] notify_change+=
0x135/0x2c2
Nov  8 00:47:28 gx110 kernel: [  285.840829]  [<c015fbbf>] sys_fchmodat+0=
xa5/0xcf
Nov  8 00:47:28 gx110 kernel: [  285.840851]  [<c015fc0a>] sys_chmod+0x21=
/0x23
Nov  8 00:47:28 gx110 kernel: [  285.840872]  [<c0102dfd>] sysenter_past_=
esp+0x56/0x8d
Nov  8 00:47:28 gx110 kernel: [  285.840898] DWARF2 unwinder stuck at sys=
enter_past_esp+0x56/0x8d
Nov  8 00:47:28 gx110 kernel: [  285.840914]
Nov  8 00:47:28 gx110 kernel: [  285.840927] Leftover inexact backtrace:
Nov  8 00:47:28 gx110 kernel: [  285.840930]
Nov  8 00:47:28 gx110 kernel: [  285.840951]  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks
Tilman

--=20
Tilman Schmidt                          E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeoeffnet mindestens haltbar bis: (siehe Rueckseite)


--------------enigE1C85D32A46DE08F1C97F5E0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3rc1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFUR8rMdB4Whm86/kRAgKlAJwN7fk3iBA3DJY2yDB3C3GktO+wAACggS91
4/d0oewXi434wZb3cUOUSzw=
=psTj
-----END PGP SIGNATURE-----

--------------enigE1C85D32A46DE08F1C97F5E0--
