Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWCPAs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWCPAs5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 19:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWCPAs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 19:48:56 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13543 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751308AbWCPAs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 19:48:56 -0500
Subject: Re: Long latencies with MD RAID 1 [was Re: libata/sata_nv latency
	on NVIDIA CK804 ]
From: Lee Revell <rlrevell@joe-job.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060316002133.GE17817@ti64.telemetry-investments.com>
References: <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>
	 <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>
	 <44189A3D.5090202@garzik.org>
	 <20060315231426.GD17817@ti64.telemetry-investments.com>
	 <1142466242.1671.96.camel@mindpipe>
	 <20060316002133.GE17817@ti64.telemetry-investments.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 19:48:47 -0500
Message-Id: <1142470128.1671.124.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 19:21 -0500, Bill Rugolsky Jr. wrote:
> On Wed, Mar 15, 2006 at 06:44:02PM -0500, Lee Revell wrote:
> > On Wed, 2006-03-15 at 18:14 -0500, Bill Rugolsky Jr. wrote:
> > > [Meanwhile, I still have to switch contexts and look at the long
> > > softirq latencies that at first glance appear to be due to the use of
> > > mempool by the RAID1 bio code.] 
> > 
> > Can you post traces of them somewhere?  There are no long running
> > softirqs in the two you posted (the worst is only 200 usecs or so).
> 
> This is typical of what I'm seeing. It seems to be looping over lots
> of io request completions?
> 
> 	-Bill
> 
> preemption latency trace v1.1.5 on 2.6.16-rc6-git4-latency
> --------------------------------------------------------------------
>  latency: 1950 us, #8586/8586, CPU#0 | (M:desktop VP:0, KP:0, SP:0 HP:0 #P:1)

This looks very similar to what I see with my regular ATA drive (except
that the completions are handled in hardirq context).

You can cause less work to be done in each softirq by
lowering /sys/block/$DEV/queue/max_sectors_kb.

I would not consider ~2ms "long", there are some other softirqs that
induce 10-15ms latencies...

Lee

