Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261347AbSJUMhf>; Mon, 21 Oct 2002 08:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbSJUMhf>; Mon, 21 Oct 2002 08:37:35 -0400
Received: from mta01bw.bigpond.com ([139.134.6.78]:58321 "EHLO
	mta01bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S261347AbSJUMhZ>; Mon, 21 Oct 2002 08:37:25 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: "Matt D. Robinson" <yakker@aparity.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.44: lkcd (0/9): general description and diffstat
Date: Mon, 21 Oct 2002 22:34:49 +1000
User-Agent: KMail/1.4.5
References: <200210211015.g9LAFlv21151@nakedeye.aparity.com>
In-Reply-To: <200210211015.g9LAFlv21151@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210212234.49219.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 21 Oct 2002 20:15, Matt D. Robinson wrote:
> These are the latest LKCD patches for 2.5.44.  We have put in a
> number of changes, additions and deletions requested by the
> following people on the lkml list between our 2.5.38 and 2.5.44
> patches:
Comments follow.

I have no real interest in LKCD functionality. I'm really only concerned that you aren't making my life ugly.

And you are, in a couple of small but annoying ways:
1. No Config.help entry. So I still have no idea what LKCD does, and whether I need to enable it in my kernel.

2. Needless compile time errors.
make -f drivers/dump/Makefile
  gcc -Wp,-MD,drivers/dump/.dump_base.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -marc
h=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_base -DEXPORT
_SYMTAB  -c -o drivers/dump/dump_base.o drivers/dump/dump_base.c
In file included from drivers/dump/dump_base.c:204:
include/linux/version.h:3: warning: `KERNEL_VERSION' redefined
include/linux/dump.h:434: warning: this is the location of the previous definition
  gcc -Wp,-MD,drivers/dump/.dump_i386.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -marc
h=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_i386   -c -o
drivers/dump/dump_i386.o drivers/dump/dump_i386.c
  ld -m elf_i386  -r -o drivers/dump/dump.o drivers/dump/dump_base.o drivers/dump/dump_i386.o
  gcc -Wp,-MD,drivers/dump/.dump_blockdev.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-tr
igraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -
march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_blockdev
  -c -o drivers/dump/dump_blockdev.o drivers/dump/dump_blockdev.c
drivers/dump/dump_blockdev.c:14: warning: `DUMP_MODULE_NAME' redefined
include/linux/dump.h:403: warning: this is the location of the previous definition
  gcc -Wp,-MD,drivers/dump/.dump_rle.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigrap
hs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march
=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_rle   -c -o dr
ivers/dump/dump_rle.o drivers/dump/dump_rle.c
  gcc -Wp,-MD,drivers/dump/.dump_gzip.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigra
phs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -marc
h=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=dump_gzip   -c -o
drivers/dump/dump_gzip.o drivers/dump/dump_gzip.c
drivers/dump/dump_gzip.c:27: warning: `DUMP_MODULE_NAME' redefined
include/linux/dump.h:403: warning: this is the location of the previous definition
drivers/dump/dump_gzip.c:29: warning: `DUMP_PRINTN' redefined
include/linux/dump.h:413: warning: this is the location of the previous definition
drivers/dump/dump_gzip.c:31: warning: `DUMP_PRINT' redefined
include/linux/dump.h:431: warning: this is the location of the previous definition

And MOST IMPORTANTLY:
3. Kernel gets bigger, even with the config option turned off:
Baseline:
- -rwxr-xr-x    1 bradh    users     4542815 Oct 21 21:58 vmlinux
- -rw-r--r--    1 bradh    users     1571320 Oct 21 21:58 bzImage

With LKCD patches installed, and the same .config (except for LKCD stuff), it looks like:
- -rwxr-xr-x    1 bradh    users     4548357 Oct 21 22:19 vmlinux-configM
- -rwxr-xr-x    1 bradh    users     4548357 Oct 21 22:03 vmlinux-configN
- -rwxr-xr-x    1 bradh    users     4588663 Oct 21 22:21 vmlinux-configY
- -rw-r--r--    1 bradh    users     1571988 Oct 21 22:17 bzImage-configM
- -rw-r--r--    1 bradh    users     1571993 Oct 21 22:03 bzImage-configN
- -rw-r--r--    1 bradh    users     1590318 Oct 21 22:21 bzImage-configY

Where the -configX shows the effect of compiling with any options presented set to X (where X is N, M or Y).

I don't know enough VM or scheduler to critique the impact on performance with it turned on. However the very least you can do is to have no impact when your code is turned off.

Brad

- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9s/RpW6pHgIdAuOMRAgodAJ9J/Lm2ShxMO/K7EkFRghkT9MF3gQCdGBpf
6d7H2aXsPgHsqnVOZwwJDGg=
=Ad25
-----END PGP SIGNATURE-----

