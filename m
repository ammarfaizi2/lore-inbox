Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSJHTK7>; Tue, 8 Oct 2002 15:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbSJHTKX>; Tue, 8 Oct 2002 15:10:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19984 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263230AbSJHTD0>; Tue, 8 Oct 2002 15:03:26 -0400
Subject: PATCH: fix ibmtr mapping bug
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:00:07 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17yzaR-0004t4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/tokenring/ibmtr.c linux.2.5.41-ac1/drivers/net/tokenring/ibmtr.c
--- linux.2.5.41/drivers/net/tokenring/ibmtr.c	2002-07-20 20:11:25.000000000 +0100
+++ linux.2.5.41-ac1/drivers/net/tokenring/ibmtr.c	2002-10-06 22:05:10.000000000 +0100
@@ -243,7 +243,7 @@
 static void __devinit find_turbo_adapters(int *iolist) {
 	int ram_addr;
 	int index=0;
-	__u32 chanid;
+	void *chanid;
 	int found_turbo=0;
 	unsigned char *tchanid, ctemp;
 	int i,j;
@@ -300,7 +300,7 @@
 		printk("ibmtr::find_turbo_adapters, ibmtr card found at"
 			" %x but not a Turbo model\n",ram_addr);
 #endif
-	iounmap(ram_addr) ; 	
+	iounmap(ram_mapped) ; 	
 	} /* for */
 	for(i=0; i<IBMTR_MAX_ADAPTERS; i++) {
 		if(!turbo_io[i]) break;
