Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313356AbSDGQgi>; Sun, 7 Apr 2002 12:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313358AbSDGQgh>; Sun, 7 Apr 2002 12:36:37 -0400
Received: from smtprelay7.dc2.adelphia.net ([64.8.50.39]:28133 "EHLO
	smtprelay7.dc2.adelphia.net") by vger.kernel.org with ESMTP
	id <S313356AbSDGQgg>; Sun, 7 Apr 2002 12:36:36 -0400
Date: Sun, 7 Apr 2002 12:43:57 -0400 (EDT)
From: "Steven N. Hirsch" <shirsch@adelphia.net>
X-X-Sender: hirsch@atx.fast.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Two fixes for 2.4.19-pre5-ac3
Message-ID: <Pine.LNX.4.44.0204071240360.15439-100000@atx.fast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

This enables the ips driver to build:

--- linux/drivers/scsi/ips.c.orig	Sun Apr  7 11:01:00 2002
+++ linux/drivers/scsi/ips.c	Sun Apr  7 11:35:31 2002
@@ -543,7 +543,8 @@
    }
 
    return (1);
-
+}
+ 
 __setup("ips=", ips_setup);
 
 #else
@@ -579,10 +580,10 @@
          }
       }
    }
+}
 
 #endif
 
-}
 
 /****************************************************************************/
 /*                                                                          */



And, unless this is reversed the OpenAFS kernel module won't load (it 
needs sys_call_table.):

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.19p5/kernel/ksyms.c linux.19pre5-ac3/kernel/ksyms.c
--- linux.19p5/kernel/ksyms.c	Thu Apr  4 13:21:17 2002
+++ linux.19pre5-ac3/kernel/ksyms.c	Fri Apr  5 14:02:06 2002
@@ -469,9 +475,6 @@
 EXPORT_SYMBOL(simple_strtoull);
 EXPORT_SYMBOL(system_utsname);	/* UTS data */
 EXPORT_SYMBOL(uts_sem);		/* UTS semaphore */
-#ifndef __mips__
-EXPORT_SYMBOL(sys_call_table);
-#endif
 EXPORT_SYMBOL(machine_restart);
 EXPORT_SYMBOL(machine_halt);
 EXPORT_SYMBOL(machine_power_off);



Regards,

Steve


