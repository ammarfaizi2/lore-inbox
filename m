Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVAaOfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVAaOfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVAaOfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:35:06 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:30919 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261217AbVAaOeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:34:37 -0500
Date: Mon, 31 Jan 2005 15:34:35 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: inter-module-* removal.. small next step
Message-ID: <20050131143435.GE6694@wohnheim.fh-wedel.de>
References: <20050130180016.GA12987@infradead.org> <1107132112.783.219.camel@baythorne.infradead.org> <1107159869.4221.53.camel@laptopd505.fenrus.org> <20050131135631.GA6694@wohnheim.fh-wedel.de> <20050131140104.GK18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050131140104.GK18316@stusta.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 January 2005 15:01:04 +0100, Adrian Bunk wrote:
> 
> Your patch doesn't add a Kconfig entry for INTER_MODULE_CRAP.

Now it does, and it picked up dwmw2's suggestion as well.

Jörn

-- 
He who knows others is wise.
He who knows himself is enlightened.
-- Lao Tsu


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 drivers/mtd/Kconfig         |    4 ++++
 drivers/mtd/chips/Kconfig   |    1 +
 drivers/mtd/devices/Kconfig |    1 +
 kernel/Makefile             |    3 ++-
 4 files changed, 8 insertions(+), 1 deletion(-)

--- linux-2.6.10cow/drivers/mtd/Kconfig~inter_module	2004-09-04 22:59:02.000000000 +0200
+++ linux-2.6.10cow/drivers/mtd/Kconfig	2005-01-31 15:29:14.000000000 +0100
@@ -2,6 +2,10 @@
 
 menu "Memory Technology Devices (MTD)"
 
+# This doens't actually belong here, but mtd is the last user, so...
+config INTER_MODULE_CRAP
+	boolean
+
 config MTD
 	tristate "Memory Technology Device (MTD) support"
 	help
--- linux-2.6.10cow/drivers/mtd/chips/Kconfig~inter_module	2004-09-04 22:59:02.000000000 +0200
+++ linux-2.6.10cow/drivers/mtd/chips/Kconfig	2005-01-31 15:32:42.000000000 +0100
@@ -31,6 +31,7 @@ config MTD_GEN_PROBE
 	tristate
 	default m if MTD_CFI!=y && !MTD_INTELPROBE && MTD_JEDECPROBE!=y && (MTD_CFI=m || MTD_JEDECPROBE=m)
 	default y if MTD_CFI=y || MTD_INTELPROBE || MTD_JEDECPROBE=y
+	select INTER_MODULE_CRAP
 
 config MTD_CFI_ADV_OPTIONS
 	bool "Flash chip driver advanced configuration options"
--- linux-2.6.10cow/drivers/mtd/devices/Kconfig~inter_module	2005-01-11 20:48:52.000000000 +0100
+++ linux-2.6.10cow/drivers/mtd/devices/Kconfig	2005-01-31 15:31:59.000000000 +0100
@@ -198,6 +198,7 @@ config MTD_DOCPROBE
 	tristate
 	default m if MTD_DOC2001!=y && MTD_DOC2000!=y && MTD_DOC2001PLUS!=y && (MTD_DOC2001=m || MTD_DOC2000=m || MTD_DOC2001PLUS=m)
 	default y if MTD_DOC2001=y || MTD_DOC2000=y || MTD_DOC2001PLUS=y
+	select INTER_MODULE_CRAP
 	help
 	  This isn't a real config option; it's derived.
 
--- linux-2.6.10cow/kernel/Makefile~inter_module	2004-12-28 17:31:37.000000000 +0100
+++ linux-2.6.10cow/kernel/Makefile	2005-01-31 14:49:40.000000000 +0100
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
