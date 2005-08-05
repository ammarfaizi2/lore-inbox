Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262949AbVHEKCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVHEKCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262952AbVHEKCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:02:23 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:39875 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S262949AbVHEKCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:02:10 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc5] reduce whitespace bloat in drivers/scsi/cpqfcTScontrol.c
Date: Fri, 5 Aug 2005 12:02:05 +0200
User-Agent: KMail/1.8.1
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508051202.07091@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This file is a ugly mess. But before anyone can go and do some real work it 
has to be cleaned up. This one is a rather straightforward cleanup:

First: s/[ ]+$//;s/memset\([ ]+/memset\(/;s/sizeof\([ ]+/sizeof\(/
Second: kill 2 comments saying that memset(foo, 0, bar) zeros out foo
Third: kill double, triple (and even more) and confusing newlines
Finally: remove some superfluous spaces when the line is changed anyway

It is a functional NOOP, it just shrinks the file by more than 1k.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.13-rc5/drivers/scsi/cpqfcTScontrol.c	2005-08-02 06:45:48.000000000 +0200
+++ linux-2.6.13-rc5/drivers/scsi/cpqfcTScontrol.c.eike	2005-08-05 11:46:56.000000000 +0200
@@ -1,6 +1,6 @@
-/* Copyright 2000, Compaq Computer Corporation 
- * Fibre Channel Host Bus Adapter 
- * 64-bit, 66MHz PCI 
+/* Copyright 2000, Compaq Computer Corporation
+ * Fibre Channel Host Bus Adapter
+ * 64-bit, 66MHz PCI
  * Originally developed and tested on:
  * (front): [chip] Tachyon TS HPFC-5166A/1.2  L2C1090 ...
  *          SP# P225CXCBFIEL6T, Rev XC
@@ -19,10 +19,10 @@
  * Written by Don Zimmerman
 */
 /* These functions control the host bus adapter (HBA) hardware.  The main chip
-   control takes place in the interrupt handler where we process the IMQ 
+   control takes place in the interrupt handler where we process the IMQ
    (Inbound Message Queue).  The IMQ is Tachyon's way of communicating FC link
    events and state information to the driver.  The Single Frame Queue (SFQ)
-   buffers incoming FC frames for processing by the driver.  References to 
+   buffers incoming FC frames for processing by the driver.  References to
    "TL/TS UG" are for:
    "HP HPFC-5100/5166 Tachyon TL/TS ICs User Guide", August 16, 1999, 1st Ed.
    Hewlitt Packard Manual Part Number 5968-1083E.
@@ -52,10 +52,10 @@
 //#define IMQ_DEBUG 1
 
 static void fcParseLinkStatusCounters(TACHYON * fcChip);
-static void CpqTsGetSFQEntry(TACHYON * fcChip, 
-	      USHORT pi, ULONG * buffr, BOOLEAN UpdateChip); 
+static void CpqTsGetSFQEntry(TACHYON * fcChip,
+	      USHORT pi, ULONG * buffr, BOOLEAN UpdateChip);
 
-static void 
+static void
 cpqfc_free_dma_consistent(CPQFCHBA *cpqfcHBAdata)
 {
   	// free up the primary EXCHANGES struct and Link Q
@@ -92,14 +92,13 @@ int CpqTsCreateTachLiteQues( void* pHBA,
   // DMA use.
   ENTER("CreateTachLiteQues");
 
-
   // Allocate primary EXCHANGES array...
   fcChip->Exchanges = NULL;
   cpqfcHBAdata->fcLQ = NULL;
-  
-  /* printk("Allocating %u for %u Exchanges ", 
+
+  /* printk("Allocating %u for %u Exchanges ",
 	  (ULONG)sizeof(FC_EXCHANGES), TACH_MAX_XID); */
-  fcChip->Exchanges = pci_alloc_consistent(cpqfcHBAdata->PciDev, 
+  fcChip->Exchanges = pci_alloc_consistent(cpqfcHBAdata->PciDev,
 			sizeof(FC_EXCHANGES), &fcChip->exch_dma_handle);
   /* printk("@ %p\n", fcChip->Exchanges); */
 
@@ -108,13 +107,11 @@ int CpqTsCreateTachLiteQues( void* pHBA,
     printk("pci_alloc_consistent failure on Exchanges: fatal error\n");
     return -1;
   }
-  // zero out the entire EXCHANGE space
-  memset( fcChip->Exchanges, 0, sizeof( FC_EXCHANGES));  
-
+  memset(fcChip->Exchanges, 0, sizeof(FC_EXCHANGES));
 
   /* printk("Allocating %u for LinkQ ", (ULONG)sizeof(FC_LINK_QUE)); */
   cpqfcHBAdata->fcLQ = pci_alloc_consistent(cpqfcHBAdata->PciDev,
-				 sizeof( FC_LINK_QUE), &cpqfcHBAdata->fcLQ_dma_handle);
+				 sizeof(FC_LINK_QUE), &cpqfcHBAdata->fcLQ_dma_handle);
   /* printk("@ %p (%u elements)\n", cpqfcHBAdata->fcLQ, FC_LINKQ_DEPTH); */
 
   if( cpqfcHBAdata->fcLQ == NULL ) // fatal error!!
@@ -123,10 +120,9 @@ int CpqTsCreateTachLiteQues( void* pHBA,
     printk("pci_alloc_consistent() failure on fc Link Que: fatal error\n");
     return -1;
   }
-  // zero out the entire EXCHANGE space
-  memset( cpqfcHBAdata->fcLQ, 0, sizeof( FC_LINK_QUE));  
-  
-  // Verify that basic Tach I/O registers are not NULL  
+  memset(cpqfcHBAdata->fcLQ, 0, sizeof(FC_LINK_QUE));
+
+  // Verify that basic Tach I/O registers are not NULL
   if( !fcChip->Registers.ReMapMemBase )
   {
     cpqfc_free_dma_consistent(cpqfcHBAdata);
@@ -134,17 +130,15 @@ int CpqTsCreateTachLiteQues( void* pHBA,
     return -1;
   }
 
-
   // Initialize the fcMemManager memory pairs (stores allocated/aligned
   // pairs for future freeing)
-  memset( cpqfcHBAdata->dynamic_mem, 0, sizeof(cpqfcHBAdata->dynamic_mem));
-  
+  memset(cpqfcHBAdata->dynamic_mem, 0, sizeof(cpqfcHBAdata->dynamic_mem));
 
   // Allocate Tach's Exchange Request Queue (each ERQ entry 32 bytes)
-  
-  fcChip->ERQ = fcMemManager( cpqfcHBAdata->PciDev, 
-			&cpqfcHBAdata->dynamic_mem[0], 
-			sizeof( TachLiteERQ ), 32*(ERQ_LEN), 0L, &ERQdma);
+
+  fcChip->ERQ = fcMemManager(cpqfcHBAdata->PciDev,
+			&cpqfcHBAdata->dynamic_mem[0],
+			sizeof(TachLiteERQ), 32*(ERQ_LEN), 0L, &ERQdma);
   if( !fcChip->ERQ )
   {
     cpqfc_free_dma_consistent(cpqfcHBAdata);
@@ -152,7 +146,7 @@ int CpqTsCreateTachLiteQues( void* pHBA,
     return -1;
   }
   fcChip->ERQ->length = ERQ_LEN-1;
-  ulAddr = (ULONG) ERQdma; 
+  ulAddr = (ULONG) ERQdma;
 #if BITS_PER_LONG > 32
   if( (ulAddr >> 32) )
   {
@@ -164,12 +158,11 @@ int CpqTsCreateTachLiteQues( void* pHBA,
 #endif
   fcChip->ERQ->base = (ULONG)ulAddr;  // copy for quick reference
 
-
   // Allocate Tach's Inbound Message Queue (32 bytes per entry)
-  
-  fcChip->IMQ = fcMemManager( cpqfcHBAdata->PciDev, 
+
+  fcChip->IMQ = fcMemManager(cpqfcHBAdata->PciDev,
 		  &cpqfcHBAdata->dynamic_mem[0],
-		  sizeof( TachyonIMQ ), 32*(IMQ_LEN), 0L, &IMQdma );
+		  sizeof(TachyonIMQ), 32*(IMQ_LEN), 0L, &IMQdma);
   if( !fcChip->IMQ )
   {
     cpqfc_free_dma_consistent(cpqfcHBAdata);
@@ -190,11 +183,10 @@ int CpqTsCreateTachLiteQues( void* pHBA,
 #endif
   fcChip->IMQ->base = (ULONG)ulAddr;  // copy for quick reference
 
-
   // Allocate Tach's  Single Frame Queue (64 bytes per entry)
-  fcChip->SFQ = fcMemManager( cpqfcHBAdata->PciDev, 
+  fcChip->SFQ = fcMemManager(cpqfcHBAdata->PciDev,
 		  &cpqfcHBAdata->dynamic_mem[0],
-		  sizeof( TachLiteSFQ ), 64*(SFQ_LEN),0L, &SPQdma );
+		  sizeof(TachLiteSFQ), 64*(SFQ_LEN),0L, &SPQdma);
   if( !fcChip->SFQ )
   {
     cpqfc_free_dma_consistent(cpqfcHBAdata);
@@ -203,7 +195,7 @@ int CpqTsCreateTachLiteQues( void* pHBA,
   }
   fcChip->SFQ->length = SFQ_LEN-1;      // i.e. Que length [# entries -
                                        // min. 32; max.  4096 (0xffff)]
-  
+
   ulAddr = SPQdma;
 #if BITS_PER_LONG > 32
   if( (ulAddr >> 32) )
@@ -216,12 +208,11 @@ int CpqTsCreateTachLiteQues( void* pHBA,
 #endif
   fcChip->SFQ->base = (ULONG)ulAddr;  // copy for quick reference
 
-
   // Allocate SCSI Exchange State Table; aligned nearest @sizeof
   // power-of-2 boundary
   // LIVE DANGEROUSLY!  Assume the boundary for SEST mem will
   // be on physical page (e.g. 4k) boundary.
-  /* printk("Allocating %u for TachSEST for %u Exchanges\n", 
+  /* printk("Allocating %u for TachSEST for %u Exchanges\n",
 		 (ULONG)sizeof(TachSEST), TACH_SEST_LEN); */
   fcChip->SEST = fcMemManager( cpqfcHBAdata->PciDev,
 		  &cpqfcHBAdata->dynamic_mem[0],
@@ -237,10 +228,10 @@ int CpqTsCreateTachLiteQues( void* pHBA,
   for( i=0; i < TACH_SEST_LEN; i++)  // for each exchange
       fcChip->SEST->sgPages[i] = NULL;
 
-  fcChip->SEST->length = TACH_SEST_LEN;  // e.g. DON'T subtract one 
+  fcChip->SEST->length = TACH_SEST_LEN;  // e.g. DON'T subtract one
                                        // (TL/TS UG, pg 153)
 
-  ulAddr = SESTdma; 
+  ulAddr = SESTdma;
 #if BITS_PER_LONG > 32
   if( (ulAddr >> 32) )
   {
@@ -252,28 +243,25 @@ int CpqTsCreateTachLiteQues( void* pHBA,
 #endif
   fcChip->SEST->base = (ULONG)ulAddr;  // copy for quick reference
 
-
 			      // Now that structures are defined,
 			      // fill in Tachyon chip registers...
 
 			      // EEEEEEEE  EXCHANGE REQUEST QUEUE
 
-  writel( fcChip->ERQ->base, 
+  writel(fcChip->ERQ->base,
     (fcChip->Registers.ReMapMemBase + TL_MEM_ERQ_BASE));
-      
+
   writel( fcChip->ERQ->length,
     (fcChip->Registers.ReMapMemBase + TL_MEM_ERQ_LENGTH));
-     
 
   fcChip->ERQ->producerIndex = 0L;
   writel( fcChip->ERQ->producerIndex,
     (fcChip->Registers.ReMapMemBase + TL_MEM_ERQ_PRODUCER_INDEX));
-      
 
 		// NOTE! write consumer index last, since the write
 		// causes Tachyon to process the other registers
 
-  ulAddr = ((unsigned long)&fcChip->ERQ->consumerIndex - 
+  ulAddr = ((unsigned long)&fcChip->ERQ->consumerIndex -
 		(unsigned long)fcChip->ERQ) + (unsigned long) ERQdma;
 
   // NOTE! Tachyon DMAs to the ERQ consumer Index host
@@ -281,15 +269,13 @@ int CpqTsCreateTachLiteQues( void* pHBA,
   writel( (ULONG)ulAddr,
     (fcChip->Registers.ReMapMemBase + TL_MEM_ERQ_CONSUMER_INDEX_ADR));
 
-
-
 				 // IIIIIIIIIIIII  INBOUND MESSAGE QUEUE
 				 // Tell Tachyon where the Que starts
 
   // set the Host's pointer for Tachyon to access
 
   /* printk("  cpqfcTS: writing IMQ BASE %Xh  ", fcChip->IMQ->base ); */
-  writel( fcChip->IMQ->base, 
+  writel(fcChip->IMQ->base,
     (fcChip->Registers.ReMapMemBase + IMQ_BASE));
 
   writel( fcChip->IMQ->length,
@@ -298,11 +284,10 @@ int CpqTsCreateTachLiteQues( void* pHBA,
   writel( fcChip->IMQ->consumerIndex,
     (fcChip->Registers.ReMapMemBase + IMQ_CONSUMER_INDEX));
 
-
 		// NOTE: TachLite DMAs to the producerIndex host address
 		// must be correctly aligned with address bits 1-0 cleared
     // Writing the BASE register clears the PI register, so write it last
-  ulAddr = ((unsigned long)&fcChip->IMQ->producerIndex - 
+  ulAddr = ((unsigned long)&fcChip->IMQ->producerIndex -
 		(unsigned long)fcChip->IMQ) + (unsigned long) IMQdma;
 
 #if BITS_PER_LONG > 32
@@ -317,43 +302,37 @@ int CpqTsCreateTachLiteQues( void* pHBA,
 #if DBG
   printk("  PI %Xh\n", (ULONG)ulAddr );
 #endif
-  writel( (ULONG)ulAddr, 
+  writel( (ULONG)ulAddr,
     (fcChip->Registers.ReMapMemBase + IMQ_PRODUCER_INDEX));
 
-
-
 				 // SSSSSSSSSSSSSSS SINGLE FRAME SEQUENCE
 				 // Tell TachLite where the Que starts
 
-  writel( fcChip->SFQ->base, 
+  writel(fcChip->SFQ->base,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SFQ_BASE));
 
   writel( fcChip->SFQ->length,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SFQ_LENGTH));
 
-
          // tell TachLite where SEST table is & how long
   writel( fcChip->SEST->base,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SEST_BASE));
 
   /* printk("  cpqfcTS: SEST %p(virt): Wrote base %Xh @ %p\n",
-    fcChip->SEST, fcChip->SEST->base, 
+    fcChip->SEST, fcChip->SEST->base,
     fcChip->Registers.ReMapMemBase + TL_MEM_SEST_BASE); */
 
   writel( fcChip->SEST->length,
     (fcChip->Registers.ReMapMemBase + TL_MEM_SEST_LENGTH));
-      
+
   writel( (TL_EXT_SG_PAGE_COUNT-1),
     (fcChip->Registers.ReMapMemBase + TL_MEM_SEST_SG_PAGE));
 
-
   LEAVE("CreateTachLiteQues");
 
   return iStatus;
 }
 
-
-
 // function to return TachLite to Power On state
 // 1st - reset tachyon ('SOFT' reset)
 // others - future
@@ -366,15 +345,14 @@ int CpqTsResetTachLite(void *pHBA, int t
   int ret_status=0; // def. success
 
   ENTER("ResetTach");
-  
+
   switch(type)
   {
-
     case CLEAR_FCPORTS:
 
       // in case he was running previously, mask Tach's interrupt
       writeb( 0, (fcChip->Registers.ReMapMemBase + IINTEN));
-      
+
      // de-allocate mem for any Logged in ports
       // (e.g., our module is unloading)
       // search the forward linked list, de-allocating
@@ -405,20 +383,18 @@ int CpqTsResetTachLite(void *pHBA, int t
                               // However, CPQ 64-bit HBAs have a "health
                               // circuit" which keeps laser ON for a brief
                               // period after it is turned off ( < 1s)
-      
-      fcChip->LaserControl( fcChip->Registers.ReMapMemBase, 0);
-  
 
+      fcChip->LaserControl(fcChip->Registers.ReMapMemBase, 0);
 
             // soft reset timing constraints require:
             //   1. set RST to 1
-            //   2. read SOFTRST register 
+            //   2. read SOFTRST register
             //      (128 times per R. Callison code)
             //   3. clear PCI ints
             //   4. clear RST to 0
       writel( 0xff000001L,
         (fcChip->Registers.ReMapMemBase + TL_MEM_SOFTRST));
-        
+
       for( i=0; i<128; i++)
         ulBuff = readl( fcChip->Registers.ReMapMemBase + TL_MEM_SOFTRST);
 
@@ -426,15 +402,13 @@ int CpqTsResetTachLite(void *pHBA, int t
       for( i=0; i<8; i++)
   	writel( 0, (fcChip->Registers.ReMapMemBase + TL_MEM_SOFTRST));
 
-               
-
 			       // clear out our copy of Tach regs,
 			       // because they must be invalid now,
 			       // since TachLite reset all his regs.
       CpqTsDestroyTachLiteQues(cpqfcHBAdata,0); // remove Host-based Que structs
       cpqfcTSClearLinkStatusCounters(fcChip);  // clear our s/w accumulators
                                // lower bits give GBIC info
-      fcChip->Registers.TYstatus.value = 
+      fcChip->Registers.TYstatus.value =
 	              readl( fcChip->Registers.TYstatus.address );
       break;
 
@@ -454,11 +428,6 @@ int CpqTsResetTachLite(void *pHBA, int t
   return ret_status;
 }
 
-
-
-
-
-
 // 'addrBase' is IOBaseU for both TachLite and (older) Tachyon
 int CpqTsLaserControl( void* addrBase, int opcode )
 {
@@ -474,10 +443,6 @@ int CpqTsLaserControl( void* addrBase, i
   return 0;
 }
 
-
-
-
-
 // Use controller's "Options" field to determine loopback mode (if any)
 //   internal loopback (silicon - no GBIC)
 //   external loopback (GBIC - no FC loop)
@@ -497,17 +462,15 @@ int CpqTsInitializeFrameManager( void *p
   // TL/TS UG, pg. 184
   // 0x0065 = 100ms for RT_TOV
   // 0x01f5 = 500ms for ED_TOV
-  // 0x07D1 = 2000ms 
-  fcChip->Registers.ed_tov.value = 0x006507D1; 
+  // 0x07D1 = 2000ms
+  fcChip->Registers.ed_tov.value = 0x006507D1;
   writel( fcChip->Registers.ed_tov.value,
     (fcChip->Registers.ed_tov.address));
-      
 
   // Set LP_TOV to the FC-AL2 specified 2 secs.
   // TL/TS UG, pg. 185
   writel( 0x07d00010, fcChip->Registers.ReMapMemBase +TL_MEM_FM_TIMEOUT2);
 
-
   // Now try to read the WWN from the adapter's NVRAM
   iStatus = CpqTsReadWriteWWN( fcChip, 1); // '1' for READ
 
@@ -522,22 +485,20 @@ int CpqTsInitializeFrameManager( void *p
     fcChip->Registers.wwn_lo = 0x44556677L;
   }
 
-  
-  writel( fcChip->Registers.wwn_hi, 
+  writel(fcChip->Registers.wwn_hi,
 	  fcChip->Registers.ReMapMemBase + TL_MEM_FM_WWN_HI);
-  
-  writel( fcChip->Registers.wwn_lo, 
+
+  writel(fcChip->Registers.wwn_lo,
 	  fcChip->Registers.ReMapMemBase + TL_MEM_FM_WWN_LO);
-	  
 
   // readback for verification:
-  wwnHi = readl( fcChip->Registers.ReMapMemBase + TL_MEM_FM_WWN_HI ); 
-          
+  wwnHi = readl(fcChip->Registers.ReMapMemBase + TL_MEM_FM_WWN_HI );
+
   wwnLo = readl( fcChip->Registers.ReMapMemBase + TL_MEM_FM_WWN_LO);
   // test for correct chip register WRITE/READ
   DEBUG_PCI( printk("  WWN %08X%08X\n",
     fcChip->Registers.wwn_hi, fcChip->Registers.wwn_lo ) );
-    
+
   if( wwnHi != fcChip->Registers.wwn_hi ||
       wwnLo != fcChip->Registers.wwn_lo )
   {
@@ -545,8 +506,6 @@ int CpqTsInitializeFrameManager( void *p
     return -1; // FAILED!
   }
 
-
-
 			// set Frame Manager Initialize command
   fcChip->Registers.FMcontrol.value = 0x06;
 
@@ -570,32 +529,27 @@ int CpqTsInitializeFrameManager( void *p
 
   writel( fcChip->Registers.FMconfig.value,
     fcChip->Registers.FMconfig.address);
-    
 
 			       // issue INITIALIZE command to FM - ACTION!
   writel( fcChip->Registers.FMcontrol.value,
     fcChip->Registers.FMcontrol.address);
-    
+
   LEAVE("InitializeFrameManager");
-  
+
   return 0;
 }
 
-
-
-
-
 // This "look ahead" function examines the IMQ for occurrence of
 // "type".  Returns 1 if found, 0 if not.
 static int PeekIMQEntry( PTACHYON fcChip, ULONG type)
 {
   ULONG CI = fcChip->IMQ->consumerIndex;
   ULONG PI = fcChip->IMQ->producerIndex; // snapshot of IMQ indexes
-  
+
   while( CI != PI )
   {                             // proceed with search
     if( (++CI) >= IMQ_LEN ) CI = 0; // rollover check
-    
+
     switch( type )
     {
       case ELS_LILP_FRAME:
@@ -604,17 +558,17 @@ static int PeekIMQEntry( PTACHYON fcChip
       // If we find it, check the incoming frame payload (1st word)
       // for LILP frame
         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
-        { 
+        {
           TachFCHDR_GCMND* fchs;
 #error This is too much stack
           ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC Frame
 	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] & 0x0fffL);
 
 	  CpqTsGetSFQEntry( fcChip,
-            SFQpi,        // SFQ producer ndx         
+            SFQpi,        // SFQ producer ndx
 	    ulFibreFrame, // contiguous dest. buffer
 	    FALSE);       // DON'T update chip--this is a "lookahead"
-          
+
 	  fchs = (TachFCHDR_GCMND*)&ulFibreFrame;
           if( fchs->pl[0] == ELS_LILP_FRAME)
 	  {
@@ -624,22 +578,19 @@ static int PeekIMQEntry( PTACHYON fcChip
 	  {
 	    // keep looking...
 	  }
-	}  
+	}
       }
       break;
 
       case OUTBOUND_COMPLETION:
         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x00 )
 	{
-
           // any OCM errors?
           if( fcChip->IMQ->QEntry[CI].word[2] & 0x7a000000L )
             return 1;   	    // found OCM error
 	}
       break;
 
-
-      
       default:
       break;
     }
@@ -647,11 +598,10 @@ static int PeekIMQEntry( PTACHYON fcChip
   return 0; // failed to find "type"
 }
 
-			
 static void SetTachTOV( CPQFCHBA* cpqfcHBAdata)
 {
-  PTACHYON fcChip = &cpqfcHBAdata->fcChip; 
-  
+  PTACHYON fcChip = &cpqfcHBAdata->fcChip;
+
   // TL/TS UG, pg. 184
   // 0x0065 = 100ms for RT_TOV
   // 0x01f5 = 500ms for ED_TOV
@@ -662,26 +612,26 @@ static void SetTachTOV( CPQFCHBA* cpqfcH
   // initialization_timeout.fcal.SANMark-1.fc)
   // We have to use 2sec, 24sec, then 128sec when login/
   // port discovery processes fail to complete.
-  
+
   // when port discovery completes (logins done), we set
   // ED_TOV to 500ms -- this is the normal operational case
   // On the first Link Down, we'll move to 2 secs (7D1 ms)
   if( (fcChip->Registers.ed_tov.value &0xFFFF) <= 0x1f5)
-    fcChip->Registers.ed_tov.value = 0x006507D1; 
-  
+    fcChip->Registers.ed_tov.value = 0x006507D1;
+
   // If we get another LST after we moved TOV to 2 sec,
   // increase to 24 seconds (5DC1 ms) per SANMark!
   else if( (fcChip->Registers.ed_tov.value &0xFFFF) <= 0x7D1)
-    fcChip->Registers.ed_tov.value = 0x00655DC1; 
+    fcChip->Registers.ed_tov.value = 0x00655DC1;
 
   // If we get still another LST, set the max TOV (Tachyon
   // has only 16 bits for ms timer, so the max is 65.5 sec)
   else if( (fcChip->Registers.ed_tov.value &0xFFFF) <= 0x5DC1)
-    fcChip->Registers.ed_tov.value = 0x0065FFFF; 
+    fcChip->Registers.ed_tov.value = 0x0065FFFF;
 
   writel( fcChip->Registers.ed_tov.value,
     (fcChip->Registers.ed_tov.address));
-  // keep the same 2sec LP_TOV 
+  // keep the same 2sec LP_TOV
   writel( 0x07D00010, fcChip->Registers.ReMapMemBase +TL_MEM_FM_TIMEOUT2);
 }	
 
@@ -706,12 +656,11 @@ static void SetTachTOV( CPQFCHBA* cpqfcH
 //   2. all IMQ messages should be processed before writing the
 //      IMQ consumer index.
 
-
 int CpqTsProcessIMQEntry(void *host)
 {
   struct Scsi_Host *HostAdapter = (struct Scsi_Host *)host;
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA *)HostAdapter->hostdata;
-  PTACHYON fcChip = &cpqfcHBAdata->fcChip; 
+  PTACHYON fcChip = &cpqfcHBAdata->fcChip;
   FC_EXCHANGES *Exchanges = fcChip->Exchanges;
   int iStatus;
   USHORT i, RPCset, DPCset;
@@ -723,7 +672,6 @@ int CpqTsProcessIMQEntry(void *host)
   UCHAR ucInboundMessageType;  // Inbound CM, dword 3 "type" field
 
   ENTER("ProcessIMQEntry");
-   
 
 				// check TachLite's IMQ producer index -
 				// is a new message waiting for us?
@@ -732,12 +680,11 @@ int CpqTsProcessIMQEntry(void *host)
   if( fcChip->IMQ->producerIndex != fcChip->IMQ->consumerIndex )
   {                             // need to process message
 
-
 #ifdef IMQ_DEBUG
-    printk("PI %X, CI %X  type: %X\n", 
+    printk("PI %X, CI %X  type: %X\n",
       fcChip->IMQ->producerIndex,fcChip->IMQ->consumerIndex,
       fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].type);
-#endif                                
+#endif
     // Examine Completion Messages in IMQ
     // what CM_Type?
     switch( (UCHAR)(fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].type
@@ -758,14 +705,11 @@ int CpqTsProcessIMQEntry(void *host)
       //   call fcComplete (to App)
       // ...
 
-
       ulBuff = fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[1];
       x_ID = ulBuff & 0x7fffL;     // lower 14 bits SEST_Index/Trans_ID
                                      // Range check CM OX/RX_ID value...
       if( x_ID < TACH_MAX_XID )   // don't go beyond array space
       {
-
-
 	if( ulBuff & 0x20000000L ) // RPC -Response Phase Complete?
           RPCset = 1;              // (SEST transactions only)
         else
@@ -794,8 +738,7 @@ int CpqTsProcessIMQEntry(void *host)
           if( ulBuff & 0x02000000L )
             dwStatus |= ABORTSEQ_NOTIFY;  // ASN
         }
-
-	  
+	
 	if( dwStatus )          // any errors?
         {
                   // set the Outbound Completion status
@@ -805,12 +748,10 @@ int CpqTsProcessIMQEntry(void *host)
           // reque it in the case of LINKFAIL (it will restart on PDISC)
           if( x_ID < TACH_SEST_LEN )
           {
-
-            printk(" #OCM error %Xh x_ID %X# ", 
+            printk(" #OCM error %Xh x_ID %X# ",
 		    dwStatus, x_ID);
 
 	    Exchanges->fcExchange[x_ID].timeOut = 30000; // seconds default
-                                                 
 
 	    // We Q ABTS for each exchange.
 	    // NOTE: We can get FRAME_TO on bad alpa (device gone).  Since
@@ -821,9 +762,9 @@ int CpqTsProcessIMQEntry(void *host)
 	    if( dwStatus & FRAME_TO ) // check for device removed...
 	    {
 	      if( !(Exchanges->fcExchange[x_ID].status & DEVICE_REMOVED) )
-	      { 
+	      {
 		// presumes device is still there: send ABTS.
-  
+
                 cpqfcTSPutLinkQue( cpqfcHBAdata, BLS_ABTS, &x_ID);
 	      }
 	    }
@@ -842,12 +783,11 @@ int CpqTsProcessIMQEntry(void *host)
         }
           // NOTE: we don't necessarily care about ALL completion messages...
                                       // SCSI resp. complete OR
-        if( ((x_ID < TACH_SEST_LEN) && RPCset)|| 
+        if( ((x_ID < TACH_SEST_LEN) && RPCset)||
              (x_ID >= TACH_SEST_LEN) )  // non-SCSI command
         {
               // exchange done; complete to upper levels with status
               // (if necessary) and free the exchange slot
-            
 
           if( x_ID >= TACH_SEST_LEN ) // Link Service Outbound frame?
                                     // A Request or Reply has been sent
@@ -866,49 +806,40 @@ int CpqTsProcessIMQEntry(void *host)
       }
       else  // ERROR CONDITION!  bogus x_ID in completion message
       {
-
         printk(" ProcessIMQ (OBCM) x_id out of range %Xh\n", x_ID);
-
       }
 
-
-
           // Load the Frame Manager's error counters.  We check them here
           // because presumably the link is up and healthy enough for the
           // counters to be meaningful (i.e., don't check them while loop
           // is initializing).
       fcChip->Registers.FMLinkStatus1.value =    // get TL's counter
         readl(fcChip->Registers.FMLinkStatus1.address);
-                  
+
       fcChip->Registers.FMLinkStatus2.value =    // get TL's counter
         readl(fcChip->Registers.FMLinkStatus2.address);
-            
 
       fcParseLinkStatusCounters( fcChip); // load into 6 s/w accumulators
     break;
 
-
-
     case ERROR_IDLE_COMPLETION:  // TachLite Error Idle...
-    
+
     // We usually get this when the link goes down during heavy traffic.
     // For now, presume that if SEST Exchanges are open, we will
     // get this as our cue to INVALIDATE all SEST entries
     // (and we OWN all the SEST entries).
     // See TL/TS UG, pg. 53
-    
+
       for( x_ID = 0; x_ID < TACH_SEST_LEN; x_ID++)
       {
-
         // Does this VALid SEST entry need to be invalidated for Abort?
-        fcChip->SEST->u[ x_ID].IWE.Hdr_Len &= 0x7FFFFFFF; 
+        fcChip->SEST->u[ x_ID].IWE.Hdr_Len &= 0x7FFFFFFF;
       }
-      
+
       CpqTsUnFreezeTachlite( fcChip, 2); // unfreeze Tachyon, if Link OK
 
     break;
 
-
     case INBOUND_SFS_COMPLETION:  //0x04
           // NOTE! we must process this SFQ message to avoid SFQ filling
           // up and stopping TachLite.  Incoming commands are placed here,
@@ -921,17 +852,15 @@ int CpqTsProcessIMQEntry(void *host)
           //       3 - Unkown Frame
           //       4-F reserved
 
-
       fcChip->SFQ->producerIndex = (USHORT)
         (fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[0] & 0x0fffL);
 
-
       ucInboundMessageType = 0;  // default to useless frame
 
         // we can only process two Types: 1, Unassisted FCP, and 3, Unknown
         // Also, we aren't interested in processing frame fragments
         // so don't Que anything with 'LKF' bit set
-      if( !(fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[2] 
+      if (!(fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[2]
         & 0x40000000) )  // 'LKF' link failure bit clear?
       {
         ucInboundMessageType = (UCHAR)  // ICM DWord3, "Type"
@@ -946,26 +875,26 @@ int CpqTsProcessIMQEntry(void *host)
           // clears SFQ entry from Tachyon buffer; copies to contiguous ulBuff
       CpqTsGetSFQEntry(
         fcChip,                  // i.e. this Device Object
-        (USHORT)fcChip->SFQ->producerIndex,  // SFQ producer ndx         
+        (USHORT)fcChip->SFQ->producerIndex,  // SFQ producer ndx
         ulFibreFrame, TRUE);    // contiguous destination buffer, update chip
-                     
+
         // analyze the incoming frame outside the INT handler...
         // (i.e., Worker)
 
       if( ucInboundMessageType == 1 )
       {
         fchs = (TachFCHDR_GCMND*)ulFibreFrame; // cast to examine IB frame
-        // don't fill up our Q with garbage - only accept FCP-CMND  
+        // don't fill up our Q with garbage - only accept FCP-CMND
         // or XRDY frames
         if( (fchs->d_id & 0xFF000000) == 0x06000000 ) // CMND
         {
 	  // someone sent us a SCSI command
-	  
-//          fcPutScsiQue( cpqfcHBAdata, 
-//                        SFQ_UNASSISTED_FCP, ulFibreFrame); 
+	
+//          fcPutScsiQue(cpqfcHBAdata,
+//                        SFQ_UNASSISTED_FCP, ulFibreFrame);
 	}
 	else if( ((fchs->d_id & 0xFF000000) == 0x07000000) || // RSP (status)
-            (fchs->d_id & 0xFF000000) == 0x05000000 )  // XRDY  
+            (fchs->d_id & 0xFF000000) == 0x05000000 )  // XRDY
 	{
 	  ULONG x_ID;
 	  // Unfortunately, ABTS requires a Freeze on the chip so
@@ -978,77 +907,67 @@ int CpqTsProcessIMQEntry(void *host)
 	  // exchange to complete with errors before the timeout
 	  // expires.  We use a Linux Scsi Cmnd result code that
 	  // causes immediate retry.
-	  
 
 	  // Do we have an open exchange that matches this s_id
 	  // and ox_id?
 	  for( x_ID = 0; x_ID < TACH_SEST_LEN; x_ID++)
 	  {
-            if( (fchs->s_id & 0xFFFFFF) == 
-                 (Exchanges->fcExchange[x_ID].fchs.d_id & 0xFFFFFF) 
+            if( (fchs->s_id & 0xFFFFFF) ==
+                 (Exchanges->fcExchange[x_ID].fchs.d_id & 0xFFFFFF)
 		       &&
-                (fchs->ox_rx_id & 0xFFFF0000) == 
+                (fchs->ox_rx_id & 0xFFFF0000) ==
                  (Exchanges->fcExchange[x_ID].fchs.ox_rx_id & 0xFFFF0000) )
 	    {
     //          printk(" #R/X frame x_ID %08X# ", fchs->ox_rx_id );
               // simulate the anticipated error - since the
 	      // SEST was frozen, frames were lost...
               Exchanges->fcExchange[ x_ID ].status |= SFQ_FRAME;
-              
+
 	      // presumes device is still there: send ABTS.
               cpqfcTSPutLinkQue( cpqfcHBAdata, BLS_ABTS, &x_ID);
 	      break;  // done
 	    }
 	  }
 	}
-	  
+	
       }
-          
       else if( ucInboundMessageType == 3)
       {
-        // FC Link Service frames (e.g. PLOGI, ACC) come in here.  
-        cpqfcTSPutLinkQue( cpqfcHBAdata, SFQ_UNKNOWN, ulFibreFrame); 
-                          
-      }
+        // FC Link Service frames (e.g. PLOGI, ACC) come in here.
+        cpqfcTSPutLinkQue( cpqfcHBAdata, SFQ_UNKNOWN, ulFibreFrame);
 
+      }
       else if( ucInboundMessageType == 2 ) // "bad FCP"?
       {
 #ifdef IMQ_DEBUG
         printk("Bad FCP incoming frame discarded\n");
 #endif
       }
-
       else // don't know this type
       {
-#ifdef IMQ_DEBUG 
+#ifdef IMQ_DEBUG
         printk("Incoming frame discarded, type: %Xh\n", ucInboundMessageType);
 #endif
       }
-        
+
         // Check the Frame Manager's error counters.  We check them here
         // because presumably the link is up and healthy enough for the
         // counters to be meaningful (i.e., don't check them while loop
         // is initializing).
       fcChip->Registers.FMLinkStatus1.value =    // get TL's counter
         readl(fcChip->Registers.FMLinkStatus1.address);
-                  
 
       fcChip->Registers.FMLinkStatus2.value =    // get TL's counter
         readl(fcChip->Registers.FMLinkStatus2.address);
-                
 
       break;
 
-
-
-
                     // We get this CM because we issued a freeze
                     // command to stop outbound frames.  We issue the
                     // freeze command at Link Up time; when this message
                     // is received, the ERQ base can be switched and PDISC
                     // frames can be sent.
 
-      
     case ERQ_FROZEN_COMPLETION:  // note: expect ERQ followed immediately
                                  // by FCP when freezing TL
       fcChip->Registers.TYstatus.value =         // read what's frozen
@@ -1056,43 +975,37 @@ int CpqTsProcessIMQEntry(void *host)
       // (do nothing; wait for FCP frozen message)
       break;
     case FCP_FROZEN_COMPLETION:
-      
+
       fcChip->Registers.TYstatus.value =         // read what's frozen
         readl(fcChip->Registers.TYstatus.address);
-      
+
       // Signal the kernel thread to proceed with SEST modification
       up( cpqfcHBAdata->TachFrozen);
 
       break;
 
-
-
     case INBOUND_C1_TIMEOUT:
     case MFS_BUF_WARN:
     case IMQ_BUF_WARN:
     break;
 
-
-
-
-
         // In older Tachyons, we 'clear' the internal 'core' interrupt state
         // by reading the FMstatus register.  In newer TachLite (Tachyon),
         // we must WRITE the register
         // to clear the condition (TL/TS UG, pg 179)
     case FRAME_MGR_INTERRUPT:
     {
-      PFC_LOGGEDIN_PORT pLoggedInPort; 
+      PFC_LOGGEDIN_PORT pLoggedInPort;
 
-      fcChip->Registers.FMstatus.value = 
+      fcChip->Registers.FMstatus.value =
         readl( fcChip->Registers.FMstatus.address );
-                
+
       // PROBLEM: It is possible, especially with "dumb" hubs that
       // don't automatically LIP on by-pass of ports that are going
-      // away, for the hub by-pass process to destroy critical 
+      // away, for the hub by-pass process to destroy critical
       // ordered sets of a frame.  The result of this is a hung LPSM
       // (Loop Port State Machine), which on Tachyon results in a
-      // (default 2 sec) Loop State Timeout (LST) FM message.  We 
+      // (default 2 sec) Loop State Timeout (LST) FM message.  We
       // want to avoid this relatively huge timeout by detecting
       // likely scenarios which will result in LST.
       // To do this, we could examine FMstatus for Loss of Synchronization
@@ -1103,7 +1016,7 @@ int CpqTsProcessIMQEntry(void *host)
       // of the LST states: ARBITRATING, OPEN, OPENED, XMITTED CLOSE,
       // or RECEIVED CLOSE.  (See TL/TS UG, pg. 181)
       // If any of these LPSM states are detected
-      // in combination with the LIP while LDn is not set, 
+      // in combination with the LIP while LDn is not set,
       // send an FM init (LIP F7,F7 for loops)!
       // It is critical to the physical link stability NOT to reset (LIP)
       // more than absolutely necessary; this is a basic premise of the
@@ -1128,7 +1041,6 @@ int CpqTsProcessIMQEntry(void *host)
 	      // re-init the loop before it hangs itself!
               printk(" #req FMinit on E-S: LPSM %Xh# ",Lpsm);
 
-
 	      fcChip->fcStats.FMinits++;
               writel( 6, fcChip->Registers.FMcontrol.address); // LIP
 	    }
@@ -1137,69 +1049,61 @@ int CpqTsProcessIMQEntry(void *host)
 	else if( fcChip->Registers.FMstatus.value & 0x40000 ) // LST?
 	{
           printk(" #req FMinit on LST, LPSM %Xh# ",Lpsm);
-	 
+	
           fcChip->fcStats.FMinits++;
           writel( 6, fcChip->Registers.FMcontrol.address);  // LIP
-	}  
+	}
       }
 
-
       // clear only the 'interrupting' type bits for this REG read
       writel( (fcChip->Registers.FMstatus.value & 0xff3fff00L),
         fcChip->Registers.FMstatus.address);
-                          
 
                // copy frame manager status to unused ULONG slot
       fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[0] =
           fcChip->Registers.FMstatus.value; // (for debugging)
 
-
           // Load the Frame Manager's error counters.  We check them here
           // because presumably the link is up and healthy enough for the
           // counters to be meaningful (i.e., don't check them while loop
           // is initializing).
       fcChip->Registers.FMLinkStatus1.value =   // get TL's counter
         readl(fcChip->Registers.FMLinkStatus1.address);
-            
+
       fcChip->Registers.FMLinkStatus2.value =   // get TL's counter
         readl(fcChip->Registers.FMLinkStatus2.address);
-          
+
           // Get FM BB_Credit Zero Reg - does not clear on READ
       fcChip->Registers.FMBB_CreditZero.value =   // get TL's counter
         readl(fcChip->Registers.FMBB_CreditZero.address);
-            
-
 
       fcParseLinkStatusCounters( fcChip); // load into 6 s/w accumulators
 
-
                // LINK DOWN
 
       if( fcChip->Registers.FMstatus.value & 0x100L ) // Link DOWN bit
-      {                                 
+      {
 	
 #ifdef IMQ_DEBUG
         printk("LinkDn\n");
 #endif
         printk(" #LDn# ");
-        
+
         fcChip->fcStats.linkDown++;
-        
+
 	SetTachTOV( cpqfcHBAdata);  // must set according to SANMark
 
 	// Check the ERQ - force it to be "empty" to prevent Tach
 	// from sending out frames before we do logins.
 
-
   	if( fcChip->ERQ->producerIndex != fcChip->ERQ->consumerIndex)
 	{
 //	  printk("#ERQ PI != CI#");
-          CpqTsFreezeTachlite( fcChip, 1); // freeze ERQ only	  
+          CpqTsFreezeTachlite(fcChip, 1); // freeze ERQ only	
 	  fcChip->ERQ->producerIndex = fcChip->ERQ->consumerIndex = 0;
- 	  writel( fcChip->ERQ->base, 
+ 	  writel(fcChip->ERQ->base,
 	    (fcChip->Registers.ReMapMemBase + TL_MEM_ERQ_BASE));
           // re-writing base forces ERQ PI to equal CI
-  
 	}
 		
 	// link down transition occurred -- port_ids can change
@@ -1207,12 +1111,11 @@ int CpqTsProcessIMQEntry(void *host)
         // (and any I/O in progress) until PDISC or PLOGI/PRLI
         // completes
         {
-          pLoggedInPort = &fcChip->fcPorts; 
+          pLoggedInPort = &fcChip->fcPorts;
           while( pLoggedInPort ) // for all ports which are expecting
                                  // PDISC after the next LIP, set the
                                  // logoutTimer
           {
-
 	    if( pLoggedInPort->pdisc) // expecting PDISC within 2 sec?
             {
               pLoggedInPort->LOGO_timer = 3;  // we want 2 seconds
@@ -1222,11 +1125,11 @@ int CpqTsProcessIMQEntry(void *host)
                                 // suspend any I/O in progress until
                                 // PDISC received...
             pLoggedInPort->prli = FALSE;   // block FCP-SCSI commands
-	    
+	
             pLoggedInPort = pLoggedInPort->pNextPort;
           }  // ... all Previously known ports checked
         }
-        
+
 	// since any hot plugging device may NOT support LILP frames
 	// (such as early Tachyon chips), clear this flag indicating
 	// we shouldn't use (our copy of) a LILP map.
@@ -1253,7 +1156,7 @@ int CpqTsProcessIMQEntry(void *host)
         {                     // looking for Extended Link Serv.Exchanges
           if( Exchanges->fcExchange[i].type == ELS_PDISC ||
               Exchanges->fcExchange[i].type == ELS_PLOGI ||
-              Exchanges->fcExchange[i].type == ELS_PRLI ) 
+              Exchanges->fcExchange[i].type == ELS_PRLI)
           {
               // ABORT the exchange!
 #ifdef IMQ_DEBUG
@@ -1266,7 +1169,6 @@ int CpqTsProcessIMQEntry(void *host)
             cpqfcTSCompleteExchange( cpqfcHBAdata->PciDev, fcChip, i); // abort on LDn
           }
         }
-
       }
 
              // ################   LINK UP   ##################
@@ -1276,7 +1178,7 @@ int CpqTsProcessIMQEntry(void *host)
           // We need the following code, duplicated from LinkDn condition,
           // because it's possible for the Tachyon to re-initialize (hard
           // reset) without ever getting a LinkDn indication.
-        pLoggedInPort = &fcChip->fcPorts; 
+        pLoggedInPort = &fcChip->fcPorts;
         while( pLoggedInPort )   // for all ports which are expecting
                                  // PDISC after the next LIP, set the
                                  // logoutTimer
@@ -1286,31 +1188,29 @@ int CpqTsProcessIMQEntry(void *host)
             pLoggedInPort->LOGO_timer = 3;  // we want 2 seconds
                                               // but Timer granularity
                                               // is 1 second
-             
+
                                   // suspend any I/O in progress until
                                   // PDISC received...
-
           }
           pLoggedInPort = pLoggedInPort->pNextPort;
         }  // ... all Previously known ports checked
- 
+
           // CpqTs acquired AL_PA in register AL_PA (ACQ_ALPA)
-        fcChip->Registers.rcv_al_pa.value = 
+        fcChip->Registers.rcv_al_pa.value =
           readl(fcChip->Registers.rcv_al_pa.address);
- 
+
 	// Now, if our acquired address is DIFFERENT from our
         // previous one, we are not allow to do PDISC - we
         // must go back to PLOGI, which will terminate I/O in
         // progress for ALL logged in FC devices...
 	// (This is highly unlikely).
 
-	if( (fcChip->Registers.my_al_pa & 0xFF) != 
+	if( (fcChip->Registers.my_al_pa & 0xFF) !=
 	    ((fcChip->Registers.rcv_al_pa.value >> 16) &0xFF) )
 	{
-
 //	  printk(" #our HBA port_id changed!# "); // FC port_id changed!!	
 
-	  pLoggedInPort = &fcChip->fcPorts; 
+	  pLoggedInPort = &fcChip->fcPorts;
           while( pLoggedInPort ) // for all ports which are expecting
                                  // PDISC after the next LIP, set the
                                  // logoutTimer
@@ -1323,9 +1223,8 @@ int CpqTsProcessIMQEntry(void *host)
 	  // when the port_id changes, we must terminate
 	  // all open exchanges.
           cpqfcTSTerminateExchange( cpqfcHBAdata, NULL, PORTID_CHANGED);
-
 	}
-	               
+	
 	// Replace the entire 24-bit port_id.  We only know the
 	// lower 8 bits (alpa) from Tachyon; if a FLOGI is done,
 	// we'll get the upper 16-bits from the FLOGI ACC frame.
@@ -1338,7 +1237,6 @@ int CpqTsProcessIMQEntry(void *host)
         fcChip->Registers.my_al_pa =
           (fcChip->Registers.rcv_al_pa.value >> 16) & 0xFF;
 
-              
               // copy frame manager status to unused ULONG slot
         fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[1] =
           fcChip->Registers.my_al_pa; // (for debugging)
@@ -1354,10 +1252,9 @@ int CpqTsProcessIMQEntry(void *host)
         fcChip->Registers.FMconfig.value = ulBuff; // copy it back
         writel( fcChip->Registers.FMconfig.value,  // put in TachLite
           fcChip->Registers.FMconfig.address);
-            
 
 #ifdef IMQ_DEBUG
-        printk("#LUp %Xh, FMstat 0x%08X#", 
+        printk("#LUp %Xh, FMstat 0x%08X#",
 		fcChip->Registers.my_al_pa, fcChip->Registers.FMstatus.value);
 #endif
 
@@ -1365,7 +1262,6 @@ int CpqTsProcessIMQEntry(void *host)
               // initialization)
         writel( fcChip->Registers.my_al_pa,
           fcChip->Registers.ReMapMemBase +TL_MEM_TACH_My_ID);
-          
 
         fcChip->fcStats.linkUp++;
 
@@ -1374,17 +1270,12 @@ int CpqTsProcessIMQEntry(void *host)
                                      // while link is down)
         ulBuff =                     // just reset TL's counter
                  readl( fcChip->Registers.FMLinkStatus1.address);
-          
+
         ulBuff =                     // just reset TL's counter
                  readl( fcChip->Registers.FMLinkStatus2.address);
 
           // for initiator, need to start verifying ports (e.g. PDISC)
 
-
-
-         
-      
-      
 	CpqTsUnFreezeTachlite( fcChip, 2); // unfreeze Tachlite, if Link OK
 	
 	// Tachyon creates an interesting problem for us on LILP frames.
@@ -1399,16 +1290,13 @@ int CpqTsProcessIMQEntry(void *host)
 	// Processing LILP is required by SANMark
 	udelay( 1000);  // microsec delay waiting for LILP (if it comes)
         if( PeekIMQEntry( fcChip, ELS_LILP_FRAME) )
-	{  // found SFQ LILP, which will post LINKACTIVE	  
+	{  // found SFQ LILP, which will post LINKACTIVE	
 //	  printk("skipping LINKACTIVE post\n");
-
 	}
 	else
-          cpqfcTSPutLinkQue( cpqfcHBAdata, LINKACTIVE, ulFibreFrame);  
+          cpqfcTSPutLinkQue(cpqfcHBAdata, LINKACTIVE, ulFibreFrame);
       }
 
-
-
       // ******* Set Fabric Login indication ********
       if( fcChip->Registers.FMstatus.value & 0x2000 )
       {
@@ -1418,20 +1306,18 @@ int CpqTsProcessIMQEntry(void *host)
       else
         fcChip->Options.fabric = 0;
 
-      
-      
                              // ******* LIP(F8,x) or BAD AL_PA? ********
       if( fcChip->Registers.FMstatus.value & 0x30000L )
       {
                         // copy the error AL_PAs
-        fcChip->Registers.rcv_al_pa.value = 
+        fcChip->Registers.rcv_al_pa.value =
           readl(fcChip->Registers.rcv_al_pa.address);
-            
+
                         // Bad AL_PA?
         if( fcChip->Registers.FMstatus.value & 0x10000L )
         {
           PFC_LOGGEDIN_PORT pLoggedInPort;
-        
+
                        // copy "BAD" al_pa field
           fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[1] =
               (fcChip->Registers.rcv_al_pa.value & 0xff00L) >> 8;
@@ -1441,18 +1327,18 @@ int CpqTsProcessIMQEntry(void *host)
             fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[1], // port id
             NULL,     // DON'T search linked list for FC WWN
             NULL);    // DON'T care about end of list
- 
+
 	  if( pLoggedInPort )
 	  {
             // Just in case we got this BAD_ALPA because a device
-	    // quietly disappeared (can happen on non-managed hubs such 
+	    // quietly disappeared (can happen on non-managed hubs such
 	    // as the Vixel Rapport 1000),
 	    // do an Implicit Logout.  We never expect this on a Logged
 	    // in port (but do expect it on port discovery).
-	    // (As a reasonable alternative, this could be changed to 
+	    // (As a reasonable alternative, this could be changed to
 	    // simply start the implicit logout timer, giving the device
 	    // several seconds to "come back".)
-	    // 
+	    //
 	    printk(" #BAD alpa %Xh# ",
 		   fcChip->IMQ->QEntry[fcChip->IMQ->consumerIndex].word[1]);
             cpqfcTSImplicitLogout( cpqfcHBAdata, pLoggedInPort);
@@ -1475,12 +1361,10 @@ int CpqTsProcessIMQEntry(void *host)
             // don't count e-s if loop is down!
         if( !(USHORT)(fcChip->Registers.FMstatus.value & 0x80) )
           fcChip->fcStats.e_stores++;
-          
       }
     }
     break;
 
-
     case INBOUND_FCP_XCHG_COMPLETION:  // 0x0C
 
     // Remarks:
@@ -1489,7 +1373,7 @@ int CpqTsProcessIMQEntry(void *host)
     // was received with OX_ID 0, we might respond with XFER_RDY with
     // RX_ID 8001.  This would start the SEST controlled data phases.  When
     // all data frames are received, we get this inbound completion. This means
-    // we should send a status frame to complete the status phase of the 
+    // we should send a status frame to complete the status phase of the
     // FCP-SCSI exchange, using the same OX_ID,RX_ID that we used for data
     // frames.
     // See Outbound CM discussion of x_IDs
@@ -1509,7 +1393,7 @@ int CpqTsProcessIMQEntry(void *host)
 
 //#define FCP_COMPLETION_DBG 1
 #ifdef FCP_COMPLETION_DBG
-        printk(" FCP_CM x_ID %Xh, status %Xh, Cmnd %p\n", 
+        printk(" FCP_CM x_ID %Xh, status %Xh, Cmnd %p\n",
           x_ID, ulBuff, Exchanges->fcExchange[x_ID].Cmnd);
 #endif
         if( ulBuff & 0x08000000L ) // RPC -Response Phase Complete - or -
@@ -1521,17 +1405,15 @@ int CpqTsProcessIMQEntry(void *host)
         dwStatus = 0L;
         if( ulBuff & 0x70000000L ) // any errs?
         {
-          
           if( ulBuff & 0x40000000L )
             dwStatus |= LINKFAIL_RX;
-          
+
 	  if( ulBuff & 0x20000000L )
             dwStatus |= COUNT_ERROR;
-          
+
           if( ulBuff & 0x10000000L )
             dwStatus |= OVERFLOW;
         }
-      
 	
 	  // FCP transaction done - copy status
         Exchanges->fcExchange[ x_ID ].status = dwStatus;
@@ -1546,11 +1428,10 @@ int CpqTsProcessIMQEntry(void *host)
           cpqfcTSCompleteExchange( cpqfcHBAdata->PciDev,fcChip, x_ID);
 
         }  // end "RPCset"
-	
         else  // ("target" logic)
         {
             // Tachlite says all data frames have been received - now it's time
-            // to analyze data transfer (successful?), then send a response 
+            // to analyze data transfer (successful?), then send a response
             // frame for this exchange
 
           ulFibreFrame[0] = x_ID; // copy for later reference
@@ -1558,7 +1439,7 @@ int CpqTsProcessIMQEntry(void *host)
           // if this was a TWE, we have to send satus response
           if( Exchanges->fcExchange[ x_ID].type == SCSI_TWE )
 	  {
-//            fcPutScsiQue( cpqfcHBAdata, 
+//            fcPutScsiQue(cpqfcHBAdata,
 //                NEED_FCP_RSP, ulFibreFrame);  // (ulFibreFrame not used here)
 	  }
         }
@@ -1570,9 +1451,6 @@ int CpqTsProcessIMQEntry(void *host)
 
     break;
 
-
-
-
     case INBOUND_SCSI_DATA_COMMAND:
     case BAD_SCSI_FRAME:
     case INB_SCSI_STATUS_COMPLETION:
@@ -1590,28 +1468,25 @@ int CpqTsProcessIMQEntry(void *host)
     if( fcChip->IMQ->producerIndex == fcChip->IMQ->consumerIndex )
     {                           // all Messages are processed -
       iStatus = 0;              // no more messages to process
-
     }
     else
       iStatus = 1;              // more messages to process
 
     // update TachLite's ConsumerIndex... (clears INTA_L)
-    // NOTE: according to TL/TS UG, the 
+    // NOTE: according to TL/TS UG, the
     // "host must return completion messages in sequential order".
     // Does this mean one at a time, in the order received?  We
     // presume so.
 
     writel( fcChip->IMQ->consumerIndex,
       (fcChip->Registers.ReMapMemBase + IMQ_CONSUMER_INDEX));
-		    
+		
 #if IMQ_DEBUG
-    printk("Process IMQ: writing consumer ndx %d\n ", 
+    printk("Process IMQ: writing consumer ndx %d\n",
       fcChip->IMQ->consumerIndex);
-    printk("PI %X, CI %X\n", 
+    printk("PI %X, CI %X\n",
     fcChip->IMQ->producerIndex,fcChip->IMQ->consumerIndex );
 #endif
-  
-
 
   }
   else
@@ -1619,21 +1494,17 @@ int CpqTsProcessIMQEntry(void *host)
    // hmmm... why did we get interrupted/called with no message?
     iStatus = -1;               // nothing to process
 #if IMQ_DEBUG
-    printk("Process IMQ: no message PI %Xh  CI %Xh", 
+    printk("Process IMQ: no message PI %Xh  CI %Xh",
       fcChip->IMQ->producerIndex,
       fcChip->IMQ->consumerIndex);
 #endif
   }
 
   LEAVE("ProcessIMQEntry");
-  
+
   return iStatus;
 }
 
-
-
-
-
 // This routine initializes Tachyon according to the following
 // options (opcode1):
 // 1 - RESTART Tachyon, simulate power on condition by shutting
@@ -1664,20 +1535,17 @@ int CpqTsInitializeTachLite( void *pHBA,
   if( !fcChip->Registers.ReMapMemBase)                // NULL address for card?
     return -1;                         // FATAL error!
 
-
-
   switch( opcode1 )
   {
     case 1:       // restore hardware to power-on (hard) restart
 
 
-      iStatus = fcChip->ResetTachyon( 
+      iStatus = fcChip->ResetTachyon(
 		  cpqfcHBAdata, opcode2); // laser off, reset hardware
 				      // de-allocate aligned buffers
 
-
 /* TBD      // reset FC link Q (producer and consumer = 0)
-      fcLinkQReset(cpqfcHBAdata); 
+      fcLinkQReset(cpqfcHBAdata);
 
 */
 
@@ -1686,7 +1554,7 @@ int CpqTsInitializeTachLite( void *pHBA,
 
     case 2:       // Config PCI/Tachyon registers
       // NOTE: For Tach TL/TS, bit 31 must be set to 1.  For TS chips, a read
-      // of bit 31 indicates state of M66EN signal; if 1, chip may run at 
+      // of bit 31 indicates state of M66EN signal; if 1, chip may run at
       // 33-66MHz  (see TL/TS UG, pg 159)
 
       ulBuff = 0x80000000;  // TachLite Configuration Register
@@ -1700,21 +1568,21 @@ int CpqTsInitializeTachLite( void *pHBA,
 //                           fcChip->Backplane.slot, TLCFGCMD, &ulBuff, 4);
 
       // read back for reference...
-      fcChip->Registers.TYconfig.value = 
+      fcChip->Registers.TYconfig.value =
          readl( fcChip->Registers.TYconfig.address );
 
       // what is the PCI bus width?
       pci_read_config_byte( cpqfcHBAdata->PciDev,
                                 0x43, // PCIMCTR offset
                                 &bBuff);
-      
+
       fcChip->Registers.PCIMCTR = bBuff;
 
       // set string identifying the chip on the circuit board
 
       fcChip->Registers.TYstatus.value =
         readl( fcChip->Registers.TYstatus.address);
-      
+
       {
 // Now that we are supporting multiple boards, we need to change
 // this logic to check for PCI vendor/device IDs...
@@ -1723,12 +1591,11 @@ int CpqTsInitializeTachLite( void *pHBA,
 	ULONG RevId = (fcChip->Registers.TYstatus.value &0x3E0)>>5;
 	UCHAR Minor = (UCHAR)(RevId & 0x3);
 	UCHAR Major = (UCHAR)((RevId & 0x1C) >>2);
-  
+
 	/* printk("  HBA Tachyon RevId %d.%d\n", Major, Minor); */
   	if( (Major == 1) && (Minor == 2) )
         {
 	  sprintf( cpqfcHBAdata->fcChip.Name, STACHLITE66_TS12);
-
 	}
 	else if( (Major == 1) && (Minor == 3) )
         {
@@ -1742,8 +1609,6 @@ int CpqTsInitializeTachLite( void *pHBA,
 	  sprintf( cpqfcHBAdata->fcChip.Name, STACHLITE_UNKNOWN);
       }
 
-
-
     case 3:       // allocate mem, set Tachyon Que registers
       iStatus = CpqTsCreateTachLiteQues( cpqfcHBAdata, opcode2);
 
@@ -1771,18 +1636,14 @@ int CpqTsInitializeTachLite( void *pHBA,
       break;
   }
   LEAVE("InitializeTachLite");
-  
+
   return iStatus;
 }
 
-
-
-
 // Depending on the type of platform memory allocation (e.g. dynamic),
 // it's probably best to free memory in opposite order as it was allocated.
 // Order of allocation: see other function
 
-
 int CpqTsDestroyTachLiteQues( void *pHBA, int opcode)
 {
   CPQFCHBA *cpqfcHBAdata = (CPQFCHBA*)pHBA;
@@ -1804,8 +1665,8 @@ int CpqTsDestroyTachLiteQues( void *pHBA
       // It's possible that extended S/G pages were allocated, mapped, and
       // not cleared due to error conditions or O/S driver termination.
       // Make sure they're all gone.
-      if (Exchanges->fcExchange[i].Cmnd != NULL) 
-      	cpqfc_pci_unmap(cpqfcHBAdata->PciDev, Exchanges->fcExchange[i].Cmnd, 
+      if (Exchanges->fcExchange[i].Cmnd != NULL)
+      	cpqfc_pci_unmap(cpqfcHBAdata->PciDev, Exchanges->fcExchange[i].Cmnd,
 			fcChip, i); // undo DMA mappings.
 
       for (j=fcChip->SEST->sgPages[i] ; j != NULL ; j = next) {
@@ -1815,7 +1676,7 @@ int CpqTsDestroyTachLiteQues( void *pHBA
       fcChip->SEST->sgPages[i] = NULL;
     }
     ulPtr = (unsigned long)fcChip->SEST;
-    vPtr = fcMemManager( cpqfcHBAdata->PciDev, 
+    vPtr = fcMemManager(cpqfcHBAdata->PciDev,
 		    &cpqfcHBAdata->dynamic_mem[0],
 		    0,0, (ULONG)ulPtr, NULL ); // 'free' mem
     fcChip->SEST = 0L;  // null invalid ptr
@@ -1828,9 +1689,8 @@ int CpqTsDestroyTachLiteQues( void *pHBA
 
   if( fcChip->SFQ )
   {
-
     ulPtr = (unsigned long)fcChip->SFQ;
-    vPtr = fcMemManager( cpqfcHBAdata->PciDev, 
+    vPtr = fcMemManager(cpqfcHBAdata->PciDev,
 		    &cpqfcHBAdata->dynamic_mem[0],
 		    0,0, (ULONG)ulPtr, NULL ); // 'free' mem
     fcChip->SFQ = 0L;  // null invalid ptr
@@ -1841,7 +1701,6 @@ int CpqTsDestroyTachLiteQues( void *pHBA
     }
   }
 
-
   if( fcChip->IMQ )
   {
       // clear Indexes to show empty Queue
@@ -1871,19 +1730,15 @@ int CpqTsDestroyTachLiteQues( void *pHBA
       iStatus = -4;
     }
   }
-    
+
   // free up the primary EXCHANGES struct and Link Q
   cpqfc_free_dma_consistent(cpqfcHBAdata);
-  
+
   LEAVE("DestroyTachLiteQues");
-  
+
   return iStatus;     // non-zero (failed) if any memory not freed
 }
 
-
-
-
-
 // The SFQ is an array with SFQ_LEN length, each element (QEntry)
 // with eight 32-bit words.  TachLite places incoming FC frames (i.e.
 // a valid FC frame with our AL_PA ) in contiguous SFQ entries
@@ -1905,7 +1760,7 @@ static void CpqTsGetSFQEntry(
 {
   ULONG total_bytes=0;
   ULONG consumerIndex = fcChip->SFQ->consumerIndex;
-  
+
 				// check passed copy of SFQ producer index -
 				// is a new message waiting for us?
 				// equal indexes means SFS is copied
@@ -1916,7 +1771,7 @@ static void CpqTsGetSFQEntry(
                    // don't allow copies over Fibre Channel defined length!
     if( total_bytes <= 2048 )
     {
-      memcpy( ulDestPtr, 
+      memcpy(ulDestPtr,
               &fcChip->SFQ->QEntry[consumerIndex],
               64 );  // each SFQ entry is 64 bytes
       ulDestPtr += 16;   // advance pointer to next 64 byte block
@@ -1937,10 +1792,8 @@ static void CpqTsGetSFQEntry(
   }
 }
 
-
-
 // TachLite routinely freezes it's core ques - Outbound FIFO, Inbound FIFO,
-// and Exchange Request Queue (ERQ) on error recover - 
+// and Exchange Request Queue (ERQ) on error recover -
 // (e.g. whenever a LIP occurs).  Here
 // we routinely RESUME by clearing these bits, but only if the loop is up
 // to avoid ERROR IDLE messages forever.
@@ -1948,9 +1801,9 @@ static void CpqTsGetSFQEntry(
 void CpqTsUnFreezeTachlite( void *pChip, int type )
 {
   PTACHYON fcChip = (PTACHYON)pChip;
-  fcChip->Registers.TYcontrol.value = 
+  fcChip->Registers.TYcontrol.value =
     readl(fcChip->Registers.TYcontrol.address);
-            
+
   // (bit 4 of value is GBIC LASER)
   // if we 'unfreeze' the core machines before the loop is healthy
   // (i.e. FLT, OS, LS failure bits set in FMstatus)
@@ -1976,14 +1829,13 @@ void CpqTsUnFreezeTachlite( void *pChip,
 
     writel( fcChip->Registers.TYcontrol.value,
       fcChip->Registers.TYcontrol.address);
-              
+
   }
           // readback for verify (TachLite still frozen?)
-  fcChip->Registers.TYstatus.value = 
+  fcChip->Registers.TYstatus.value =
     readl(fcChip->Registers.TYstatus.address);
 }
 
-
 // Whenever an FC Exchange Abort is required, we must manipulate the
 // Host/Tachyon shared memory SEST table.  Before doing this, we
 // must freeze Tachyon, which flushes certain buffers and ensure we
@@ -1994,22 +1846,19 @@ void CpqTsUnFreezeTachlite( void *pChip,
 void CpqTsFreezeTachlite( void *pChip, int type )
 {
   PTACHYON fcChip = (PTACHYON)pChip;
-  fcChip->Registers.TYcontrol.value = 
+  fcChip->Registers.TYcontrol.value =
     readl(fcChip->Registers.TYcontrol.address);
-    
+
                      //set FFA, FEQ - freezes SCSI assist and ERQ
   if( type == 1)    // freeze ERQ only
     fcChip->Registers.TYcontrol.value |= 0x100L; // (bit 4 is laser)
   else              // freeze both FCP assists (SEST) and ERQ
     fcChip->Registers.TYcontrol.value |= 0x300L; // (bit 4 is laser)
-  
+
   writel( fcChip->Registers.TYcontrol.value,
     fcChip->Registers.TYcontrol.address);
-              
-}
-
-
 
+}
 
 // TL has two Frame Manager Link Status Registers, with three 8-bit
 // fields each. These eight bit counters are cleared after each read,
@@ -2022,7 +1871,6 @@ void fcParseLinkStatusCounters(PTACHYON 
   UCHAR bBuff;
   ULONG ulBuff;
 
-
 // The BB0 timer usually increments when TL is initialized, resulting
 // in an initially bogus count.  If our own counter is ZERO, it means we
 // are reading this thing for the first time, so we ignore the first count.
@@ -2032,7 +1880,7 @@ void fcParseLinkStatusCounters(PTACHYON 
   if( fcChip->fcStats.lastBB0timer == 0L)  // TL was reset? (ignore 1st values)
   {
                            // get TL's register counter - the "last" count
-    fcChip->fcStats.lastBB0timer = 
+    fcChip->fcStats.lastBB0timer =
       fcChip->Registers.FMBB_CreditZero.value & 0x00ffffffL;
   }
   else  // subsequent pass - check for rollover
@@ -2045,7 +1893,6 @@ void fcParseLinkStatusCounters(PTACHYON 
       fcChip->fcStats.BB0_Timer += (0x00FFFFFFL - fcChip->fcStats.lastBB0timer);
       fcChip->fcStats.BB0_Timer += ulBuff;  // plus some more
 
-
     }
     else // no rollover -- more counts or no change
     {
@@ -2056,8 +1903,6 @@ void fcParseLinkStatusCounters(PTACHYON 
     fcChip->fcStats.lastBB0timer = ulBuff;
   }
 
-
-
   bBuff = (UCHAR)(fcChip->Registers.FMLinkStatus1.value >> 24);
   fcChip->fcStats.LossofSignal += bBuff;
 
@@ -2067,7 +1912,6 @@ void fcParseLinkStatusCounters(PTACHYON 
   bBuff = (UCHAR)(fcChip->Registers.FMLinkStatus1.value >> 8);
   fcChip->fcStats.LossofSync += bBuff;
 
-
   bBuff = (UCHAR)(fcChip->Registers.FMLinkStatus2.value >> 24);
   fcChip->fcStats.Rx_EOFa += bBuff;
 
@@ -2078,18 +1922,14 @@ void fcParseLinkStatusCounters(PTACHYON 
   fcChip->fcStats.Bad_CRC += bBuff;
 }
 
-
 void cpqfcTSClearLinkStatusCounters(PTACHYON fcChip)
 {
   ENTER("ClearLinkStatusCounters");
-  memset( &fcChip->fcStats, 0, sizeof( FCSTATS));
+  memset(&fcChip->fcStats, 0, sizeof(FCSTATS));
   LEAVE("ClearLinkStatusCounters");
 
 }
 
-
-
-
 // The following function reads the I2C hardware to get the adapter's
 // World Wide Name (WWN).
 // If the WWN is "500805f1fadb43e8" (as printed on the card), the
@@ -2097,7 +1937,7 @@ void cpqfcTSClearLinkStatusCounters(PTAC
 // is fadb43e8.
 // In the NVRAM, the bytes appear as:
 // [2d] ..
-// [2e] .. 
+// [2e] ..
 // [2f] 50
 // [30] 08
 // [31] 05
@@ -2133,7 +1973,7 @@ int CpqTsReadWriteWWN( PVOID pChip, int 
     if( ulBuff )   // NVRAM read successful?
     {
       iStatus = 0; // success!
-      
+
                    // for engineering/ prototype boards, the data may be
                    // invalid (GIGO, usually all "FF"); this prevents the
                    // parse routine from working correctly, which means
@@ -2147,7 +1987,7 @@ int CpqTsReadWriteWWN( PVOID pChip, int 
         for( i= 0; i < 8; i++)
           WWNbuf[i] = nvRam[i +0x2f]; // dangerous! some formats won't work
       }
-      
+
       fcChip->Registers.wwn_hi = 0L;
       fcChip->Registers.wwn_lo = 0L;
       for( i=0; i<4; i++)  // WWN bytes are big endian in NVRAM
@@ -2165,30 +2005,21 @@ int CpqTsReadWriteWWN( PVOID pChip, int 
     }  // done reading
     else
     {
-
       printk( "cpqfcTS: NVRAM read failed\n");
-
     }
   }
-
   else  // WRITE
   {
-
     // NOTE: WRITE not supported & not used in released driver.
 
-   
     printk("ReadWriteNRAM: can't write NVRAM; aborting write\n");
   }
-  
+
   LEAVE("ReadWriteWWN");
   return iStatus;
 }
 
-
-
-
-
-// The following function reads or writes the entire "NVRAM" contents of 
+// The following function reads or writes the entire "NVRAM" contents of
 // the I2C hardware (i.e. the NM24C03).  Note that HP's 5121A (TS 66Mhz)
 // adapter does not use the NM24C03 chip, so this function only works on
 // Compaq's adapters.
@@ -2201,7 +2032,7 @@ int CpqTsReadWriteNVRAM( PVOID pChip, PV
   UCHAR *ucPtr = buf; // cast caller's void ptr to UCHAR array
   int iStatus=-1;  // assume failure
 
-     
+
   if( Read )  // READing NVRAM?
   {
     ulBuff = cpqfcTS_ReadNVRAM(   // TRUE on success
@@ -2210,7 +2041,6 @@ int CpqTsReadWriteNVRAM( PVOID pChip, PV
                 256,            // bytes to write
                 ucPtr );        // source ptr
 
-
     if( ulBuff )
       iStatus = 0; // success
     else
@@ -2220,12 +2050,10 @@ int CpqTsReadWriteNVRAM( PVOID pChip, PV
 #endif
     }
   }  // done reading
-
-  else  // WRITING NVRAM 
+  else  // WRITING NVRAM
   {
-
     printk("cpqfcTS: WRITE of FC Controller's NVRAM disabled\n");
   }
-    
+
   return iStatus;
 }
