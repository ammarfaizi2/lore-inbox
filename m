Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbTD2NUO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTD2NUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:20:14 -0400
Received: from p50888CD3.dip0.t-ipconnect.de ([80.136.140.211]:64269 "EHLO
	gw.sphinx-it.de") by vger.kernel.org with ESMTP id S261839AbTD2NUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:20:12 -0400
Message-ID: <3EAE7F0E.7080003@coolgoose.com>
Date: Tue, 29 Apr 2003 15:33:02 +0200
From: Schwarzseher <fields35@coolgoose.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.3b) Gecko/20030313 Minotaur/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.68 and SMP on arch/sparc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
out whatever reasons I'm currently trying to update a debian 
installation on an old 2 processor SparcStation 20 clone.

Unfortunately I run into trouble compiling a 2.5.68 kernel on it. It 
seems that the inline "cpu_possible" is missing out of 
include/asm-sparc/smp.h while being existent in include/asm-i386/smp.h 
and others. A
Also unfortunately it seems to be needed for compiling successfully. 
Even more unfortunately I don't have an idea on how to add it (or rather 
what to add) because I'm not so deeply involved into inner kernel 
workings or the sparc architecture.

I attached the errors below. Am I the only one who tries to ran an 
actual 2.5 testing kernel on this vintage hardware?

While in this issue (even when it's off topic for this list, so please 
ignore if you feel insulted): Does anyone have an idea why swapon 
/dev/sdc2 throws a core since I updated to a (successfully for SMP 
compiled) 2.4.20 kernel? The swapon syscall is executed and in fact the 
swapspace is added but afterwards the swapon utility hickups with an 
segmentation fault... Had a look into the source but didn't understand 
what may be happening that results into a segfault.

Regards
Schwarzseher

---8<---8<---cut here for the kernel compile errors ---8<----8<-----8<----
  gcc -Wp,-MD,init/.main.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7 -fomit-frame-pointer 
-nostdinc -iwithprefix include    -DKBUILD_BASENAME=main 
-DKBUILD_MODNAME=main -c -o init/.tmp_main.o init/main.c
In file included from include/linux/blkdev.h:6,
                 from include/linux/blk.h:4,
                 from init/main.c:26:
include/linux/genhd.h: In function `disk_stat_set_all':
include/linux/genhd.h:140: warning: implicit declaration of function 
`cpu_possible'
In file included from include/linux/interrupt.h:10,
                 from include/asm/highmem.h:23,
                 from include/linux/highmem.h:12,
                 from include/linux/pagemap.h:10,
                 from include/linux/blkdev.h:10,
                 from include/linux/blk.h:4,
                 from init/main.c:26:
include/asm/hardirq.h: In function `irqs_running':
include/asm/hardirq.h:135: `smp_num_cpus' undeclared (first use in this 
function)
include/asm/hardirq.h:135: (Each undeclared identifier is reported only once
include/asm/hardirq.h:135: for each function it appears in.)
include/asm/hardirq.h:136: `BR_GLOBALIRQ_LOCK' undeclared (first use in 
this function)
include/asm/hardirq.h: In function `release_irqlock':
include/asm/hardirq.h:148: `BR_GLOBALIRQ_LOCK' undeclared (first use in 
this function)
init/main.c: In function `smp_init':
init/main.c:339: warning: implicit declaration of function `num_online_cpus'
init/main.c:341: warning: implicit declaration of function `cpu_online'
make[1]: *** [init/main.o] Error 1
make: *** [init] Error 2
----8<--------8<-------8<-------8<-----


