Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264677AbUFGOLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264677AbUFGOLr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264659AbUFGOJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:09:53 -0400
Received: from holomorphy.com ([207.189.100.168]:18615 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264655AbUFGOHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:07:18 -0400
Date: Mon, 7 Jun 2004 07:07:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607140714.GB21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org> <20040607135631.GY21007@holomorphy.com> <20040607135738.GZ21007@holomorphy.com> <20040607140445.GA21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607140445.GA21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 07:04:45AM -0700, William Lee Irwin III wrote:
> array->nr_active only ever modified, never examined.

cpu_to_node_mask() is dead.


Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 07:03:00.910109000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 07:06:28.072616000 -0700
@@ -46,12 +46,6 @@
 
 #include <asm/unistd.h>
 
-#ifdef CONFIG_NUMA
-#define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
-#else
-#define cpu_to_node_mask(cpu) (cpu_online_map)
-#endif
-
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
