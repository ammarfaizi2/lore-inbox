Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278708AbRJTAls>; Fri, 19 Oct 2001 20:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278707AbRJTAl1>; Fri, 19 Oct 2001 20:41:27 -0400
Received: from octopus.harvestroad.com.au ([203.103.97.30]:65284 "EHLO
	tetra.cab.ambinet.com.au") by vger.kernel.org with ESMTP
	id <S278706AbRJTAlY>; Fri, 19 Oct 2001 20:41:24 -0400
Message-ID: <3BD0C752.F1A001F1@ambinet.com.au>
Date: Sat, 20 Oct 2001 08:37:38 +0800
From: Casper Boon <casper@ambinet.com.au>
Organization: Ambinet Systems
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: alan@redhat.com
Subject: A Little patch for DTC SCSI Controller
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC

The patch below is for the DTC3x80 controller which stopped working
under
2.4 series.  The change is only to the header and changes readb to
isa_readb
and writeb to isa_writeb.  Without this patch the kernel panics at
startup.


========================================================================
Casper A. Boon                                     casper@ambinet.com.au
Ambinet Systems                                             0417 171 505
========================================================================

diff -u linux-2.4.10/drivers/scsi/dtc.h
linux-2.4.10-cab/drivers/scsi/dtc.h
--- linux-2.4.10/drivers/scsi/dtc.h     Tue Sep 19 05:12:01 2000
+++ linux-2.4.10-cab/drivers/scsi/dtc.h Sat Oct 13 18:09:01 2001
@@ -80,29 +80,29 @@
 #define DTC_address(reg) (base + DTC_5380_OFFSET + reg)
 
 #define
dbNCR5380_read(reg)                                              \
-    (rval=readb(DTC_address(reg)), \
+    (rval=isa_readb(DTC_address(reg)), \
      (((unsigned char) printk("DTC : read register %d at addr %08x is:
%02x\n"\
     , (reg), (int)DTC_address(reg), rval)), rval ) )
 
 #define dbNCR5380_write(reg, value) do
{                                  \
     printk("DTC : write %02x to register %d at address %08x\n",        
\
             (value), (reg), (int)DTC_address(reg));     \
-    writeb(value, DTC_address(reg));} while(0)
+    isa_writeb(value, DTC_address(reg));} while(0)
 
 
 #if !(DTCDEBUG & DTCDEBUG_TRANSFER) 
-#define NCR5380_read(reg) (readb(DTC_address(reg)))
-#define NCR5380_write(reg, value) (writeb(value, DTC_address(reg)))
+#define NCR5380_read(reg) (isa_readb(DTC_address(reg)))
+#define NCR5380_write(reg, value) (isa_writeb(value, DTC_address(reg)))
 #else
-#define NCR5380_read(reg) (readb(DTC_address(reg)))
+#define NCR5380_read(reg) (isa_readb(DTC_address(reg)))
 #define xNCR5380_read(reg)                                            
\
     (((unsigned char) printk("DTC : read register %d at address
%08x\n"\
-    , (reg), DTC_address(reg))), readb(DTC_address(reg)))
+    , (reg), DTC_address(reg))), isa_readb(DTC_address(reg)))
 
 #define NCR5380_write(reg, value) do {                                
\
     printk("DTC : write %02x to register %d at address %08x\n",       
\
            (value), (reg), (int)DTC_address(reg));     \
-    writeb(value, DTC_address(reg));} while(0)
+    isa_writeb(value, DTC_address(reg));} while(0)
 #endif
 
 #define NCR5380_intr dtc_intr
