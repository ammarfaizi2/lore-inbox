Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313224AbSC1TBs>; Thu, 28 Mar 2002 14:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313225AbSC1TBj>; Thu, 28 Mar 2002 14:01:39 -0500
Received: from eccentric.mae.cornell.edu ([128.253.249.157]:778 "EHLO
	eccentric.mae.cornell.edu") by vger.kernel.org with ESMTP
	id <S313224AbSC1TB0>; Thu, 28 Mar 2002 14:01:26 -0500
Message-ID: <3CA36885.2080800@mae.cornell.edu>
Date: Thu, 28 Mar 2002 14:01:25 -0500
From: Andrey Klochko <andrey@eccentric.mae.cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en-us, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: xsebbi@gmx.de
Subject: Re: [2.5.7-dj2] Compile Error
Content-Type: multipart/mixed;
 boundary="------------000605000802000506080101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000605000802000506080101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>Hi there,
>
>make bzImage says:
>make[1]: Entering directory `/usr/src/linux-2.5-dj/kernel'
>make all_targets
>make[2]: Entering directory `/usr/src/linux-2.5-dj/kernel'
>gcc -D__KERNEL__ -I/usr/src/linux-2.5-dj/include -Wall 
>-Wstrict-prototypes -Wno-
>trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
>-pipe -mpref
>erred-stack-boundary=2 -march=i686 -malign-functions=4    
>-DKBUILD_BASENAME=acct
>  -c -o acct.o acct.c
>acct.c:235: parse error before `do'
>acct.c:378: parse error before `do'
>acct.c:384: parse error before `&'
>acct.c:386: warning: type defaults to `int' in declaration of 
>`do_acct_process'
>acct.c:386: warning: parameter names (without types) in function 
>declaration
>acct.c:386: conflicting types for `do_acct_process'
>acct.c:297: previous declaration of `do_acct_process'
>acct.c:386: warning: data definition has no type or storage class
>acct.c:387: warning: type defaults to `int' in declaration of `fput'
>acct.c:387: warning: parameter names (without types) in function 
>declaration
>acct.c:387: conflicting types for `fput'
>/usr/src/linux-2.5-dj/include/linux/file.h:36: previous declaration of 
>`fput'
>acct.c:387: warning: data definition has no type or storage class
>acct.c:388: parse error before `}'
>make[2]: *** [acct.o] Error 1
>make[2]: Leaving directory `/usr/src/linux-2.5-dj/kernel'
>make[1]: *** [first_rule] Error 2
>make[1]: Leaving directory `/usr/src/linux-2.5-dj/kernel'
>make: *** [_dir_kernel] Error 2
>
>just for information.
>
>		Sebastian

Try attached patch

Andrey



--------------000605000802000506080101
Content-Type: text/plain;
 name="kernel_Makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_Makefile.diff"

--- linux-2.5/kernel/Makefile.orig	Thu Mar 28 13:50:52 2002
+++ linux-2.5/kernel/Makefile	Thu Mar 28 13:24:12 2002
@@ -14,13 +14,13 @@
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
-	    sysctl.o acct.o capability.o ptrace.o timer.o user.o \
+	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o kthread.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
-obj-$(CONFIG_CONFIG_BSD_PROCESS_ACCT) += acct.o
+obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 
 ifneq ($(CONFIG_IA64),y)

--------------000605000802000506080101--

