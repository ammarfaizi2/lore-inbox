Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317348AbSGTEN7>; Sat, 20 Jul 2002 00:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSGTEN7>; Sat, 20 Jul 2002 00:13:59 -0400
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:13952 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S317348AbSGTEN6>; Sat, 20 Jul 2002 00:13:58 -0400
From: glynis@butterfly.hjsoft.com
Date: Sat, 20 Jul 2002 00:17:01 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: still having smp/snat problems (Re: Linux 2.4.19-rc3)
Message-ID: <20020720041700.GA8172@butterfly.hjsoft.com>
References: <Pine.LNX.4.44.0207192119380.28216-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207192119380.28216-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2002 at 09:20:49PM -0300, Marcelo Tosatti wrote:
> <rusty@rustcorp.com.au> (02/07/17 1.630)
> 	[PATCH] The real netfilter conntrack SMP overrun fix

assuming this should have fixed this:
LIST_DELETE: ip_conntrack_core.c:165
`&ct->tuplehash[IP_CT_DIR_REPLY]'(dd8f2e90) not in &ip_conntrack_hash
[hash_conntrack(&ct->tuplehash[IP_CT_DIR_REPLY].tuple)].

it doesn't seem to have taken.   i see this error and the following
crash when i use these rules:
iptables -t nat -A POSTROUTING -j SNAT --to 64.192.31.41
iptables -t nat -A POSTROUTING -j SNAT --to 192.168.1.1
iptables -t nat -A POSTROUTING -j SNAT --to 127.0.0.1

when i use the masquerading instead of snat, it doesn't exhibit the
error and crash.

here's the info for my _stable_ config on my dual athlon 1800+:
---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
Linux butterfly 2.4.19-rc3 #1 SMP Fri Jul 19 21:30:52 EDT 2002 i686 unknown=
 unknown GNU/Linux
=20
Gnu C                  gcc (GCC) 3.1.1 20020703 (Debian prerelease) Copyrig=
ht (C) 2002 Free Software Foundation, Inc. This is free software; see the s=
ource for copying conditions. There is NO warranty; not even for MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12
Modules Loaded         snd-mixer-oss snd-pcm-oss snd-ens1371 snd-rawmidi sn=
d-seq-device snd-ac97-codec snd-pcm snd-timer snd soundcore ipt_REJECT ipta=
ble_filter ipt_MASQUERADE iptable_nat ip_conntrack ip_tables autofs4 cpia_u=
sb cpia videodev serial af_packet usb-ohci usbcore 3c59x ne2k-pci 8390
---
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9OOQ8CGPRljI8080RAmsyAJ9bAbEC2XcaMgbQXP20GnOGfMWPUACbBDLi
iQJgauFSMYXWOXfywSFgjA0=
=oMca
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
