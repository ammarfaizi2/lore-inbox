Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWIVXFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWIVXFd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 19:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbWIVXFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 19:05:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61154 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964851AbWIVXFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 19:05:32 -0400
Date: Fri, 22 Sep 2006 19:05:27 -0400
From: Dave Jones <davej@redhat.com>
To: =?utf-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] warning at kernel/cpu.c:38/lock_cpu_hotplug()
Message-ID: <20060922230527.GA23045@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	=?utf-8?B?Uy7Dh2HEn2xhcg==?= Onur <caglar@pardus.org.tr>,
	linux-kernel@vger.kernel.org
References: <200609230145.21997.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200609230145.21997.caglar@pardus.org.tr>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 01:45:16AM +0300, S.Çağlar Onur wrote:
 > Hi;
 > 
 > With kernel-2.6.18, "modprobe cpufreq_stats" always (i can reproduce) gaves 
 > following;
 > 
 > ...
 > Lukewarm IQ detected in hotplug locking
 > BUG: warning at kernel/cpu.c:38/lock_cpu_hotplug()
 >  [<b0134a42>] lock_cpu_hotplug+0x42/0x65
 >  [<b02f8af1>] cpufreq_update_policy+0x25/0xad
 >  [<b0358756>] kprobe_flush_task+0x18/0x40
 >  [<b0355aab>] schedule+0x63f/0x68b
 >  [<b01377c2>] __link_module+0x0/0x1f
 >  [<b0119e7d>] __cond_resched+0x16/0x34
 >  [<b03560bf>] cond_resched+0x26/0x31
 >  [<b0355b0e>] wait_for_completion+0x17/0xb1
 >  [<f965c547>] cpufreq_stat_cpu_callback+0x13/0x20 [cpufreq_stats]
 >  [<f9670074>] cpufreq_stats_init+0x74/0x8b [cpufreq_stats]
 >  [<b0137872>] sys_init_module+0x91/0x174
 >  [<b0102c81>] sysenter_past_esp+0x56/0x79

Ah yes, cpufreq vs hotplug cpu locking. The eternal battle continues.

Andrew, did we arrive at concensus about how we should fix this?
I'm still of the opinion that it should be ripped out
completely, and started from scratch.

	Dave

