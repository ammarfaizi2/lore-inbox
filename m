Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270072AbRHGFSK>; Tue, 7 Aug 2001 01:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270073AbRHGFR7>; Tue, 7 Aug 2001 01:17:59 -0400
Received: from zok.SGI.COM ([204.94.215.101]:23273 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S270072AbRHGFRp>;
	Tue, 7 Aug 2001 01:17:45 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.7-ac8 
In-Reply-To: Your message of "Mon, 06 Aug 2001 19:03:21 +0100."
             <20010806190320.A5719@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 Aug 2001 15:17:49 +1000
Message-ID: <14551.997161469@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001 19:03:21 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.7-ac8

<rant>
The aic7xxx maintainer keeps trying to break the kernel build system,
introducing special cases just to support his broken makefiles.  At the
same time he refuses to listen to suggestions for doing it correctly.
This is unacceptable, and will not work in kbuild 2.5.  The module
install structure is an exact match for the kernel source structure,
with no need to install modules elsewhere.  modutils >= 2.3.12 takes
care of the correct hierarchy, mkinitrd has no problem with the correct
tree.
</rant>

Index: 7.41/Rules.make
--- 7.41/Rules.make Tue, 07 Aug 2001 10:44:16 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.3 644)
+++ 7.41(w)/Rules.make Tue, 07 Aug 2001 15:10:31 +1000 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.3 644)
@@ -150,7 +150,7 @@ endif
 #
 ALL_MOBJS = $(filter-out $(obj-y), $(obj-m))
 ifneq "$(strip $(ALL_MOBJS))" ""
-MOD_DESTDIR ?= $(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
+MOD_DESTDIR := $(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
 endif
 
 unexport MOD_DIRS
Index: 7.41/drivers/scsi/aic7xxx/Makefile
--- 7.41/drivers/scsi/aic7xxx/Makefile Tue, 07 Aug 2001 10:44:16 +1000 kaos (linux-2.4/y/d/24_Makefile 1.1.1.1.1.1 644)
+++ 7.41(w)/drivers/scsi/aic7xxx/Makefile Tue, 07 Aug 2001 15:10:40 +1000 kaos (linux-2.4/y/d/24_Makefile 1.1.1.1.1.1 644)
@@ -27,7 +27,6 @@ AIC7XXX_OBJS += aic7xxx_pci.o
 endif
 
 # Override our module desitnation
-MOD_DESTDIR = $(shell cd .. && $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)
 MOD_TARGET = aic7xxx.o
 
 include $(TOPDIR)/Rules.make

