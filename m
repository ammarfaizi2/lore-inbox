Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268409AbUHTR0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268409AbUHTR0i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268389AbUHTR0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 13:26:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18139 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268342AbUHTRZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 13:25:58 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: paulmck@us.ibm.com
Subject: Re: kernbench on 512p
Date: Fri, 20 Aug 2004 13:24:32 -0400
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com, manfred@dbl.q-ag.de
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com>
In-Reply-To: <20040820155717.GF1243@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408201324.32464.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 20, 2004 11:57 am, Paul E. McKenney wrote:
> If I am not too confused, you need #4 and #5 out of Manfred's set of
> five RCU_HUGE patchset.  They are at:
>
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=108546358123902&w=2
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=108546384711797&w=2
>
> A little work will be required to get them to apply.  For example, in
> the first patch, instead of:
>
> 	spin_lock(&rcu_state.mutex);
>
> one would say:
>
> 	spin_lock(&rsp->lock);
>
> due to the addition of the _bh() primitives.  The "rcu_ctrlblk."
> and "rcu_state." have been replaced by pointers in order to handle
> multiple different types of grace periods:
>
> o	Traditional grace periods based on context switch, executing
> 	in user mode, or running the idle loop.
>
> o	New-age low-latency grace periods based on running with
> 	interrupts enabled.

Looks like a bit more context has changed.  Manfred, care to respin against 
-mm3 so I can test?

Thanks,
Jesse
