Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbVA3SAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbVA3SAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVA3SAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:00:40 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:26630 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261751AbVA3SA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:00:26 -0500
Date: Sun, 30 Jan 2005 18:00:17 +0000
From: Arjan van de Ven <arjan@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: bunk@stusta.de, dwmw2@infradead.org
Subject: inter-module-* removal.. small next step
Message-ID: <20050130180016.GA12987@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

intermodule is deprecated for quite some time now, and MTD is the sole last
user in the tree. To shrink the kernel for the people who don't use MTD, and
to prevent accidental return of more users of this, make the compiling of
this function conditional on MTD.


Signed-off-by: Arjan van de Ven <arjan@infradead.org>

--- linux/kernel/Makefile	2005-01-30 18:57:11.000000000 +0100
+++ linux/kernel/Makefile	2005-01-30 18:57:11.000000000 +0100
@@ -6,7 +6,7 @@
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o
 
 obj-$(CONFIG_FUTEX) += futex.o
@@ -27,6 +27,10 @@
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 
+inter-$(CONFIG_MTD)	+= intermodule.o
+obj-y	+= $(inter-y)
+obj-y  += $(inter=m)
+
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond

