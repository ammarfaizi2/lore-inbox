Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTFTGzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 02:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTFTGzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 02:55:31 -0400
Received: from rj.SGI.COM ([192.82.208.96]:48594 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S262127AbTFTGzY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 02:55:24 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: kdb@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Announce: kdb v4.3 is available for kernels 2.4.20, 2.4.21
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 20 Jun 2003 17:07:47 +1000
Message-ID: <29513.1056092867@kao1.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/kdb/download/v4.3/

  kdb-v4.3-2.4.20-common-1.bz2
  kdb-v4.3-2.4.20-i386-1.bz2
  kdb-v4.3-2.4.20-ia64-021210-1.bz2
  kdb-v4.3-2.4.20-sparc64-1.bz2
  kdb-v4.3-2.4.20-xscale-1.bz2

  kdb v4.3 patches against 2.4.21 are functionally identical to 2.4.20.
  kdb-v4.3-2.4.21-common-1.bz2
  kdb-v4.3-2.4.21-i386-1.bz2
  Other 2.4.21 arch patches will appear later.  ia64 is waiting for an
  official 2.4.21 ia64 kernel patch.

Changelog extracts since v4.2.

2.4.20-common-1

2003-06-20 Keith Owens  <kaos@sgi.com>

       * More details on vm command, add vmp and pte commands.
         Dean Nelson, Dean Roe, SGI.
       * YAO1SCF (Yet Another O(1) Scheduler Coexistence Fix).
       * Changes to common code to build on sparc.  Tom Duffy.
       * Move Tom Duffy's changes to drivers/sbus from the sparc64
         patch to the common patch to keep all the serial changes
         together.
       * Changes to common code to build on Xscale.  Eddie Dong, Intel.
       * Remove CROSS_COMPILE_INC.
       * Remove obsolete boot parameter 'kdb', long since replaced by
         'kdb=on'.
       * Remove obsolete kdb_eframe_t casts.
       * Add CONFIG_KDB_CONTINUE_CATASTROPHIC.
       * Wait a short interval for cpus to join kdb before proceeding.
       * Automatically enable sysrq for sr command.
       * Correct double free of kdb_printf lock, spotted by Richard Sanders.
       * Add optional cpu parameter to btc command.
       * kdb v4.3-2.4.20-common-1.

2.4.20-i386-1

2003-06-20 Keith Owens  <kaos@sgi.com>

       * Add CONFIG_KDB_CONTINUE_CATASTROPHIC.
       * Correct KDB_ENTER() definition.
       * kdb v4.3-2.4.20-i386-1.

2.4.20-ia64-020821-1

2003-06-20 Keith Owens  <kaos@sgi.com>

       * Add CONFIG_KDB_CONTINUE_CATASTROPHIC.
       * Do not send IPI if the machine state does not require them.
       * Correct definition of KDB_ENTER().
       * Workaround for broken init monarch handler.
       * Monarch cpu must get to kdb, even if it was interrupted in user space.
       * Unwind fixes.
       * Generalize ia64_spinlock_contention name.
       * Add kdba_fru for SN machines.
       * Correct test for cpu number.
       * kdb v4.3-2.4.20-ia64-020821-1.

2.4.20-sparc64-1

2003-06-01 Keith Owens <kaos@sgi.com>

       * Move drivers/sbus changes to common patch.
       * kdb v4.3-2.4.20-sparc64-1

2003-05-05 Tom Duffy <Thomas.Duffy.99@alumni.brown.edu>
       * port new kdb v4.2 to sparc64
       * kdb v4.2-2.4.20-sparc64-1

2.4.20-xscale-1

2003-06-01 Keith Owens <kaos@sgi.com>

       * Fit patch against arm code in 2.4.20 kernel.
       * kdb v4.3-2.4.20-xscale-1.

2003-05-06 Eddie Dong <Eddie.dong@intel.com>
       *
       * Port to KDB4.2
       * Add read/write access to user pages.  Vamsi Krishna S., IBM
       * kdb v4.2-2.4.20-xscale-1.



v4.3/README

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
  kdb-v4.3-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.3-2.4.20-i386-<n>              (use highest value of <n>)
in that order.  To use kdb for ia64-021210 on kernel 2.4.20, apply
  kdb-v4.3-2.4.20-common-<n>            (use highest value of <n>)
  kdb-v4.3-2.4.20-ia64-021210-<n>       (use highest value of <n>)
in that order.

Use patch -p1 for all patches.

I do not have any time to work on 2.5, so there are no patches available
for 2.5 kernels.  If somebody wants to port the latest kdb patches to
2.5 kernels and send patches to kaos@sgi.com then I will put them up in
this directory.  Jim Houston has some kdb patches against 2.5.69 in
http://www.ccur.com/realtime/oss/.

The kdb-smphdr* patches in the v4.0 directory are Sonic Zhang's changes
to improve hardware breakpoint handling on i386 and ia64.  They are
not official kdb patches yet, they are available for review.

If you have applied the O(1) scheduler patch to your 2.4 kernel then the
kdb changes to kernel/sched.c will not fit.  For O(1), the code should
look like this

switch_tasks:
#ifdef  CONFIG_KDB
	{
		extern struct task_struct *kdb_active_task[];
		kdb_active_task[smp_processor_id()] = next;
	}
#endif
	prefetch(next);
	clear_tsk_need_resched(prev);


