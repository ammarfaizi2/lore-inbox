Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWCOHmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWCOHmE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 02:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWCOHmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 02:42:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:50904 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932118AbWCOHmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 02:42:03 -0500
Date: Tue, 14 Mar 2006 23:41:15 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1
Message-ID: <20060315074115.GC5620@us.ibm.com>
References: <20060312031036.3a382581.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312031036.3a382581.akpm@osdl.org>
X-Operating-System: Linux 2.6.16-rc6-i386 (i686)
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.2006 [03:10:36 -0800], Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc6/2.6.16-rc6-mm1/
> 

Hrm, 2.6.16-rc6-mm1 fails to build 32-bit kernels on my Ubuntu Dapper
install (64-bit kernel, 32-bit userspace). gcc is version 4.0.3 (Ubuntu
4.0.3-1ubuntu1) and is biarch.  It builds 64-bit kernels fine (including
2.6.16-rc6-mm1) and 2.6.16-rc6 as a 32-bit kernel also built fine. So
seems like a regression with patch specific to -mm :( After a quick peek
looks like 2.6.16-rc5-mm3 also suffers from this, at least (Sorry, I
only recently started building 32-bit kernels on this box).

nacc@arkanoid:~/linux/views/2.6.16-rc6-mm1-dev$ make ARCH=i386 O=$(pwd | sed s/views/build/) -j8
  GEN    /home/nacc/linux/build/2.6.16-rc6-mm1-dev/Makefile
  CHK     include/linux/version.h
  Using /home/nacc/linux/views/2.6.16-rc6-mm1-dev as source for kernel
  CHK     usr/initramfs_list
  CHK     include/linux/compile.h
  AS      arch/i386/kernel/vsyscall-int80.o
  AS      arch/i386/kernel/vsyscall-sysenter.o
  CC      arch/i386/kernel/time_hpet.o
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S: Assembler messages:
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:131: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:131: Error: undefined symbol `SIGCONTEXT_esp' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:132: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:132: Error: undefined symbol `SIGCONTEXT_eax' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:133: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:133: Error: undefined symbol `SIGCONTEXT_ecx' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:134: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:134: Error: undefined symbol `SIGCONTEXT_edx' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:135: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:135: Error: undefined symbol `SIGCONTEXT_ebx' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:136: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:136: Error: undefined symbol `SIGCONTEXT_ebp' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:137: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:137: Error: undefined symbol `SIGCONTEXT_esi' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:138: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:138: Error: undefined symbol `SIGCONTEXT_edi' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:139: Error: undefined symbol `RT_SIGFRAME_sigcontext' in operation
/home/nacc/linux/views/2.6.16-rc6-mm1-dev/arch/i386/kernel/vsyscall-sigreturn.S:139: Error: undefined symbol `SIGCONTEXT_eip' in operation
make[2]: *** [arch/i386/kernel/vsyscall-int80.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[2]: *** [arch/i386/kernel/vsyscall-sysenter.o] Error 1
make[1]: *** [arch/i386/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make[1]: *** wait: No child processes.  Stop.
make: *** [_all] Error 2

Thanks,
Nish
