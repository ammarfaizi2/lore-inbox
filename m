Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280838AbRKBVMw>; Fri, 2 Nov 2001 16:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280837AbRKBVMn>; Fri, 2 Nov 2001 16:12:43 -0500
Received: from 39.159.252.64.snet.net ([64.252.159.39]:128 "EHLO stinkfoot.org")
	by vger.kernel.org with ESMTP id <S280838AbRKBVMZ>;
	Fri, 2 Nov 2001 16:12:25 -0500
Message-ID: <3BE30EDC.4030301@stinkfoot.org>
Date: Fri, 02 Nov 2001 16:23:40 -0500
From: Ethan <e-d0uble@stinkfoot.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PPC kernel ide modules failing [PATCH?]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

..answering myself here..  as I found that this problem occurs using a bunch of different trees (bk, ben, stock, etc..)
I have fixed this issue (albeit in possibly a completely incorrect and bad way)I'm certainly no programmer, and definately not a kernel hacker.
I was wondering if this is the correct way to handle this:

diff -u -r linux.orig/arch/ppc/kernel/Makefile linux/arch/ppc/kernel/Makefile
--- linux.orig/arch/ppc/kernel/Makefile Tue Aug 28 09:58:33 2001
+++ linux/arch/ppc/kernel/Makefile      Fri Nov  2 15:00:46 2001
@@ -29,7 +29,7 @@
 
 O_TARGET := kernel.o
 
-export-objs                    := ppc_ksyms.o prep_setup.o time.o
+export-objs                    := ppc_ksyms.o prep_setup.o time.o setup.o
 
 obj-y                          := entry.o traps.o irq.o idle.o time.o misc.o \
                                        process.o signal.o ptrace.o \
diff -u -r linux.orig/arch/ppc/kernel/setup.c linux/arch/ppc/kernel/setup.c
--- linux.orig/arch/ppc/kernel/setup.c  Sat Sep  8 15:38:42 2001
+++ linux/arch/ppc/kernel/setup.c       Fri Nov  2 15:42:56 2001
@@ -726,3 +726,4 @@
        for (i = 0; i < 96; i++)
                id->words160_255[i] = __le16_to_cpu(id->words160_255[i]);
 }
+EXPORT_SYMBOL(ppc_generic_ide_fix_driveid);


Today, Ethan@stinkfoot.org wrote:
> I thought that I'd mention that on recent PPC kernels the ide modules
> won't load:
> /lib/modules/2.4.14-pre3/kernel/drivers/ide/ide-mod.o: unresolved symbol
> ppc_generic_ide_fix_driveid

use Alan's tree, or the bk tree.

-- 
now the forces of openness have a powerful and
  unexpected new ally - http://ibm.com/linux

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


