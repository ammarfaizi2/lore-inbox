Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129437AbQLMTsE>; Wed, 13 Dec 2000 14:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129604AbQLMTry>; Wed, 13 Dec 2000 14:47:54 -0500
Received: from h201.s254.netsol.com ([216.168.254.201]:29324 "EHLO
	tesla.admin.cto.netsol.com") by vger.kernel.org with ESMTP
	id <S129437AbQLMTrr>; Wed, 13 Dec 2000 14:47:47 -0500
Date: Wed, 13 Dec 2000 14:17:15 -0500
From: Pete Toscano <pete@research.netsol.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: test1[12] + sparc + bind 9.1.0b1 == bad things
Message-ID: <20001213141715.K1139@tesla.admin.cto.netsol.com>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 1:41pm  up 1 day,  2:23,  6 users,  load average: 0.05, 0.11, 0.09
X-Married: 395 days, 17 hours, 56 minutes, and 12 seconds
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hello,

i'm tried using the first beta release of bind 9.1.0 on an ultra 5
running 2.4.0-test11 or test12 (modified redhat 6.2 distro -- mostly
ipv6-related mods).  as soon as i start up named, the machine goes nuts
and continuously prints the following oops (from test12):


              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
(10): Oops
TSTATE: 0000000080f09606 TPC: 0000000000448264 TNPC: 0000000000448268 Y: 01=
800000
g0: 000000000041a198 g1: ffffffffffffffff g2: 0000000000000000 g3: 30303866=
66666666
g4: fffff80000000000 g5: 000000000000000f g6: fffff800167dc000 g7: 00000000=
00000000
o0: 0000000000000001 o1: 000000000000000f o2: fffff800167dc178 o3: 00000000=
00000000
o4: 0000000000624f3b o5: 0000000000624f3f sp: fffff8001295bdd1 ret_pc: 0000=
000000443848
l0: 0000000000000006 l1: fffff800167dc000 l2: 0000000000629000 l3: 00000000=
0068dc00
l4: 0000000000629000 l5: 0000000000003fff l6: 000000000000000f l7: 00000000=
00625318
i0: 0000000000000009 i1: 0000000000000400 i2: fffff800167dc000 i3: 00000000=
00000001
i4: 0000000000624f1b i5: 0000000000624f26 i6: fffff8001295be91 i7: 00000000=
0041a198
Instruction DUMP: 10680005  90102000  c45aa008 <c470e008> c6708000 913a2000=
  c0728000  c072a008  91924000=20
Aiee, killing interrupt handler
=FF=FF<1>Unable to handle kernel paging request in mna handler<1> at virtua=
l address 303038666666666e
current->{mm,active_mm}->context =3D 00000000625318ff
current->{mm,active_mm}->pgd =3D 0000000003402a00

here's the ksymoops output:

ksymoops 2.3.5 on sparc64 2.4.0-test12-1.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12-1/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
(10): Oops
TSTATE: 0000000080f09606 TPC: 0000000000448264 TNPC: 0000000000448268 Y: 01=
800000
Using defaults from ksymoops -t elf32-sparc -a sparc
g0: 000000000041a198 g1: ffffffffffffffff g2: 0000000000000000 g3: 30303866=
66666666
g4: fffff80000000000 g5: 000000000000000f g6: fffff800167dc000 g7: 00000000=
00000000
o0: 0000000000000001 o1: 000000000000000f o2: fffff800167dc178 o3: 00000000=
00000000
o4: 0000000000624f3b o5: 0000000000624f3f sp: fffff8001295bdd1 ret_pc: 0000=
000000443848
l0: 0000000000000006 l1: fffff800167dc000 l2: 0000000000629000 l3: 00000000=
0068dc00
l4: 0000000000629000 l5: 0000000000003fff l6: 000000000000000f l7: 00000000=
00625318
i0: 0000000000000009 i1: 0000000000000400 i2: fffff800167dc000 i3: 00000000=
00000001
i4: 0000000000624f1b i5: 0000000000624f26 i6: fffff8001295be91 i7: 00000000=
0041a198
Instruction DUMP: 10680005  90102000  c45aa008 <c470e008> c6708000 913a2000=
  c0728000  c072a008  91924000=20

>>PC;  00448264 <del_timer+24/60>   <=3D=3D=3D=3D=3D
>>O7;  00443848 <do_exit+68/220>
>>I7;  0041a198 <die_if_kernel+f8/120>
Code;  00448258 <del_timer+18/60>
0000000000000000 <_PC>:
Code;  00448258 <del_timer+18/60>
   0:   10 68 00 05       unknown
Code;  0044825c <del_timer+1c/60>
   4:   90 10 20 00       clr  %o0
Code;  00448260 <del_timer+20/60>
   8:   c4 5a a0 08       unknown
Code;  00448264 <del_timer+24/60>   <=3D=3D=3D=3D=3D
   c:   c4 70 e0 08       unknown   <=3D=3D=3D=3D=3D
Code;  00448268 <del_timer+28/60>
  10:   c6 70 80 00       unknown
Code;  0044826c <del_timer+2c/60>
  14:   91 3a 20 00       sra  %o0, 0, %o0
Code;  00448270 <del_timer+30/60>
  18:   c0 72 80 00       unknown
Code;  00448274 <del_timer+34/60>
  1c:   c0 72 a0 08       unknown
Code;  00448278 <del_timer+38/60>
  20:   91 92 40 00       unknown

Aiee, killing interrupt handler
<1>Unable to handle kernel paging request in mna handler<1> at virtual addr=
ess 303038666666666e

is there any further info i can provide?  would the test11 oops help
too?

is it not bad enough that i spent the whole day frustrated, working with
this system? but then the computer had to keep making faces at me,
mocking me.  *sigh* =3D;]

pete

--=20
Pete Toscano    p:sigsegv@psinet.com     w:pete@research.netsol.com
GPG fingerprint: D8F5 A087 9A4C 56BB 8F78  B29C 1FF0 1BA7 9008 2736

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6N8s7H/Abp5AIJzYRAg6yAJ9RyHaL6BSFOzWeJIR4BnsFSmf9PgCgo+d5
6TWzg8J01cr5VTkLLzS71eU=
=9s/D
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
