Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264126AbTCXQcX>; Mon, 24 Mar 2003 11:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264263AbTCXQbP>; Mon, 24 Mar 2003 11:31:15 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:32490 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264270AbTCXQas>; Mon, 24 Mar 2003 11:30:48 -0500
Message-Id: <200303241641.h2OGfw35008208@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:45 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: [x86-64] Add missing tlb flush after change_page_attr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/x86_64/kernel/pci-gart.c linux-2.5/arch/x86_64/kernel/pci-gart.c
--- bk-linus/arch/x86_64/kernel/pci-gart.c	2003-03-08 09:56:51.000000000 +0000
+++ linux-2.5/arch/x86_64/kernel/pci-gart.c	2003-03-18 21:19:53.000000000 +0000
@@ -419,6 +419,7 @@ static __init int init_k8_gatt(agp_kern_
 		panic("Cannot allocate GATT table"); 
 	memset(gatt, 0, gatt_size); 
 	change_page_attr(virt_to_page(gatt), gatt_size/PAGE_SIZE, PAGE_KERNEL_NOCACHE);
+	global_flush_tlb();
 	agp_gatt_table = gatt;
 	
 	for_all_nb(dev) { 
