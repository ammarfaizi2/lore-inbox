Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129113AbRBBXFW>; Fri, 2 Feb 2001 18:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129356AbRBBXFM>; Fri, 2 Feb 2001 18:05:12 -0500
Received: from [195.154.83.81] ([195.154.83.81]:59404 "EHLO netgem.com")
	by vger.kernel.org with ESMTP id <S130313AbRBBXFE>;
	Fri, 2 Feb 2001 18:05:04 -0500
From: Jocelyn Mayer <jocelyn.mayer@netgem.com>
To: linux-kernel@vger.kernel.org
Message-ID: <3A7B3CF0.50327D75@netgem.com>
Date: Sat, 03 Feb 2001 00:04:16 +0100
Organization: Netgem S.A.
X-Mailer: Mozilla 4.61 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
Subject: Fix for include/linux/fs.h in 2.4.0 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had some problems while compiling some applications 
with the 2.4.0 kernel.
The problem was a conflict between string.h from the libc
and the one from the kernel, which is included in fs.h
So, using <string.h> and <linux/fs.h> at the same time
brings some conflicts.
It seems to me that <linux/string.h> should not be apparent 
from user mode, so I did this patch:

--- fs.h-orig   Fri Feb  2 23:55:35
2001                                                                                                                                      
+++ fs.h        Fri Feb  2 21:26:05
2001                                                                                                                                      
@@ -20,7 +20,7
@@                                                                                                                                                             
 #include
<linux/stat.h>                                                                                                                                                      
 #include
<linux/cache.h>                                                                                                                                                     
 #include
<linux/stddef.h>                                                                                                                                                    
-#include
<linux/string.h>                                                                                                                                                    
+/*  #include <linux/string.h>
*/                                                                                                                                             
                                                                                                                                                                              
 #include
<asm/atomic.h>                                                                                                                                                      
 #include
<asm/bitops.h>                                                                                                                                                      
@@ -190,6 +190,7
@@                                                                                                                                                           
                                                                                                                                                                              
 #include
<asm/semaphore.h>                                                                                                                                                   
 #include
<asm/byteorder.h>                                                                                                                                                   
+#include
<linux/string.h>                                                                                                                                                    
                                                                                                                                                                              
 extern void update_atime (struct inode
*);                                                                                                                                   
 #define UPDATE_ATIME(inode) update_atime
(inode)                                                                                                                             
 

Like this, the #include <linux/string.h> is "protected" 
by a #ifdef __KERNEL__, so I don't have any conflict any more.

I recompiled my kernel without any problem since I did that patch.

Regards.

Jocelyn Mayer.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
