Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVFAO3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVFAO3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 10:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVFAO3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 10:29:42 -0400
Received: from mail.ccur.com ([208.248.32.212]:3393 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261389AbVFAO3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 10:29:36 -0400
Subject: Re: SD_SHARE_CPUPOWER breaks scheduler fairness
From: Steve Rotolo <steve.rotolo@ccur.com>
Reply-To: steve.rotolo@ccur.com
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, bugsy@ccur.com
In-Reply-To: <200506011249.47655.kernel@kolivas.org>
References: <1117561608.1439.168.camel@whiz>
	 <200506011249.47655.kernel@kolivas.org>
Content-Type: text/plain
Organization: Concurrent Computer Corporation
Message-Id: <1117636171.22879.29.camel@bonefish>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Wed, 01 Jun 2005 10:29:31 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Jun 2005 14:29:31.0649 (UTC) FILETIME=[533C9F10:01C566B6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-31 at 22:49, Con Kolivas wrote:
> Sort of yes and yes. The idea that the sibling gets put to sleep if a real 
> time task is running is a workaround for the fact that you do share cpu power 
> (as you've correctly understood) and a real time task will slow down if a 
> SCHED_NORMAL task is running on its sibling which it should not.  The 
> limitation is that, yes, for all intents you only have N hyperthreaded cpus 
> for spinning N rt tasks before nothing else runs, but you can actually run 
> N*2 rt tasks in this setting which you would not be able to if hyperthreading 
> was disabled.
> 
> For some time I've been thinking about changing the balance between the 
> siblings slightly to allow SCHED_NORMAL tasks to run a small proportion of 
> time when rt tasks are running on the sibling. The tricky part is that 
> SCHED_FIFO tasks have no timeslice so we can't proportion cpu out according 
> to the difference in size of the timeslices, which is currently how we 
> proportion out cpu across siblings with SCHED_NORMAL, and this maintains cpu 
> distribution very similarly to how 'nice' does on the same cpu.

Thanks for responding, Con.  But I want to make sure that an important
point doesn't escape your attention.  It appears that tasks get trapped
on the stalled sibling, even when they could run on some other cpu.  The
load-balancer does not understand that the sibling is temporarily out of
service so it actually balances tasks to it.  And since it's idle, it
may attract tasks to it more than other cpus (thanks to SD_WAKE_IDLE). 
I think this is a serious bug.

-- 
Steve

