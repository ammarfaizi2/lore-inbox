Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262560AbSJGW23>; Mon, 7 Oct 2002 18:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262668AbSJGW23>; Mon, 7 Oct 2002 18:28:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:32918 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262560AbSJGW22>;
	Mon, 7 Oct 2002 18:28:28 -0400
Subject: [PATCH] aacraid Makefile error in 2.5.41
From: Mark Haverkamp <markh@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Oct 2002 15:34:40 -0700
Message-Id: <1034030080.23403.12.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried building the aacraid driver in 2.5.41 and got an error
saying that O_TARGET usage was obsolete.  The following change 
to the Makefile allows me to build.

--- base_linux-2.5/drivers/scsi/aacraid/Makefile	Mon Oct  7 13:03:15 2002
+++ linux-2.5/drivers/scsi/aacraid/Makefile	Mon Oct  7 14:30:03 2002
@@ -1,10 +1,9 @@
 
 EXTRA_CFLAGS	+= -I$(TOPDIR)/drivers/scsi
 
-O_TARGET	:= aacraid.o
-obj-m		:= $(O_TARGET)
+obj-$(CONFIG_SCSI_AACRAID) := aacraid.o
 
-obj-y		:= linit.o aachba.o commctrl.o comminit.o commsup.o \
+aacraid-objs	:= linit.o aachba.o commctrl.o comminit.o commsup.o \
 		   dpcsup.o rx.o sa.o
 
 include $(TOPDIR)/Rules.make

