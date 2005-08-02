Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVHBHM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVHBHM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 03:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVHBHM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 03:12:56 -0400
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:51686 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261361AbVHBHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 03:11:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [ANNOUNCE] Interbench v0.24
Date: Tue, 2 Aug 2005 17:13:07 +1000
User-Agent: KMail/1.8.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>
References: <200507291310.42203.kernel@kolivas.org> <42EF1C00.7090302@bigpond.net.au>
In-Reply-To: <42EF1C00.7090302@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508021713.07363.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2005 05:08 pm, Peter Williams wrote:
> Con Kolivas wrote:
> > Interbench is a Linux Kernel Interactivity Benchmark.
> >
> > Direct download:
> > http://ck.kolivas.org/apps/interbench/interbench-0.24.tar.bz2
> > Web:
> > http://interbench.kolivas.org
> >
> > Changes:
> > 3 new loads were added:
> >
> > Gaming benchmark:
> > This simulates an unlocked frame rate cpu intensive 3d gaming
> > environment. It measures the latencies mean/sd/max and desired cpu
> > percentage only. These should give a marker of frame rate stability
> > (latencies), and maximum frame rates under different loads (desired cpu
> > percentage). As this simulates an unlocked frame rate the deadlines met
> > is meaningless. This does not accurately emulate a 3d game which is gpu
> > bound, only a cpu bound one.
> >
> > Hackbench:
> > Taken from Rusty's hackbench code as suggested by Ingo Molnar, this will
> > run 'hackbench 50' repeatedly in the background when benchmarking real
> > time performance.
> >
> > Custom:
> > Based on the periodic scheduling used for audio/video, custom will allow
> > you to specify a cpu percentage and frame rate of a custom workload, and
> > this can be used to benchmark this workload's performance under normal
> > scheduling, real time scheduling or it can be used as a background load.
> >
> >
> > Bugfixes:
> > Numerous floating point and overflow errors were tracked down and fixed.
> > These are responsible for results like 'nan' and 4294... which is
> > basically 2^32. Unfortunately the standard deviation reported in previous
> > versions appears to have been bogus, but fortunately little value was
> > placed on this result.
> >
> > Error handling was made _much_ more robust - for example it was found
> > that contrary to 'man sem_wait' but consistent with SUSv3, sem_wait can
> > return -1 with -EINTR.
> >
> > Lots of little tweaks.
>
> I've just been perusing the code and noticed that there is a bug in
> calculating the latency standard deviation caused by the fact that the
> latency that is inserted into the samples array is not necessarily the
> same as that added to total_latency and could be quite a bit larger.  So
> either the means are too small or the standard deviations are too large.
>
> BTW, there's a method for calculating variances and means that avoids
> the need to keep an array of samples.  Basically, in addition to the sum
> of the samples (sum_x, say) you keep a sum of the squares of the samples
> (sum_x_sq, say) and the number of samples (n, say).  Then:
>
> mean = sum_x / n
> variance = (sum_x_sq - (mean * mean) / n) / (n - 1)
> standard deviation = sqrt(variance)
>
> Without the need to keep the array of samples there's no need worry
> about an arbitrary upper limit on the number of samples.

Lovely! Thank you very much as that was causing me much grief indeed and your 
approach simplifies the code greatly.

Cheers,
Con
