Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132137AbRDHASj>; Sat, 7 Apr 2001 20:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRDHAS3>; Sat, 7 Apr 2001 20:18:29 -0400
Received: from jalon.able.es ([212.97.163.2]:7104 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S132137AbRDHASQ>;
	Sat, 7 Apr 2001 20:18:16 -0400
Date: Sun, 8 Apr 2001 02:18:08 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: "Justin T . Gibbs" <gibbs@scsiguy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx 6.1.10 breaks 2.4.3-ac3
Message-ID: <20010408021808.C1138@werewolf.able.es>
In-Reply-To: <20010407205834.A2606@werewolf.able.es> <200104072333.f37NXus90906@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200104072333.f37NXus90906@aslan.scsiguy.com>; from gibbs@scsiguy.com on Sun, Apr 08, 2001 at 01:33:56 +0200
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 04.08 Justin T. Gibbs wrote:
> 
> Actually, I would say, "Apply the 2.4.3 patch.  It will probably apply
> cleanly to your kernel.  If it doesn't, and you don't know enough C
> to correct the problem, you shouldn't be playing around with kernel
> patches."
>

Below is inlined the patch that touches everything outside the aic7xxx
private subtree. The rest needed is the src.tar.gz file from your site.
Just corrected offsets.

> >That is not the way to do things. It is supposed that what people can get
> >at your site is the aic driver.
> 
> Ahh, now I have people telling me what the content of my
> site should be. ;-)

Nope, you can do whatever you like.

> 
> This has already happened in all cases save the functionality I've added
> in 6.1.10.  I haven't even gotten around to announcing 6.1.10 yet, so
> you can hardly fault me for not posting the SCSI layer changes yet.
>

Once you said 'here is my site for this certain soft updates', you can't
excpect that people do not check it in a regular basis, did you announce
anything or not.

=============== patch-follows

diff -u -r -N linux-2.4.3.virgin/Documentation/Configure.help
linux-2.4.3/Documentation/Configure.help
--- linux-2.4.3.virgin/Documentation/Configure.help	Wed Apr  4 15:41:33
2001
+++ linux-2.4.3/Documentation/Configure.help	Wed Apr  4 15:41:37 2001
@@ -5687,7 +5687,7 @@
   Default: 253
 
 Initial Bus Reset Settle Delay
-CONFIG_AIC7XXX_RESET_DELAY
+CONFIG_AIC7XXX_RESET_DELAY_MS
   The number of milliseconds to delay after an initial bus reset.
   The bus settle delay following all error recovery actions is
   dictated by the SCSI layer and is not affected by this value.
diff -u -r -N linux-2.4.3.virgin/Makefile linux-2.4.3/Makefile
--- linux-2.4.3.virgin/Makefile	Thu Mar 29 21:13:15 2001
+++ linux-2.4.3/Makefile	Tue Apr  3 13:04:24 2001
@@ -144,7 +144,6 @@
 DRIVERS-$(CONFIG_ATM) += drivers/atm/atm.o
 DRIVERS-$(CONFIG_IDE) += drivers/ide/idedriver.o
 DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
-DRIVERS-$(CONFIG_SCSI_AIC7XXX) += drivers/scsi/aic7xxx/aic7xxx_drv.o
 DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
 DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
 
diff -u -r -N linux-2.4.3.virgin/arch/alpha/defconfig
linux-2.4.3/arch/alpha/defconfig
--- linux-2.4.3.virgin/arch/alpha/defconfig	Sun Mar  4 15:30:18 2001
+++ linux-2.4.3/arch/alpha/defconfig	Wed Apr  4 15:49:21 2001
@@ -286,7 +286,7 @@
 # CONFIG_SCSI_AHA1740 is not set
 CONFIG_SCSI_AIC7XXX=y
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
-CONFIG_AIC7XXX_RESET_DELAY=5000
+CONFIG_AIC7XXX_RESET_DELAY_MS=5000
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
 # CONFIG_SCSI_AM53C974 is not set
diff -u -r -N linux-2.4.3.virgin/arch/ppc/defconfig
linux-2.4.3/arch/ppc/defconfig
--- linux-2.4.3.virgin/arch/ppc/defconfig	Sun Mar  4 15:30:18 2001
+++ linux-2.4.3/arch/ppc/defconfig	Wed Apr  4 15:49:38 2001
@@ -297,7 +297,7 @@
 # CONFIG_SCSI_AHA1740 is not set
 CONFIG_SCSI_AIC7XXX=y
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
-CONFIG_AIC7XXX_RESET_DELAY=15000
+CONFIG_AIC7XXX_RESET_DELAY_MS=15000
 # CONFIG_SCSI_AIC7XXX_OLD is not set
 # CONFIG_SCSI_ADVANSYS is not set
 # CONFIG_SCSI_IN2000 is not set
diff -u -r -N linux-2.4.3.virgin/arch/sparc64/defconfig
linux-2.4.3/arch/sparc64/defconfig
--- linux-2.4.3.virgin/arch/sparc64/defconfig	Sun Mar 25 19:14:21 2001
+++ linux-2.4.3/arch/sparc64/defconfig	Wed Apr  4 15:49:48 2001
@@ -307,7 +307,7 @@
 CONFIG_SCSI_QLOGICPTI=m
 CONFIG_SCSI_AIC7XXX=m
 CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
-CONFIG_AIC7XXX_RESET_DELAY=5000
+CONFIG_AIC7XXX_RESET_DELAY_MS=5000
 CONFIG_SCSI_AIC7XXX_OLD=m
 CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT=y
 CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=8
diff -u -r -N linux-2.4.3.virgin/drivers/scsi/Makefile
linux-2.4.3/drivers/scsi/Makefile
--- linux-2.4.3.virgin/drivers/scsi/Makefile	Mon Mar 26 16:36:30 2001
+++ linux-2.4.3/drivers/scsi/Makefile	Tue Apr  3 13:04:15 2001
@@ -6,6 +6,12 @@
 #
 # 20 Sep 2000, Torben Mathiasen <tmm@image.dk>
 # Changed link order to reflect new scsi initialization.
+#
+# *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!
+# The link order must be, SCSI Core, SCSI HBA drivers, and
+# lastly SCSI peripheral drivers (disk/tape/cdrom/etc.) to
+# satisfy certain initialization assumptions in the SCSI layer.
+# *!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!*!
 
 O_TARGET := scsidrv.o
 
@@ -64,6 +70,9 @@
 obj-$(CONFIG_SCSI_AHA152X)	+= aha152x.o
 obj-$(CONFIG_SCSI_AHA1542)	+= aha1542.o
 obj-$(CONFIG_SCSI_AHA1740)	+= aha1740.o
+ifeq ($(CONFIG_SCSI_AIC7XXX),y)
+obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx/aic7xxx_drv.o
+endif
 obj-$(CONFIG_SCSI_AIC7XXX_OLD)	+= aic7xxx_old.o
 obj-$(CONFIG_SCSI_IPS)		+= ips.o
 obj-$(CONFIG_SCSI_FD_MCS)	+= fd_mcs.o
diff -u -r -N linux-2.4.3.virgin/drivers/scsi/scsi_lib.c
linux-2.4.3/drivers/scsi/scsi_lib.c
--- linux-2.4.3.virgin/drivers/scsi/scsi_lib.c	Fri Mar  2 19:38:39 2001
+++ linux-2.4.3/drivers/scsi/scsi_lib.c	Thu Apr  5 14:28:17 2001
@@ -1111,9 +1111,13 @@
  */
 void scsi_unblock_requests(struct Scsi_Host * SHpnt)
 {
+	Scsi_Device *SDloop;
+
 	SHpnt->host_self_blocked = FALSE;
+	/* Now that we are unblocked, try to start the queues. */
+	for (SDloop = SHpnt->host_queue; SDloop; SDloop = SDloop->next)
+		scsi_queue_next_request(&SDloop->request_queue, NULL);
 }
-
 
 /*
  * Function:    scsi_report_bus_reset()


-- 
J.A. Magallon                                          #  Let the source
mailto:jamagallon@able.es                              #  be with you, Luke... 

Linux werewolf 2.4.3-ac3 #1 SMP Thu Apr 5 00:28:45 CEST 2001 i686

