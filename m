Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262877AbVDHRIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbVDHRIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 13:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVDHRIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 13:08:15 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:41654 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262877AbVDHRIH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 13:08:07 -0400
Date: Fri, 8 Apr 2005 19:08:05 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH] restrict inter_module_* to its last users
Message-ID: <20050408170805.GE2292@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Derived from a patch Arjan sent around.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories

Next step for inter_module removal.  This patch makes the code
conditional on its last users and shrinks the kernel binary for the
huge majority of people.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/Kconfig         |    4 ++++
 drivers/mtd/chips/Kconfig   |    1 +
 drivers/mtd/devices/Kconfig |    1 +
 kernel/Makefile             |    3 ++-
 4 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.11cow/drivers/mtd/Kconfig~inter_module	2005-03-04 11:40:19.000000000 +0100
+++ linux-2.6.11cow/drivers/mtd/Kconfig	2005-03-09 23:24:05.000000000 +0100
@@ -2,6 +2,10 @@
 
 menu "Memory Technology Devices (MTD)"
 
+# This doens't actually belong here, but mtd is the last user, so...
+config INTER_MODULE_CRAP
+	boolean
+
 config MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
--- linux-2.6.11cow/drivers/mtd/chips/Kconfig~inter_module	2005-03-04 11:40:19.000000000 +0100
+++ linux-2.6.11cow/drivers/mtd/chips/Kconfig	2005-03-09 23:24:05.000000000 +0100
@@ -31,6 +31,7 @@ config MTD_JEDECPROBE
 
 config MTD_GEN_PROBE
 	tristate
+	select INTER_MODULE_CRAP
 
 config MTD_CFI_ADV_OPTIONS
 	bool "Flash chip driver advanced configuration options"
--- linux-2.6.11cow/drivers/mtd/devices/Kconfig~inter_module	2005-03-04 11:40:19.000000000 +0100
+++ linux-2.6.11cow/drivers/mtd/devices/Kconfig	2005-03-09 23:24:05.000000000 +0100
@@ -202,6 +202,7 @@ config MTD_DOC2001PLUS
 config MTD_DOCPROBE
 	tristate
 	select MTD_DOCECC
+	select INTER_MODULE_CRAP
 
 config MTD_DOCECC
 	tristate
--- linux-2.6.11cow/kernel/Makefile~inter_module	2004-12-28 17:31:37.000000000 +0100
+++ linux-2.6.11cow/kernel/Makefile	2005-03-09 23:24:05.000000000 +0100
@@ -6,9 +6,10 @@ obj-y     = sched.o fork.o exec_domain.o
 	    exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
-	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
+	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o
 
+obj-$(CONFIG_INTER_MODULE_CRAP) += intermodule.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
