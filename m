Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422801AbWHURoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422801AbWHURoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 13:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWHURoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 13:44:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26262 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422801AbWHURoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 13:44:02 -0400
Date: Mon, 21 Aug 2006 10:43:34 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: simon.derr@bull.net, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060821104334.2faad899.pj@sgi.com>
In-Reply-To: <20060821132709.GB8499@krispykreme>
References: <20060821132709.GB8499@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
> We have a bug report where sched_setaffinity fails for cpus that are
> hotplug added after boot. Nathan found this suspicious piece of code:
> 
> void __init cpuset_init_smp(void)
> {
>         top_cpuset.cpus_allowed = cpu_online_map;
>         top_cpuset.mems_allowed = node_online_map;
> }
> 
> Any reason we statically set the top level cpuset to the boot time cpu
> online map?


Your query confuses me, about 4 different ways ...

1) What does sched_setaffinity have to do with this part of cpusets?
2) What did you mean by "statically assigned"?  At boot, whatever cpus
   and memory nodes are online are copied to the top_cpuset's settings.
   As Simon suggests, it would be up to the hotplug/hotunplug folks to
   update these top_cpuset settings, as cpus and nodes come and go.
3) I don't understand what you thought was suspicious here.
4) I don't understand what you expected to see instead here.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
