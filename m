Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317887AbSHDQDC>; Sun, 4 Aug 2002 12:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317891AbSHDQDB>; Sun, 4 Aug 2002 12:03:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317887AbSHDQDB>;
	Sun, 4 Aug 2002 12:03:01 -0400
Date: Sun, 4 Aug 2002 17:06:34 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx_old compile fix
Message-ID: <20020804170634.L24631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aic7xxx_old did a sti() before calling panic().  remove these calls.

diff -urpNX dontdiff linux-2.5.30/drivers/scsi/aic7xxx_old.c linux-2.5.30-willy/drivers/scsi/aic7xxx_old.c
--- linux-2.5.30/drivers/scsi/aic7xxx_old.c	2002-07-27 12:09:15.000000000 -0600
+++ linux-2.5.30-willy/drivers/scsi/aic7xxx_old.c	2002-08-04 08:32:04.000000000 -0600
@@ -5077,7 +5077,6 @@ aic7xxx_handle_seqint(struct aic7xxx_hos
         }
         else 
         {
-          sti();
           panic("aic7xxx: AWAITING_MSG for an SCB that does "
                 "not have a waiting message.\n");
         }
@@ -6933,7 +6932,6 @@ aic7xxx_isr(int irq, void *dev_id, struc
 #endif
     if (errno & (SQPARERR | ILLOPCODE | ILLSADDR))
     {
-      sti();
       panic("aic7xxx: unrecoverable BRKADRINT.\n");
     }
     if (errno & ILLHADDR)

-- 
Revolutions do not require corporate support.
