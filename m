Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268192AbTB1VfP>; Fri, 28 Feb 2003 16:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268201AbTB1VeT>; Fri, 28 Feb 2003 16:34:19 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:53232 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268198AbTB1VdQ>; Fri, 28 Feb 2003 16:33:16 -0500
Date: Fri, 28 Feb 2003 13:34:20 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, haveblue@us.ibm.com
Subject: [PATCH] 7/7 Fix error bounds checking for NUMA-Q
Message-ID: <361490000.1046468060@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Dave Hansen.

Fix simpile bounding error found by some Stanford-checker type thing 
to use the proper MAX_MP_BUSSES define instead of a constant.


diff -urpN -X /home/fletch/.diff.exclude 015-notsc/arch/i386/pci/numa.c 016-numa_pci_fix/arch/i386/pci/numa.c
--- 015-notsc/arch/i386/pci/numa.c	Thu Jan  9 19:15:56 2003
+++ 016-numa_pci_fix/arch/i386/pci/numa.c	Fri Feb 28 08:05:36 2003
@@ -17,7 +17,7 @@ static int __pci_conf1_mq_read (int seg,
 {
 	unsigned long flags;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
@@ -45,7 +45,7 @@ static int __pci_conf1_mq_write (int seg
 {
 	unsigned long flags;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);

