Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWC0VSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWC0VSY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 16:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWC0VSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 16:18:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:21192 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751448AbWC0VSX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 16:18:23 -0500
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com, Jes Sorensen <jes@sgi.com>
Date: Mon, 27 Mar 2006 13:18:17 -0800
Message-Id: <20060327211817.16768.77971.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] ia64 sn_hwperf use of num_online_cpus()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate an unnecessary -- and flawed -- use of the expensive
num_online_cpus().

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/arch/ia64/sn/kernel/sn2/sn_hwperf.c
===================================================================
--- linux.orig/arch/ia64/sn/kernel/sn2/sn_hwperf.c	2006-03-19 21:53:29.000000000 -0800
+++ linux/arch/ia64/sn/kernel/sn2/sn_hwperf.c	2006-03-27 13:14:12.000000000 -0800
@@ -605,7 +605,7 @@ static int sn_hwperf_op_cpu(struct sn_hw
 	op_info->a->arg &= SN_HWPERF_ARG_OBJID_MASK;
 
 	if (cpu != SN_HWPERF_ARG_ANY_CPU) {
-		if (cpu >= num_online_cpus() || !cpu_online(cpu)) {
+		if (cpu >= NR_CPUS || !cpu_online(cpu)) {
 			r = -EINVAL;
 			goto out;
 		}
