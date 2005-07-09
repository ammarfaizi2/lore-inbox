Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbVGIFtj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbVGIFtj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 01:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbVGIFtj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 01:49:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6594 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263147AbVGIFtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 01:49:39 -0400
Date: Sat, 9 Jul 2005 01:49:35 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: 2.6-mm swapped kmalloc args.
Message-ID: <20050709054935.GA9130@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repeat after me Cris developers..  "Size, then flags."  :-)

aacraid suffers the same affliction.  Yay for type-unsafe interfaces.

Signed-off-by: Dave Jones <davej@redhat.com>


--- 2.6-mm/arch/cris/arch-v32/mm/intmem.c~	2005-07-09 00:13:54 -04:00
+++ 2.6-mm/arch/cris/arch-v32/mm/intmem.c	2005-07-09 00:14:48 -04:00
@@ -28,7 +28,7 @@ static void crisv32_intmem_init(void)
 	static int initiated = 0;
 	if (!initiated) {
 		struct intmem_allocation* alloc =
-		  (struct intmem_allocation*)kmalloc(GFP_KERNEL, sizeof *alloc);
+		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
 		INIT_LIST_HEAD(&intmem_allocations);
 		intmem_virtual = ioremap(MEM_INTMEM_START, MEM_INTMEM_SIZE);
 		initiated = 1;
@@ -57,7 +57,7 @@ void* crisv32_intmem_alloc(unsigned size
 			if (allocation->size > size + alignment) {
 				struct intmem_allocation* alloc =
 					(struct intmem_allocation*)
-					kmalloc(GFP_ATOMIC, sizeof *alloc);
+					kmalloc(sizeof *alloc, GFP_ATOMIC);
 				alloc->status = STATUS_FREE;
 				alloc->size = allocation->size - size - alignment;
 				alloc->offset = allocation->offset + size;
@@ -66,7 +66,7 @@ void* crisv32_intmem_alloc(unsigned size
 				if (alignment) {
 					struct intmem_allocation* tmp;
 					tmp = (struct intmem_allocation*)
-						kmalloc(GFP_ATOMIC, sizeof *tmp);
+						kmalloc(sizeof *tmp, GFP_ATOMIC);
 					tmp->offset = allocation->offset;
 					tmp->size = alignment;
 					tmp->status = STATUS_FREE;

--- 2.6-mm/drivers/scsi/aacraid/commctrl.c~	2005-07-09 00:14:55 -04:00
+++ 2.6-mm/drivers/scsi/aacraid/commctrl.c	2005-07-09 00:15:04 -04:00
@@ -469,7 +469,7 @@ static int aac_send_raw_srb(struct aac_d
 		goto cleanup;
 	}
 
-	user_srbcmd = kmalloc(GFP_KERNEL, fibsize);
+	user_srbcmd = kmalloc(fibsize, GFP_KERNEL);
 	if (!user_srbcmd) {
 		dprintk((KERN_DEBUG"aacraid: Could not make a copy of the srb\n"));
 		rcode = -ENOMEM;
