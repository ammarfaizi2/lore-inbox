Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSIXMtf>; Tue, 24 Sep 2002 08:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSIXMtf>; Tue, 24 Sep 2002 08:49:35 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:48132 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261661AbSIXMte>; Tue, 24 Sep 2002 08:49:34 -0400
Date: Tue, 24 Sep 2002 22:54:36 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: "Michel Eyckmans (MCE)" <mce@pi.be>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, <netfilter-devel@lists.samba.org>
Subject: [PATCH] export find_task_by_pid() for 2.5.38
In-Reply-To: <200209230019.g8N0JmvC003642@jebril.pi.be>
Message-ID: <Mutt.LNX.4.44.0209242252160.1028-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002, Michel Eyckmans (MCE) wrote:

> By the way, 2.3.38 gives me this:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.38/kernel/net/ipv4/netfilter/ipt_owner.o
> depmod:         find_task_by_pid
> 

Below is a patch which exports the function, which used to be an inline.  
(This is also an issue for ip6t_owner).

- James
-- 
James Morris
<jmorris@intercode.com.au>

diff -urN -X dontdiff linux-2.5.38.orig/kernel/Makefile linux-2.5.38.w1/kernel/Makefile
--- linux-2.5.38.orig/kernel/Makefile	Tue Sep 24 19:23:03 2002
+++ linux-2.5.38.w1/kernel/Makefile	Tue Sep 24 22:14:47 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o pid.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
diff -urN -X dontdiff linux-2.5.38.orig/kernel/pid.c linux-2.5.38.w1/kernel/pid.c
--- linux-2.5.38.orig/kernel/pid.c	Tue Sep 24 19:23:03 2002
+++ linux-2.5.38.w1/kernel/pid.c	Tue Sep 24 22:23:56 2002
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>
 
 #define PIDHASH_SIZE 4096
 #define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
@@ -217,3 +218,5 @@
 		attach_pid(current, i, 0);
 	}
 }
+
+EXPORT_SYMBOL(find_task_by_pid);

