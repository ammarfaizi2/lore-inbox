Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbTA2Awt>; Tue, 28 Jan 2003 19:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264716AbTA2Awt>; Tue, 28 Jan 2003 19:52:49 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:27040 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264715AbTA2Aws>; Tue, 28 Jan 2003 19:52:48 -0500
Message-ID: <3E3727ED.2020400@us.ibm.com>
Date: Tue, 28 Jan 2003 17:01:33 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] fix max PCI bus number
Content-Type: multipart/mixed;
 boundary="------------080107050808070705060804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080107050808070705060804
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The Stanford checker found this.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------080107050808070705060804
Content-Type: text/plain;
 name="numa-max-busnum-2.5.59-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa-max-busnum-2.5.59-0.patch"

--- linux-2.5.59-clean/arch/i386/pci/numa.c	Thu Jan 16 18:21:44 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/pci/numa.c	Tue Jan 28 16:31:18 2003
@@ -17,7 +17,7 @@
 {
 	unsigned long flags;
 
-	if (!value || (bus > 255) || (dev > 31) || (fn > 7) || (reg > 255))
+	if (!value || (bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255))
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);
@@ -45,7 +45,7 @@
 {
 	unsigned long flags;
 
-	if ((bus > 255) || (dev > 31) || (fn > 7) || (reg > 255)) 
+	if ((bus > MAX_MP_BUSSES) || (dev > 31) || (fn > 7) || (reg > 255)) 
 		return -EINVAL;
 
 	spin_lock_irqsave(&pci_config_lock, flags);

--------------080107050808070705060804--

