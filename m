Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbSLVLSI>; Sun, 22 Dec 2002 06:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSLVLSI>; Sun, 22 Dec 2002 06:18:08 -0500
Received: from codepoet.org ([166.70.99.138]:1182 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S265670AbSLVLSH>;
	Sun, 22 Dec 2002 06:18:07 -0500
Date: Sun, 22 Dec 2002 04:26:13 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: bcollins@debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.4.x ieee1394
Message-ID: <20021222112613.GA8743@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, bcollins@debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200212172033.gBHKX6A32611@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212172033.gBHKX6A32611@hera.kernel.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Dec 17, 2002 at 04:14:22PM +0000, linux-kernel wrote:
> ChangeSet 1.901, 2002/12/17 14:14:22-02:00, bcollins@debian.org
> 
> 	[PATCH] Linux1394 Firewire
> 	
> 	Syncs to our Linux-2.4 branch. Mostly bug fixes. I'll start sending more
> 	frequent and mmore verbose patches.
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.900   -> 1.901  
[-------------snip---------]
> diff -Nru a/drivers/ieee1394/Makefile b/drivers/ieee1394/Makefile
> --- a/drivers/ieee1394/Makefile	Tue Dec 17 12:33:07 2002
> +++ b/drivers/ieee1394/Makefile	Tue Dec 17 12:33:07 2002
> @@ -2,11 +2,8 @@
>  # Makefile for the Linux IEEE 1394 implementation
>  #
>  
> -O_TARGET := ieee1394drv.o
> -

After this change, firewire doesn't build for me when adding
1394 stuff directly into the kernel, i.e.

    CONFIG_IEEE1394=y
    CONFIG_IEEE1394_OHCI1394=m
    CONFIG_IEEE1394_SBP2=m
    CONFIG_IEEE1394_RAWIO=y

The top level kernel Makefile has:
    DRIVERS-$(CONFIG_IEEE1394) += drivers/ieee1394/ieee1394drv.o
but there is no longer a ieee1394drv.o target.  This patch fixes 
the problem.

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
