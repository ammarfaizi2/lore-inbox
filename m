Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbTBYQYT>; Tue, 25 Feb 2003 11:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268050AbTBYQYT>; Tue, 25 Feb 2003 11:24:19 -0500
Received: from holomorphy.com ([66.224.33.161]:36278 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268045AbTBYQYS>;
	Tue, 25 Feb 2003 11:24:18 -0500
Date: Tue, 25 Feb 2003 08:33:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: check cpu_online() in nr_running()
Message-ID: <20030225163335.GD10396@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nr_uninterruptible() and nr_iowait() both check cpu_online(cpu) as
cpu ranges from 0 to NR_CPUS-1; so should nr_running().


-- wli


diff -urpN linux-2.5.63/kernel/sched.c nr_running-2.5.63-1/kernel/sched.c
--- linux-2.5.63/kernel/sched.c	Thu Feb 20 20:33:52 2003
+++ nr_running-2.5.63-1/sched.c	Tue Feb 25 08:23:09 2003
@@ -637,6 +637,8 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
+		if (!cpu_online(i))
+			continue;
 		sum += cpu_rq(i)->nr_running;
 
 	return sum;
