Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312238AbSCTViE>; Wed, 20 Mar 2002 16:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312239AbSCTVhy>; Wed, 20 Mar 2002 16:37:54 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:15374 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S312213AbSCTVhj> convert rfc822-to-8bit; Wed, 20 Mar 2002 16:37:39 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Hooks for random device entropy generation missing incpqarray.c
Date: Wed, 20 Mar 2002 15:37:33 -0600
Message-ID: <45B36A38D959B44CB032DA427A6E10640167CF88@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Hooks for random device entropy generation missing incpqarray.c
thread-index: AcHQVaesSzVQT5C4S6e55naVBsHUlAAAPwWw
From: "Cameron, Steve" <Steve.Cameron@COMPAQ.com>
To: "Manon Goo" <manon@manon.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Mar 2002 21:37:34.0300 (UTC) FILETIME=[726469C0:01C1D057]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> excuse me I am using 2.4.18
> 

Ok.  If SA_SAMPLE_RANDOM is not in
the call to request_irq, you can put 
it in.  A trivial (but untested) patch: 
(if outlook doesn't mangle it) 

-- steve

--- cpqarray.c.orig	Wed Mar 20 15:25:51 2002
+++ cpqarray.c	Wed Mar 20 15:26:30 2002
@@ -516,8 +516,9 @@
 
 	
 	hba[i]->access.set_intr_mask(hba[i], 0);
-	if (request_irq(hba[i]->intr, do_ida_intr,
-		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i])) 
+	if (request_irq(hba[i]->intr, do_ida_intr, 
+		SA_SAMPLE_RANDOM|SA_INTERRUPT|SA_SHIRQ, 
+		hba[i]->devname, hba[i])) 
 	{
 
 		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 

 
