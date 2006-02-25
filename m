Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932623AbWBYIzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623AbWBYIzt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 03:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030181AbWBYIzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 03:55:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64191 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932623AbWBYIzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 03:55:48 -0500
Date: Sat, 25 Feb 2006 03:55:38 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ak@suse.de, dhect@vmware.com, zach@vmware.com, torvalds@osdl.org
Subject: Re: [PATCH] Fix topology.c location
Message-ID: <20060225085538.GA17448@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ak@suse.de, dhect@vmware.com, zach@vmware.com, torvalds@osdl.org
References: <200602242305.k1ON5Tmb026520@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602242305.k1ON5Tmb026520@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > commit 9c869edac591977314323a4eaad5f7633fca684f
 > tree 9455f4e8e78cd62f87b19dd7abe2c65ca23d9ceb
 > parent ad329b1519c0091806046b0e49ab073ea590dc11
 > author Zachary Amsden <zach@vmware.com> Sat, 25 Feb 2006 05:04:27 -0800
 > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 25 Feb 2006 06:31:39 -0800
 > 
 > [PATCH] Fix topology.c location
 > 
 > When compiling a non-default subarch, topology.c is missing from the kernel
 > build.  This causes builds with CONFIG_HOTPLUG_CPU to fail.  In addition,
 > on Intel processors with cpuid level > 4, it causes intel_cacheinfo.c to
 > reference uninitialized data that should have been set up by the initcall
 > in topology.c which calls register_cpu.  This causes a kernel panic on boot
 > on newer Intel processors.  Moving topology.c to arch/i386/kernel fixes
 > both of these problems.

This change breaks x86-64 compiles, as it uses the same file.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/arch/x86_64/kernel/Makefile~	2006-02-25 03:29:04.000000000 -0500
+++ linux-2.6.15.noarch/arch/x86_64/kernel/Makefile	2006-02-25 03:29:35.000000000 -0500
@@ -45,7 +45,7 @@ CFLAGS_vsyscall.o		:= $(PROFILING) -g0
 
 bootflag-y			+= ../../i386/kernel/bootflag.o
 cpuid-$(subst m,y,$(CONFIG_X86_CPUID))  += ../../i386/kernel/cpuid.o
-topology-y                     += ../../i386/mach-default/topology.o
+topology-y                     += ../../i386/kernel/topology.o
 microcode-$(subst m,y,$(CONFIG_MICROCODE))  += ../../i386/kernel/microcode.o
 intel_cacheinfo-y		+= ../../i386/kernel/cpu/intel_cacheinfo.o
 quirks-y			+= ../../i386/kernel/quirks.o

