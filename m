Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbQKPNGl>; Thu, 16 Nov 2000 08:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130205AbQKPNGb>; Thu, 16 Nov 2000 08:06:31 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:62109 "EHLO
	mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S129245AbQKPNGV>; Thu, 16 Nov 2000 08:06:21 -0500
Message-ID: <3A13D4BA.AD4A580B@home.com>
Date: Thu, 16 Nov 2000 07:36:10 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Patch to fix lockup on ppa insert
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to the imm patch, it's working for me.

John

diff -ru linux.clean/drivers/scsi/ppa.h linux.current/drivers/scsi/ppa.h
--- linux.clean/drivers/scsi/ppa.h      Thu Sep 14 20:27:05 2000
+++ linux.current/drivers/scsi/ppa.h    Thu Nov 16 07:26:38 2000
@@ -170,7 +170,7 @@
                eh_device_reset_handler:        NULL,                  
\
                eh_bus_reset_handler:           ppa_reset,             
\
                eh_host_reset_handler:          ppa_reset,             
\
-               use_new_eh_code:                1,                     
\
+               use_new_eh_code:                0,                     
\
                bios_param:                     ppa_biosparam,         
\
                this_id:                        -1,                    
\
                sg_tablesize:                   SG_ALL,                
\
diff -ru linux.clean/drivers/scsi/ppa.c linux.current/drivers/scsi/ppa.c
--- linux.clean/drivers/scsi/ppa.c      Thu Nov 16 07:25:29 2000
+++ linux.current/drivers/scsi/ppa.c    Thu Nov 16 07:28:10 2000
@@ -215,8 +215,10 @@
        }
        try_again = 1;
        goto retry_entry;
-    } else
+    } else {
+       host->use_new_eh_code = 1;
        return 1;               /* return number of hosts detected */
+    }
 }
 
 /* This is to give the ppa driver a way to modify the timings (and
other
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
