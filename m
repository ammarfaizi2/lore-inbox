Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbTFLFHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbTFLFHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:07:20 -0400
Received: from rdu26-81-149.nc.rr.com ([66.26.81.149]:61078 "EHLO
	max.bungled.net") by vger.kernel.org with ESMTP id S264733AbTFLFHP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:07:15 -0400
Date: Thu, 12 Jun 2003 01:20:59 -0400
From: Nathan Conrad <conrad@bungled.net>
To: Andrew Morton <akpm@digeo.com>
Cc: green@namesys.com, davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: ext3 / reiserfs data corruption, 2.5-bk; NULL pointer dereference bug
Message-ID: <20030612052059.GA2366@bungled.net>
References: <20030610214436.GA6719@bungled.net> <20030610135935.5db1abb7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <20030610135935.5db1abb7.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just saw another one of these NULL pointer dereference oops on my
laptop:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c01665f3
*pde =3D 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[__d_lookup+99/256]    Not tainted
EFLAGS: 00210282
EIP is at __d_lookup+0x63/0x100
eax: 00000000   ebx: c06ef980   ecx: 00000010   edx: dfe80000
esi: dfe8da40   edi: 00000000   ebp: df85be70   esp: db047ec8
ds: 007b   es: 007b   ss: 0068
Process gcc (pid: 4738, threadinfo=3Ddb046000 task=3Dc22198c0)
Stack: dcfcc014 c012a225 00000000 00000000 dfe8da40 db047f48 00000000 dcfcc=
001=20
       0029e101 00000003 dcfcc001 db047f90 dfff4fc0 db047f3c c015cf80 dfd50=
e00=20
       db047f44 c015cb64 dcfcc001 dcfcc005 db047f3c db047f44 c015d129 db047=
f90=20
Call Trace:
[in_group_p+37/48] in_group_p+0x25/0x30
[do_lookup+48/176] do_lookup+0x30/0xb0
[permission+84/112] permission+0x54/0x70
[link_path_walk+297/2000] link_path_walk+0x129/0x7d0
[__user_walk+73/96] __user_walk+0x49/0x60
[sys_access+129/320] sys_access+0x81/0x140
[syscall_call+7/11] syscall_call+0x7/0xb

Code: 0f 18 00 90 8b 74 24 10 8d 5d 90 39 73 78 75 17 8b 7b 58 89=20

I ran memtest86 for about 14 hours and it passed all of its tests. I
enabled the memory debugging options (under the kernel hacking
section) and I did not notice any errors displayed by it in my syslog.

I'm not sure what else to try... The backtrace is signifigantly
different that the last one...

On Tue, Jun 10, 2003 at 01:59:35PM -0700, Andrew Morton wrote:
> Nathan Conrad <conrad@bungled.net> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 000=
00000
> >  printing eip:
> > c016781a
> > *pde =3D 00000000
> > Oops: 0000 [#1]
> > CPU:    0
> > EIP:    0060:[find_inode_fast+26/96]    Not tainted
>=20
> Something scribbled on your inode hash chains.  Please make sure that
> you're building the kernel with all the memory debug options enabled, and
> run memtest86 on that machine for 12 hourws or so.


--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6A27zobaRZFwMRIRAh08AKCTr8brL+Ykh5XzpHUaE+o95zbiQQCeJUwZ
gjsVjnQcKy9nuWHLYSYQmeo=
=3V7R
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
