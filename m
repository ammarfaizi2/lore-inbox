Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbTC2WjD>; Sat, 29 Mar 2003 17:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261296AbTC2WjC>; Sat, 29 Mar 2003 17:39:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56326 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261308AbTC2Wiz>;
	Sat, 29 Mar 2003 17:38:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: parisc-linux@lists.parisc-linux.org
Subject: Announce: modutils 2.4.25 is available
Date: Sun, 30 Mar 2003 08:50:00 +1000
Message-ID: <17381.1048978200@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.4

modutils-2.4.25.tar.gz          Source tarball, includes RPM spec file
modutils-2.4.25-1.src.rpm       As above, in SRPM format
modutils-2.4.25-1.i386.rpm      Compiled with gcc 2.96 20000731,
                                glibc 2.2.2.
modutils-2.4.25-1.ia64.rpm	Compiled with gcc 2.96-ia64-20000731,
				glibc-2.2.3.
patch-modutils-2.4.25.gz        Patch from modutils 2.4.24 to 2.4.25.

Changelog extract

        * Add hppa and hppa64 to the list of architectures that have function
          descriptors.
        * Add combined s390/s390x support.  IBM.

This version of modutils is almost identical to 2.4.23.  The changes
affect architectures that have function descriptors, i.e. ia64, ppc64,
hppa, hppa64.  It also adds support for combined s390/s390x utilities.

For historical reasons, insmod and depmod treat modules with neither
EXPORT_SYMBOL() nor EXPORT_NO_SYMBOLS() as exporting everything.  This
provides backwards compatibility with 2.0 kernels and some 2.2 modules.
No new code should be relying on this behaviour and the feature has
been removed in 2.5 kernels.  Unfortunately some developers are still
relying on this default behaviour, even for new code.

When an architecture has function descriptors and uses EXPORT_SYMBOL()
on a function, gcc generates a function descriptor and ksymtab contains
the address of that descriptor.  Without an explicit EXPORT_SYMBOL(),
gcc does not generate a function descriptor and the exported symbol
points to the start of the function body.  Any attempt to call to that
function tries to use the start of the function code as a descriptor
and breaks spectacularly.

To prevent this kernel breakage, I am making an incompatible change to
modutils.  It only affects ia64, ppc64, hppa and hppa64 users, and only
if they are relying on the deprecated feature of all symbols being
exported.

Users on these architectures must ensure that their modules still
resolve and add EXPORT_SYMBOL() where necessary before doing a
permanent upgrade to modutils 2.4.25.  The simplest way to check is to
build (but not install) modutils-2.4.25 then
  ./depmod/depmod -nae > /dev/null
Any unresolved references that did not occur with modutils 2.4.23 need
an explicit EXPORT_SYMBOL().  If this is too much bother, stay on
modutils 2.4.23 and risk the kernel breakage.

Other architectures can safely upgrade to 2.4.25 with no change, or
they can stay on 2.4.23.

If anybody fancies a janatorial task, configure modutils 2.4.25 with
CFLAGS="-O2 -Wall -DHAS_FUNCTION_DESCRIPTORS" ./configure, build it
then run ./depmod/depmod -nae > /dev/null.  You can do that on any
architecture to find kernel modules that still rely on exporting all
symbols.

No, I am not going to fudge modutils 2.4 to allow the continued default
export of data symbols but not text symbols on architectures with
function descriptors.  It is too much extra work just to allow the
continued use of a deprecated feature that has already been removed in
2.5 kernels.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+hiMWi4UHNye0ZOoRAt88AJ963sQNt9gYwJwq3ZbfY+WUjR8Q8QCgqeCb
vYMYdDo5gavjhnX/hoGGzhU=
=apeE
-----END PGP SIGNATURE-----

