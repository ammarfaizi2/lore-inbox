Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264563AbUAJAu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 19:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264575AbUAJAu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 19:50:26 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:47059 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264563AbUAJAuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 19:50:20 -0500
Date: Sat, 10 Jan 2004 01:50:06 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [0/4] better i386 CPU selection
Message-ID: <20040110005005.GC25089@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040110004625.GB25089@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patches below are:

[1/4]
- changed the i386 CPU selection from a choice to single options for
  every cpu
- renamed the M* variables to CPU_*, this is needed to ask the users
  upgrading from older kernels instead of silently changing the
  semantics
- X86_GOOD_APIC -> X86_BAD_APIC
- AMD Elan is a different subarch, you can't configure a kernel that
  runs on both the AMD Elan and other i386 CPUs
- added optimizing CFLAGS for the AMD Elan
- gcc 2.95 supports -march=k6 (no need for check_gcc)
- help text changes/updates

[2/4]
move "struct movsl_mask movsl_mask" to usercopy.c 
(CONFIG_X86_INTEL_USERCOPY is used on non-Intel CPUs)

[3/4]
- made arch/i386/kernel/cpu/Makefile CPU specific

[4/4]
- made arch/i386/kernel/cpu/mtrr/Makefile CPU specific

Dependencies between these patches:
- patch 3 requires 1+2
- patch 4 requires 1

The main part is patch 1.

Patch 2 fixes a small issue that only shows up with patch 3.

Patches 3+4 are proof of concept patches for space optimizations by 
omitting unneeded code. They are "proof of concept" since the #ifdef's 
they introduce aren't 

TODO:
- change include/asm-i386/module.h to use some kind of bitmask

I've updated the patches for 2.6.1-rc3 and a kernel with these patches 
applied compiles and runs for me.

cu
Adrian
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
