Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbSJAGg5>; Tue, 1 Oct 2002 02:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSJAGg5>; Tue, 1 Oct 2002 02:36:57 -0400
Received: from transport.cksoft.de ([62.111.66.27]:18951 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S261496AbSJAGg4>; Tue, 1 Oct 2002 02:36:56 -0400
Date: Tue, 1 Oct 2002 08:40:30 +0200 (CEST)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
Cc: linux-kernel@vger.kernel.org, <coreteam@netfilter.org>,
       <netfilter-devel@lists.netfilter.org>, <patch@zabbadoz.net>
Subject: Re: 2.5.39 make modules_install error (netfilter)
In-Reply-To: <20021001142528.4640228c.Corporal_Pisang@Counter-Strike.com.my>
Message-ID: <Pine.BSF.4.44.0210010838480.427-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Oct 2002, Corporal Pisang wrote:

Hi,

> Final hurdle for me to get 2.5.39 compiled,
>
> This is the error on make modules_install
>
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.39; fi
> depmod: *** Unresolved symbols in /lib/modules/2.5.39/kernel/net/ipv4/netfilter/ipt_owner.o
> depmod:         next_thread
> depmod:         find_task_by_pid
> depmod: *** Unresolved symbols in /lib/modules/2.5.39/kernel/net/ipv6/netfilter/ip6t_owner.o
> depmod:         next_thread
> depmod:         find_task_by_pid

think someone already posted at least parts of this one.

--- linux-20020930-175132/kernel/pid.c.orig	Mon Sep 30 19:13:24 2002
+++ linux-20020930-175132/kernel/pid.c	Mon Sep 30 21:13:30 2002
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/bootmem.h>
+#include <linux/module.h>

 #define PIDHASH_SIZE 4096
 #define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
@@ -275,3 +276,5 @@
 		attach_pid(current, i, 0);
 	}
 }
+
+EXPORT_SYMBOL(find_task_by_pid);
--- linux-20020930-175132/kernel/Makefile.orig	Mon Sep 30 19:41:03 2002
+++ linux-20020930-175132/kernel/Makefile	Mon Sep 30 20:38:38 2002
@@ -3,7 +3,8 @@
 #

 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o pid.o \
+	      exit.o

 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
--- linux-20020930-175132/kernel/exit.c.orig	Mon Sep 30 20:37:53 2002
+++ linux-20020930-175132/kernel/exit.c	Mon Sep 30 21:13:15 2002
@@ -911,3 +911,5 @@
 }

 #endif
+
+EXPORT_SYMBOL(next_thread);

-- 
Greetings
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

