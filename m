Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJHUoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJHUoi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUJHUoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:44:37 -0400
Received: from pristine.overt.org ([69.59.183.228]:64425 "EHLO
	pristine.saidi.cx") by vger.kernel.org with ESMTP id S264704AbUJHUof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:44:35 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <B00811E6-196A-11D9-8001-000A95AF0DA8@umich.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Ali Saidi <saidi@umich.edu>
Subject: [PATCH] Alpha - cpu mask fix-ups broke SMP DP264 machines in 2.6.8
Date: Fri, 8 Oct 2004 16:43:19 -0400
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu mask fix-ups in 2.6.8 broke SMP kernels booting on a DP264. 
Instead of not setting the DIM for cpus that did not exit, the patch 
inadvertently doesn't set the DIM for CPUs that do exist. Thus no 
device interrupts get to the cpu.

Thanks,

Ali


--- linux-2.6.8.1.orig/arch/alpha/kernel/sys_dp264.c    2004-10-08 
15:51:26.000000000 -0400
+++ linux-2.6.8.1.fix/arch/alpha/kernel/sys_dp264.c     2004-10-08 
15:58:07.000000000 -0400
@@ -71,10 +71,10 @@
         dim1 = &cchip->dim1.csr;
         dim2 = &cchip->dim2.csr;
         dim3 = &cchip->dim3.csr;
-       if (cpu_possible(0)) dim0 = &dummy;
-       if (cpu_possible(1)) dim1 = &dummy;
-       if (cpu_possible(2)) dim2 = &dummy;
-       if (cpu_possible(3)) dim3 = &dummy;
+       if (!cpu_possible(0)) dim0 = &dummy;
+       if (!cpu_possible(1)) dim1 = &dummy;
+       if (!cpu_possible(2)) dim2 = &dummy;
+       if (!cpu_possible(3)) dim3 = &dummy;

         *dim0 = mask0;
         *dim1 = mask1;

