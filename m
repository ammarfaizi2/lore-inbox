Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269648AbUIRWDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269648AbUIRWDj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269650AbUIRWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:03:38 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:12536 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S269648AbUIRWDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:03:34 -0400
From: Christian Borntraeger <linux-kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Torben Mathiasen <device@lanana.org>
Subject: [Patch][RFC] conflicting device major numbers in devices.txt
Date: Sun, 19 Sep 2004 00:03:30 +0200
User-Agent: KMail/1.7
Cc: john.cagle@hp.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409190003.31177.linux-kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

some month ago a change to Documentation/devices.txt was submitted by John 
Cagle. 

http://linux.bkbits.net:8080/linux-2.6/cset%4040586a32fpYGPUC8ysFeU7GIfmmdUA

The patch changed the major number of the s/390 dasd devices from 94 to 95. 
As you can see in include/major.h and drivers/s390/block/dasd.c the change 
to the documentation was bogus. The dasd device driver was using and will 
be using major number 94. 

Unfortunately, the "Inverse NAND Flash Translation Layer", which was added 
somewhen during 2.5 now uses the same major number.

I attached a patch to restore the old state but I am not sure, how to deal 
with the inftla driver. 


Patch to restore the old state

Signed-of-by: Christian Borntraeger <linux-kernel@borntraeger.net>

-------------

diff -ur linux-bk/Documentation/devices.txt 
linux-dev/Documentation/devices.txt
--- a/Documentation/devices.txt 2004-09-18 23:20:38.000000000 +0200
+++ b/Documentation/devices.txt 2004-09-18 23:28:48.000000000 +0200
@@ -1683,11 +1683,16 @@
     1 = /dev/dcxx1 Second capture card
       ...
 
- 94 block Inverse NAND Flash Translation Layer
-    0 = /dev/inftla First INFTL layer
-   16 = /dev/inftlb Second INFTL layer
+ 94 block IBM S/390 DASD block storage
+    0 = /dev/dasda First DASD device, major
+    1 = /dev/dasda1 First DASD device, block 1
+    2 = /dev/dasda2 First DASD device, block 2
+    3 = /dev/dasda3 First DASD device, block 3
+    4 = /dev/dasdb Second DASD device, major
+    5 = /dev/dasdb1 Second DASD device, block 1
+    6 = /dev/dasdb2 Second DASD device, block 2
+    7 = /dev/dasdb3 Second DASD device, block 3
       ...
-  240 = /dev/inftlp 16th INTFL layer
 
  95 char IP filter
     0 = /dev/ipl  Filter control device/log file
@@ -1696,15 +1701,9 @@
     3 = /dev/ipauth Authentication control device/log file
       ...  
 
- 95 block IBM S/390 DASD block storage
-    0 = /dev/dasd0 First DASD device, major
-    1 = /dev/dasd0a First DASD device, block 1
-    2 = /dev/dasd0b First DASD device, block 2
-    3 = /dev/dasd0c First DASD device, block 3
-    4 = /dev/dasd1 Second DASD device, major
-    5 = /dev/dasd1a Second DASD device, block 1
-    6 = /dev/dasd1b Second DASD device, block 2
-    7 = /dev/dasd1c Second DASD device, block 3
+ 95 block IBM S/390 VM/ESA minidisk
+    0 = /dev/msd0  First VM/ESA minidisk
+    1 = /dev/msd1  Second VM/ESA minidisk
       ...
 
  96 char Parallel port ATAPI tape devices
@@ -1715,11 +1714,6 @@
   129 = /dev/npt1  Second p.p. ATAPI tape, no rewind
       ...
 
- 96 block IBM S/390 VM/ESA minidisk
-    0 = /dev/msd0  First VM/ESA minidisk
-    1 = /dev/msd1  Second VM/ESA minidisk
-      ...
-
  97 char Parallel port generic ATAPI interface
     0 = /dev/pg0  First parallel port ATAPI device
     1 = /dev/pg1  Second parallel port ATAPI device


