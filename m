Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWE3OTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWE3OTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWE3OTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:19:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:39640 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932289AbWE3OT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:19:29 -0400
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060530141006.GG14721@redhat.com>
References: <20060529212109.GA2058@elte.hu>
	 <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com>
	 <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com>
	 <1148967947.3636.4.camel@laptopd505.fenrus.org>
	 <20060530141006.GG14721@redhat.com>
Content-Type: text/plain
Date: Tue, 30 May 2006 16:19:22 +0200
Message-Id: <1148998762.3636.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 10:10 -0400, Dave Jones wrote:
> On Tue, May 30, 2006 at 07:45:47AM +0200, Arjan van de Ven wrote:
> 
>  > One
>  > ---
>  > store_scaling_governor takes policy->lock and then calls __cpufreq_set_policy
>  > __cpufreq_set_policy calls __cpufreq_governor
>  > __cpufreq_governor  calls __cpufreq_driver_target via cpufreq_governor_performance
>  > __cpufreq_driver_target calls lock_cpu_hotplug() (which takes the hotplug lock)
>  > 
>  > 
>  > Two
>  > ---
>  > cpufreq_stats_init lock_cpu_hotplug() and then calls cpufreq_stat_cpu_callback
>  > cpufreq_stat_cpu_callback calls cpufreq_update_policy
>  > cpufreq_update_policy takes the policy->lock
>  > 
>  > 
>  > so this looks like a real honest AB-BA deadlock to me...
> 
> This looks a little clearer this morning.  I missed the fact that sys_init_module
> isn't completely serialised, only the loading part. ->init routines can and will be
> called in parallel.
> 
> I don't see where cpufreq_update_policy takes policy->lock though.
> In my tree it just takes the per-cpu data->lock.

isn't that basically the same lock?


