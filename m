Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270366AbRHHG6j>; Wed, 8 Aug 2001 02:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270368AbRHHG62>; Wed, 8 Aug 2001 02:58:28 -0400
Received: from zok.SGI.COM ([204.94.215.101]:22745 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270366AbRHHG6M>;
	Wed, 8 Aug 2001 02:58:12 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kbuild-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Announce: Kernel Build for 2.5, Release 1 is available.
Date: Wed, 08 Aug 2001 16:58:01 +1000
Message-ID: <31408.997253881@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

The kernel build project is proud to announce the first general release
of kernel build for kernel 2.5 (kbuild 2.5).
http://sourceforge.net/projects/kbuild/, Package kbuild-2.5, download
release 1.

This is a complete redesign and rewrite of the kernel build system.
Although it is primarily intended for the 2.5 kernel series, it can be
used on 2.4 kernels, in fact it was developed under 2.4.  Only a few
kbuild 2.4 files are changed by this patch and the changes are such
that you can still do a kbuild 2.4 compile, even with the kbuild 2.5
patch installed.

Features of kbuild 2.5.  For a fuller description, get the patch and
read Documentation/kbuild/kbuild-2.5.txt.

  Supports separate source and object directories.  You can compile
  multiple versions of the kernel from a single source tree, using a
  separate object directory and config for each version.  You can even
  compile different architectures simultaneously from the same source
  tree.

  Supports a common source and object directory.  The default mode is
  the same as kbuild 2.4, to use the same tree for both source and
  object.  Even in this mode, kbuild 2.5 treats almost all the source
  files as read only, no more time stamp fiddling with .h files.  The
  exceptions are files that are generated at run time and are
  incorrectly being shipped as part of the kernel tar ball.  I will be
  sending patches to remove these files from the 2.4 tar ball.
  Obviously you can only compile one kernel at a time in this mode.

  Supports multiple source directories.  As the development of the
  kernel has become more distributed, it has become harder for external
  developers to package their code so it compiles against the correct
  kernel tree and with the correct options.  With multiple source tree
  support (shadow trees), external code can be treated as if it were
  part of the base kernel tree.  This is useful for developing new
  drivers, new file systems, testing replacements for existing drivers,
  overlaying architecture specific patches on the base kernel etc.

  One global Makefile for the entire kernel.  Instead of make
  recursively decending through every directory in the source tree,
  kbuild 2.5 collects the makefile fragments from all directories,
  verifies them and merges them into a single global makefile.  When
  make is given the whole picture, it can do a much better job.  In
  particular a change to a file or config option now only recompiles
  and relinks the affected objects, no more spurious compiles.

  CML2 support.  The patch on sourceforge uses the Configuration Mini
  Language 1 (CML1) code from kbuild 2.4.  You can select either CML1
  or CML2 support, but you have to get the current CML2 entries from
  Eric Raymond's CML2 page, http://www.tuxedo.org/~esr/kbuild/.  We
  expect 2.5 kernels to support only CML2, so test CML2 now, while both
  versions are available.

  A far more robust mini language for the makefile fragments.  Instead
  of setting magic make variables and hoping that Rules.make does what
  you expect, the Makefile.in files say what you want to do, it is up
  to kbuild 2.5 to determine how to achieve your requirements.

  Quiet mode.  By default kbuild 2.5 outputs one line for each compile,
  link or user defined command.  The only other output is warnings and
  errors which are now far easier to see.  Of course, you can still see
  the full commands if you really care.

  Standard support for shipping generated files.  kbuild 2.4 has had
  continual problems with files that are both generated and shipped.
  This is typically done where the generation process requires
  utilities that not every user has installed.  In kbuild 2.5 this
  problem has a standard solution which should prevent recurrence of
  the kbuild 2.4 problems.

  Correct parallel running.  You can do make -j on all commands and
  kbuild 2.5 will ensure that commands are run in the correct order.

  Multiple targets can be specified on the same make command.  You
  cannot mix clean or mrproper with other targets but everything else
  can be put on one command.
    make -j oldconfig installable && sudo make -j install
  works beautifully.

  Install targets such as bzImage, zImage, where to install System.map
  and .config, the install path prefix, which commands to run after
  install etc. are all CONFIG_ options.  Copy .config from one kernel
  to another, run make install and it all happens, hands free.

  Users who require additional processing can dynamically specify
  additional targets, at any point in the build cycle.  This is useful
  for running distribution specific code without hacking the makefiles.

  You can compile individual targets at any level in the tree, which is
  useful when you are hacking on code.  Or you can compile everything
  in a directory, with or without recursion into sub directories.
  Unlike kbuild 2.4 make SUBDIRS=, the kbuild 2.5 method will not
  create inconsistent kernels.

  The kernel version number is only incremented when vmlinux is
  rebuilt, not on every make.

  You can rename the source and object directories without having to
  recompile anything.

  It is documented!  Read Documentation/kbuild/kbuild-2.5.txt.


TODO:

  Add other architectures.  Release 1 only supports ix86.  IA64 will be
  next because I have access to a box.  After that it will depend on
  help from the arch support groups.

  Patch for -ac kernel (maybe).  It only needs to track changes to
  makefiles in -ac, the core kbuild 2.5 code is the same for -ac
  kernels.

  Help to convert external sources to kbuild 2.5 format.  XFS is
  already converted, it will compile with either kbuild 2.4 or 2.5.
  http://marc.theaimsgroup.com/?l=linux-xfs&m=99701265316648&w=2

  Performance improvements.  Some of the code has behaviour O(n**2) in
  the number of objects being built.  For a small compile, kbuild 2.5
  is about 10% faster compared to 2.4 make dep + make bzImage.  For a
  full kernel compile, kbuild 2.5 is about twice as slow as kbuild 2.4.
  I know where the problems are and am working on them.  MEC mantra

     Correctness comes first. 
     Then maintainability. 
     Then speed. 

  Add module symbol version support.  The old genksyms was a nice idea
  but the implementation has fundamental design problems and has been
  removed.  I will be adding clean module symbol version support later,
  after kernel 2.5 has started.  The correct implementation needs a new
  version of modutils.

  Remove incorrectly shipped files from the kernel tar ball.

  Convert relative includes (#include "../..") to remove assumptions
  about the structure of the kernel tree, this breaks when code is
  moved around.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.3 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE7cOL4i4UHNye0ZOoRAij5AJ90j8PTsXz0+PsRz0jXMKp5fHnpOQCfaETG
kk3ylHmGewU+QsBDrBwkCq0=
=wcrs
-----END PGP SIGNATURE-----

