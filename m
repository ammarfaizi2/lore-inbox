Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267870AbTBYOg4>; Tue, 25 Feb 2003 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267359AbTBYOg4>; Tue, 25 Feb 2003 09:36:56 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:17805 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S267176AbTBYOgy>; Tue, 25 Feb 2003 09:36:54 -0500
Message-Id: <200302251445.h1PEjpGi030617@locutus.cmf.nrl.navy.mil>
To: Adrian Bunk <bunk@fs.tum.de>, jgarzik@pobox.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63: fore200e.c doesn't compile 
In-reply-to: Your message of "Tue, 25 Feb 2003 14:15:46 +0100."
             <20030225131546.GL7685@fs.tum.de> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 25 Feb 2003 09:45:51 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030225131546.GL7685@fs.tum.de>,Adrian Bunk writes:
>drivers/atm/fore200e.o drivers/atm/fore200e.c
>drivers/atm/fore200e.c: In function `fore200e_push_rpd':
>drivers/atm/fore200e.c:1135: structure has no member named `timestamp'
>drivers/atm/fore200e.c:1136: structure has no member named `timestamp'

it shouldnt be doing that.  you only need to set the timestamp in the 
skb.  i see the eni driver does the same thing.  i will see about
a patch for that shortly.

Index: linux/drivers/atm/fore200e.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/fore200e.c,v
retrieving revision 1.1.1.1
diff -u -d -b -w -r1.1.1.1 fore200e.c
--- linux/drivers/atm/fore200e.c	20 Feb 2003 13:45:03 -0000	1.1.1.1
+++ linux/drivers/atm/fore200e.c	25 Feb 2003 14:42:06 -0000
@@ -1132,8 +1132,7 @@
 	return;
     } 
 
-	do_gettimeofday(&vcc->timestamp);
-    skb->stamp = vcc->timestamp;
+    do_gettimeofday(&skb->stamp)
     
 #ifdef FORE200E_52BYTE_AAL0_SDU
     if (cell_header) {
