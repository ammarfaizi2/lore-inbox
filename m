Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTIXBCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 21:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbTIXBCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 21:02:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:51615 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261232AbTIXBCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 21:02:51 -0400
Subject: [PATCH] linux-2.4.23-pre5_nrcpus-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo.tosatti@cyclades.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1064365144.3855.320.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Sep 2003 17:59:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo, all,
	This is a backported patch from 2.5 that fixes array overflows and
memory corruption when booting on boxes with more processors then
CONFIG_NR_CPUS. 

Please consider for acceptance.

thanks
-john

diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Tue Sep 23 17:54:34 2003
+++ b/arch/i386/kernel/mpparse.c	Tue Sep 23 17:54:34 2003
@@ -229,6 +229,11 @@
 		boot_cpu_logical_apicid = logical_apicid;
 	}
 
+	if (num_processors >= NR_CPUS){
+		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot "
+			"boot CPU(apicid 0x%d).\n", NR_CPUS, m->mpc_apicid);
+		return;
+	}
 	num_processors++;
 
 	if (m->mpc_apicid > MAX_APICS) {



