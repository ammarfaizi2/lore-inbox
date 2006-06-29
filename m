Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933066AbWF2Wja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933066AbWF2Wja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933067AbWF2Wja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:39:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6602 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933066AbWF2Wj2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 18:39:28 -0400
Date: Thu, 29 Jun 2006 15:42:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gregoire Favre <gregoire.favre@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: 2.6.17-mm4 undefined reference to `alternatives_smp_module_del'
Message-Id: <20060629154247.1bf8eccf.akpm@osdl.org>
In-Reply-To: <20060629122721.GA18671@gmail.com>
References: <20060629122721.GA18671@gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregoire Favre <gregoire.favre@gmail.com> wrote:
>
> Hello,
> 
> just tried to compil 2.6.17-mm4 under amd64 and it fails with :
> 
>   AR      arch/x86_64/lib/lib.a
>   GEN     .version
>   CHK     include/linux/compile.h
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/kernel/built-in.o: In function `module_arch_cleanup':
> (.text.module_arch_cleanup+0x1): undefined reference to `alternatives_smp_module_del'
> arch/x86_64/kernel/built-in.o: In function `module_finalize':
> (.text.module_finalize+0xe8): undefined reference to `alternatives_smp_module_add'
> make: *** [.tmp_vmlinux1] Error 1
> 
> 

Thanks.  Reverting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/broken-out/x86-dont-print-out-smp-info-on-up-kernels.patch
will fix it.

<looks at davej>

That patch is pretty yuk anyway

 void module_arch_cleanup(struct module *mod)
 {
+#ifdef CONFIG_SMP
	alternatives_smp_module_del(mod);
+#endif
 }

Should be a stub in a header file, which would fix this problem too.
