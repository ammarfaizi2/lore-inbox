Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbVEMGVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbVEMGVZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 02:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbVEMGVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 02:21:25 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:65484 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262168AbVEMGVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 02:21:18 -0400
Date: Fri, 13 May 2005 11:49:55 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Jan Dittmer <jdittmer@ppp0.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hien@us.ibm.com
Subject: Re: 2.6.12-rc4-mm1, build results compared to 2.6.12-rc3-mm3
Message-ID: <20050513061955.GB3895@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20050512033100.017958f6.akpm@osdl.org> <42834A2E.60908@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42834A2E.60908@ppp0.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2005 at 12:24:45PM +0000, Jan Dittmer wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc4/2.6.12-rc4-mm1/
> 
> 
> Comparing 2.6.12-rc3-mm3 to 2.6.12-rc4-mm1 (defconfig)
> 
> - sparc64: broke
>     CC      arch/sparc64/kernel/signal32.o
>     CC      arch/sparc64/kernel/ioctl32.o
>     CC      arch/sparc64/kernel/binfmt_elf32.o
>     CC      arch/sparc64/kernel/module.o
>     CC      arch/sparc64/kernel/kprobes.o
>   In file included from /usr/src/ctest/mm/kernel/arch/sparc64/kernel/kprobes.c:8:
>   /usr/src/ctest/mm/kernel/include/linux/kprobes.h:122: error: parse error before "spinlock_t"
>   /usr/src/ctest/mm/kernel/include/linux/kprobes.h:123: warning: function declaration isn't a prototype
>   make[2]: *** [arch/sparc64/kernel/kprobes.o] Error 1
>   make[1]: *** [arch/sparc64/kernel] Error 2
>   make: *** [_all] Error 2


#include <linux/sched.h> to fix this compile issue.


Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
---

 linux-2.6.12-rc4-mm1-maneesh/include/linux/kprobes.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN include/linux/kprobes.h~kprobes-function-return-probes-sparc64-compile-fix include/linux/kprobes.h
--- linux-2.6.12-rc4-mm1/include/linux/kprobes.h~kprobes-function-return-probes-sparc64-compile-fix	2005-05-13 11:44:45.310631368 +0530
+++ linux-2.6.12-rc4-mm1-maneesh/include/linux/kprobes.h	2005-05-13 11:46:13.922160368 +0530
@@ -33,6 +33,7 @@
 #include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/smp.h>
+#include <linux/sched.h>
 #include <asm/kprobes.h>
 
 struct kprobe;
_



Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
