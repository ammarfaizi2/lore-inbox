Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSG3T6n>; Tue, 30 Jul 2002 15:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSG3T6m>; Tue, 30 Jul 2002 15:58:42 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:7313 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316610AbSG3T6m>;
	Tue, 30 Jul 2002 15:58:42 -0400
Subject: Re: link errors in 2.5.29+bk
From: Paul Larson <plars@austin.ibm.com>
To: Meelis Roos <mroos@linux.ee>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.43.0207291351390.24473-100000@romulus.cs.ut.ee>
References: <Pine.GSO.4.43.0207291351390.24473-100000@romulus.cs.ut.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 30 Jul 2002 14:58:24 -0500
Message-Id: <1028059116.11135.268.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 05:53, Meelis Roos wrote:

> aic7xxx_old has yet to be converted to cli removal:
> 
> drivers/built-in.o: In function `aic7xxx_handle_seqint':
> drivers/built-in.o(.text+0x2d2c4): undefined reference to `sti'
> drivers/built-in.o: In function `aic7xxx_isr':
> drivers/built-in.o(.text+0x320b4): undefined reference to `sti'

See if this works for you.

-Paul Larson

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.525   -> 1.526  
#	drivers/scsi/aic7xxx_old.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	plars@plap.(none)	1.526
#  
# --------------------------------------------
#
diff -Nru a/drivers/scsi/aic7xxx_old.c b/drivers/scsi/aic7xxx_old.c
--- a/drivers/scsi/aic7xxx_old.c	Tue Jul 30 14:30:14 2002
+++ b/drivers/scsi/aic7xxx_old.c	Tue Jul 30 14:30:14 2002
@@ -5077,7 +5077,7 @@
         }
         else 
         {
-          sti();
+          local_irq_enable();
           panic("aic7xxx: AWAITING_MSG for an SCB that does "
                 "not have a waiting message.\n");
         }
@@ -6933,7 +6933,7 @@
 #endif
     if (errno & (SQPARERR | ILLOPCODE | ILLSADDR))
     {
-      sti();
+      local_irq_enable();
       panic("aic7xxx: unrecoverable BRKADRINT.\n");
     }
     if (errno & ILLHADDR)

