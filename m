Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbTIXWKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 18:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTIXWKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 18:10:46 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:30876 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261620AbTIXWKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 18:10:45 -0400
Subject: [PATCH] linux-2.4.23-pre5_nrcpus-fix_A1
From: john stultz <johnstul@us.ibm.com>
To: marcelo <marcelo.tosatti@cyclades.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1064365144.3855.320.camel@cog.beaverton.ibm.com>
References: <1064365144.3855.320.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1064441207.3855.368.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 24 Sep 2003 15:06:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-23 at 17:59, john stultz wrote:
> Marcelo, all,
> 	This is a backported patch from 2.5 that fixes array overflows and
> memory corruption when booting on boxes with more processors then
> CONFIG_NR_CPUS. 
> 

Marcelo, All,
	James Cleverdon pointed out that I had a printk formatting typo in the
last revision of this patch ( "0x%d" - doh!).

Anyway, this revision corrects the error, changing 0x%d -> 0x%x.

thanks
-john

diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Sep 24 15:02:51 2003
+++ b/arch/i386/kernel/mpparse.c	Wed Sep 24 15:02:51 2003
@@ -229,6 +229,11 @@
 		boot_cpu_logical_apicid = logical_apicid;
 	}
 
+	if (num_processors >= NR_CPUS){
+		printk(KERN_WARNING "NR_CPUS limit of %i reached. Cannot "
+			"boot CPU(apicid 0x%x).\n", NR_CPUS, m->mpc_apicid);
+		return;
+	}
 	num_processors++;
 
 	if (m->mpc_apicid > MAX_APICS) {



