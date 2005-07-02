Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVGBPr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVGBPr4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 11:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVGBPqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 11:46:05 -0400
Received: from soufre.accelance.net ([213.162.48.15]:19165 "EHLO
	soufre.accelance.net") by vger.kernel.org with ESMTP
	id S261194AbVGBPpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 11:45:07 -0400
Message-ID: <42C6B67E.8050706@xenomai.org>
Date: Sat, 02 Jul 2005 17:45:02 +0200
From: Philippe Gerum <rpm@xenomai.org>
Organization: Xenomai
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] I-pipe 2.6.12-v0.8-00
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The interrupt pipeline patch v0.8-00 has been released, including
support for both x86 and ppc32 architectures.

At the following location, you will find a split version of the most
recent patch: http://download.gna.org/adeos/patches/v2.6/ipipe/split/

diffstat ipipe-core-2.6.12-v0.8-00.patch:
  2.6.12-ipipe-0.8/include/linux/ipipe.h  |  379 +++++++++++++++++++++++++++
  2.6.12-ipipe-0.8/include/linux/sched.h  |    1
  2.6.12-ipipe-0.8/init/Kconfig           |    1
  2.6.12-ipipe-0.8/init/main.c            |    3
  2.6.12-ipipe-0.8/kernel/Makefile        |    1
  2.6.12-ipipe-0.8/kernel/ipipe/Kconfig   |    9
  2.6.12-ipipe-0.8/kernel/ipipe/Makefile  |    2
  2.6.12-ipipe-0.8/kernel/ipipe/core.c    |  443 
++++++++++++++++++++++++++++++++
  2.6.12-ipipe-0.8/kernel/ipipe/generic.c |  240 +++++++++++++++++
  2.6.12-ipipe-0.8/kernel/irq/handle.c    |   13
  2.6.12-ipipe-0.8/kernel/printk.c        |   59 ++++
  2.6.12-ipipe-0.8/kernel/sched.c         |    5
  2.6.12-ipipe-0.8/kernel/sysctl.c        |    1
  2.6.12-ipipe-0.8/lib/kernel_lock.c      |    4
  2.6.12-ipipe-0.8/mm/vmalloc.c           |    4
  include/linux/hardirq.h                 |   13
  16 files changed, 1178 insertions(+)

diffstat ipipe-i386-2.6.12-v0.8-00.patch:
  arch/i386/Kconfig                        |    3
  arch/i386/kernel/Makefile                |    1
  arch/i386/kernel/apic.c                  |    7
  arch/i386/kernel/entry.S                 |   80 +++-
  arch/i386/kernel/i8259.c                 |   33 +
  arch/i386/kernel/io_apic.c               |  145 ++++++-
  arch/i386/kernel/ipipe-core.c            |  619 
+++++++++++++++++++++++++++++++
  arch/i386/kernel/ipipe-root.c            |  354 +++++++++++++++++
  arch/i386/kernel/process.c               |    1
  arch/i386/kernel/smp.c                   |   29 +
  arch/i386/kernel/time.c                  |    5
  arch/i386/kernel/traps.c                 |    8
  arch/i386/mach-visws/visws_apic.c        |    6
  arch/i386/mm/fault.c                     |    2
  arch/i386/mm/ioremap.c                   |    2
  include/asm-i386/apic.h                  |    6
  include/asm-i386/io_apic.h               |    4
  include/asm-i386/ipipe.h                 |  318 +++++++++++++++
  include/asm-i386/mach-default/do_timer.h |    5
  include/asm-i386/mach-visws/do_timer.h   |    5
  include/asm-i386/pgalloc.h               |   23 +
  include/asm-i386/spinlock.h              |    4
  include/asm-i386/system.h                |   31 +
  23 files changed, 1625 insertions(+), 66 deletions(-)

diffstat ipipe-ppc-2.6.12-v0.8-00.patch:
  arch/ppc/Kconfig                 |    2
  arch/ppc/kernel/Makefile         |    1
  arch/ppc/kernel/entry.S          |   13
  arch/ppc/kernel/head.S           |   14
  arch/ppc/kernel/head_44x.S       |    6
  arch/ppc/kernel/head_4xx.S       |   14
  arch/ppc/kernel/head_8xx.S       |   13
  arch/ppc/kernel/head_booke.h     |   16 +
  arch/ppc/kernel/head_fsl_booke.S |    4
  arch/ppc/kernel/idle.c           |    4
  arch/ppc/kernel/ipipe-core.c     |  592 
+++++++++++++++++++++++++++++++++++++++
  arch/ppc/kernel/ipipe-root.c     |  360 +++++++++++++++++++++++
  arch/ppc/platforms/pmac_pic.c    |    2
  include/asm-ppc/hw_irq.h         |   33 ++
  include/asm-ppc/ipipe.h          |  338 ++++++++++++++++++++++
  include/asm-ppc/pgalloc.h        |    5
  16 files changed, 1414 insertions(+), 3 deletions(-)

Patch sequence to build a Linux 2.6.12 tree with I-pipe support:

http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.12.tar.bz2
http://download.gna.org/adeos/patches/v2.6/ipipe/ipipe-2.6.12-v0.8-00.patch

-- 

Philippe.
