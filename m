Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSHEQJX>; Mon, 5 Aug 2002 12:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHEQJW>; Mon, 5 Aug 2002 12:09:22 -0400
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:57998 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318638AbSHEQJV>; Mon, 5 Aug 2002 12:09:21 -0400
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
Organization: IBM Deutschland Entwicklung GmbH
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] 13/18 Export elevator_init
Date: Mon, 5 Aug 2002 19:48:48 +0200
User-Agent: KMail/1.4.2
Cc: lkml <linux-kernel@vger.kernel.org>
References: <200208051830.50713.arndb@de.ibm.com>
In-Reply-To: <200208051830.50713.arndb@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208051948.48243.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:  The dasd driver wants to switch to the noop elevator function but
          it can do that if the driver is compiled as a module because
          elevator_init is not exported.
Solution: Export elevator_init. Has been accepted to 2.5.

diff -urN linux-2.4.19-rc3/drivers/block/Makefile linux-2.4.19-s390/drivers/block/Makefile
--- linux-2.4.19-rc3/drivers/block/Makefile	Tue Jul 30 09:02:27 2002
+++ linux-2.4.19-s390/drivers/block/Makefile	Tue Jul 30 09:02:43 2002
@@ -10,7 +10,7 @@
 
 O_TARGET := block.o
 
-export-objs	:= ll_rw_blk.o blkpg.o loop.o DAC960.o genhd.o
+export-objs	:= ll_rw_blk.o blkpg.o elevator.o loop.o DAC960.o genhd.o
 
 obj-y	:= ll_rw_blk.o blkpg.o genhd.o elevator.o
 
diff -urN linux-2.4.19-rc3/drivers/block/elevator.c linux-2.4.19-s390/drivers/block/elevator.c
--- linux-2.4.19-rc3/drivers/block/elevator.c	Fri Jul 20 05:59:41 2001
+++ linux-2.4.19-s390/drivers/block/elevator.c	Tue Jul 30 09:01:22 2002
@@ -220,3 +220,5 @@
 	*elevator = type;
 	elevator->queue_ID = queue_ID++;
 }
+
+EXPORT_SYMBOL(elevator_init);


