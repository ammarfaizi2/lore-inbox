Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264970AbTFCLub (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 07:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264974AbTFCLub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 07:50:31 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:30109 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264970AbTFCLua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 07:50:30 -0400
Date: Tue, 3 Jun 2003 13:07:42 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: strange dependancy generation bug?
Message-ID: <20030603120742.GA13838@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently (about the same time that the V=0 stuff was changed over
in kbuild), I noticed that the dependancy generation stuff seems to be
executed more often.

An example:

(davej@halogen:linux-2.5)$ make arch/i386/kernel/cpu/cpufreq/powernow-k7.o V=1
make -f scripts/Makefile.build obj=scripts
make -f scripts/Makefile.build obj=scripts/genksyms
make -f scripts/Makefile.build obj=arch/i386/kernel/cpu/cpufreq arch/i386/kernel/cpu/cpufreq/powernow-k7.o
  gcc -Wp,-MD,arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=powernow_k7 -DKBUILD_MODNAME=powernow_k7 -c -o arch/i386/kernel/cpu/cpufreq/.tmp_powernow-k7.o arch/i386/kernel/cpu/cpufreq/powernow-k7.c
scripts/fixdep arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.d arch/i386/kernel/cpu/cpufreq/powernow-k7.o 'gcc -Wp,-MD,arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    -DKBUILD_BASENAME=powernow_k7 -DKBUILD_MODNAME=powernow_k7 -c -o arch/i386/kernel/cpu/cpufreq/.tmp_powernow-k7.o arch/i386/kernel/cpu/cpufreq/powernow-k7.c' > arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.tmp; rm -f arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.d; mv -f arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.tmp arch/i386/kernel/cpu/cpufreq/.powernow-k7.o.cmd


First question that springs to mind, is why does the fixdep stuff get run _after_ doing the compile ?
Second, is why does this always happen? Even on subsequent builds.

		Dave

