Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbUEXFsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbUEXFsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUEXFsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:48:36 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:64327 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264034AbUEXFsZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:48:25 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.4 is available for kernel 2.6.6
Date: Mon, 24 May 2004 15:48:17 +1000
Message-ID: <12956.1085377697@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

KDB (Linux Kernel Debugger) has been updated.

ftp://oss.sgi.com/projects/kdb/download/v4.4/

Current versions are :-

  kdb-v4.4-2.6.6-common-1.bz2
  kdb-v4.4-2.6.6-i386-1.bz2
  kdb-v4.4-2.6.6-ia64-1.bz2

There are some user and developer changes in this release, hence the
bump from kdb v4.3 to v4.4.

User visible changes:

  The sequence to enter kdb from a serial console is now <escape>KDB.
  The old <control>A sequence caused problems for people using editors
  and GNU readline over a seral link.  Edit kdb_serial_str in
  kdb/kdbmain.c if you do not like <escape>KDB.

  New summary command.

  The cpu command distinguishes between cpus that are in kdb control,
  cpus that have some kdb data but are not in kdb control ('+') and
  cpus with no kdb data ('*').  Also the format of the output has
  changed, to make it more readable on big systems.

  New process states, 'I' for idle and 'M' for sleeping system daemons.
  By default tasks in states I and M are not printed, they rarely
  contribute anything to problem diagnosis.  Use ps IM or ps A to see
  them.

  dmesg can print any part of the log, not just the end.

  The md command will suppress a run of zeroes.

  Section data is suppressed by default.  Pity, it can be useful when
  debugging modules, but the in kernel module loader in 2.6 does not
  maintain section data.

Developer visible changes:

  arch/$(ARCH)/kdb/{ansidecl,bfd}.h have been moved to include/asm-$(ARCH).
  Makefiles used to add -I $(TOPDIR) arch/$(ARCH)/kdb to CFLAGS, this
  is no longer required.  #include "bfd.h" or "ansidecl.h" replaced by
  <asm/bfd.h> and <asm/ansidecl.h>.

  Some kdb fields have moved from kdb.h to kdbprivate.h.  You need to
  use #include <linux/kdbprivate.h> in code that uses kdb internals.

  If you maintain an architecture specific kdb patch, please upgrade to
  kdb v4.4 and send it to me.


Changelog extract since kdb-v4.3-2.6.6-common-1.

2004-05-23 Keith Owens  <kaos@sgi.com>

	* Shrink the output from the cpu command.
	* Add cpu state 'I', the cpu is idle.
	* Add cpu state '+', some kdb data is available but the cpu is not
	  responding.
	* Do not print tasks in state I or M by default in ps and bta commands.
	* Add states I (idle task) and M (sleeping system daemon) to ps and
	  bta commands.
	* Delete unused variables.
	* Move private kdb fields from kdb.h to kdbprivate.h.
	* Print 'for keyboard entry' for the special cases when KDB_ENTER() is
	  used to get registers.
	* Move bfd.h and ansidecl.h from arch/$(ARCH)/kdb to include/asm-$(ARCH)
	  and remove -I arch/$(ARCH)/kdb.
	* dmesg command now prints from either the start or end of dmesg, or at
	  an arbitrary point in the middle of the kernel log buffer.
	* Sensible string dump for multi byte md commands.
	* 'page' command handles ia64 correctly.
	* Show some activity when waiting for cpus to enter kdb.
	* Change the KDB entry code to <esc>KDB.
	* Allow comment commands, starting with '#'.
	* Commands defined using defcmd from kdb_cmds are not printed as they
	  are entered, use defcmd with no parameters to print all the defined
	  commands.
	* Add summary command.
	* Update copyright notices.
	* Zero suppression on md command.
	* Make set NOSECT=1 the default.
	* PPC64 uses OF-stdout instead of console.  Ananth N Mavinakayanahalli.
	* kdb v4.4-2.6.6-common-1.

Changelog extract since kdb-v4.3-2.6.6-i386-1.

2004-05-23 Keith Owens  <kaos@sgi.com>

	* Move bfd.h and ansidecl.h from arch/$(ARCH)/kdb to include/asm-$(ARCH).
	* Update copyright notices.
	* kdb v4.4-2.6.6-i386-1.

Changelog extract since kdb v4.3-2.6.6-rc3-ia64-1.

2004-05-23 Keith Owens  <kaos@sgi.com>

	* Move bfd.h and ansidecl.h from arch/$(ARCH)/kdb to include/asm-$(ARCH).
	* ia64-opc.c needs kdbprivate.h after common reorganisation.
	* Update copyright notices.
	* kdb v4.4-2.6.6-ia64-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQFAsYyhi4UHNye0ZOoRAuopAKCzXUXdb1ZAXgNRVgh3A1Ae6NqrwACgjAKt
qlT0gcdOIS4Hx3usoGyLTGM=
=aqHg
-----END PGP SIGNATURE-----

