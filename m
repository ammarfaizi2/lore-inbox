Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbTILEIL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbTILEIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:08:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:23513 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261532AbTILEIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:08:10 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Overflow check for i386 assign_irq_vector, 2.6.0-test5
Date: Thu, 11 Sep 2003 21:07:55 -0700
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_baUY/LhF9ZPlSGF"
Message-Id: <200309112107.55790.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_baUY/LhF9ZPlSGF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Some very large systems overflow the array and corrupt memory.  A BUG_ON will 
at least flag the problem until dynamic irq_vector allocation is added.


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm
--Boundary-00=_baUY/LhF9ZPlSGF
Content-Type: text/x-diff;
  charset="us-ascii";
  name="x445_assign_irq_vector_bug_on_2003-09-11_2.6.0-test5"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="x445_assign_irq_vector_bug_on_2003-09-11_2.6.0-test5"

diff -pru 2.6.0-test5/arch/i386/kernel/io_apic.c t5/arch/i386/kernel/io_apic.c
--- 2.6.0-test5/arch/i386/kernel/io_apic.c	2003-09-08 12:50:01.000000000 -0700
+++ t5/arch/i386/kernel/io_apic.c	2003-09-11 12:08:14.000000000 -0700
@@ -1143,6 +1143,7 @@ int irq_vector[NR_IRQS] = { FIRST_DEVICE
 static int __init assign_irq_vector(int irq)
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
+	BUG_ON(irq >= NR_IRQS);
 	if (IO_APIC_VECTOR(irq) > 0)
 		return IO_APIC_VECTOR(irq);
 next:

--Boundary-00=_baUY/LhF9ZPlSGF--

