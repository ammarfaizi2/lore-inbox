Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751449AbWCQCfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWCQCfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWCQCfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:35:22 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:13956 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1750828AbWCQCfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:35:21 -0500
Date: Thu, 16 Mar 2006 18:35:20 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: linux-kernel@vger.kernel.org
Subject: uml build problem 2.6.15.6/2.6.16rc6
Message-ID: <Pine.LNX.4.62.0603161831480.12573@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to build a UML kernel on both versions (same starting 
config before make ARCH-um oldconfig) and I get the following error on 
2.6.16rc6 (similar errors on 2.6.15.6)

this is on a dual Opteron system with a debian 3.1 64bit build

# make ARCH=um -j8
   SYMLINK arch/um/include/kern_constants.h
   SYMLINK arch/um/include/sysdep
   CHK     include/linux/version.h
scripts/kconfig/conf -s arch/um/Kconfig
#
# using defaults found in .config
#
.config:11:warning: trying to assign nonexistent symbol HZ
   CHK     arch/um/include/uml-config.h
   UPD     arch/um/include/uml-config.h
   SPLIT   include/linux/autoconf.h -> include/config/*
   CC      arch/um/kernel/asm-offsets.s
In file included from include/asm/timex.h:14,
                  from include/linux/timex.h:61,
                  from include/linux/sched.h:11,
                  from arch/um/include/sysdep/kernel-offsets.h:3,
                  from arch/um/kernel/asm-offsets.c:1:
include/asm/processor.h:70: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared 
here (not in a function)
include/asm/processor.h:70: error: requested alignment is not a constant
include/asm/processor.h:225: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared 
here (not in a function)
include/asm/processor.h:225: error: requested alignment is not a constant
In file included from include/linux/sched.h:12,
                  from arch/um/include/sysdep/kernel-offsets.h:3,
                  from arch/um/kernel/asm-offsets.c:1:
include/linux/jiffies.h:18:5: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:20:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:22:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:24:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:26:7: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:28:7: warning: "CONFIG_HZ" is not defined

many for errors follow in jiffies.h related to CONFIG_HZ

include/linux/jiffies.h:410:6: warning: "CONFIG_HZ" is not defined
include/linux/jiffies.h:410:6: division by zero in #if
include/linux/jiffies.h: In function `jiffies_64_to_clock_t':
include/linux/jiffies.h:411: error: `CONFIG_HZ' undeclared (first use in 
this function)
In file included from include/linux/list.h:7,
                  from include/linux/wait.h:23,
                  from include/asm/semaphore.h:42,
                  from include/linux/sched.h:20,
                  from arch/um/include/sysdep/kernel-offsets.h:3,
                  from arch/um/kernel/asm-offsets.c:1:
include/linux/prefetch.h: In function `prefetch_range':
include/linux/prefetch.h:64: error: `CONFIG_X86_L1_CACHE_SHIFT' undeclared 
(first use in this function)
In file included from include/linux/slab.h:97,
                  from include/linux/percpu.h:4,
                  from include/linux/sched.h:34,
                  from arch/um/include/sysdep/kernel-offsets.h:3,
                  from arch/um/kernel/asm-offsets.c:1:
include/linux/kmalloc_sizes.h:5:5: warning: "CONFIG_X86_L1_CACHE_SHIFT" is 
not defined
include/linux/kmalloc_sizes.h:9:5: warning: "CONFIG_X86_L1_CACHE_SHIFT" is 
not defined
In file included from arch/um/kernel/asm-offsets.c:1:
arch/um/include/sysdep/kernel-offsets.h: In function `foo':
arch/um/include/sysdep/kernel-offsets.h:22: error: structure has no member 
named `mode'
In file included from arch/um/include/sysdep/kernel-offsets.h:24,
                  from arch/um/kernel/asm-offsets.c:1:
arch/um/include/common-offsets.h:3: error: structure has no member named 
`regs'
make[1]: *** [arch/um/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2



-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

