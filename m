Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSGGVFI>; Sun, 7 Jul 2002 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGGVFH>; Sun, 7 Jul 2002 17:05:07 -0400
Received: from adsl-65-69-128-164.dsl.rcsntx.swbell.net ([65.69.128.164]:20477
	"EHLO keyser.soze.net") by vger.kernel.org with ESMTP
	id <S316574AbSGGVFH>; Sun, 7 Jul 2002 17:05:07 -0400
Date: Sun, 7 Jul 2002 21:07:45 +0000
From: Justin Guyett <justin@soze.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Doc/fs/proc.txt (bdflush) for 2.4.19-rc
Message-ID: <20020707210745.GG14028@dreams.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the vm/bdflush description to accurately reflect the
values in /proc.  The descriptions won't win any prizes, but at least
the variable table is correct.


--- linux-2.4.19-rc1/Documentation/filesystems/proc.txt		Sun Jul  7 20:40:04 2002
+++ linux-2.4.19-rc1-new/Documentation/filesystems/proc.txt	Sun Jul  7 20:46:36 2002
@@ -961,17 +961,17 @@
 
 Table 2-2: Parameters in /proc/sys/vm/bdflush 
 ..............................................................................
- Value      Meaning                                                            
- nfract     Percentage of buffer cache dirty to  activate bdflush              
- ndirty     Maximum number of dirty blocks to  write out per wake-cycle        
- nrefill    Number of clean buffers to try to obtain  each time we call refill 
- nref_dirt  buffer threshold for activating bdflush when trying to refill
-            buffers. 
- dummy      Unused                                                             
- age_buffer Time for normal buffer to age before we flush it                   
- age_super  Time for superblock to age before we flush it                      
- dummy      Unused                                                             
- dummy      Unused                                                             
+ Value       Meaning                                                            
+ -----       -------
+ nfract      Percentage of buffer cache dirty to activate bdflush
+ ndirty      Maximum number of dirty blocks to write out per wake-cycle
+ dummy       Unused
+ dummy       Unused
+ interval    Time between kupdate flushes
+ age_buffer  Time for normal buffer to age before we flush it
+ nfract_sync Percentage of buffer cache dirty to activate bdflush synchronously
+ nfract_stop Percentage of buffer cache dirty to stop bdflush
+ dummy       Unused
 ..............................................................................
 
 nfract
@@ -991,29 +991,25 @@
 disk at  one  time.  A high value will mean delayed, bursty I/O, while a small
 value can lead to memory shortage when bdflush isn't woken up often enough.
 
-nrefill
--------
+interval
+--------
 
-This is  the  number  of  buffers  that  bdflush  will add to the list of free
-buffers when  refill_freelist()  is  called.  It is necessary to allocate free
-buffers beforehand,  since  the  buffers  are  often  different sizes than the
-memory pages  and some bookkeeping needs to be done beforehand. The higher the
-number, the  more  memory  will be wasted and the less often refill_freelist()
-will need to run.
+Interval specifies the time in jiffies  (clockticks) between kupdated flushes.
+The default number of jiffies per second is 100.
 
-nref_dirt
----------
+age_buffer
+----------
 
-When refill_freelist() comes across more than nref_dirt dirty buffers, it will
-wake up bdflush.
+Age_buffer specifies the  maximum time Linux waits before writing  out a dirty
+buffer to disk. The value is expressed in jiffies (clockticks) and the default
+number of jiffies  per second is 100.  Age_buffer is  the maximum age for data
+blocks.
 
-age_buffer and age_super
-------------------------
+nfract_sync and nfract_stop_bdflush
+-----------------------------------
 
-Finally, the age_buffer and age_super parameters govern the maximum time Linux
-waits before  writing  out  a  dirty buffer to disk. The value is expressed in
-jiffies (clockticks),  the  number of jiffies per second is 100. Age_buffer is
-the maximum age for data blocks, while age_super is for filesystems meta data.
+These follow the same general rules as nfract above, but values specify limits
+determining when synchronous flushing starts and flushing ends, respectively.
 
 buffermem
 ---------

