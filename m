Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUFTOeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUFTOeo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 10:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUFTOeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 10:34:44 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:39081 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S265494AbUFTOem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 10:34:42 -0400
From: Hans-Frieder Vogt <hfvogt@arcor.de>
Reply-To: hfvogt@arcor.de
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.7-bk2 runs faster than linux-2.6.7 ;)
Date: Sun, 20 Jun 2004 16:36:13 +0200
User-Agent: KMail/1.6.1
Cc: len.brown@intel.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406201636.13058.hfvogt@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi List,

I traced the current double-speed issue for 2.6.7-bk2 on x86-64 back to an 
ACPI-change in mpparse.c. The small attached patch solved the issue at least 
on my MSI K8T Neo (Athlon 64 3200+) system.

--- linux-2.6.7-bk2.orig/arch/x86_64/kernel/mpparse.c	2004-06-19 
17:17:15.824315000 +0200
+++ linux-2.6.7-bk2/arch/x86_64/kernel/mpparse.c	2004-06-20 16:02:34.974446912 
+0200
@@ -861,7 +861,7 @@
 
 		for (idx = 0; idx < mp_irq_entries; idx++)
 			if (mp_irqs[idx].mpc_srcbus == MP_ISA_BUS &&
-				(mp_irqs[idx].mpc_dstapic == ioapic) &&
+				(mp_irqs[idx].mpc_dstapic == intsrc.mpc_dstapic) &&
 				(mp_irqs[idx].mpc_srcbusirq == i ||
 				mp_irqs[idx].mpc_dstirq == i))
 					break;

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt (at) arcor (dot) de
