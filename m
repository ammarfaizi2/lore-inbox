Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264544AbTFUOXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbTFUOXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:23:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17136 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264490AbTFUOXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:23:37 -0400
Date: Sat, 21 Jun 2003 16:37:34 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove an unused function from NCR53c406a.c
Message-ID: <20030621143734.GW29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removes an unused function from 
drivers/scsi/NCR53c406a.c .
 
I've tested the compilation with 2.5.72-mm2.
 
--- linux-2.5.72-mm2/drivers/scsi/NCR53c406a.c.old	2003-06-21 16:34:54.000000000 +0200
+++ linux-2.5.72-mm2/drivers/scsi/NCR53c406a.c	2003-06-21 16:35:28.000000000 +0200
@@ -170,7 +170,6 @@
 /* Static function prototypes */
 static void NCR53c406a_intr(int, void *, struct pt_regs *);
 static irqreturn_t do_NCR53c406a_intr(int, void *, struct pt_regs *);
-static void wait_intr(void);
 static void chip_init(void);
 static void calc_port_addr(void);
 #ifndef IRQ_LEV
@@ -664,26 +663,6 @@
 	return (info_msg);
 }
 
-static void wait_intr(void)
-{
-	unsigned long i = jiffies + WATCHDOG;
-
-	while (time_after(i, jiffies) && !(inb(STAT_REG) & 0xe0)) {	/* wait for a pseudo-interrupt */
-		cpu_relax();
-		barrier();
-	}
-
-	if (time_before_eq(i, jiffies)) {	/* Timed out */
-		rtrc(0);
-		current_SC->result = DID_TIME_OUT << 16;
-		current_SC->SCp.phase = idle;
-		current_SC->scsi_done(current_SC);
-		return;
-	}
-
-	NCR53c406a_intr(0, NULL, NULL);
-}
-
 static int NCR53c406a_queue(Scsi_Cmnd * SCpnt, void (*done) (Scsi_Cmnd *))
 {
 	int i;


Please apply
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

