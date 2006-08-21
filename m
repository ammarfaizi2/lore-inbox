Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751867AbWHUN1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbWHUN1f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWHUN1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:27:35 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:60849 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751867AbWHUN1f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:27:35 -0400
Date: Mon, 21 Aug 2006 23:27:09 +1000
From: Anton Blanchard <anton@samba.org>
To: pj@sgi.com, simon.derr@bull.net
Cc: nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: cpusets not cpu hotplug aware
Message-ID: <20060821132709.GB8499@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

We have a bug report where sched_setaffinity fails for cpus that are
hotplug added after boot. Nathan found this suspicious piece of code:

void __init cpuset_init_smp(void)
{
        top_cpuset.cpus_allowed = cpu_online_map;
        top_cpuset.mems_allowed = node_online_map;
}

Any reason we statically set the top level cpuset to the boot time cpu
online map?

Anton
