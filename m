Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFYQoG>; Tue, 25 Jun 2002 12:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315627AbSFYQoF>; Tue, 25 Jun 2002 12:44:05 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:58886 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S315611AbSFYQoD> convert rfc822-to-8bit; Tue, 25 Jun 2002 12:44:03 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: ide driver bug fix for the error message "hda: bad special flag 0x03"
Date: Tue, 25 Jun 2002 11:43:42 -0500
Message-ID: <5A96E87E2BA0714ABBEA2C8F3F3F667C0AA680@cceexc19.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ide driver bug fix for the error message "hda: bad special flag 0x03"
Thread-Index: AcIcZo0h1mzuJYdtEda4RQCAX6bejQ==
From: "Shen, JT" <JT.Shen@hp.com>
To: <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>, "Shen, JT" <JT.Shen@hp.com>
X-OriginalArrivalTime: 25 Jun 2002 16:43:42.0918 (UTC) FILETIME=[7756C660:01C21C67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Naur linux-2.4.19-10/drivers/ide/ide-probe.c linux-2.4.19-11/drivers/ide/ide-probe.c
--- linux-2.4.19-10/drivers/ide/ide-probe.c	Fri Jun 21 15:14:46 2002
+++ linux-2.4.19-11/drivers/ide/ide-probe.c	Mon Jun 24 15:19:15 2002
@@ -131,6 +131,7 @@
 				type = ide_cdrom;	/* Early cdrom models used zero */
 			case ide_cdrom:
 				drive->removable = 1;
+				drive->special.all = 0;
 #ifdef CONFIG_PPC
 				/* kludge for Apple PowerBook internal zip */
 				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {








Andre,

Above is the patch that will fix the bug that when a user issue the command:

   cat /proc/ide/hda/identify

the message "hda: bad special flag 0x03" gets written to the system log.  This will happen because the .config file that RedHat uses to create the kernel image has the flag CONFIG_BLK_DEV_IDECD=m.  Thus in ide.c code, it won't call ide_cdrom_reinit(). So for CDROM the special flag is left as 0x03.


The solution is to set the special flags to 0 when it is discovered as cdrom in ide-probe.c.

Let me know if you have any question.

Thanks,

JT  
