Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbSKLWiG>; Tue, 12 Nov 2002 17:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267000AbSKLWiG>; Tue, 12 Nov 2002 17:38:06 -0500
Received: from air-2.osdl.org ([65.172.181.6]:31647 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266996AbSKLWiF>;
	Tue, 12 Nov 2002 17:38:05 -0500
Subject: Megaraid SCSI problems
From: Stephen Hemminger <shemminger@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel List <linux-kernel@vger.kernel.org>
Cc: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Matt Domsch <Matt_Domsch@Dell.com>, markh@osdl.org
In-Reply-To: <1037055810.4648.68.camel@irongate.swansea.linux.org.uk>
References: <200211101453.gAAErOb10864@localhost.localdomain> 
	<1036946868.1009.16.camel@irongate.swansea.linux.org.uk> 
	<1037052584.12335.6.camel@dell_ss3.pdx.osdl.net> 
	<1037055810.4648.68.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:44:51 -0800
Message-Id: <1037141092.16635.29.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our megaraid problems turned out to be a problem with probing the IBM
EXP300 SCSI RAID enclosure.  The enclosure responds to the initial
inquiry but does not respond to report LUN's adding it to the black list
fixes the problem.

Thanks to Matt Domsch and Mark Haverkamp. Don't give up the good work
the megaraid driver still needs better error handling.

---------------------------------------------------
diff -urN -X dontdiff linux-2.5/drivers/scsi/scsi_scan.c linux-2.5-megaraid/drivers/scsi/scsi_scan.c
--- linux-2.5/drivers/scsi/scsi_scan.c	2002-11-11 11:02:17.000000000 -0800
+++ linux-2.5-megaraid/drivers/scsi/scsi_scan.c	2002-11-12 14:15:33.000000000 -0800
@@ -131,6 +131,7 @@
 	{"MITSUMI", "CD-R CR-2201CS", "6119", BLIST_NOLUN},	/* locks up */
 	{"RELISYS", "Scorpio", NULL, BLIST_NOLUN},	/* responds to all lun */
 	{"MICROTEK", "ScanMaker II", "5.61", BLIST_NOLUN},	/* responds to all lun */
+	{"IBM", "EXP300", "D014", BLIST_NOLUN},		/* locks up */
 
 	/*
 	 * Other types of devices that have special flags.

