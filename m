Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317603AbSHTXrN>; Tue, 20 Aug 2002 19:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHTXqp>; Tue, 20 Aug 2002 19:46:45 -0400
Received: from tempest.prismnet.com ([209.198.128.6]:52998 "EHLO
	tempest.prismnet.com") by vger.kernel.org with ESMTP
	id <S317603AbSHTXqO>; Tue, 20 Aug 2002 19:46:14 -0400
From: Troy Wilson <tcw@tempest.prismnet.com>
Message-Id: <200208202350.g7KNoBJG036692@tempest.prismnet.com>
Subject: mdelay causes BUG, please use udelay
In-Reply-To: 
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Date: Tue, 20 Aug 2002 18:50:11 -0500 (CDT)
CC: linux-kernel@vger.kernel.org, Martin.Bligh@us.ibm.com, tcw@prismnet.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

  We probably shouldn't be doing this, but we can at least avoid the BUG
caused by doing an mdelay in interrupt context if we change to udelay.

Thanks,

- Troy


diff -urN linux-2.5.31/drivers/net/e1000/e1000_hw.c linux-2.5.31.udelay/drivers/net/e1000/e1000_hw.c
--- linux-2.5.31/drivers/net/e1000/e1000_hw.c	Sat Aug 10 20:41:28 2002
+++ linux-2.5.31.udelay/drivers/net/e1000/e1000_hw.c	Tue Aug 20 18:12:20 2002
@@ -134,7 +134,7 @@
     /* Delay to allow any outstanding PCI transactions to complete before
      * resetting the device
      */ 
-    msec_delay(10);
+    usec_delay(10000);
 
     /* Issue a global reset to the MAC.  This will reset the chip's
      * transmit, receive, DMA, and link units.  It will not effect
