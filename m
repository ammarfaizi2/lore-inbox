Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312238AbSCYCZr>; Sun, 24 Mar 2002 21:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSCYCZi>; Sun, 24 Mar 2002 21:25:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:25791 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S312238AbSCYCZZ>; Sun, 24 Mar 2002 21:25:25 -0500
Date: Mon, 25 Mar 2002 11:23:58 +0900
From: hirao <hirao@estartu.open.nm.fujitsu.co.jp>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: [PATCH] enhance kernel profiling to loadable modules
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2761.1016686968@kao2.melbourne.sgi.com>
Message-Id: <20020325093336.0727.HIRAO@estartu.open.nm.fujitsu.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.00.07
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, Keith
 Thank you for the comment. 

> Instead of patching kernel/module.c and maintaining a separate list of
> module related profiling data, use the kernel_data field in struct
> module.  I added that field specificially so to track any kernel data
> that relates to each module.
 It is necessary to use kernel_data field in struct module. I see. 

> Change the module_arch_init() and free_module() functions in
> include/asm-i386/module.h to allocate and free the kernel_data
> structure during module load and unload.  Take the profile lock in
> those routines (disabling interrupts) when you update kernel_data.
 Certainly, I made patch for the x86 architecture. 
 However, I guessed that neither creation nor free of profiling buffer
would depend on architecture. 
 And, I had it write these processing (create_module_profile(),
delete_module_profile()) in kernel/profile.c, and call from module(). 
 Isn't this idea correct?
 If it is not correct, it is necessary to inpriment as processing of
the architecture dependence like your point it. 

> 
> To map a profile eip to a module, run the module list looking for the
> address, see kernel_text_address() in arch/i386/kernel/traps.c for
> example code.
> 
> With this approach, the mainline module code is unchanged, all arch
> specific profile code is in include/asm-$(ARCH)/module.h.
> 
> Your srch_prof_buffer() algorithm is ix86 specific, you assume that
> modules are always above the end of the kernel.  That is not true on
> all architectures.  The correct method is to treat the kernel as just
> another module and store the profile data for the kernel in
> kernel_module.kernel_data, using arch_init_modules().  Running the
> module list (which includes the kernel itself) will find the correct
> address range in an architecture portable way.  Add one extra slot to
> the kernel profile table for out of range addresses.
 It is so. Processing which specifies module from eip is corrected as
shown in the point. 


-- 
hirao <hirao@estartu.open.nm.fujitsu.co.jp>

