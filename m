Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261885AbVBXHYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbVBXHYH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 02:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbVBXHWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 02:22:45 -0500
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:41579 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261895AbVBXHUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 02:20:53 -0500
Subject: [PATCH 5/13] find_busiest_group cleanup
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1109229542.5177.73.camel@npiggin-nld.site>
References: <1109229293.5177.64.camel@npiggin-nld.site>
	 <1109229362.5177.67.camel@npiggin-nld.site>
	 <1109229415.5177.68.camel@npiggin-nld.site>
	 <1109229491.5177.71.camel@npiggin-nld.site>
	 <1109229542.5177.73.camel@npiggin-nld.site>
Content-Type: multipart/mixed; boundary="=-pT9w5sCbdqV0tuPXHQUx"
Date: Thu, 24 Feb 2005 18:20:49 +1100
Message-Id: <1109229650.5177.78.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pT9w5sCbdqV0tuPXHQUx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

5/13

--=-pT9w5sCbdqV0tuPXHQUx
Content-Disposition: attachment; filename=sched-cleanup-fbg.patch
Content-Type: text/x-patch; name=sched-cleanup-fbg.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Cleanup find_busiest_group a bit. New sched-domains code
means we can't have groups without a CPU.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>


Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-02-24 17:31:29.298502546 +1100
+++ linux-2.6/kernel/sched.c	2005-02-24 17:43:38.629469074 +1100
@@ -1771,7 +1771,7 @@
 	do {
 		unsigned long load;
 		int local_group;
-		int i, nr_cpus = 0;
+		int i;
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
@@ -1785,13 +1785,9 @@
 			else
 				load = source_load(i);
 
-			nr_cpus++;
 			avg_load += load;
 		}
 
-		if (!nr_cpus)
-			goto nextgroup;
-
 		total_load += avg_load;
 		total_pwr += group->cpu_power;
 

--=-pT9w5sCbdqV0tuPXHQUx--


