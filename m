Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVAVFi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVAVFi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 00:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVAVFgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 00:36:23 -0500
Received: from ozlabs.org ([203.10.76.45]:14830 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262666AbVAVFgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 00:36:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16881.58840.63293.407888@cargo.ozlabs.ibm.com>
Date: Sat, 22 Jan 2005 16:34:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: anton@samba.org, nacc@us.ibm.com
Subject: [PATCH] PPC64 replace schedule_timeout in pSeries_cpu_die
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nishanth Aravamudan <nacc@us.ibm.com>.

Replace schedule_timeout() with msleep to simplify the code and to
express the delay in milliseconds instead of HZ.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- 2.6.11-rc1-kj-v/arch/ppc64/kernel/pSeries_smp.c	2005-01-15 16:55:41.000000000 -0800
+++ 2.6.11-rc1-kj/arch/ppc64/kernel/pSeries_smp.c	2005-01-15 17:21:12.000000000 -0800
@@ -107,8 +107,7 @@ void pSeries_cpu_die(unsigned int cpu)
 		cpu_status = query_cpu_stopped(pcpu);
 		if (cpu_status == 0 || cpu_status == -1)
 			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/5);
+		msleep(200);
 	}
 	if (cpu_status != 0) {
 		printk("Querying DEAD? cpu %i (%i) shows %i\n",
