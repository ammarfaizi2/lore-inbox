Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262811AbTC1JBY>; Fri, 28 Mar 2003 04:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTC1JBY>; Fri, 28 Mar 2003 04:01:24 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:26278 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S262811AbTC1JBW>; Fri, 28 Mar 2003 04:01:22 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Oleg Drokin <green@namesys.com>
Subject: Re: NFS/ReiserFS problems 2.5.64-mbj1
Date: Fri, 28 Mar 2003 10:12:16 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au,
       Bill Huey <billh@gnuppy.monkey.org>
References: <20030327092207.GA1248@gnuppy.monkey.org> <20030327200702.A30403@namesys.com>
In-Reply-To: <20030327200702.A30403@namesys.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_5HBh+eUjEIi2m1l";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303281012.26031.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_5HBh+eUjEIi2m1l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Mar 27, 2003 18:07, Oleg Drokin wrote:
> On Thu, Mar 27, 2003 at 01:22:07AM -0800, Bill Huey wrote:
> > NFS problems with reiserfs:
>=20
> Can you reproduce it with 2.5.66?

Well, I can. I got following Oops with 2.5.66-bk3:

 <1>Unable to handle kernel NULL pointer dereference at virtual address=20
00000000
 printing eip:
00000000
*pde =3D 00000000
Oops: 0000 [#4]
CPU:    0
EIP:    0060:[<00000000>]    Tainted: GF
EFLAGS: 00010206
EIP is at 0x0
eax: 00000000   ebx: cd6ba014   ecx: c038a008   edx: 00000006
esi: c1382400   edi: 11270000   ebp: cd6e3ea4   esp: cd6e3e6c
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 624, threadinfo=3Dcd6e2000 task=3Dcd780cc0)
Stack: c01de985 c1382400 cd6e3e98 cd6e3e8c d4a535f0 cb05e6d4 cd6ba014 cd6ba=
004
       00000004 00000002 00000002 0014bfca 00000004 00000004 cd6e3eec d4a53=
a3e
       c1382400 cd6ba014 00000006 00000006 d4a535f0 cb05e6d4 cd6ba004 cd6ba=
8e8
Call Trace:
 [<c01de985>] reiserfs_decode_fh+0xbd/0xc4
 [<d4a535f0>] gcc2_compiled.+0x0/0x100 [nfsd]
 [<d4a53a3e>] fh_verify+0x34e/0x4f8 [nfsd]
 [<d4a535f0>] gcc2_compiled.+0x0/0x100 [nfsd]
 [<d4a27f80>] ip_table+0x0/0x400 [sunrpc]
 [<d4a54c4f>] nfsd_access+0x27/0xf0 [nfsd]
 [<d4a5b716>] nfsd3_proc_access+0xb6/0xc4 [nfsd]
 [<d4a6ff70>] nfsd_procedures3+0x90/0x318 [nfsd]
 [<d4a51ae8>] nfsd_dispatch+0xd0/0x188 [nfsd]
 [<d4a0b50d>] svc_process+0x3cd/0x660 [sunrpc]
 [<d4a6ff70>] nfsd_procedures3+0x90/0x318 [nfsd]
 [<d4a701f8>] nfsd_version3+0x0/0x28 [nfsd]
 [<d4a516dd>] nfsd+0x411/0x74c [nfsd]
 [<d4a512cc>] nfsd+0x0/0x74c [nfsd]
 [<d4a512cc>] nfsd+0x0/0x74c [nfsd]
 [<d4a6f578>] nfsd_list+0x0/0x8 [nfsd]
 [<c01081e5>] kernel_thread_helper+0x5/0xc

Code:  Bad EIP value.

> sb->s_export_op->find_exported_dentry is NULL
> in reiserfs_decode_fh, well. In fact we never set this field at all.
> What is supposed to be there, anyway?
> I guess following patch should fix the problem.

=46or me it looks good, so I'll give it a try...

> In fact I guess somebody should put find_exported_dentry() declaration to
> include/linux/fs.h or something like that.
> Also absolutely the same problem must exist if you try to export fat=20
filesystem.

I didn't try that...

Regards
     Thomas
--Boundary-02=_5HBh+eUjEIi2m1l
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+hBH5YAiN+WRIZzQRAgQxAJ94kPY8dbpYWDcTYh2Op1fFjYxAxACgwUfT
PoP8PUs9hGA8QV7t89r2ZoA=
=BaY7
-----END PGP SIGNATURE-----

--Boundary-02=_5HBh+eUjEIi2m1l--

