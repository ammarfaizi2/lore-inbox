Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTEBHCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 03:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbTEBHCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 03:02:48 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52430 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261906AbTEBHCp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 03:02:45 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
Subject: Announce: kdb v4.2 is available for kernel 2.4.20, i386 and ia64
Date: Fri, 02 May 2003 17:14:56 +1000
Message-ID: <11249.1051859696@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://oss.sgi.com/projects/kdb/download/v4.2/

  kdb-v4.2-2.4.20-common-1.bz2
  kdb-v4.2-2.4.20-i386-1.bz2
  kdb-v4.2-2.4.20-ia64-021210-1.bz2

Changelog extracts since v4.1.

2003-05-02 Keith Owens  <kaos@sgi.com>

	* Some architectures have problems with the initial empty kallsyms
	  section so revert to three kallsyms passes.
	* Flush buffered input at startup and at 'more' prompt.
	* Only print 'more' prompt when longjmp data is available.
	* Print more data for buffers and inodes.
	* Disable kill command when O(1) scheduler is installed, the code
	  needs to be redone for O(1).
	* The kernel has an undocumented assumption that enable_bh() is
	  always called with interrupts enabled, make it so.
	* Print trailing punctuation even for symbols that are not in kernel.
	* Add read/write access to user pages.  Vamsi Krishna S., IBM
	* Rename cpu_is_online to cpu_online, as in 2.5.
	* O(1) scheduler removes init_task so kdb maintains its own list of
	  active tasks.
	* Delete btp 0 <cpuid> option, it needed init_tasks.
	* Clean up USB keyboard support.  Steven Dake.
	* Sync with XFS 2.4.20 tree.
	* kdb v4.2-2.4.20-common-1.

2.4.20-i386-1

2003-05-02 Keith Owens  <kaos@sgi.com>

	* Add kdba_fp_value().
	* Limit backtrace size to catch loops.
	* Add read/write access to user pages.  Vamsi Krishna S., IBM
	* Clean up USB keyboard support.  Steven Dake.
	* kdb v4.2-2.4.20-i386-1.

2.4.20-ia64-020821-1

2003-05-02 Keith Owens  <kaos@sgi.com>

	* Add kdba_fp_value().
	* Limit backtrace size to catch loops.
	* Print spinlock name in ia64_spinlock_contention.
	* Tweak INIT slave stack lock and handler.
	* Add read/write access to user pages.  Vamsi Krishna S., IBM
	* Rename cpu_is_online to cpu_online, as in 2.5.
	* Clean up USB keyboard support.
	* Clean up serial console support.
	* kdb v4.2-2.4.20-ia64-020821-1.


v4.2/README

Starting with kdb v2.0 there is a common patch against each kernel which
contains all the architecture independent code plus separate architecture
dependent patches.  Apply the common patch for your kernel plus at least
one architecture dependent patch, the architecture patches activate kdb.

The naming convention for kdb patches is :-

 vx.y    The version of kdb.  x.y is updated as new features are added to kdb.
 -v.p.s  The kernel version that the patch applies to.  's' may include -pre,
	 -rc or whatever numbering system the kernel keepers have thought up this
	 week.
 -common The common kdb code.  Everybody needs this.
 -i386   Architecture dependent code for i386.
 -ia64   Architecture dependent code for ia64, etc.
 -n      If there are multiple kdb patches against the same kernel version then
	 the last number is incremented.

To build kdb for your kernel, apply the common kdb patch which is less
than or equal to the kernel v.p.s, taking the highest value of '-n'
if there is more than one.  Apply the relevant arch dependent patch
with the same value of 'vx.y-v.p.s-', taking the highest value of '-n'
if there is more than one.

For example, to use kdb for i386 on kernel 2.4.20, apply
  kdb-v4.2-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.2-2.4.20-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-021210 on kernel 2.4.20, apply
  kdb-v4.2-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.2-2.4.20-ia64-021210-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

I do not have any time to work on 2.5, so there are no patches available
for 2.5 kernels.  If somebody wants to port the latest kdb patches to
2.5 kernels and send patches to kaos@sgi.com then I will put them up in
this directory.

The kdb-smphdr* patches in the v4.0 directory are Sonic Zhang's changes
to improve hardware breakpoint handling on i386 and ia64.  They are
not official kdb patches yet, they are available for review.  They will
probably fit v4.2.

The next step is to integrate Sonic Zhang's breakpoint changes into kdb
and to change the kdb entry logic to cope with multiple cpus doing
concurrent entry into kdb.  At the moment kdb tries to serialize so it
only processes one event at a time.  The bad news is that this does not
work well with IA64 SAL interrupts so kdb has to change.  The good news
is that the change will remove the deadlock when two cpus hit a
breakpoint at the same time.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+shrti4UHNye0ZOoRAo/BAKCHWwL0LSjoEawaYCWT/sMVMR0FkQCgtulL
3V3BdZ5k5IuW0RL9mkSMp10=
=b/1W
-----END PGP SIGNATURE-----

