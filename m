Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbVINPyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVINPyx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 11:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVINPyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 11:54:53 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:36346 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030212AbVINPyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 11:54:51 -0400
Date: Wed, 14 Sep 2005 17:54:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/7] s390: show_cpuinfo fix.
Message-ID: <20050914155452.GD11478@skybase.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/7] s390: show_cpuinfo fix.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Disable preemption in show_cpuinfo to avoid problems and the
warning about smp_processor_id.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-09-14 16:48:17.000000000 +0200
@@ -634,6 +634,7 @@ static int show_cpuinfo(struct seq_file 
         struct cpuinfo_S390 *cpuinfo;
 	unsigned long n = (unsigned long) v - 1;
 
+	preempt_disable();
 	if (!n) {
 		seq_printf(m, "vendor_id       : IBM/S390\n"
 			       "# processors    : %i\n"
@@ -658,6 +659,7 @@ static int show_cpuinfo(struct seq_file 
 			       cpuinfo->cpu_id.ident,
 			       cpuinfo->cpu_id.machine);
 	}
+	preempt_enable();
         return 0;
 }
 
