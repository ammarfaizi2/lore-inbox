Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267783AbUJGSfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267783AbUJGSfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUJGSdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:33:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57822 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267720AbUJGSbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:31:09 -0400
Date: Thu, 7 Oct 2004 11:27:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: pwil3058@bigpond.net.au, colpatch@us.ibm.com, mbligh@aracnet.com,
       Simon.Derr@bull.net, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041007112755.58af8601.pj@sgi.com>
In-Reply-To: <200410070016.i970GSWx009446@owlet.beaverton.ibm.com>
References: <41647E59.9080700@bigpond.net.au>
	<200410070016.i970GSWx009446@owlet.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick wrote:
> 
> Two concrete examples for cpusets stick in my mind:
> 
>     * the department that has been given 16 cpus of a 128 cpu machine,
>       is free to do what they want with them, and doesn't much care
>       specifically how they're laid out. Think general timeshare.
> 
>     * the department that has been given 16 cpus of a 128 cpu machine
>       to run a finely tuned application which expects and needs everybody
>       to stay off those cpus. Think compute-intensive.
> 
> Correct me if I'm wrong, but CKRM can handle the first, but cannot
> currently handle the second.

Even the first scenario is not well handled by CKRM, in my view, for
most workloads.  On a 128 cpu, if you want 16 cpus of compute power, you
are much better off having that power on 16 specific cpus, rather than
getting 12.5% of each of the 128 cpus, unless your workload has very low
cache footprint.

I think of it like this.  Long ago, I learned to consider performance
for many of the applications I wrote in terms of how many disk accesses
I needed, for the disk was a thousand times slower than the processor
and dominated performance across a broad scale.

The gap between the speed of interior cpu cycles and external ram
access across a bus or three is approaching the processor to disk
gap of old.  A complex hierarchy of caches has grown up, within and
surrounding each processor, in an effort to ameliorate this gap.

The dreaded disk seek of old is now the cache line miss of today.

Look at the advertisements for compute power for hire in the magazines.
I can rent a decent small computer, with web access and offsite backup,
in an air conditioned room with UPS and 24/7 administration for under
$100/month. These advertisements never sell me 12.5% of the cycles on
each of the 128 cpus in a large server.  They show pictures of some nice
little rack machine -- that can be all mine, for just $79/month.  Sign
up now with our online web server and be using your system in minutes.

[ hmmm ... wonder how many spam filters I hit on that last paragraph ... ]

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
