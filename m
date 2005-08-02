Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVHBHIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVHBHIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVHBHIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:08:53 -0400
Received: from omta03ps.mx.bigpond.com ([144.140.82.155]:3255 "EHLO
	omta03ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261235AbVHBHIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:08:52 -0400
Message-ID: <42EF1C00.7090302@bigpond.net.au>
Date: Tue, 02 Aug 2005 17:08:48 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
Subject: Re: [ANNOUNCE] Interbench v0.24
References: <200507291310.42203.kernel@kolivas.org>
In-Reply-To: <200507291310.42203.kernel@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta03ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 2 Aug 2005 07:08:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> Interbench is a Linux Kernel Interactivity Benchmark.
> 
> Direct download:
> http://ck.kolivas.org/apps/interbench/interbench-0.24.tar.bz2
> Web:
> http://interbench.kolivas.org
> 
> Changes:
> 3 new loads were added:
> 
> Gaming benchmark:
> This simulates an unlocked frame rate cpu intensive 3d gaming environment. It 
> measures the latencies mean/sd/max and desired cpu percentage only. These 
> should give a marker of frame rate stability (latencies), and maximum frame 
> rates under different loads (desired cpu percentage). As this simulates an 
> unlocked frame rate the deadlines met is meaningless. This does not 
> accurately emulate a 3d game which is gpu bound, only a cpu bound one.
> 
> Hackbench:
> Taken from Rusty's hackbench code as suggested by Ingo Molnar, this will run 
> 'hackbench 50' repeatedly in the background when benchmarking real time 
> performance.
> 
> Custom:
> Based on the periodic scheduling used for audio/video, custom will allow you 
> to specify a cpu percentage and frame rate of a custom workload, and this can 
> be used to benchmark this workload's performance under normal scheduling, 
> real time scheduling or it can be used as a background load.
> 
> 
> Bugfixes:
> Numerous floating point and overflow errors were tracked down and fixed. These 
> are responsible for results like 'nan' and 4294... which is basically 2^32. 
> Unfortunately the standard deviation reported in previous versions appears to 
> have been bogus, but fortunately little value was placed on this result.
> 
> Error handling was made _much_ more robust - for example it was found that 
> contrary to 'man sem_wait' but consistent with SUSv3, sem_wait can return -1 
> with -EINTR.
> 
> Lots of little tweaks.

I've just been perusing the code and noticed that there is a bug in 
calculating the latency standard deviation caused by the fact that the 
latency that is inserted into the samples array is not necessarily the 
same as that added to total_latency and could be quite a bit larger.  So 
either the means are too small or the standard deviations are too large.

BTW, there's a method for calculating variances and means that avoids 
the need to keep an array of samples.  Basically, in addition to the sum 
of the samples (sum_x, say) you keep a sum of the squares of the samples 
(sum_x_sq, say) and the number of samples (n, say).  Then:

mean = sum_x / n
variance = (sum_x_sq - (mean * mean) / n) / (n - 1)
standard deviation = sqrt(variance)

Without the need to keep the array of samples there's no need worry 
about an arbitrary upper limit on the number of samples.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
