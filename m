Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSJ3W3s>; Wed, 30 Oct 2002 17:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbSJ3W3s>; Wed, 30 Oct 2002 17:29:48 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:3680 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S264940AbSJ3W3q>;
	Wed, 30 Oct 2002 17:29:46 -0500
Date: Wed, 30 Oct 2002 23:36:05 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_TINY
Message-ID: <20021030233605.A32411@jaquet.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This details some new patches I have done as part of my
CONFIG_TINY exploration. Executive summary: Nothing earth-
shattering covered. I have made a few new patches and=20
brought acme's initstr stuff forward (I hope. Most of=20
it anyway.)

Patches:
 o Notes: noswap, noscript, noinline, hashes kernels have=20
   been boot tested. 'all' haven't, only so much time for
   fun in a day.

 o config: Patches arch/i386/config.in to allow selection of
   the patches below. Note that the noinline stuff is not
   configurable.
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-config

 o noswap: Disabling swap by stubbing out all of swapfile.c,
   swap_stat.c, page_io.c, highmem.c and some of memory.c.=20
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-noswap

 o noscript: Removing binfmt_script from the kernel. I had
   expected my machine to have severe difficulties booting=20
   with this one but there was no problems at all... Some=20
   think required here (for me, at least).
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-noscript

 o noinline: Same patch as last time (a forward port of
   an old Andrew Morton patch). I tried to do some mindless,
   aggressive uninlining but that expanded my kernel, so I
   need to think a bit more about this (yet again).
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-noinlines

 o nohashes: Minimises the VFS hashes and makes the network
   hashes 1/16 of their former size (down to a single page).=20
   These numbers are arbitrarily chosen. Comments welcome.
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-nohashes
         =20
 o allinone: All of the above rolled up into one.
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-allinone

 o initstr: Marks strings from __init functions as __initdata.
   Only some of the kernel covered so far. Large patch.
   Patch at: www.jaquet.dk/kernel/config_tiny/2.5.44-initstr


Below is a table with a 2.5.44 kernel constrasted with
2.5.44 kernels patched with the named patch (only compile
time ones are listed). Size of vmlinux along with the four=20
first columns from 'size vmlinux' are displayed.

The .config is 'allnoconfig'.=20

              vmlinux        size fields=20
               size    text    data    bss     dec  =20
base kernel   681405  481005  50913  252512  784430
noswap        667644  469197  50945  250144  770286
noscript      681150  480541  50877  252512  783930  =20
noinlines     678345  476733  50913  252512  780158
allinone      664329  464445  50909  250144  765498


Note that the reason the all patch doesn't accumulate
the gains from the noswap and the noinlines is that
the noinlines patch touches a lot of stuff that the
noswap patch subsequently disables.

As before, your comments and suggestions will be
appreciated.

Regards,
  Rasmus

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9wF7VlZJASZ6eJs4RAoVKAJ49FDfQx/GIiYx2qJqmsf/k596UqQCdFtrg
VZuXAzOvBgrTz67Gvtn94Lw=
=tOgf
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
