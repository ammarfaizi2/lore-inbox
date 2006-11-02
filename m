Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbWKBRhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbWKBRhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 12:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWKBRhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 12:37:05 -0500
Received: from mga05.intel.com ([192.55.52.89]:42595 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750944AbWKBRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 12:37:03 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,381,1157353200"; 
   d="scan'208"; a="156681137:sNHT947449321"
Subject: 2.6.19-rc1: Slowdown in lmbench's fork
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: linux-kernel@vger.kernel.org
Cc: ebiederm@xmission.com
Content-Type: text/plain
Organization: Intel
Date: Thu, 02 Nov 2006 08:44:57 -0800
Message-Id: <1162485897.10806.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After introduction of the following patch:

[PATCH] genirq: x86_64 irq: make vector_irq per cpu
http://kernel.org/git/?
p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=550f2299ac8ffaba943cf211380d3a8d3fa75301

we see fork benchmark in lmbench-3.0-a7 slowed by 
11.5% on a 2 socket woodcrest machine.  Similar change
is seen also on other SMP Xeon machines.

When running lmbench, we have chosen the lmbench option
to pin parent and child on different processor cores 
  
Overhead of calling sched_setaffinity to place the process 
on processor is included in lmbench's fork time measurement. 
The patch may play a role in increasing this.

The two follow up patches to the original "make vector_irq per cpu" 
did not affect the fork time.

[PATCH] x86_64 irq: Properly update vector_irq
[PATCH] x86-64: Only look at per_cpu data for online ...

Tim
