Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWIHKIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWIHKIK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 06:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWIHKIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 06:08:09 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:14564 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750770AbWIHKIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 06:08:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=aUZxnCmnDjWFxLV4OVcIUUfFwHMdFRQt76YszefITfSTtQm2oNDyk8tQLHx5naVYZvXp1sI7/l8xZyhvXclOlqdBRbSUXbcuopQeFnyLfCrwnAOZdw1izgZot2Rpoghv9O4HDEM/AHgmE4bZ3KTQ/7jNRJIjb4mC0T4BRBtAncw=
Date: Fri, 8 Sep 2006 12:07:22 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc6-mm1
Message-ID: <20060908120722.GA1121@slug>
References: <20060908011317.6cb0495a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 01:13:17AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
Hi,

2.6.18-rc6-mm1 fails to build on x86 with !CONFIG_SMP with the following
message:
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  CC      arch/i386/kernel/cpu/common.o
arch/i386/kernel/cpu/common.c: In function `init_gdt':
arch/i386/kernel/cpu/common.c:667: warning: implicit declaration of function `early_smp_processor_id'
  LD      arch/i386/kernel/cpu/built-in.o
  LD      arch/i386/kernel/built-in.o
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o: In function `init_gdt':
arch/i386/kernel/cpu/common.c:667: undefined reference to `early_smp_processor_id'
arch/i386/kernel/built-in.o: In function `cpu_init':
arch/i386/kernel/cpu/common.c:737: undefined reference to `early_smp_processor_id'
make: *** [.tmp_vmlinux1] Error 1

We need to include <asm/smp.h> to define early_smp_processor_id().

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- arch/i386/kernel/cpu/common.c~	2006-09-08 11:57:09.000000000 +0200
+++ arch/i386/kernel/cpu/common.c	2006-09-08 11:57:24.000000000 +0200
@@ -13,6 +13,7 @@
 #include <asm/mmu_context.h>
 #include <asm/mtrr.h>
 #include <asm/mce.h>
+#include <asm/smp.h>
 #ifdef CONFIG_X86_LOCAL_APIC
 #include <asm/mpspec.h>
 #include <asm/apic.h>
