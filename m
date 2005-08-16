Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbVHPJOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbVHPJOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVHPJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:14:04 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:32198 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965156AbVHPJN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:13:59 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] more whitespace cleanups for cpqfcTS
Date: Tue, 16 Aug 2005 11:13:43 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161111.35431@bilbo.math.uni-mannheim.de> <200508161112.47120@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161112.47120@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161113.45940@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More whitespace cleanups:
-remove trailing whitespace
-remove brakets around return statements
-remove some double (or more) newlines

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/scsi/cpqfcTSi2c.c	2005-08-07 20:18:56.000000000 +0200
+++ b/drivers/scsi/cpqfcTSi2c.c	2005-08-14 15:47:35.000000000 +0200
@@ -1,6 +1,6 @@
-/* Copyright(c) 2000, Compaq Computer Corporation 
- * Fibre Channel Host Bus Adapter 
- * 64-bit, 66MHz PCI 
+/* Copyright(c) 2000, Compaq Computer Corporation
+ * Fibre Channel Host Bus Adapter
+ * 64-bit, 66MHz PCI
  * Originally developed and tested on:
  * (front): [chip] Tachyon TS HPFC-5166A/1.2  L2C1090 ...
  *          SP# P225CXCBFIEL6T, Rev XC
@@ -18,16 +18,15 @@
  * General Public License for more details.
  * Written by Don Zimmerman
 */
-// These functions control the NVRAM I2C hardware on 
+// These functions control the NVRAM I2C hardware on
 // non-intelligent Fibre Host Adapters.
-// The primary purpose is to read the HBA's NVRAM to get adapter's 
+// The primary purpose is to read the HBA's NVRAM to get adapter's
 // manufactured WWN to copy into Tachyon chip registers
 // Orignal source author unknown
 
 #include <linux/types.h>
 enum boolean { FALSE, TRUE } ;
 
-
 #ifndef UCHAR
 typedef __u8 UCHAR;
 #endif
@@ -41,7 +40,6 @@ typedef __u16 USHORT;
 typedef __u32 ULONG;
 #endif
 
-
 #include <linux/string.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -61,7 +59,7 @@ static void tl_i2c_tx_byte( void* GPIOou
 // Tachlite GPIO2, GPIO3 (I2C) DEFINES
 // The NVRAM chip NM24C03 defines SCL (serial clock) and SDA (serial data)
 // GPIO2 drives SDA, and GPIO3 drives SCL
-// 
+//
 // Since Tachlite inverts the state of the GPIO 0-3 outputs, SET writes 0
 // and clear writes 1. The input lines (read in TL status) is NOT inverted
 // This really helps confuse the code and debugging.
@@ -78,7 +76,6 @@ static void tl_i2c_tx_byte( void* GPIOou
 
 #define SLAVE_READ_ADDRESS    0xA1
 #define SLAVE_WRITE_ADDRESS   0xA0
-					      
 
 static void i2c_delay(ULONG mstime);
 static void tl_i2c_clock_pulse( UCHAR , void* GPIOout);
@@ -102,9 +99,9 @@ static unsigned short tl_i2c_rx_ack( voi
 	// slave must drive data low for acknowledge
   value = tl_read_i2c_data( GPIOin);
   if (value & SENSE_DATA_HI )
-    return( FALSE );
+    return FALSE;
 
-  return( TRUE );
+  return TRUE;
 }
 //-----------------------------------------------------------------------------
 //
@@ -116,7 +113,7 @@ static unsigned short tl_i2c_rx_ack( voi
 //-----------------------------------------------------------------------------
 static UCHAR tl_read_i2c_data( void* gpioreg )
 {
-  return( (UCHAR)(readl( gpioreg ) & 0x08L) ); // GPIO3
+  return (UCHAR)(readl( gpioreg ) & 0x08L); // GPIO3
 }
 //-----------------------------------------------------------------------------
 //
@@ -171,16 +168,15 @@ static unsigned short tl_i2c_tx_start( v
 		// if he's still driving data low after 10 clocks, abort
     value = tl_read_i2c_data( GPIOin ); // read status
     if (!(value & 0x08) )
-      return( FALSE );
+      return FALSE;
   }
 
-
 	// To START, bring data low while clock high
   tl_write_i2c_reg(  GPIOout, SET_CLOCK_HI | SET_DATA_LO );
 
   i2c_delay(0);
 
-  return( TRUE );                           // TX start successful
+  return TRUE;                           // TX start successful
 }
 //-----------------------------------------------------------------------------
 //
@@ -194,7 +190,7 @@ static unsigned short tl_i2c_tx_stop( vo
 {
   int i;
 
-  for (i = 0; i < 10; i++) 
+  for (i = 0; i < 10; i++)
   {
   // Send clock pulse, drive data line low
     tl_i2c_clock_pulse( SET_DATA_LO, GPIOout );
@@ -207,10 +203,10 @@ static unsigned short tl_i2c_tx_stop( vo
 
   // If slave is driving data line low, there's a problem; retry
     if ( tl_read_i2c_data(GPIOin) & SENSE_DATA_HI )
-      return( TRUE );  // TX STOP successful!
+      return TRUE;  // TX STOP successful!
   }
 
-  return( FALSE );                      // error
+  return FALSE;                      // error
 }
 //-----------------------------------------------------------------------------
 //
@@ -229,7 +225,7 @@ static void tl_i2c_tx_byte( void* GPIOou
       tl_i2c_clock_pulse( (UCHAR)SET_DATA_HI, GPIOout);
     else
       tl_i2c_clock_pulse( (UCHAR)SET_DATA_LO, GPIOout);
-  }  
+  }
 }
 //-----------------------------------------------------------------------------
 //
@@ -243,7 +239,6 @@ static UCHAR tl_i2c_rx_byte( void* GPIOi
   UCHAR bit;
   UCHAR data = 0;
 
-
   for (bit = 0x80; bit; bit >>= 1) {
     // do clock pulse, let data line float high
     tl_i2c_clock_pulse( SET_DATA_HI, GPIOout );
@@ -253,7 +248,7 @@ static UCHAR tl_i2c_rx_byte( void* GPIOi
       data |= bit;
   }
 
-  return (data);
+  return data;
 }
 //*****************************************************************************
 //*****************************************************************************
@@ -275,12 +270,12 @@ unsigned long cpqfcTS_ReadNVRAM( void* G
   // Select the NVRAM for "dummy" write, to set the address
   tl_i2c_tx_byte( GPIOout , SLAVE_WRITE_ADDRESS );
   if ( !tl_i2c_rx_ack(GPIOin, GPIOout ) )
-    return( FALSE );
+    return FALSE;
 
-  // Now send the address where we want to start reading  
+  // Now send the address where we want to start reading
   tl_i2c_tx_byte( GPIOout , 0 );
   if ( !tl_i2c_rx_ack(GPIOin, GPIOout ) )
-    return( FALSE );
+    return FALSE;
 
   // Send a repeated start condition and select the
   //  slave for reading now.
@@ -288,11 +283,11 @@ unsigned long cpqfcTS_ReadNVRAM( void* G
     tl_i2c_tx_byte( GPIOout, SLAVE_READ_ADDRESS );
 
   if ( !tl_i2c_rx_ack(GPIOin, GPIOout) )
-    return( FALSE );
+    return FALSE;
 
   // this loop will now read out the data and store it
   //  in the buffer pointed to by buf
-  for ( i=0; i<count; i++) 
+  for (i = 0; i < count; i++)
   {
     *buf++ = tl_i2c_rx_byte(GPIOin, GPIOout);
 
@@ -307,7 +302,7 @@ unsigned long cpqfcTS_ReadNVRAM( void* G
 
   tl_i2c_tx_stop(GPIOin, GPIOout);
 
-  return( TRUE );
+  return TRUE;
 }
 
 //****************************************************************
@@ -354,7 +349,6 @@ static void tl_i2c_clock_pulse( UCHAR va
 
   i2c_delay(0);
 
-
   // read the port to preserve non-I2C bits
   ret_val = readl( GPIOout );
 
@@ -369,14 +363,10 @@ static void tl_i2c_clock_pulse( UCHAR va
 
   i2c_delay(0);
 
-
   //set clock bit
   tl_set_clock( GPIOout);
 }
 
-
-
-
 //*****************************************************************
 //
 //
@@ -397,18 +387,16 @@ int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf
   UCHAR  sub_name;
   UCHAR  done;
   int iReturn=0;  // def. 0 offset is failure to find WWN field
-  
-
-	  
+	
   data_ptr = (UCHAR *)buf;
 
   done = FALSE;
   i = 0;
 
-  while ( (i < 128) && (!done) ) 
+  while ( (i < 128) && (!done) )
   {
     z = data_ptr[i];\
-    if ( !(z & 0x80) )  
+    if ( !(z & 0x80) )
     {	
       len  = 1 + (z & 0x07);
 
@@ -416,12 +404,12 @@ int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf
       if (name == 0x0F)
         done = TRUE;
     }
-    else 
+    else
     {
       name = z & 0x7F;
       len  = 3 + data_ptr[i+1] + (data_ptr[i+2] << 8);
-           
-      switch (name) 
+
+      switch (name)
       {
       case 0x0D:
 	//
@@ -434,10 +422,10 @@ int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf
 
 	  while ( j<(i+len) ) {
 	    sub_name = (data_ptr[j] & 0x3f);
-	    sub_len  = data_ptr[j+1] + 
+	    sub_len  = data_ptr[j+1] +
 	               (data_ptr[j+2] << 8);
-            ptr_inc  = sub_len + 3; 
-	    switch (sub_name) 
+            ptr_inc  = sub_len + 3;
+	    switch (sub_name)
 	    {
 	    case 0x3C:
               memcpy( wwnbuf, &data_ptr[j+3], 8);
@@ -451,27 +439,23 @@ int cpqfcTS_GetNVRAM_data( UCHAR *wwnbuf
 	  break;
         default:
 	  break;
-      }  
-    }  
+      }
+    }
   //
     i += len;
-  }  // end while 
+  }  // end while
   return iReturn;
 }
 
-
-
-
-
 // define a short 5 micro sec delay, and longer (ms) delay
 
 static void i2c_delay(ULONG mstime)
 {
   ULONG i;
-  
+
 // NOTE: we only expect to use these delays when reading
 // our adapter's NVRAM, which happens only during adapter reset.
-// Delay technique from "Linux Device Drivers", A. Rubini 
+// Delay technique from "Linux Device Drivers", A. Rubini
 // (1st Ed.) pg 137.
 
 //  printk(" delay %lx  ", mstime);
@@ -483,11 +467,8 @@ static void i2c_delay(ULONG mstime)
 	
   }
   else  // 5 micro sec delay
-  
+
     udelay( 5 ); // micro secs
-  
+
 //  printk("done\n");
 }
-
-
-
--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 15:05:20.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 15:05:57.000000000 +0200
@@ -1,6 +1,6 @@
-/* Copyright(c) 2000, Compaq Computer Corporation 
- * Fibre Channel Host Bus Adapter 
- * 64-bit, 66MHz PCI 
+/* Copyright(c) 2000, Compaq Computer Corporation
+ * Fibre Channel Host Bus Adapter
+ * 64-bit, 66MHz PCI
  * Originally developed and tested on:
  * (front): [chip] Tachyon TS HPFC-5166A/1.2  L2C1090 ...
  *          SP# P225CXCBFIEL6T, Rev XC
@@ -24,15 +24,15 @@
  * QLogic CPQFCTS SCSI-FCP
  * Written by Erik H. Moe, ehm@cris.com
  * Copyright 1995, Erik H. Moe
- * Renamed and updated to 1.3.x by Michael Griffith <grif@cs.ucr.edu> 
+ * Renamed and updated to 1.3.x by Michael Griffith <grif@cs.ucr.edu>
  * Chris Loveland <cwl@iol.unh.edu> to support the isp2100 and isp2200
 */
 
 
-#include <linux/config.h>  
-#include <linux/interrupt.h>  
+#include <linux/config.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/version.h> 
+#include <linux/version.h>
 #include <linux/blkdev.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -61,10 +61,10 @@
 MODULE_AUTHOR("Compaq Computer Corporation");
 MODULE_DESCRIPTION("Driver for Compaq 64-bit/66Mhz PCI Fibre Channel HBA v. 2.5.4");
 MODULE_LICENSE("GPL");
-  
+
 int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev, unsigned int reset_flags);
 
-// This struct was originally defined in 
+// This struct was originally defined in
 // /usr/src/linux/include/linux/proc_fs.h
 // since it's only partially implemented, we only use first
 // few fields...
@@ -86,91 +86,91 @@ static int cpqfc_alloc_private_data_pool
 */
 static void Cpqfc_initHBAdata(CPQFCHBA *cpqfcHBAdata, struct pci_dev *PciDev )
 {
-             
+
   cpqfcHBAdata->PciDev = PciDev; // copy PCI info ptr
 
   // since x86 port space is 64k, we only need the lower 16 bits
-  cpqfcHBAdata->fcChip.Registers.IOBaseL = 
+  cpqfcHBAdata->fcChip.Registers.IOBaseL =
     PciDev->resource[1].start & PCI_BASE_ADDRESS_IO_MASK;
-  
-  cpqfcHBAdata->fcChip.Registers.IOBaseU = 
+
+  cpqfcHBAdata->fcChip.Registers.IOBaseU =
     PciDev->resource[2].start & PCI_BASE_ADDRESS_IO_MASK;
-  
+
   // 32-bit memory addresses
-  cpqfcHBAdata->fcChip.Registers.MemBase = 
+  cpqfcHBAdata->fcChip.Registers.MemBase =
     PciDev->resource[3].start & PCI_BASE_ADDRESS_MEM_MASK;
 
-  cpqfcHBAdata->fcChip.Registers.ReMapMemBase = 
+  cpqfcHBAdata->fcChip.Registers.ReMapMemBase =
     ioremap( PciDev->resource[3].start & PCI_BASE_ADDRESS_MEM_MASK,
              0x200);
-  
-  cpqfcHBAdata->fcChip.Registers.RAMBase = 
+
+  cpqfcHBAdata->fcChip.Registers.RAMBase =
     PciDev->resource[4].start;
-  
+
   cpqfcHBAdata->fcChip.Registers.SROMBase =  // NULL for HP TS adapter
     PciDev->resource[5].start;
-  
+
   // now the Tachlite chip registers
   // the REGISTER struct holds both the physical address & last
   // written value (some TL registers are WRITE ONLY)
 
-  cpqfcHBAdata->fcChip.Registers.SFQconsumerIndex.address = 
+  cpqfcHBAdata->fcChip.Registers.SFQconsumerIndex.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_SFQ_CONSUMER_INDEX;
 
-  cpqfcHBAdata->fcChip.Registers.ERQproducerIndex.address = 
+  cpqfcHBAdata->fcChip.Registers.ERQproducerIndex.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_ERQ_PRODUCER_INDEX;
-      
+
   // TL Frame Manager
-  cpqfcHBAdata->fcChip.Registers.FMconfig.address = 
+  cpqfcHBAdata->fcChip.Registers.FMconfig.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_CONFIG;
-  cpqfcHBAdata->fcChip.Registers.FMcontrol.address = 
+  cpqfcHBAdata->fcChip.Registers.FMcontrol.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_CONTROL;
-  cpqfcHBAdata->fcChip.Registers.FMstatus.address = 
+  cpqfcHBAdata->fcChip.Registers.FMstatus.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_STATUS;
-  cpqfcHBAdata->fcChip.Registers.FMLinkStatus1.address = 
+  cpqfcHBAdata->fcChip.Registers.FMLinkStatus1.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_LINK_STAT1;
-  cpqfcHBAdata->fcChip.Registers.FMLinkStatus2.address = 
+  cpqfcHBAdata->fcChip.Registers.FMLinkStatus2.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_LINK_STAT2;
-  cpqfcHBAdata->fcChip.Registers.FMBB_CreditZero.address = 
+  cpqfcHBAdata->fcChip.Registers.FMBB_CreditZero.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_BB_CREDIT0;
-      
+
       // TL Control Regs
-  cpqfcHBAdata->fcChip.Registers.TYconfig.address = 
+  cpqfcHBAdata->fcChip.Registers.TYconfig.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_TACH_CONFIG;
-  cpqfcHBAdata->fcChip.Registers.TYcontrol.address = 
+  cpqfcHBAdata->fcChip.Registers.TYcontrol.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_TACH_CONTROL;
-  cpqfcHBAdata->fcChip.Registers.TYstatus.address = 
+  cpqfcHBAdata->fcChip.Registers.TYstatus.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_TACH_STATUS;
-  cpqfcHBAdata->fcChip.Registers.rcv_al_pa.address = 
+  cpqfcHBAdata->fcChip.Registers.rcv_al_pa.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_RCV_AL_PA;
-  cpqfcHBAdata->fcChip.Registers.ed_tov.address = 
+  cpqfcHBAdata->fcChip.Registers.ed_tov.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + TL_MEM_FM_ED_TOV;
 
 
-  cpqfcHBAdata->fcChip.Registers.INTEN.address = 
+  cpqfcHBAdata->fcChip.Registers.INTEN.address =
 	        cpqfcHBAdata->fcChip.Registers.ReMapMemBase + IINTEN;
-  cpqfcHBAdata->fcChip.Registers.INTPEND.address = 
+  cpqfcHBAdata->fcChip.Registers.INTPEND.address =
 	        cpqfcHBAdata->fcChip.Registers.ReMapMemBase + IINTPEND;
-  cpqfcHBAdata->fcChip.Registers.INTSTAT.address = 
+  cpqfcHBAdata->fcChip.Registers.INTSTAT.address =
         cpqfcHBAdata->fcChip.Registers.ReMapMemBase + IINTSTAT;
 
   DEBUG_PCI(printk("  cpqfcHBAdata->fcChip.Registers. :\n"));
-  DEBUG_PCI(printk("    IOBaseL = %x\n", 
+  DEBUG_PCI(printk("    IOBaseL = %x\n",
     cpqfcHBAdata->fcChip.Registers.IOBaseL));
-  DEBUG_PCI(printk("    IOBaseU = %x\n", 
+  DEBUG_PCI(printk("    IOBaseU = %x\n",
     cpqfcHBAdata->fcChip.Registers.IOBaseU));
-  
+
   /* printk(" ioremap'd Membase: %p\n", cpqfcHBAdata->fcChip.Registers.ReMapMemBase); */
-  
-  DEBUG_PCI(printk("    SFQconsumerIndex.address = %p\n", 
+
+  DEBUG_PCI(printk("    SFQconsumerIndex.address = %p\n",
     cpqfcHBAdata->fcChip.Registers.SFQconsumerIndex.address));
-  DEBUG_PCI(printk("    ERQproducerIndex.address = %p\n", 
+  DEBUG_PCI(printk("    ERQproducerIndex.address = %p\n",
     cpqfcHBAdata->fcChip.Registers.ERQproducerIndex.address));
-  DEBUG_PCI(printk("    TYconfig.address = %p\n", 
+  DEBUG_PCI(printk("    TYconfig.address = %p\n",
     cpqfcHBAdata->fcChip.Registers.TYconfig.address));
-  DEBUG_PCI(printk("    FMconfig.address = %p\n", 
+  DEBUG_PCI(printk("    FMconfig.address = %p\n",
     cpqfcHBAdata->fcChip.Registers.FMconfig.address));
-  DEBUG_PCI(printk("    FMcontrol.address = %p\n", 
+  DEBUG_PCI(printk("    FMcontrol.address = %p\n",
     cpqfcHBAdata->fcChip.Registers.FMcontrol.address));
 
   // set default options for FC controller (chip)
@@ -190,15 +190,15 @@ static void Cpqfc_initHBAdata(CPQFCHBA *
   cpqfcHBAdata->fcChip.UnFreezeTachyon = CpqTsUnFreezeTachlite;
   cpqfcHBAdata->fcChip.CreateTachyonQues = CpqTsCreateTachLiteQues;
   cpqfcHBAdata->fcChip.DestroyTachyonQues = CpqTsDestroyTachLiteQues;
-  cpqfcHBAdata->fcChip.InitializeTachyon = CpqTsInitializeTachLite;  
-  cpqfcHBAdata->fcChip.LaserControl = CpqTsLaserControl;  
+  cpqfcHBAdata->fcChip.InitializeTachyon = CpqTsInitializeTachLite;
+  cpqfcHBAdata->fcChip.LaserControl = CpqTsLaserControl;
   cpqfcHBAdata->fcChip.ProcessIMQEntry = CpqTsProcessIMQEntry;
   cpqfcHBAdata->fcChip.InitializeFrameManager = CpqTsInitializeFrameManager;
   cpqfcHBAdata->fcChip.ReadWriteWWN = CpqTsReadWriteWWN;
   cpqfcHBAdata->fcChip.ReadWriteNVRAM = CpqTsReadWriteNVRAM;
 
       if (cpqfc_alloc_private_data_pool(cpqfcHBAdata) != 0) {
-		printk(KERN_WARNING 
+		printk(KERN_WARNING
 			"cpqfc: unable to allocate pool for passthru ioctls.  "
 			"Passthru ioctls disabled.\n");
       }
@@ -213,12 +213,12 @@ static void launch_FCworker_thread(struc
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
 
   ENTER("launch_FC_worker_thread");
-             
+
   cpqfcHBAdata->notify_wt = &sem;
 
   /* must unlock before kernel_thread(), for it may cause a reschedule. */
   spin_unlock_irq(HostAdapter->host_lock);
-  kernel_thread((int (*)(void *))cpqfcTSWorkerThread, 
+  kernel_thread((int (*)(void *))cpqfcTSWorkerThread,
                           (void *) HostAdapter, 0);
   /*
    * Now wait for the kernel error thread to initialize itself
@@ -229,16 +229,16 @@ static void launch_FCworker_thread(struc
   cpqfcHBAdata->notify_wt = NULL;
 
   LEAVE("launch_FC_worker_thread");
- 
+
 }
 
 
-/* "Entry" point to discover if any supported PCI 
+/* "Entry" point to discover if any supported PCI
    bus adapter can be found
 */
 /* We're supporting:
  * Compaq 64-bit, 66MHz HBA with Tachyon TS
- * Agilent XL2 
+ * Agilent XL2
  * HP Tachyon
  */
 static struct pci_device_id cpqfc_boards[] __initdata = {
@@ -255,7 +255,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
   int NumberOfAdapters=0; // how many of our PCI adapters are found?
   struct pci_dev *PciDev = NULL;
   struct Scsi_Host *HostAdapter = NULL;
-  CPQFCHBA *cpqfcHBAdata = NULL; 
+  CPQFCHBA *cpqfcHBAdata = NULL;
   struct timer_list *cpqfcTStimer = NULL;
   int i;
 
@@ -271,7 +271,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
       }
 
       if (pci_set_dma_mask(PciDev, CPQFCTS_DMA_MASK) != 0) {
-	printk(KERN_WARNING 
+	printk(KERN_WARNING
 		"cpqfc: HBA cannot support required DMA mask, skipping.\n");
 	goto err_disable_dev;
       }
@@ -281,7 +281,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 		      (ULONG)sizeof(CPQFCHBA)); */
 
       HostAdapter = scsi_register( ScsiHostTemplate, sizeof( CPQFCHBA ) );
-      
+
       if(HostAdapter == NULL) {
 	printk(KERN_WARNING
 		"cpqfc: can't register SCSI HBA, skipping.\n");
@@ -289,34 +289,34 @@ int cpqfcTS_detect(Scsi_Host_Template *S
       }
       DEBUG_PCI( printk("  HBA found!\n"));
       DEBUG_PCI( printk("  HostAdapter->PciDev->irq = %u\n", PciDev->irq) );
-      DEBUG_PCI(printk("  PciDev->baseaddress[0]= %lx\n", 
+      DEBUG_PCI(printk("  PciDev->baseaddress[0]= %lx\n",
 				PciDev->resource[0].start));
-      DEBUG_PCI(printk("  PciDev->baseaddress[1]= %lx\n", 
+      DEBUG_PCI(printk("  PciDev->baseaddress[1]= %lx\n",
 				PciDev->resource[1].start));
-      DEBUG_PCI(printk("  PciDev->baseaddress[2]= %lx\n", 
+      DEBUG_PCI(printk("  PciDev->baseaddress[2]= %lx\n",
 				PciDev->resource[2].start));
-      DEBUG_PCI(printk("  PciDev->baseaddress[3]= %lx\n", 
+      DEBUG_PCI(printk("  PciDev->baseaddress[3]= %lx\n",
 				PciDev->resource[3].start));
 
       HostAdapter->irq = PciDev->irq;  // copy for Scsi layers
-      
+
       // HP Tachlite uses two (255-byte) ranges of Port I/O (lower & upper),
       // for a total I/O port address space of 512 bytes.
       // mask out the I/O port address (lower) & record
       HostAdapter->io_port = (unsigned int)
 	     PciDev->resource[1].start & PCI_BASE_ADDRESS_IO_MASK;
       HostAdapter->n_io_port = 0xff;
-      
+
       // i.e., expect 128 targets (arbitrary number), while the
       //  RA-4000 supports 32 LUNs
-      HostAdapter->max_id =  0;   // incremented as devices log in    
+      HostAdapter->max_id =  0;   // incremented as devices log in
       HostAdapter->max_lun = CPQFCTS_MAX_LUN;         // LUNs per FC device
       HostAdapter->max_channel = CPQFCTS_MAX_CHANNEL; // multiple busses?
-      
+
       // get the pointer to our HBA specific data... (one for
       // each HBA on the PCI bus(ses)).
       cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
-      
+
       // make certain our data struct is clear
       memset( cpqfcHBAdata, 0, sizeof( CPQFCHBA ) );
 
@@ -326,7 +326,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 
       cpqfcHBAdata->HostAdapter = HostAdapter; // back ptr
       Cpqfc_initHBAdata( cpqfcHBAdata, PciDev ); // fill MOST fields
-     
+
       cpqfcHBAdata->HBAnum = NumberOfAdapters;
       spin_lock_init(&cpqfcHBAdata->hba_spinlock);
 
@@ -350,7 +350,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 			cpqfcHBAdata->fcChip.Registers.IOBaseU);
 	goto err_free_irq;
       }	
-      
+
       if( !request_region( cpqfcHBAdata->fcChip.Registers.IOBaseL,
       			   0xff, DEV_NAME ) )
       {
@@ -358,15 +358,15 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 	      			cpqfcHBAdata->fcChip.Registers.IOBaseL);
 	goto err_release_region_U;
       }	
-      
+
       // OK, we have grabbed everything we need now.
       DEBUG_PCI(printk("  Reserved 255 I/O addresses @ %x\n",
         cpqfcHBAdata->fcChip.Registers.IOBaseL ));
       DEBUG_PCI(printk("  Reserved 255 I/O addresses @ %x\n",
         cpqfcHBAdata->fcChip.Registers.IOBaseU ));
 
-     
- 
+
+
       // start our kernel worker thread
 
       spin_lock_irq(HostAdapter->host_lock);
@@ -392,7 +392,7 @@ int cpqfcTS_detect(Scsi_Host_Template *S
       }
 
       cpqfcHBAdata->fcStatsTime = jiffies;  // (for FC Statistics delta)
-      
+
       // give our HBA time to initialize and login current devices...
       {
 	// The Brocade switch (e.g. 2400, 2010, etc.) as of March 2000,
@@ -411,13 +411,13 @@ int cpqfcTS_detect(Scsi_Host_Template *S
 
 	spin_unlock_irq(HostAdapter->host_lock);
 	stop_time = jiffies + 4*HZ;
-        while ( time_before(jiffies, stop_time) ) 
+        while ( time_before(jiffies, stop_time) )
 	  	schedule();  // (our worker task needs to run)
 
       }
-      
+
       spin_lock_irq(HostAdapter->host_lock);
-      NumberOfAdapters++; 
+      NumberOfAdapters++;
       spin_unlock_irq(HostAdapter->host_lock);
 
       continue;
@@ -438,7 +438,7 @@ err_continue:
   }
 
   LEAVE("cpqfcTS_detect");
- 
+
   return NumberOfAdapters;
 }
 
@@ -446,22 +446,22 @@ err_continue:
 static void my_ioctl_done (Scsi_Cmnd * SCpnt)
 {
     struct request * req;
-    
+
     req = SCpnt->request;
     req->rq_status = RQ_SCSI_DONE; /* Busy, but indicate request done */
-  
+
     if (req->CPQFC_WAITING != NULL)
 	CPQFC_COMPLETE(req->CPQFC_WAITING);
-}   
+}
 #endif
 
 static int cpqfc_alloc_private_data_pool(CPQFCHBA *hba)
 {
 	hba->private_data_bits = NULL;
 	hba->private_data_pool = NULL;
-	hba->private_data_bits = 
+	hba->private_data_bits =
 		kmalloc(((CPQFC_MAX_PASSTHRU_CMDS+BITS_PER_LONG-1) /
-				BITS_PER_LONG)*sizeof(unsigned long), 
+				BITS_PER_LONG)*sizeof(unsigned long),
 				GFP_KERNEL);
 	if (hba->private_data_bits == NULL)
 		return -1;
@@ -496,10 +496,10 @@ int is_private_data_of_cpqfc(CPQFCHBA *h
 	   forged to be somewhere in our pool..., though they'd
 	   normally have to be root already to do this.  */
 
-	return (pointer != NULL && 
-		pointer >= (void *) hba->private_data_pool && 
-		pointer < (void *) hba->private_data_pool + 
-			sizeof(*hba->private_data_pool) * 
+	return (pointer != NULL &&
+		pointer >= (void *) hba->private_data_pool &&
+		pointer < (void *) hba->private_data_pool +
+			sizeof(*hba->private_data_pool) *
 				CPQFC_MAX_PASSTHRU_CMDS);
 }
 
@@ -508,11 +508,11 @@ cpqfc_passthru_private_t *cpqfc_alloc_pr
 	int i;
 
 	do {
-		i = find_first_zero_bit(hba->private_data_bits, 
+		i = find_first_zero_bit(hba->private_data_bits,
 			CPQFC_MAX_PASSTHRU_CMDS);
 		if (i == CPQFC_MAX_PASSTHRU_CMDS)
 			return NULL;
-	} while ( test_and_set_bit(i & (BITS_PER_LONG - 1), 
+	} while ( test_and_set_bit(i & (BITS_PER_LONG - 1),
 			hba->private_data_bits+(i/BITS_PER_LONG)) != 0);
 	return &hba->private_data_pool[i];
 }
@@ -521,7 +521,7 @@ void cpqfc_free_private_data(CPQFCHBA *h
 {
 	int i;
 	i = data - hba->private_data_pool;
-	clear_bit(i&(BITS_PER_LONG-1), 
+	clear_bit(i&(BITS_PER_LONG-1),
 			hba->private_data_bits+(i/BITS_PER_LONG));
 }
 
@@ -584,7 +584,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
 		kfree(buf);
 		return -ENOMEM;
 	}
-	ScsiPassThruReq->upper_private_data = 
+	ScsiPassThruReq->upper_private_data =
 			cpqfc_alloc_private_data(cpqfcHBAdata);
 	if (ScsiPassThruReq->upper_private_data == NULL) {
 		kfree(buf);
@@ -594,22 +594,22 @@ int cpqfcTS_ioctl( struct scsi_device *S
 
 	if (vendor_cmd->rw_flag == VENDOR_WRITE_OPCODE) {
 		if (vendor_cmd->len) { // Need data from user?
-        		if (copy_from_user(buf, vendor_cmd->bufp, 
+        		if (copy_from_user(buf, vendor_cmd->bufp,
 						vendor_cmd->len)) {
 				kfree(buf);
-				cpqfc_free_private_data(cpqfcHBAdata, 
+				cpqfc_free_private_data(cpqfcHBAdata,
 					ScsiPassThruReq->upper_private_data);
 				scsi_release_request(ScsiPassThruReq);
 				return( -EFAULT);
 			}
 		}
-		ScsiPassThruReq->sr_data_direction = DMA_TO_DEVICE; 
+		ScsiPassThruReq->sr_data_direction = DMA_TO_DEVICE;
 	} else if (vendor_cmd->rw_flag == VENDOR_READ_OPCODE) {
 		ScsiPassThruReq->sr_data_direction = DMA_FROM_DEVICE;
 	} else
 		// maybe this means a bug in the user app
 		ScsiPassThruReq->sr_data_direction = DMA_BIDIRECTIONAL;
-	    
+	
 	ScsiPassThruReq->sr_cmd_len = 0; // set correctly by scsi_do_req()
 	ScsiPassThruReq->sr_sense_buffer[0] = 0;
 	ScsiPassThruReq->sr_sense_buffer[2] = 0;
@@ -625,8 +625,8 @@ int cpqfcTS_ioctl( struct scsi_device *S
 	privatedata->pdrive = vendor_cmd->pdrive;
 	
         // eventually gets us to our own _quecommand routine
-	scsi_wait_req(ScsiPassThruReq, 
-		&vendor_cmd->cdb[0], buf, vendor_cmd->len, 
+	scsi_wait_req(ScsiPassThruReq,
+		&vendor_cmd->cdb[0], buf, vendor_cmd->len,
 		10*HZ,  // timeout
 		1);	// retries
         result = ScsiPassThruReq->sr_result;
@@ -635,12 +635,12 @@ int cpqfcTS_ioctl( struct scsi_device *S
         if( result != 0 )
 	{
 	  memcpy( vendor_cmd->sense_data, // see struct def - size=40
-		  ScsiPassThruReq->sr_sense_buffer, 
+		  ScsiPassThruReq->sr_sense_buffer,
 		  sizeof(ScsiPassThruReq->sr_sense_buffer) <
                   sizeof(vendor_cmd->sense_data)           ?
                   sizeof(ScsiPassThruReq->sr_sense_buffer) :
                   sizeof(vendor_cmd->sense_data)
-                ); 
+                );
 	}
         SDpnt = ScsiPassThruReq->sr_device;
 	/* upper_private_data is already freed in call_scsi_done() */
@@ -653,12 +653,12 @@ int cpqfcTS_ioctl( struct scsi_device *S
         if(  copy_to_user( vendor_cmd->bufp, buf, vendor_cmd->len))
 		result = -EFAULT;
 
-        if( buf) 
+        if( buf)
 	  kfree( buf);
 
         return result;
       }
-      
+
       case CPQFCTS_GETPCIINFO:
       {
 	cpqfc_pci_info_struct pciinfo;
@@ -669,10 +669,10 @@ int cpqfcTS_ioctl( struct scsi_device *S
          	
 	
         pciinfo.bus = cpqfcHBAdata->PciDev->bus->number;
-        pciinfo.dev_fn = cpqfcHBAdata->PciDev->devfn;  
+        pciinfo.dev_fn = cpqfcHBAdata->PciDev->devfn;
 	pciinfo.board_id = cpqfcHBAdata->PciDev->device |
-			  (cpqfcHBAdata->PciDev->vendor <<16); 
-	      
+			  (cpqfcHBAdata->PciDev->vendor <<16);
+	
         if(copy_to_user( arg, &pciinfo, sizeof(cpqfc_pci_info_struct)))
 		return( -EFAULT);
         return 0;
@@ -680,7 +680,7 @@ int cpqfcTS_ioctl( struct scsi_device *S
 
       case CPQFCTS_GETDRIVVER:
       {
-	DriverVer_type DriverVer = 
+	DriverVer_type DriverVer =
 		CPQFCTS_DRIVER_VER( VER_MAJOR,VER_MINOR,VER_SUBMINOR);
 	
 	if( !arg)
@@ -715,21 +715,21 @@ int cpqfcTS_ioctl( struct scsi_device *S
 	}
 	result = access_ok(VERIFY_WRITE, arg, sizeof(Scsi_FCTargAddress)) ? 0 : -EFAULT;
 	if (result) break;
- 
+
       put_user(pLoggedInPort->port_id,
 		&((Scsi_FCTargAddress *) arg)->host_port_id);
- 
+
       for( i=3,j=0; i>=0; i--)   	// copy the LOGIN port's WWN
-        put_user(pLoggedInPort->u.ucWWN[i], 
+        put_user(pLoggedInPort->u.ucWWN[i],
 		&((Scsi_FCTargAddress *) arg)->host_wwn[j++]);
       for( i=7; i>3; i--)		// copy the LOGIN port's WWN
-        put_user(pLoggedInPort->u.ucWWN[i], 
+        put_user(pLoggedInPort->u.ucWWN[i],
 		&((Scsi_FCTargAddress *) arg)->host_wwn[j++]);
         break;
 
 
       case CPQFC_IOCTL_FC_TDR:
-          
+
         result = cpqfcTS_TargetDeviceReset( ScsiDev, 0);
 
         break;
@@ -753,14 +753,14 @@ int cpqfcTS_ioctl( struct scsi_device *S
 
 int cpqfcTS_release(struct Scsi_Host *HostAdapter)
 {
-  CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata; 
+  CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
 
 
   ENTER("cpqfcTS_release");
 	
   DEBUG_PCI( printk(" cpqfcTS: delete timer...\n"));
-  del_timer( &cpqfcHBAdata->cpqfcTStimer);  
-    
+  del_timer( &cpqfcHBAdata->cpqfcTStimer);
+
   // disable the hardware...
   DEBUG_PCI( printk(" disable hardware, destroy queues, free mem\n"));
   cpqfcHBAdata->fcChip.ResetTachyon( cpqfcHBAdata, CLEAR_FCPORTS);
@@ -775,7 +775,7 @@ int cpqfcTS_release(struct Scsi_Host *Ho
     send_sig( SIGKILL, cpqfcHBAdata->worker_thread, 1);
     down( &sem);
     cpqfcHBAdata->notify_wt = NULL;
-    
+
   }
 
   cpqfc_free_private_data_pool(cpqfcHBAdata);
@@ -785,7 +785,7 @@ int cpqfcTS_release(struct Scsi_Host *Ho
   scsi_unregister( HostAdapter);
   release_region( cpqfcHBAdata->fcChip.Registers.IOBaseL, 0xff);
   release_region( cpqfcHBAdata->fcChip.Registers.IOBaseU, 0xff);
- /* we get "vfree: bad address" executing this - need to investigate... 
+ /* we get "vfree: bad address" executing this - need to investigate...
   if( (void*)((unsigned long)cpqfcHBAdata->fcChip.Registers.MemBase) !=
       cpqfcHBAdata->fcChip.Registers.ReMapMemBase)
     vfree( cpqfcHBAdata->fcChip.Registers.ReMapMemBase);
@@ -802,8 +802,8 @@ const char * cpqfcTS_info(struct Scsi_Ho
   static char buf[300];
   CPQFCHBA *cpqfcHBA;
   int BusSpeed, BusWidth;
-  
-  // get the pointer to our Scsi layer HBA buffer  
+
+  // get the pointer to our Scsi layer HBA buffer
   cpqfcHBA = (CPQFCHBA *)HostAdapter->hostdata;
 
   BusWidth = (cpqfcHBA->fcChip.Registers.PCIMCTR &0x4) > 0 ?
@@ -814,13 +814,13 @@ const char * cpqfcTS_info(struct Scsi_Ho
   else
     BusSpeed = 33;
 
-  sprintf(buf, 
+  sprintf(buf,
 "%s: WWN %08X%08X\n on PCI bus %d device 0x%02x irq %d IObaseL 0x%x, MEMBASE 0x%x\nPCI bus width %d bits, bus speed %d MHz\nFCP-SCSI Driver v%d.%d.%d",
-      cpqfcHBA->fcChip.Name, 
+      cpqfcHBA->fcChip.Name,
       cpqfcHBA->fcChip.Registers.wwn_hi,
       cpqfcHBA->fcChip.Registers.wwn_lo,
       cpqfcHBA->PciDev->bus->number,
-      cpqfcHBA->PciDev->device,  
+      cpqfcHBA->PciDev->device,
       HostAdapter->irq,
       cpqfcHBA->fcChip.Registers.IOBaseL,
       cpqfcHBA->fcChip.Registers.MemBase,
@@ -829,7 +829,7 @@ const char * cpqfcTS_info(struct Scsi_Ho
       VER_MAJOR, VER_MINOR, VER_SUBMINOR
 );
 
-  
+
   cpqfcTSDecodeGBICtype( &cpqfcHBA->fcChip, &buf[ strlen(buf)]);
   cpqfcTSGetLPSM( &cpqfcHBA->fcChip, &buf[ strlen(buf)]);
   return buf;
@@ -839,16 +839,16 @@ const char * cpqfcTS_info(struct Scsi_Ho
 // /proc/scsi support. The following routines allow us to do 'normal'
 // sprintf like calls to return the currently requested piece (buflenght
 // chars, starting at bufoffset) of the file. Although procfs allows for
-// a 1 Kb bytes overflow after te supplied buffer, I consider it bad 
+// a 1 Kb bytes overflow after te supplied buffer, I consider it bad
 // programming to use it to make programming a little simpler. This piece
-// of coding is borrowed from ncr53c8xx.c with some modifications 
+// of coding is borrowed from ncr53c8xx.c with some modifications
 //
 struct info_str
 {
         char *buffer;			// Pointer to output buffer
         int buflength;			// It's length
         int bufoffset;			// File offset corresponding with buf[0]
-	int buffillen;			// Current filled length 
+	int buffillen;			// Current filled length
         int filpos;			// Current file offset
 };
 
@@ -895,7 +895,7 @@ static int copy_info(struct info_str *in
 
 // Routine to get data for /proc RAM filesystem
 //
-int cpqfcTS_proc_info (struct Scsi_Host *host, char *buffer, char **start, off_t offset, int length, 
+int cpqfcTS_proc_info (struct Scsi_Host *host, char *buffer, char **start, off_t offset, int length,
 		       int inout)
 {
   struct scsi_cmnd *DumCmnd;
@@ -909,10 +909,10 @@ int cpqfcTS_proc_info (struct Scsi_Host 
 
   if (inout) return -EINVAL;
 
-  // get the pointer to our Scsi layer HBA buffer  
+  // get the pointer to our Scsi layer HBA buffer
   cpqfcHBA = (CPQFCHBA *)host->hostdata;
   fcChip = &cpqfcHBA->fcChip;
-  
+
   *start 	  = buffer;
 
   info.buffer     = buffer;
@@ -920,15 +920,15 @@ int cpqfcTS_proc_info (struct Scsi_Host 
   info.bufoffset  = offset;
   info.filpos     = 0;
   info.buffillen  = 0;
-  copy_info(&info, "Driver version = %d.%d.%d", VER_MAJOR, VER_MINOR, VER_SUBMINOR); 
+  copy_info(&info, "Driver version = %d.%d.%d", VER_MAJOR, VER_MINOR, VER_SUBMINOR);
   cpqfcTSDecodeGBICtype( &cpqfcHBA->fcChip, &buf[0]);
   cpqfcTSGetLPSM( &cpqfcHBA->fcChip, &buf[ strlen(buf)]);
-  copy_info(&info, "%s\n", buf); 
+  copy_info(&info, "%s\n", buf);
 
 #define DISPLAY_WWN_INFO
 #ifdef DISPLAY_WWN_INFO
   ScsiDev = scsi_get_host_dev (host);
-  if (!ScsiDev) 
+  if (!ScsiDev)
     return -ENOMEM;
   DumCmnd = scsi_get_command (ScsiDev, GFP_KERNEL);
   if (!DumCmnd) {
@@ -951,7 +951,7 @@ int cpqfcTS_proc_info (struct Scsi_Host 
           copy_info(&info, "%02X", pLoggedInPort->u.ucWWN[i]);
         for( i=7; i>3; i--)             // copy the LOGIN port's WWN
           copy_info(&info, "%02X", pLoggedInPort->u.ucWWN[i]);
-	copy_info(&info, " port_id: %06X\n", pLoggedInPort->port_id); 
+	copy_info(&info, " port_id: %06X\n", pLoggedInPort->port_id);
       }
     }
   }
@@ -962,18 +962,18 @@ int cpqfcTS_proc_info (struct Scsi_Host 
 
 
 
-  
-  
+
+
 // Unfortunately, the proc_info buffer isn't big enough
 // for everything we would like...
-// For FC stats, compile this and turn off WWN stuff above  
+// For FC stats, compile this and turn off WWN stuff above
 //#define DISPLAY_FC_STATS
 #ifdef DISPLAY_FC_STATS
 // get the Fibre Channel statistics
   {
     int DeltaSecs = (jiffies - cpqfcHBA->fcStatsTime) / HZ;
     int days,hours,minutes,secs;
-    
+
     days = DeltaSecs / (3600*24); // days
     hours = (DeltaSecs% (3600*24)) / 3600; // hours
     minutes = (DeltaSecs%3600 /60); // minutes
@@ -981,21 +981,21 @@ int cpqfcTS_proc_info (struct Scsi_Host 
 copy_info( &info, "Fibre Channel Stats (time dd:hh:mm:ss %02u:%02u:%02u:%02u\n",
       days, hours, minutes, secs);
   }
-    
+
   cpqfcHBA->fcStatsTime = jiffies;  // (for next delta)
 
   copy_info( &info, "  LinkUp           %9u     LinkDown      %u\n",
         fcChip->fcStats.linkUp, fcChip->fcStats.linkDown);
-        
+
   copy_info( &info, "  Loss of Signal   %9u     Loss of Sync  %u\n",
     fcChip->fcStats.LossofSignal, fcChip->fcStats.LossofSync);
-		  
+		
   copy_info( &info, "  Discarded Frames %9u     Bad CRC Frame %u\n",
     fcChip->fcStats.Dis_Frm, fcChip->fcStats.Bad_CRC);
 
   copy_info( &info, "  TACH LinkFailTX  %9u     TACH LinkFailRX     %u\n",
     fcChip->fcStats.linkFailTX, fcChip->fcStats.linkFailRX);
-  
+
   copy_info( &info, "  TACH RxEOFa      %9u     TACH Elastic Store  %u\n",
     fcChip->fcStats.Rx_EOFa, fcChip->fcStats.e_stores);
 
@@ -1003,11 +1003,11 @@ copy_info( &info, "Fibre Channel Stats (
     fcChip->fcStats.BB0_Timer*10, fcChip->fcStats.FMinits );
 	
   copy_info( &info, "  FC-2 Timeouts    %9u     FC-2 Logouts  %u\n",
-    fcChip->fcStats.timeouts, fcChip->fcStats.logouts); 
-        
+    fcChip->fcStats.timeouts, fcChip->fcStats.logouts);
+
   copy_info( &info, "  FC-2 Aborts      %9u     FC-4 Aborts   %u\n",
     fcChip->fcStats.FC2aborted, fcChip->fcStats.FC4aborted);
-   
+
   // clear the counters
   cpqfcTSClearLinkStatusCounters( fcChip);
 #endif
@@ -1172,7 +1172,7 @@ Original code from M. McGowen, Compaq
 void cpqfcTS_print_scsi_cmd(Scsi_Cmnd * cmd)
 {
 
-printk("cpqfcTS: (%s) chnl 0x%02x, trgt = 0x%02x, lun = 0x%02x, cmd_len = 0x%02x\n", 
+printk("cpqfcTS: (%s) chnl 0x%02x, trgt = 0x%02x, lun = 0x%02x, cmd_len = 0x%02x\n",
     ScsiToAscii( cmd->cmnd[0]), cmd->channel, cmd->target, cmd->lun, cmd->cmd_len);
 
 if( cmd->cmnd[0] == 0)   // Test Unit Ready?
@@ -1248,7 +1248,7 @@ static void QueLinkDownCmnd( CPQFCHBA *c
 
 // The file <scsi/scsi_host.h> says not to call scsi_done from
 // inside _queuecommand, so we'll do it from the heartbeat timer
-// (clarification: Turns out it's ok to call scsi_done from queuecommand 
+// (clarification: Turns out it's ok to call scsi_done from queuecommand
 // for cases that don't go to the hardware like scsi cmds destined
 // for LUNs we know don't exist, so this code might be simplified...)
 
@@ -1278,7 +1278,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
   struct Scsi_Host *HostAdapter = Cmnd->device->host;
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
   PTACHYON fcChip = &cpqfcHBAdata->fcChip;
-  TachFCHDR_GCMND fchs;  // only use for FC destination id field  
+  TachFCHDR_GCMND fchs;  // only use for FC destination id field
   PFC_LOGGEDIN_PORT pLoggedInPort;
   ULONG ulStatus, SESTtype;
   LONG ExchangeID;
@@ -1287,23 +1287,23 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
 
 
   ENTER("cpqfcTS_queuecommand");
-      
+
   PCI_TRACEO( (ULONG)Cmnd, 0x98)
-      
-  
+
+
   Cmnd->scsi_done = done;
-#ifdef DEBUG_CMND  
+#ifdef DEBUG_CMND
   cpqfcTS_print_scsi_cmd( Cmnd);
 #endif
 
-  // prevent board contention with kernel thread...  
-  
+  // prevent board contention with kernel thread...
+
    if( cpqfcHBAdata->BoardLock )
   {
 //    printk(" @BrdLck Hld@ ");
     QueCmndOnBoardLock( cpqfcHBAdata, Cmnd);
   }
-  
+
   else
   {
 
@@ -1312,20 +1312,20 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
     // we might have something pending in the LinkQ, which
     // might cause the WorkerTask to run.  In case that
     // happens, make sure we lock it out.
-    
-    
-    
-    PCI_TRACE( 0x98) 
+
+
+
+    PCI_TRACE( 0x98)
     CPQ_SPINLOCK_HBA( cpqfcHBAdata)
-    PCI_TRACE( 0x98) 
-	    
+    PCI_TRACE( 0x98)
+	
   // can we find an FC device mapping to this SCSI target?
     pLoggedInPort = fcFindLoggedInPort( fcChip,
       Cmnd,     // search Scsi Nexus
       0,        // DON'T search linked list for FC port id
       NULL,     // DON'T search linked list for FC WWN
       NULL);    // DON'T care about end of list
- 
+
     if( pLoggedInPort == NULL )      // not found!
     {
 //    printk(" @Q bad targ cmnd %p@ ", Cmnd);
@@ -1335,7 +1335,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
     {
       printk(KERN_WARNING "cpqfc: Invalid LUN: %d\n", Cmnd->device->lun);
       QueBadTargetCmnd( cpqfcHBAdata, Cmnd);
-    } 
+    }
 
     else  // we know what FC device to send to...
     {
@@ -1352,7 +1352,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
 
     // In this case (previous login OK), the device is temporarily
     // unavailable waiting for re-login, in which case we expect it
-    // to be back in between 25 - 500ms.  
+    // to be back in between 25 - 500ms.
     // If the FC port doesn't log back in within several seconds
     // (i.e. implicit "logout"), or we get an explicit logout,
     // we set "device_blocked" in Scsi_Device struct; in this
@@ -1376,15 +1376,15 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
 
         if( Cmnd->cmnd[0] == WRITE_10 ||
   	  Cmnd->cmnd[0] == WRITE_6 ||
-	  Cmnd->cmnd[0] == WRITE_BUFFER ||      
-	  Cmnd->cmnd[0] == VENDOR_WRITE_OPCODE ||  // CPQ specific 
+	  Cmnd->cmnd[0] == WRITE_BUFFER ||
+	  Cmnd->cmnd[0] == VENDOR_WRITE_OPCODE ||  // CPQ specific
 	  Cmnd->cmnd[0] == MODE_SELECT )
         {
           SESTtype = SCSI_IWE; // data from HBA to Device
         }
         else
           SESTtype = SCSI_IRE; // data from Device to HBA
-    	  
+    	
         ulStatus = cpqfcTSBuildExchange(
           cpqfcHBAdata,
           SESTtype,     // e.g. Initiator Read Entry (IRE)
@@ -1393,7 +1393,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
           &ExchangeID );// fcController->fcExchanges index, -1 if failed
 
         if( !ulStatus ) // Exchange setup?
-   
+
         {
           if( cpqfcHBAdata->BoardLock )
           {
@@ -1404,7 +1404,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
 	  ulStatus = cpqfcTSStartExchange( cpqfcHBAdata, ExchangeID );
 	  if( !ulStatus )
           {
-            PCI_TRACEO( ExchangeID, 0xB8) 
+            PCI_TRACEO( ExchangeID, 0xB8)
           // submitted to Tach's Outbound Que (ERQ PI incremented)
           // waited for completion for ELS type (Login frames issued
           // synchronously)
@@ -1416,7 +1416,7 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
             printk("quecommand: cpqfcTSStartExchange failed: %Xh\n", ulStatus );
           }
         }            // end good BuildExchange status
-        
+
         else  // SEST table probably full  -- why? hardware hang?
         {
 	  printk("quecommand: cpqfcTSBuildExchange faild: %Xh\n", ulStatus);
@@ -1427,10 +1427,10 @@ int cpqfcTS_queuecommand(Scsi_Cmnd *Cmnd
     CPQ_SPINUNLOCK_HBA( cpqfcHBAdata)
   }
 	
-  PCI_TRACEO( (ULONG)Cmnd, 0x9C) 
+  PCI_TRACEO( (ULONG)Cmnd, 0x9C)
   LEAVE("cpqfcTS_queuecommand");
   return 0;
-}    
+}
 
 
 // Entry point for upper Scsi layer intiated abort.  Typically
@@ -1449,12 +1449,12 @@ int cpqfcTS_abort(Scsi_Cmnd *Cmnd)
 //	printk(" cpqfcTS_abort called?? \n");
  	return 0;
 }
- 
+
 int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd)
 {
 
   struct Scsi_Host *HostAdapter = Cmnd->device->host;
-  // get the pointer to our Scsi layer HBA buffer  
+  // get the pointer to our Scsi layer HBA buffer
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
   PTACHYON fcChip = &cpqfcHBAdata->fcChip;
   FC_EXCHANGES *Exchanges = fcChip->Exchanges;
@@ -1481,15 +1481,15 @@ int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd)
   {
     if( Exchanges->fcExchange[i].Cmnd == Cmnd )
     {
-      
+
       // found it!
       printk(" x_ID %Xh, type %Xh\n", i, Exchanges->fcExchange[i].type);
 
       Exchanges->fcExchange[i].status = INITIATOR_ABORT; // seconds default
       Exchanges->fcExchange[i].timeOut = 10; // seconds default (changed later)
 
-      // Since we need to immediately return the aborted Cmnd to Scsi 
-      // upper layers, we can't make future reference to any of its 
+      // Since we need to immediately return the aborted Cmnd to Scsi
+      // upper layers, we can't make future reference to any of its
       // fields (e.g the Nexus).
 
       cpqfcTSPutLinkQue( cpqfcHBAdata, BLS_ABTS, &i);
@@ -1502,10 +1502,10 @@ int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd)
   {
     // now search our non-SEST buffers (i.e. Cmnd waiting to
     // start on the HBA or waiting to complete with error for retry).
-    
+
     // first check BadTargetCmnd
     for( i=0; i< CPQFCTS_MAX_TARGET_ID; i++)
-    { 
+    {
       if( cpqfcHBAdata->BadTargetCmnd[i] == Cmnd )
       {
         cpqfcHBAdata->BadTargetCmnd[i] = NULL;
@@ -1518,7 +1518,7 @@ int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd)
 
     for( i=0; i < CPQFCTS_REQ_QUEUE_LEN; i++)
     {
-      if( cpqfcHBAdata->LinkDnCmnd[i] == Cmnd ) 
+      if( cpqfcHBAdata->LinkDnCmnd[i] == Cmnd )
       {
 	cpqfcHBAdata->LinkDnCmnd[i] = NULL;
 	printk("in LinkDnCmnd Q\n");
@@ -1536,18 +1536,18 @@ int cpqfcTS_eh_abort(Scsi_Cmnd *Cmnd)
 	goto Done;
       }
     }
-    
+
     Cmnd->result = DID_ERROR <<16;  // Hmmm...
     printk("Not found! ");
 //    panic("_abort");
   }
-  
+
 Done:
-  
+
 //    panic("_abort");
   LEAVE("cpqfcTS_eh_abort");
   return 0;  // (see scsi.h)
-}    
+}
 
 
 // FCP-SCSI Target Device Reset
@@ -1556,7 +1556,7 @@ Done:
 
 #ifdef SUPPORT_RESET
 
-int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev, 
+int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev,
                                unsigned int reset_flags)
 {
   int timeout = 10*HZ;
@@ -1566,9 +1566,9 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
   Scsi_Cmnd * SCpnt;
   Scsi_Device * SDpnt;
 
-// FIXME, cpqfcTS_TargetDeviceReset needs to be fixed 
-// similarly to how the passthrough ioctl was fixed 
-// around the 2.5.30 kernel.  Scsi_Cmnd replaced with 
+// FIXME, cpqfcTS_TargetDeviceReset needs to be fixed
+// similarly to how the passthrough ioctl was fixed
+// around the 2.5.30 kernel.  Scsi_Cmnd replaced with
 // Scsi_Request, etc.
 // For now, so people don't fall into a hole...
 
@@ -1583,7 +1583,7 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
   SCpnt = scsi_get_command(ScsiDev, GFP_KERNEL);
   {
     CPQFC_DECLARE_COMPLETION(wait);
-    
+
     SCpnt->SCp.buffers_residual = FCP_TARGET_RESET;
 
 	// FIXME: this would panic, SCpnt->request would be NULL.
@@ -1592,7 +1592,7 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 	CPQFC_WAIT_FOR_COMPLETION(&wait);
 	SCpnt->request->CPQFC_WAITING = NULL;
   }
-    
+
 
       if(driver_byte(SCpnt->result) != 0)
 	  switch(SCpnt->sense_buffer[2] & 0xf) {
@@ -1600,7 +1600,7 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 	    if(cmd[0] == ALLOW_MEDIUM_REMOVAL) dev->lockable = 0;
 	    else printk("SCSI device (ioctl) reports ILLEGAL REQUEST.\n");
 	    break;
-	case NOT_READY: // This happens if there is no disc in drive 
+	case NOT_READY: // This happens if there is no disc in drive
 	    if(dev->removable && (cmd[0] != TEST_UNIT_READY)){
 		printk(KERN_INFO "Device not ready.  Make sure there is a disc in the drive.\n");
 		break;
@@ -1609,8 +1609,8 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 	    if (dev->removable){
 		dev->changed = 1;
 		SCpnt->result = 0; // This is no longer considered an error
-		// gag this error, VFS will log it anyway /axboe 
-		// printk(KERN_INFO "Disc change detected.\n"); 
+		// gag this error, VFS will log it anyway /axboe
+		// printk(KERN_INFO "Disc change detected.\n");
 		break;
 	    };
 	default: // Fall through for non-removable media
@@ -1623,7 +1623,7 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 		   sense_class(SCpnt->sense_buffer[0]),
 		   sense_error(SCpnt->sense_buffer[0]),
 		   SCpnt->sense_buffer[2] & 0xf);
-	    
+	
       };
   result = SCpnt->result;
 
@@ -1636,7 +1636,7 @@ int cpqfcTS_TargetDeviceReset( Scsi_Devi
 }
 
 #else
-int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev, 
+int cpqfcTS_TargetDeviceReset( Scsi_Device *ScsiDev,
                                unsigned int reset_flags)
 {
 	return -ENOTSUPP;
@@ -1666,12 +1666,12 @@ int cpqfcTS_biosparam(struct scsi_device
 		sector_t capacity, int ip[])
 {
   int size = capacity;
-  
+
   ENTER("cpqfcTS_biosparam");
   ip[0] = 64;
   ip[1] = 32;
   ip[2] = size >> 11;
-  
+
   if( ip[2] > 1024 )
   {
     ip[0] = 255;
@@ -1681,12 +1681,12 @@ int cpqfcTS_biosparam(struct scsi_device
 
   LEAVE("cpqfcTS_biosparam");
   return 0;
-}    
+}
 
 
 
-irqreturn_t cpqfcTS_intr_handler( int irq, 
-		void *dev_id, 
+irqreturn_t cpqfcTS_intr_handler( int irq,
+		void *dev_id,
 		struct pt_regs *regs)
 {
 
@@ -1713,7 +1713,7 @@ irqreturn_t cpqfcTS_intr_handler( int ir
 
     if( IntPending & 0x4) // "INT" - Tach wrote to IMQ
     {
-      while( (++InfLoopBrk < INFINITE_IMQ_BREAK) && (MoreMessages ==1) ) 
+      while( (++InfLoopBrk < INFINITE_IMQ_BREAK) && (MoreMessages ==1) )
       {
         MoreMessages = CpqTsProcessIMQEntry( HostAdapter); // ret 0 when done
       }
@@ -1725,7 +1725,7 @@ irqreturn_t cpqfcTS_intr_handler( int ir
 
       else  // working normally - re-enable INTs and continue
         writeb( 0x1F, cpqfcHBA->fcChip.Registers.INTEN.address);
-    
+
     }  // (...ProcessIMQEntry() clears INT by writing IMQ consumer)
     else  // indications of errors or problems...
           // these usually indicate critical system hardware problems.
@@ -1753,11 +1753,11 @@ irqreturn_t cpqfcTS_intr_handler( int ir
 		if (pcistat & 0x0800) printk("Signalled Target Abort\n");
 	}
 	if (IntStat & 0x4) printk("(INT)\n");
-	if (IntStat & 0x8) 
+	if (IntStat & 0x8)
 		printk("CRS: PCI master address crossed 46 bit bouandary\n");
 	if (IntStat & 0x10) printk("MRE: external memory parity error.\n");
       }
-    }      
+    }
   }
   spin_unlock_irqrestore( HostAdapter->host_lock, flags);
   LEAVE("intr_handler");
@@ -1774,22 +1774,22 @@ int cpqfcTSDecodeGBICtype( PTACHYON fcCh
         // GPIO1, GPIO0, GPIO4 for MD2, MD1, MD0.  The input states appear
         // to be inverted -- i.e., a setting of 111 is read when there is NO
         // GBIC present.  The Module Def (MD) spec says 000 is "no GBIC"
-        // Hard code the bit states to detect Copper, 
+        // Hard code the bit states to detect Copper,
         // Long wave (single mode), Short wave (multi-mode), and absent GBIC
 
   ULONG ulBuff;
 
   sprintf( cErrorString, "\nGBIC detected: ");
 
-  ulBuff = fcChip->Registers.TYstatus.value & 0x13; 
+  ulBuff = fcChip->Registers.TYstatus.value & 0x13;
   switch( ulBuff )
   {
   case 0x13:  // GPIO4, GPIO1, GPIO0 = 111; no GBIC!
     sprintf( &cErrorString[ strlen( cErrorString)],
             "NONE! ");
-    return FALSE;          
-          
-       
+    return FALSE;
+
+
   case 0x11:   // Copper GBIC detected
     sprintf( &cErrorString[ strlen( cErrorString)],
             "Copper. ");
@@ -1806,7 +1806,7 @@ int cpqfcTSDecodeGBICtype( PTACHYON fcCh
   default:     // unknown GBIC - presumably it will work (?)
     sprintf( &cErrorString[ strlen( cErrorString)],
             "Unknown. ");
-          
+
     break;
   }  // end switch GBIC detection
 
@@ -1826,13 +1826,13 @@ int cpqfcTSGetLPSM( PTACHYON fcChip, cha
 
   int LinkUp;
 
-  if( fcChip->Registers.FMstatus.value & 0x80 ) 
+  if( fcChip->Registers.FMstatus.value & 0x80 )
     LinkUp = FALSE;
   else
     LinkUp = TRUE;
 
   sprintf( &cErrorString[ strlen( cErrorString)],
-    " LPSM %Xh ", 
+    " LPSM %Xh ",
      (fcChip->Registers.FMstatus.value >>4) & 0xf );
 
 
@@ -1940,7 +1940,7 @@ int cpqfcTSGetLPSM( PTACHYON fcChip, cha
 // we need about 8 allocations per HBA.  Figuring at most 10 HBAs per server
 // size the dynamic_mem array at 80.
 
-void* fcMemManager( struct pci_dev *pdev, ALIGNED_MEM *dynamic_mem, 
+void* fcMemManager( struct pci_dev *pdev, ALIGNED_MEM *dynamic_mem,
 		   ULONG n_alloc, ULONG ab, ULONG u32_AlignedAddress,
 			dma_addr_t *dma_handle)
 {
@@ -1964,8 +1964,8 @@ void* fcMemManager( struct pci_dev *pdev
       if( dynamic_mem[i].AlignedAddress == u32_AlignedAddress )
       {
         alloc_address = dynamic_mem[i].BaseAllocated; // 'success' status
-	pci_free_consistent(pdev,dynamic_mem[i].size, 
-				alloc_address, 
+	pci_free_consistent(pdev,dynamic_mem[i].size,
+				alloc_address,
 				dynamic_mem[i].dma_handle);
         dynamic_mem[i].BaseAllocated = 0;   // clear for next use
         dynamic_mem[i].AlignedAddress = 0;
@@ -1980,9 +1980,9 @@ void* fcMemManager( struct pci_dev *pdev
     t_alloc = n_alloc + (ab - allocBoundary); // pad bytes for alignment
 //    printk("pci_alloc_consistent() for Tach alignment: %ld bytes\n", t_alloc);
 
-// (would like to) allow thread block to free pages 
+// (would like to) allow thread block to free pages
     alloc_address =                  // total bytes (NumberOfBytes)
-      pci_alloc_consistent(pdev, t_alloc, &handle); 
+      pci_alloc_consistent(pdev, t_alloc, &handle);
 
                                   // now mask off least sig. bits of address
     if( alloc_address )           // (only if non-NULL)
@@ -1998,11 +1998,11 @@ void* fcMemManager( struct pci_dev *pdev
         {
           dynamic_mem[i].BaseAllocated = alloc_address;// address from O/S
           dynamic_mem[i].dma_handle = handle;
-	  if (dma_handle != NULL) 
+	  if (dma_handle != NULL)
 	  {
-//             printk("handle = %p, ab=%d, boundary = %d, mask=0x%08x\n", 
+//             printk("handle = %p, ab=%d, boundary = %d, mask=0x%08x\n",
 //			handle, ab, allocBoundary, mask);
-	    *dma_handle = (dma_addr_t) 
+	    *dma_handle = (dma_addr_t)
 		((((ULONG)handle) + (ab - allocBoundary)) & mask);
 	  }
           dynamic_mem[i].size = t_alloc;
@@ -2010,12 +2010,12 @@ void* fcMemManager( struct pci_dev *pdev
         }
       }
       ulAddress = (unsigned long)alloc_address;
-      
+
       ulAddress += (ab - allocBoundary);    // add the alignment bytes-
                                             // then truncate address...
       alloc_address = (void*)(ulAddress & mask);
-      
-      dynamic_mem[i].AlignedAddress = 
+
+      dynamic_mem[i].AlignedAddress =
 	(ULONG)(ulAddress & mask); // 32bit Tach address
       memset( alloc_address, 0, n_alloc );  // clear new memory
     }
@@ -2038,11 +2038,11 @@ static Scsi_Host_Template driver_templat
 	.ioctl                  = cpqfcTS_ioctl,
 	.queuecommand           = cpqfcTS_queuecommand,
 	.eh_device_reset_handler   = cpqfcTS_eh_device_reset,
-	.eh_abort_handler       = cpqfcTS_eh_abort, 
-	.bios_param             = cpqfcTS_biosparam, 
+	.eh_abort_handler       = cpqfcTS_eh_abort,
+	.bios_param             = cpqfcTS_biosparam,
 	.can_queue              = CPQFCTS_REQ_QUEUE_LEN,
-	.this_id                = -1, 
-	.sg_tablesize           = SG_ALL, 
+	.this_id                = -1,
+	.sg_tablesize           = SG_ALL,
 	.cmd_per_lun            = CPQFCTS_CMD_PER_LUN,
 	.use_clustering         = ENABLE_CLUSTERING,
 };
