Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRB0SU0>; Tue, 27 Feb 2001 13:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRB0SUQ>; Tue, 27 Feb 2001 13:20:16 -0500
Received: from atlrel2.hp.com ([156.153.255.202]:7375 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S129733AbRB0SUH>;
	Tue, 27 Feb 2001 13:20:07 -0500
From: Khalid Aziz <khalid@lyra.fc.hp.com>
Message-Id: <200102271620.LAA19975@lyra.fc.hp.com>
Subject: [PATCH] enhancement in drivers/scsi/sym53c8xx.c
To: linux-kernel@vger.kernel.org
Date: Tue, 27 Feb 2001 11:20:18 -0500 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When working with LVD SCSI bus, I have found it to be rather useful 
to know if the bus is operating in LVD or SE mode since the bus auto 
switches. All the info needed to print the bus mode is already there 
in sym53c8xx driver. This patch simply adds appropriate printk to do 
that.

--- sym53c8xx.c.bak	Tue Feb 27 11:05:43 2001
+++ sym53c8xx.c	Tue Feb 27 11:09:13 2001
@@ -5473,6 +5473,23 @@
 	if (np->scsi_mode == SMODE_HVD)
 		np->rv_stest2 |= 0x20;
 
+	switch (np->scsi_mode) {
+		case SMODE_SE:
+			printk(KERN_INFO "%s: Bus mode: Single-Ended\n",
+				ncr_name(np));
+			break;
+
+		case SMODE_LVD:
+			printk(KERN_INFO "%s: Bus mode: LVD\n",
+				ncr_name(np));
+			break;
+
+		case SMODE_HVD:
+			printk(KERN_INFO "%s: Bus mode: High Voltage Differential\n",
+				ncr_name(np));
+			break;
+	}
+
 	/*
 	**	Set LED support from SCRIPTS.
 	**	Ignore this feature for boards known to use a 


====================================================================
Khalid Aziz                             Linux Development Laboratory
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
