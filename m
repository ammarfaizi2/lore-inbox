Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSL2Qfu>; Sun, 29 Dec 2002 11:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSL2Qfu>; Sun, 29 Dec 2002 11:35:50 -0500
Received: from codepoet.org ([166.70.99.138]:22158 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S265012AbSL2Qft>;
	Sun, 29 Dec 2002 11:35:49 -0500
Date: Sun, 29 Dec 2002 09:44:09 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix 2.4.x ieee1394
Message-ID: <20021229164409.GA5416@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212172033.gBHKX6A32611@hera.kernel.org> <20021222112613.GA8743@codepoet.org> <20021229153821.GN27658@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021229153821.GN27658@fs.tum.de>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Dec 29, 2002 at 04:38:21PM +0100, Adrian Bunk wrote:
> When I try 2.4.21-pre2 with your patch and the IEEE 1394 options you 
> mention in your mail _nothing_ gets built inside the drivers/ieee1394 
> directory and the error message at the final linking is:
> 
> <--  snip  -->
> 
> ...
>         -o vmlinux
> ld: cannot open drivers/ieee1394/ieee1394.o: No such file or directory
> make: *** [vmlinux] Error 1
> 
> <--  snip  -->
> 
> 
> How did you manage to get a kernel that actually compiles?
> 

Sorry about that.  I missed a spot.  Here is the full fix:

--- linux/drivers/ieee1394/Makefile.orig	2002-12-21 14:32:36.000000000 -0700
+++ linux/drivers/ieee1394/Makefile	2002-12-21 19:43:05.000000000 -0700
@@ -18,7 +18,8 @@
 obj-$(CONFIG_IEEE1394_AMDTP) += amdtp.o
 obj-$(CONFIG_IEEE1394_CMP) += cmp.o
 
-include $(TOPDIR)/Rules.make
-
 ieee1394.o: $(ieee1394-objs)
 	$(LD) $(LDFLAGS) -r -o $@ $(ieee1394-objs)
+
+include $(TOPDIR)/Rules.make
+
--- linux/Makefile.orig	2002-12-21 14:32:42.000000000 -0700
+++ linux/Makefile	2002-12-21 19:59:00.000000000 -0700
@@ -153,7 +153,7 @@
 DRIVERS-$(CONFIG_FC4) += drivers/fc4/fc4.a
 DRIVERS-$(CONFIG_SCSI) += drivers/scsi/scsidrv.o
 DRIVERS-$(CONFIG_FUSION_BOOT) += drivers/message/fusion/fusion.o
-DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
+DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394.o
 
 ifneq ($(CONFIG_CD_NO_IDESCSI)$(CONFIG_BLK_DEV_IDECD)$(CONFIG_BLK_DEV_SR)$(CONFIG_PARIDE_PCD),)
 DRIVERS-y += drivers/cdrom/driver.o

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
