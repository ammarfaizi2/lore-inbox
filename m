Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266920AbUG1OAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUG1OAh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 10:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266921AbUG1OAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 10:00:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6568 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266920AbUG1OAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 10:00:24 -0400
Date: Wed, 28 Jul 2004 09:59:41 -0400
From: Alan Cox <alan@redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: PATCH: fix some 32bit isms
Message-ID: <20040728135941.GA17409@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fairly self explanatory. int is not size_t.
 
Alan 

OSDL Developer Certificate of Origin 1.0 included herein by reference


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/message/fusion/mptbase.c linux-2.6.8-rc2/drivers/message/fusion/mptbase.c
--- linux.vanilla-2.6.8-rc2/drivers/message/fusion/mptbase.c	2004-07-27 19:22:42.000000000 +0100
+++ linux-2.6.8-rc2/drivers/message/fusion/mptbase.c	2004-07-28 14:27:53.603586584 +0100
@@ -2417,7 +2417,7 @@
 	} else {
 		printk(MYIOC_s_ERR_FMT 
 		     "Invalid IOC facts reply, msgLength=%d offsetof=%d!\n",
-		     ioc->name, facts->MsgLength, (offsetof(IOCFactsReply_t,
+		     ioc->name, facts->MsgLength, (int)(offsetof(IOCFactsReply_t,
 		     RequestFrameSize)/sizeof(u32)));
 		return -66;
 	}
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc2/drivers/mtd/inftlmount.c linux-2.6.8-rc2/drivers/mtd/inftlmount.c
--- linux.vanilla-2.6.8-rc2/drivers/mtd/inftlmount.c	2004-07-27 19:22:43.000000000 +0100
+++ linux-2.6.8-rc2/drivers/mtd/inftlmount.c	2004-07-28 14:31:37.711517000 +0100
@@ -58,7 +58,7 @@
 	u8 buf[SECTORSIZE];
 	struct INFTLMediaHeader *mh = &inftl->MediaHdr;
 	struct INFTLPartition *ip;
-	int retlen;
+	size_t retlen;
 
 	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: find_boot_record(inftl=0x%x)\n",
 		(int)inftl);
@@ -288,7 +288,7 @@
 		inftl->PUtable = kmalloc(inftl->nb_blocks * sizeof(u16), GFP_KERNEL);
 		if (!inftl->PUtable) {
 			printk(KERN_WARNING "INFTL: allocation of PUtable "
-				"failed (%d bytes)\n",
+				"failed (%ld bytes)\n",
 				inftl->nb_blocks * sizeof(u16));
 			return -ENOMEM;
 		}
@@ -297,7 +297,7 @@
 		if (!inftl->VUtable) {
 			kfree(inftl->PUtable);
 			printk(KERN_WARNING "INFTL: allocation of VUtable "
-				"failed (%d bytes)\n",
+				"failed (%ld bytes)\n",
 				inftl->nb_blocks * sizeof(u16));
 			return -ENOMEM;
 		}
@@ -348,7 +348,8 @@
 static int check_free_sectors(struct INFTLrecord *inftl, unsigned int address,
 	int len, int check_oob)
 {
-	int i, retlen;
+	int i;
+	size_t retlen;
 	u8 buf[SECTORSIZE + inftl->mbd.mtd->oobsize];
 
 	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: check_free_sectors(inftl=0x%x,"
@@ -382,7 +383,7 @@
  */
 int INFTL_formatblock(struct INFTLrecord *inftl, int block)
 {
-	int retlen;
+	size_t retlen;
 	struct inftl_unittail uci;
 	struct erase_info *instr = &inftl->instr;
 	int physblock;
@@ -551,7 +552,8 @@
 	int chain_length, do_format_chain;
 	struct inftl_unithead1 h0;
 	struct inftl_unittail h1;
-	int i, retlen;
+	int i;
+	size_t retlen;
 	u8 *ANACtable, ANAC;
 
 	DEBUG(MTD_DEBUG_LEVEL3, "INFTL: INFTL_mount(inftl=0x%x)\n", (int)s);
