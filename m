Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUIUJ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUIUJ0d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 05:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267545AbUIUJ0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 05:26:33 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:26124 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267543AbUIUJ0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 05:26:20 -0400
Date: Tue, 21 Sep 2004 11:23:56 +0200
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Cagle, John" <john.cagle@hp.com>,
       Christian Borntraeger <linux-kernel@borntraeger.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Torben Mathiasen <device@lanana.org>, linux-mtd@lists.infradead.org
Subject: Re: [Patch][RFC] conflicting device major numbers in devices.txt
Message-ID: <20040921092356.GD4055@linux>
References: <C50AB9511EE59B49B2A503CB7AE1ABD108F82153@cceexc19.americas.cpqcorp.net> <1095580254.5065.172.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <1095580254.5065.172.camel@localhost.localdomain>
X-OS: Linux 2.6.5-7.108-default
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 19 2004, David Woodhouse wrote:
> On Sat, 2004-09-18 at 18:14 -0500, Cagle, John wrote:
> > Torben -- please correct this in devices.txt and find a new block
> > major for the Linux-MTD project (if they will accept it).
> 
> Seems reasonable.
>

Allright. Patch attached.

s/390 dasd moved to major 94.
s/390 VM/ESA moved to major 95.
INFTL moved to major 96.

Andrew:

Patch also adds Marvell MPSC low-density device to Minor 44 & 45 (Major 204).
This one was in my queue.

Thanks,
Torben


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="devices.diff"

Index: devices.txt
===================================================================
RCS file: /home/torben/cvsroot/lanana/devices.txt,v
retrieving revision 1.25
diff -u -r1.25 devices.txt
--- devices.txt	30 Aug 2004 09:28:36 -0000	1.25
+++ devices.txt	20 Sep 2004 12:07:31 -0000
@@ -1683,11 +1683,16 @@
 		  1 = /dev/dcxx1	Second capture card
 		    ...
 
- 94 block	Inverse NAND Flash Translation Layer
-		  0 = /dev/inftla	First INFTL layer
-		 16 = /dev/inftlb	Second INFTL layer
+ 94 block IBM S/390 DASD block storage
+    		  0 = /dev/dasda First DASD device, major
+    		  1 = /dev/dasda1 First DASD device, block 1
+	    	  2 = /dev/dasda2 First DASD device, block 2
+    		  3 = /dev/dasda3 First DASD device, block 3
+    		  4 = /dev/dasdb Second DASD device, major
+    		  5 = /dev/dasdb1 Second DASD device, block 1
+    		  6 = /dev/dasdb2 Second DASD device, block 2
+    		  7 = /dev/dasdb3 Second DASD device, block 3
 		    ...
-		240 = /dev/inftlp	16th INTFL layer
 
  95 char	IP filter
 		  0 = /dev/ipl		Filter control device/log file
@@ -1696,15 +1701,9 @@
 		  3 = /dev/ipauth	Authentication control device/log file
 		    ...		
 
- 95 block	IBM S/390 DASD block storage
-		  0 = /dev/dasd0	First DASD device, major
-		  1 = /dev/dasd0a	First DASD device, block 1
-		  2 = /dev/dasd0b	First DASD device, block 2
-		  3 = /dev/dasd0c	First DASD device, block 3
-		  4 = /dev/dasd1	Second DASD device, major
-		  5 = /dev/dasd1a	Second DASD device, block 1
-		  6 = /dev/dasd1b	Second DASD device, block 2
-		  7 = /dev/dasd1c	Second DASD device, block 3
+ 95 block	IBM S/390 VM/ESA minidisk
+		  0 = /dev/msd0		First VM/ESA minidisk
+		  1 = /dev/msd1		Second VM/ESA minidisk
 		    ...
 
  96 char	Parallel port ATAPI tape devices
@@ -1715,10 +1714,11 @@
 		129 = /dev/npt1		Second p.p. ATAPI tape, no rewind
 		    ...
 
- 96 block	IBM S/390 VM/ESA minidisk
-		  0 = /dev/msd0		First VM/ESA minidisk
-		  1 = /dev/msd1		Second VM/ESA minidisk
+ 96 block Inverse NAND Flash Translation Layer
+		  0 = /dev/inftla First INFTL layer
+		 16 = /dev/inftlb Second INFTL layer
 		    ...
+		240 = /dev/inftlp	16th INTFL layer
 
  97 char	Parallel port generic ATAPI interface
 		  0 = /dev/pg0		First parallel port ATAPI device
@@ -2745,6 +2745,8 @@
 		 41 = /dev/ttySMX0		Motorola i.MX - port 0
 		 42 = /dev/ttySMX1		Motorola i.MX - port 1
 		 43 = /dev/ttySMX2		Motorola i.MX - port 2
+		 44 = /dev/ttyMM0		Marvell MPSC - port 0
+		 45 = /dev/ttyMM1		Marvell MPSC - port 1	
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0

--FCuugMFkClbJLl1L--
