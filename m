Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWDIW2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWDIW2i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 18:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWDIW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 18:28:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:9636 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750948AbWDIW2h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 18:28:37 -0400
From: Neil Brown <neilb@suse.de>
To: Francois Romieu <romieu@fr.zoreil.com>
Date: Mon, 10 Apr 2006 08:28:07 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17465.35447.335927.594545@cse.unsw.edu.au>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to correct ELCR? - was Re: [PATCH 2.6.16] Shared interrupts sometimes lost
In-Reply-To: message from Francois Romieu on Sunday April 9
References: <5Zd5E-3vi-7@gated-at.bofh.it>
	<4437C45E.8010503@shaw.ca>
	<17464.55398.270243.839773@cse.unsw.edu.au>
	<20060409154805.GA9973@electric-eye.fr.zoreil.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday April 9, romieu@fr.zoreil.com wrote:
> Neil Brown <neilb@suse.de> :
> [...]
> 
> Can you send an url for the exact rt2500 sources that you are
> actually using ?
> 
> Just curious :o)

http://rt2x00.serialmonkey.com/rt2500-cvs-daily.tar.gz

(though that may change from day to day... I just checked, and *now*
it is the same as what I started with)

plus a bunch of printks, which I attach for your amusement :-)

NeilBrown


Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .assoc.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .auth.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .auth_rsp.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .connect.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .eeprom.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .md5.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .mlme.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rt2500.ko.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rt2500.mod.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rt2500.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_data.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_info.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_init.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_main.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_tkip.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .rtmp_wep.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .sanity.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .sync.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .tmp_versions
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: .wpa.o.cmd
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: assoc.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: auth.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: auth_rsp.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: connect.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: eeprom.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: md5.o
diff -ur rt2500-cvs-2006040703/Module/mlme.c /root/rt-latest/rt2500-cvs-2006040703/Module/mlme.c
--- rt2500-cvs-2006040703/Module/mlme.c	2006-04-05 13:52:43.000000000 +1000
+++ /root/rt-latest/rt2500-cvs-2006040703/Module/mlme.c	2006-04-07 21:54:14.000000000 +1000
@@ -350,12 +350,19 @@
         This task guarantee only one MlmeHandler will run. 
     ==========================================================================
  */
+extern void dump_prio(PRTMP_ADAPTER A);
 VOID MlmeHandler(
     IN PRTMP_ADAPTER pAd) 
 {
     MLME_QUEUE_ELEM        *Elem = NULL;
     unsigned long flags;
-
+    int loops=0;
+    { int static done = 0;
+    if (!done) {
+	    done = 1;
+	    dump_prio(pAd);
+    }
+    }
     // Only accept MLME and Frame from peer side, no other (control/data) frame should
     // get into this state machine
 
@@ -411,6 +418,14 @@
         {
             printk(KERN_ERR DRV_NAME "ERROR: empty Elem in MlmeQueue\n");
         }
+	loops++;
+	if (loops > 10) {
+		static int done = 0;
+		if (done) break;
+		done=1;
+		dump_prio(pAd);
+		printk("BREAK\n"); break;
+	}
     }
 
     spin_lock_irqsave(&pAd->Mlme.TaskLock,flags);
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: mlme.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rt2500.ko
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rt2500.mod.c
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rt2500.mod.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rt2500.o
diff -ur rt2500-cvs-2006040703/Module/rt2560.h /root/rt-latest/rt2500-cvs-2006040703/Module/rt2560.h
--- rt2500-cvs-2006040703/Module/rt2560.h	2005-10-06 12:53:08.000000000 +1000
+++ /root/rt-latest/rt2500-cvs-2006040703/Module/rt2560.h	2006-04-07 23:42:18.000000000 +1000
@@ -517,6 +517,15 @@
         ULONG		TwakeExpire:1;		// Wakeup timer expired interrupt
 		ULONG		TbcnExpire:1;		// Beacon timer expired interrupt
 #else
+/* 0x169
+ TbcnExpire
+ TxRingTxDone
+ PrioRingTxDone
+ RxDone
+ ExcryptionDone
+ fe14
+  1eb
+*/
         ULONG       TbcnExpire:1;       // Beacon timer expired interrupt
         ULONG       TwakeExpire:1;      // Wakeup timer expired interrupt
         ULONG       TatimwExpire:1;     // Timer of atim window expired interrupt
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rt2560.h.~1.4.~
diff -ur rt2500-cvs-2006040703/Module/rtmp_data.c /root/rt-latest/rt2500-cvs-2006040703/Module/rtmp_data.c
--- rt2500-cvs-2006040703/Module/rtmp_data.c	2005-11-25 22:30:47.000000000 +1100
+++ /root/rt-latest/rt2500-cvs-2006040703/Module/rtmp_data.c	2006-04-08 11:10:21.000000000 +1000
@@ -905,6 +905,25 @@
 	}
 }
 
+void dump_prio(PRTMP_ADAPTER A)
+{
+	int i;
+	u32 u;
+	PTXD_STRUC T;
+	printk("Prio: Index=%d Done=%d\n", A->CurPrioIndex, A->NextPrioDoneIndex);
+	for (i=0; i<PRIO_RING_SIZE; i++) {
+		T=(PTXD_STRUC)(A->PrioRing[i].va_addr);
+		printk("%3d: size=%d FT=%d own=%d vld=%d, rty=%d\n",
+		       i, A->PrioRing[i].size, A->PrioRing[i].FrameType,
+		       T->Owner, T->Valid, T->RetryCount);
+	}
+	printk("\n");
+	RTMP_IO_READ32(A, CSR7, &u);
+	printk("CSR7 is 0x%x\n", u);
+	RTMP_IO_READ32(A, CSR8, &u);
+	printk("CSR8 is 0x%x\n", u);
+}
+
 /*
 	========================================================================
 
@@ -947,10 +966,11 @@
         pTxD = &TxD;
         RTMPDescriptorEndianChange((PUCHAR)pTxD, TYPE_TXD);
 #endif
-
+	//printk("PrioDone for %d\n", pAdapter->NextPrioDoneIndex);
 		// Check for the descriptor ownership
 		if ((pTxD->Owner == DESC_OWN_NIC) || (pTxD->Valid == FALSE))
 		{
+			//printk("..no\n");
 #ifdef BIG_ENDIAN
             RTMPDescriptorEndianChange((PUCHAR)pTxD, TYPE_TXD);
             *pDestTxD = TxD;
@@ -2120,13 +2140,14 @@
     pTxD = &TxD;
     RTMPDescriptorEndianChange((PUCHAR)pTxD, TYPE_TXD);
 #endif
-		
+    printk("Queuing prio for %d\n", pAdapter->CurPrioIndex);
 	if (pTxD->Owner == DESC_OWN_NIC)
 	{
 		// Descriptor owned by NIC. No descriptor avaliable
 		// This should not happen since caller guaranteed.
 		// Make sure to release Prio ring resource
 		spin_unlock_irqrestore(&pAdapter->PrioRingLock, irqflag);
+		printk("...not mine\n");
 		return;
 	}
 	if (pTxD->Valid == TRUE)
@@ -2135,6 +2156,7 @@
 		// This should not happen since caller guaranteed.
 		// Make sure to release Prio ring resource
 		spin_unlock_irqrestore(&pAdapter->PrioRingLock, irqflag);
+		printk("...still valid\n");
 		return;
 	}
 	if (pBuffer == NULL)
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_data.c.~1.35.~
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_data.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_info.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_init.c.~1.27.~
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_init.o
diff -ur rt2500-cvs-2006040703/Module/rtmp_main.c /root/rt-latest/rt2500-cvs-2006040703/Module/rtmp_main.c
--- rt2500-cvs-2006040703/Module/rtmp_main.c	2006-02-25 20:45:51.000000000 +1100
+++ /root/rt-latest/rt2500-cvs-2006040703/Module/rtmp_main.c	2006-04-08 11:09:41.000000000 +1000
@@ -194,7 +194,7 @@
     // register_netdev() will call dev_alloc_name() for us
     // TODO: Remove the following line to keep the default eth%d name
     if (ifname == NULL)
-       strcpy(net_dev->name, "ra%d");
+       strcpy(net_dev->name, "eth%d");
     else
        strncpy(net_dev->name, ifname, IFNAMSIZ);
 
@@ -456,7 +456,7 @@
     int         ret = 0;
 
     DBGPRINT(RT_DEBUG_INFO, "====> RTMPHandleInterrupt\n");
-
+ again:
     // 1. Disable interrupt
 	if (RTMP_TEST_FLAG(pAdapter, fRTMP_ADAPTER_INTERRUPT_IN_USE) && RTMP_TEST_FLAG(pAdapter, fRTMP_ADAPTER_INTERRUPT_ACTIVE))
 	{
@@ -523,6 +523,7 @@
     if (IntSource.field.PrioRingTxDone)
     {
         DBGPRINT(RT_DEBUG_INFO, "====> RTMPHandlePrioRingTxDoneInterrupt\n");
+	printk("Word = %d\n", IntSource.word);
         RTMPHandlePrioRingTxDoneInterrupt(pAdapter);
         ret = 1;
     }
@@ -546,6 +547,7 @@
     if (RTMP_TEST_FLAG(pAdapter, fRTMP_ADAPTER_RESET_IN_PROGRESS))
     {
         ret = 1;
+	printk("Don't enable interrupt\n");
         goto out;
     }
 
@@ -554,12 +556,19 @@
     //
     NICEnableInterrupt(pAdapter);
 
+    RTMP_IO_READ32(pAdapter, CSR7, &IntSource.word);
+    if (IntSource.word & ~0xFE14) {
+	    /*printk("word now %x\n", IntSource.word); */
+	    // goto again;
+    }
     DBGPRINT(RT_DEBUG_INFO, "<==== RTMPHandleInterrupt\n");
 out:
 	if(ret)
 		return IRQ_RETVAL(IRQ_HANDLED);
-	else
+	else {
+//		printk("Nothing handled: %x\n", IntSource.word);
 		return IRQ_RETVAL(IRQ_NONE);
+	}
 }
 
 int rt2500_set_mac_address(struct net_device *net_dev, void *addr)
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_main.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_tkip.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: rtmp_wep.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: sanity.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: sync.o
Only in /root/rt-latest/rt2500-cvs-2006040703/Module: wpa.o

