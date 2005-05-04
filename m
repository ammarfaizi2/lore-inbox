Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVEDPFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVEDPFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 11:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVEDPFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 11:05:42 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31617 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261856AbVEDPFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 11:05:35 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc3-V0.7.46-01
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Daniel Walker <dwalker@mvista.com>
In-Reply-To: <20050504082241.GA13380@elte.hu>
References: <20050325145908.GA7146@elte.hu> <20050331085541.GA21306@elte.hu>
	 <20050401104724.GA31971@elte.hu> <20050405071911.GA23653@elte.hu>
	 <20050421073537.GA1004@elte.hu> <20050422062714.GA23667@elte.hu>
	 <1114903693.12664.9.camel@mindpipe>  <20050504082241.GA13380@elte.hu>
Content-Type: text/plain
Date: Wed, 04 May 2005 11:05:34 -0400
Message-Id: <1115219134.935.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-05-04 at 10:22 +0200, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> > it looks like we are finally getting close to the lower limit 
> > that can be achieved with PREEMPT_DESKTOP ... It's only 127 usecs, and 
> > IIRC you mentioned previously that this code path can't be made 
> > preemptible in !PREEMPT_RT.
> 
> yeah, signal delivery will have to stay atomic in !PREEMPT_RT kernels.
> 

OK.  I found a few more.

When umounting, shrink_dcache_sb() will produce a 3-4 ms. bump.  However
it's not clear this can be made preemptible.  AFAICT the whole thing
needs to be under the dcache_lock.  This one is pretty obvious so I'm
not attaching a trace.

There's also still one path in the VM related to page freeing that can
produce ~500 usec latencies but I don't have a trace handy now.

> > Since Mingming's patch will have to live in -mm for a while, can it be 
> > added to the RT patchset as well?
> 
> i think so - i'll add it to the next patch.

OK, great.

Lee

