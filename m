Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbTDOTqE (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264049AbTDOTqE 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:46:04 -0400
Received: from holomorphy.com ([66.224.33.161]:37511 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264048AbTDOTqC 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:46:02 -0400
Date: Tue, 15 Apr 2003 12:57:32 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: mort@wildopensource.com
Subject: cpu-2.5.67-1
Message-ID: <20030415195732.GD12487@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, mort@wildopensource.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New in this release:
(1) cpus_complement()				(Martin Hicks)
(2) cpus_shift_right()				(Martin Hicks)
(3) cpus_shift_left()				(Martin Hicks)
(4) cpus_weight()				(Martin Hicks)
(5) UP micro-optimizations
(6) NR_CPUS < BITS_PER_LONG micro-optimizations
(7) IA64 arch support code			(Martin Hicks)

Martin, if you're wondering, I renamed cpus_inv()/cpus_shr()/cpus_shl()
to the (slightly) more verbose names so they line up more closely with
the bitmap_* functions' names. If that's too ugly to live (or whatever)
I can back it out and go back to your names, possibly backpropagating
the shorter names to the bitmap_* functions.

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/cpu/

-- wli

 arch/i386/kernel/apic.c                   |    3 
 arch/i386/kernel/cpu/proc.c               |    2 
 arch/i386/kernel/io_apic.c                |   49 ++++++-----
 arch/i386/kernel/irq.c                    |   43 ++++++---
 arch/i386/kernel/ldt.c                    |    4 
 arch/i386/kernel/mpparse.c                |    6 -
 arch/i386/kernel/reboot.c                 |    2 
 arch/i386/kernel/smp.c                    |   80 ++++++++++--------
 arch/i386/kernel/smpboot.c                |   70 ++++++++--------
 arch/ia64/kernel/iosapic.c                |   11 +-
 arch/ia64/kernel/irq.c                    |   60 +++++++++----
 arch/ia64/kernel/palinfo.c                |   10 --
 arch/ia64/kernel/perfmon.c                |   89 ++++++++++----------
 arch/ia64/kernel/setup.c                  |    2 
 arch/ia64/kernel/smp.c                    |    2 
 arch/ia64/kernel/smpboot.c                |   40 +++++----
 arch/ia64/kernel/time.c                   |    4 
 drivers/base/node.c                       |   13 ++
 include/asm-i386/highmem.h                |    6 +
 include/asm-i386/mach-default/mach_apic.h |   30 ++++--
 include/asm-i386/mach-default/mach_ipi.h  |    4 
 include/asm-i386/mach-numaq/mach_apic.h   |   19 ++--
 include/asm-i386/mach-numaq/mach_ipi.h    |    9 +-
 include/asm-i386/mmu_context.h            |    9 --
 include/asm-i386/mpspec.h                 |    4 
 include/asm-i386/numaq.h                  |    4 
 include/asm-i386/smp.h                    |   29 +-----
 include/asm-i386/topology.h               |   11 +-
 include/asm-ia64/perfmon.h                |    2 
 include/asm-ia64/smp.h                    |   22 -----
 include/linux/bitmap.h                    |  131 ++++++++++++++++++++++++++++++
 include/linux/cpumask.h                   |  112 +++++++++++++++++++++++++
 include/linux/init_task.h                 |    2 
 include/linux/irq.h                       |    2 
 include/linux/node.h                      |    3 
 include/linux/rcupdate.h                  |    5 -
 include/linux/sched.h                     |    7 -
 include/linux/smp.h                       |    3 
 kernel/fork.c                             |    2 
 kernel/module.c                           |    9 +-
 kernel/rcupdate.c                         |   12 +-
 kernel/sched.c                            |   56 +++++++-----
 kernel/softirq.c                          |    7 -
 kernel/workqueue.c                        |    4 
 44 files changed, 663 insertions(+), 331 deletions(-)
