Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290584AbSARDBT>; Thu, 17 Jan 2002 22:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290587AbSARDBJ>; Thu, 17 Jan 2002 22:01:09 -0500
Received: from rj.SGI.COM ([204.94.215.100]:42437 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S290584AbSARDAz>;
	Thu, 17 Jan 2002 22:00:55 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Announce: kdb v2.1 is available for kernel 2.4.17
Date: Fri, 18 Jan 2002 14:00:44 +1100
Message-ID: <7170.1011322844@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v2.1/

  kdb-v2.1-2.4.17-common-1.bz2
  kdb-v2.1-2.4.17-i386-1.bz2

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
- -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
        -rc or whatever numbering system the kernel keepers have thought up this
        week.
- -common The common kdb code.  Everybody needs this.
- -i386   Architecture dependent code for i386.
- -ia64   Architecture dependent code for ia64, etc.
- -n      If there are multiple kdb patches against the same kernel version then
        the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb v2.1 for i386 on kernel 2.4.17, apply
  kdb-v2.1-2.4.17-common-1
  kdb-v2.1-2.4.17-i386-1
in that order.


Changelog extracts.  The bulk of this release is rewriting the data
accessing to rely on the MMU instead of trying to validate an address
by hand.  The auto repeat of commands has been changed, some commands
auto repeat, others do not.  Dead code has been removed.

common

2002-01-18 Keith Owens <kaos@sgi.com>

	* Ignore single stepping during panic.
	* Remove kdba_getword, kdba_putword.  Replace with kdb_getword,
	  kdb_putword that rely on copy_xx_user.  The new functions return
	  an error code, like copy_xx_user.
	* New functions kdb_getarea, kdb_putarea for copying areas of data
	  such as structures.  These functions also return an error code.
	* Change all common code to use the new functions.
	* bp command checks that it can read and write the word at the
	  breakpoint before accepting the address.
	* Break points are now set FIFO and cleared LIFO so overlapping
	  entries give sensible results.
	* Verify address before disassembling code.
	* Common changes for sparc64.  Ethan Solomita, Tom Duffy.
	* Remove ss <count>, never supported.
	* Remove kallsyms entries from arch vmlinux.lds files.
	* Specify which commands auto repeat.
	* kdb v2.1-2.4.17-common-1.

i386

2002-01-18 Keith Owens  <kaos@sgi.com>

	* Use new kdb_get/put functions.
	* Define kdba_{get,put}area_size functions for i386.
	* Remove over-engineered dblist callback functions.
	* Correctly handle failing call disp32 in backtrace.
	* Remove bp_instvalid flag, redundant code.
	* Remove dead code.
	* kdb v2.1-2.4.17-i386-1.

ia64-011226

2002-01-18 Keith Owens  <kaos@sgi.com>

	* Replace kdb_get/putword with kdb_get/putarea functions.
	* Wrap kdb references in #ifdef CONFIG_KDB.
	* Delete sample i386 code.
	* Refuse to update kernel text on NUMA systems.
	* Reject hardware breakpoints, not supported yet.
	* kdb v2.1-2.4.17-ia64-011226-1.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE8R4/ai4UHNye0ZOoRAjJeAJ94HepPodstKmk+Aa5hAjXGv8i+YgCbBdR6
HBXdtKRGpw2cUBNk9x9Jg+U=
=j8j6
-----END PGP SIGNATURE-----

