Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWBXBlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWBXBlV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWBXBlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:41:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932159AbWBXBlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:41:20 -0500
Date: Thu, 23 Feb 2006 20:41:12 -0500
From: Dave Jones <davej@redhat.com>
To: ak@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Make SMP x86-64 kernels boot on more UP systems.
Message-ID: <20060224014112.GA16089@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, ak@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should someone boot an SMP kernel on UP hardware on some systems,
strange things happen, such as..

SMP: Allowing 0 CPUs.

We blow up shortly afterwards.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15.noarch/arch/x86_64/kernel/smpboot.c~	2006-02-20 21:59:56.000000000 -0500
+++ linux-2.6.15.noarch/arch/x86_64/kernel/smpboot.c	2006-02-20 22:01:57.000000000 -0500
@@ -975,6 +975,11 @@ __init void prefill_possible_map(void)
 	if (possible > NR_CPUS) 
 		possible = NR_CPUS;
 
+	if (possible == 0) {	/* Could be SMP kernel on UP hw with broken BIOS */
+		possible = 1;
+		printk (KERN_DEBUG "BIOS never enumerated boot CPU, fixing.\n");
+	}
+
 	printk(KERN_INFO "SMP: Allowing %d CPUs, %d hotplug CPUs\n",
 		possible,
 	        max_t(int, possible - num_processors, 0));
