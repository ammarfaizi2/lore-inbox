Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbUKIKez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbUKIKez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 05:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKIKez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 05:34:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:45972 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261467AbUKIKeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 05:34:36 -0500
Subject: [PATCH 0/11] oprofile: introduction
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1099996464.1985.777.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 09 Nov 2004 21:34:24 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Andrew,

This set of patches updates oprofile to a forward port of the latest
development version of the oprofile-callgraph patch which has been
available from oprofile.sourceforge.net for some months, plus some
recent bug fixes and ia64 callgraph support from myself and Keith
Owens.  I'm pushing this on behalf of John Levon, who's too busy
right now.

The patches are against 2.6.10-rc1-mm3 plus Jesse Barnes' recent
profile hook patch.  Please apply, in the given order.  Overall
diffstat is

 arch/alpha/oprofile/common.c          |   27 +---
 arch/alpha/oprofile/op_model_ev4.c    |    3
 arch/alpha/oprofile/op_model_ev5.c    |    3
 arch/alpha/oprofile/op_model_ev6.c    |    3
 arch/alpha/oprofile/op_model_ev67.c   |    8 -
 arch/arm/oprofile/common.c            |   21 +--
 arch/arm/oprofile/init.c              |    7 -
 arch/arm/oprofile/op_model_xscale.c   |    5
 arch/i386/oprofile/Makefile           |    2
 arch/i386/oprofile/backtrace.c        |  118 ++++++++++++++++++
 arch/i386/oprofile/init.c             |   12 +
 arch/i386/oprofile/nmi_int.c          |   47 +++----
 arch/i386/oprofile/nmi_timer_int.c    |   16 --
 arch/i386/oprofile/op_model_athlon.c  |    9 -
 arch/i386/oprofile/op_model_p4.c      |    9 -
 arch/i386/oprofile/op_model_ppro.c    |    9 -
 arch/i386/oprofile/op_x86_model.h     |    5
 arch/ia64/kernel/ia64_ksyms.c         |    3
 arch/ia64/kernel/unwind.c             |    2
 arch/ia64/oprofile/Makefile           |    2
 arch/ia64/oprofile/backtrace.c        |  150 ++++++++++++++++++++++++
 arch/ia64/oprofile/init.c             |   10 -
 arch/ia64/oprofile/perfmon.c          |   15 --
 arch/parisc/oprofile/init.c           |    5
 arch/ppc64/oprofile/common.c          |   33 ++---
 arch/ppc64/oprofile/op_model_power4.c |    3
 arch/ppc64/oprofile/op_model_rs64.c   |    3
 arch/s390/oprofile/init.c             |    7 -
 arch/sh/oprofile/op_model_null.c      |    3
 arch/sparc64/oprofile/init.c          |    5
 drivers/oprofile/buffer_sync.c        |   57 +++++++--
 drivers/oprofile/cpu_buffer.c         |  141 ++++++++++++++++++----
 drivers/oprofile/cpu_buffer.h         |    6
 drivers/oprofile/event_buffer.h       |    2
 drivers/oprofile/oprof.c              |   74 +++++++----
 drivers/oprofile/oprof.h              |    5
 drivers/oprofile/oprofile_files.c     |   42 +++++-
 drivers/oprofile/oprofile_stats.c     |    4
 drivers/oprofile/oprofile_stats.h     |    1
 drivers/oprofile/timer_int.c          |   19 ---
 include/linux/mm.h                    |    1
 include/linux/oprofile.h              |   20 ++-
 mm/memory.c                           |   20 ++-
 43 files changed, 676 insertions(+), 261 deletions(-)



1  check-user-page
	oprofile: add check_user_page_readable()

2  oprofile-callgraph-common
	oprofile: arch-independent code for stack trace sampling

3  oprofile-callgraph-i386
	oprofile: i386 support for stack trace sampling

4  oprofile-callgraph-ia64
	oprofile: ia64 support for oprofile stack trace sampling

5  oprofile-callgraph-alpha
	oprofile: update alpha for api changes

6  oprofile-callgraph-arm
	oprofile: update arm for api changes

7  oprofile-callgraph-ppc64
	oprofile: update ppc for api changes

8  oprofile-callgraph-parisc
	oprofile: update parisc for api changes

9  oprofile-callgraph-s390
	oprofile: update s390 for api changes

10 oprofile-callgraph-sh
	oprofile: update sh for api changes

11 oprofile-callgraph-sparc64
	oprofile: update sparc64 for api changes


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


