Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422831AbWA1FYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831AbWA1FYE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 00:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbWA1FYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 00:24:04 -0500
Received: from proof.pobox.com ([207.106.133.28]:60303 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1422831AbWA1FYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 00:24:02 -0500
Date: Fri, 27 Jan 2006 23:23:56 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Paul Jackson <pj@sgi.com>
Cc: steiner@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       rml@novell.com
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060128052355.GC18730@localhost.localdomain>
References: <20060127230659.GA4752@sgi.com> <20060127191400.aacb8539.pj@sgi.com> <20060128034241.GB18730@localhost.localdomain> <20060127205834.b5821a02.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127205834.b5821a02.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Nathan wrote:
> > Which is problematic, because cpuset_cpus_allowed ->
> > guarantee_online_cpus restricts the task->cpus_allowed mask to cpus
> > which happen to be online at the time of the call to
> > sched_setaffinity.  If more cpus come online later, that task can't be
> > migrated to them.
> 
> Well, sort of.
> 
> A task could always migrate - just because a sched_getaffinity
> the task did in the past doesn't show a CPU as valid, doesn't stop
> the task from asking to pin to that CPU now.

I was speaking of the setaffinity (not getaffinity) case -- I assumed
this was what you were referring to since I couldn't find any calls to
the cpuset code in the getaffinity path.


> One of three lessons could be taken from your example:
>  1) return all possible CPUS (CPU_MASK_ALL, likely), as you
> recommend

I'm only recommending not changing the current behavior of
sched_getaffinity.

(BTW - cpu_possible_map can be a subset of CPU_MASK_ALL on some
platforms -- powerpc, at least, since we can discover the number of
truly possible cpus early in boot.)

