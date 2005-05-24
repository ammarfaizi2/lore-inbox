Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVEXKWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVEXKWA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 06:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVEXKVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 06:21:00 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:61844 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S262057AbVEXKPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 06:15:15 -0400
Subject: Re: NFS corruption on 2.6.11.7
From: Kenneth Johansson <ken@kenjo.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116894917.11483.111.camel@lade.trondhjem.org>
References: <1116888428.5206.14.camel@tiger>
	 <1116894917.11483.111.camel@lade.trondhjem.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HC6I6jWxkX0leW6nI99L"
Date: Tue, 24 May 2005 12:15:11 +0200
Message-Id: <1116929711.6237.8.camel@tiger>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HC6I6jWxkX0leW6nI99L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-05-23 at 20:35 -0400, Trond Myklebust wrote:
> ty den 24.05.2005 Klokka 00:47 (+0200) skreiv Kenneth Johansson:
> > I have both the server and client running  2.6.11.7 and have some sever=
e
> > data corruption when reading from the server (maybe on write also I hav=
e
> > not tested).
> >=20
> > If I copy the data over with scp or ftp I get correct data. Also  nfs
> > works OK with a mac os x 10.4 client.
> >=20
> > Running gen.sh on the server and then cmp.sh on the client results in a
> > md5 checksum difference on 5-12 files I have never done one run where
> > there was no errors.=20
> >=20
> > This is what cat /proc/mounts reports on the nfs mount
> >=20
> > :/export/home/ken /home/ken nfs rw,v3,rsize=3D32768,wsize=3D32768,hard,=
udp,lock,addr=3Damd 0 0
> >=20
>=20
> I'm seeing no problems at all with this on a loopback mount with
> 2.6.12-rc4. Mind giving us some more details on your setup?
>=20
> Cheers,
>   Trond

I did some more investigation what type of data error I get and it looks
a bit strange. I always get 28 bytes wrong in a sequence some times this
is data repeated from previous in the file but not always.  Anybody know
what cache line size this cpu has?

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(TM) XP 2200+
stepping        : 0
cpu MHz         : 1802.998
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips        : 3547.13

Here is a sample if three files with errors in them.

file 13 "od -Ax -tx1z"


-924dc0 df b3 0c 89 2d a2 83 da 1c 08 f2 66 da f6 6b f4  >....-......f..k.<
+924dc0 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=3D.=
.<

-924dd0 af c2 44 57 9a 13 01 43 84 bf 99 c3 1b 16 8a 00  >..DW...C........<
+924dd0 3e 64 d7 bd 4f 8d 26 cf 4f 4f 2c 62 1b 16 8a 00  >>d..O.&.OO,b....<


28 bytes wrong in a sequence
The data is a repeat from previous data in the file.

>grep "43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd" 13_org=20
924d40 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=3D..=
<

>grep "43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd" 13_err=20
924d40 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=3D..=
<
924dc0 43 11 2a f4 98 09 d5 76 aa 26 83 00 24 3d 11 fd  >C.*....v.&..$=3D..=
<

924dc0 is a copy of 924d40
128 bytes offset


file 14 "od -Ax -tx1z"

-0912f0 91 45 bb cd eb 4f 01 d3 69 27 88 b5 7d 7d 17 8d  >.E...O..i'..}}..<
+0912f0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<

-091300 7d 94 8e f9 81 d0 c2 4a b5 8e c6 af b0 03 4c 16  >}......J......L.<
+091300 d9 05 ac 0d fc eb 00 71 17 bd fb 3e b0 03 4c 16  >.......q...>..L.<

>grep "b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29" 14_err
0912b0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<
0912f0 b8 3f 4e 5d 2e 86 ed c0 51 79 fe ec 3e 53 c9 29  >.?N]....Qy..>S.)<

28 bytes wrong
64 bytes offset


file 16 "od -Ax -tx1z"

-635200 c3 1d f2 b8 c4 d5 12 c1 3f 48 e6 9d dc 98 1f e5  >........?H......<
+635200 c3 1d f2 b8 c4 d5 12 c1 00 10 00 00 00 d0 ec 08  >................<

-635210 9e 54 e7 f1 49 5b 1e d0 9f e2 7c 26 24 cb 98 24  >.T..I[....|&$..$<
+635210 00 10 00 00 00 90 14 08 00 10 00 00 00 50 25 06  >.............P%.<

-635220 25 fc 63 2a bf 07 b4 c0 cf a1 67 9b ef 01 5d 6d  >%.c*......g...]m<
+635220 00 10 00 00 bf 07 b4 c0 cf a1 67 9b ef 01 5d 6d  >..........g...]m<

28 bytes wrong=20
This time the data is not from this file.





--=-HC6I6jWxkX0leW6nI99L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCkv6vmDGOmJIy9x8RAnLsAJ9txdWkwmCdJq9BbVlYfxDJ9LMp5gCffvGy
h9gzc1UAnB+yYesURixmJu4=
=8xkO
-----END PGP SIGNATURE-----

--=-HC6I6jWxkX0leW6nI99L--

