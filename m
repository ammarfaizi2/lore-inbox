Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVBHUoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVBHUoE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVBHUoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:44:03 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37519 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261540AbVBHUnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:43:52 -0500
Date: Tue, 8 Feb 2005 12:42:34 -0800
From: Paul Jackson <pj@sgi.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: dino@in.ibm.com, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, Simon.Derr@bull.net, ak@suse.de,
       sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20050208124234.6aed9e28.pj@sgi.com>
In-Reply-To: <42090C42.7020700@us.ibm.com>
References: <20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<1097014749.4065.48.camel@arrakis>
	<420800F5.9070504@us.ibm.com>
	<20050208095440.GA3976@in.ibm.com>
	<42090C42.7020700@us.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
>   The reason Paul and I decided that they weren't totally reconcilable is 
> because of the memory binding side of the CPUSETs code.

Speak for yourself, Matthew ;).

I agree you that the scheduler experts (I'm not one, nor do I aspire to
be one) may well find that it makes sense someday to better integrate
scheduler domains and cpusets.  It seems a little inefficient on the
surface for scheduler domain code to spend time trying to choose the
best task to run on a CPU, only to find out that the chosen task is not
allowed, because that tasks cpus_allowed does not allow execution on the
intended CPU.  Since in some systems, cpusets will provide a better
indication of the natural clustering of various cpus_allowed values than
a simple boottime hierarchical partitioning of the system, it makes
sense to me that there might be a way to improve the integration of
cpusets and scheduler domains, at least as an option on systems that are
making heavy use of cpusets.  This might have the downside of making
sched domains more dynamic than they are now, which might cost more
performance than it gained.  Others will have to evaluate those
tradeoffs.

But when you write the phrase "they weren't totally reconcilable,"
I presume you mean "cpusets and CKRM weren't totally reconcilable."

I would come close to turning this phrasing around, and state that
they were (nearly) totally unreconcilable <grin>.

I found no useful and significant basis for integration of cpusets and
CKRM either involving CPU or Memory Node management.

As best as I can figure out, CKRM is a fair share scheduler with a
gussied up more modular architecture, so that the components to track
usage, control (throttle) tasks, and classify tasks are separate
plugins.  I can find no significant and useful overlap on any of these
fronts, either the existing plugins or their infrastructure, with what
cpusets has and needs.

There are claims that CKRM has some generalized resource management
architecture that should be able to handle cpusets needs, but despite my
repeated (albeit not entirely successful) efforts to find documentation
and read source and my pleadings with Matthew and earlier on this
thread, I was never able to figure out what this meant, or find anything
that could profitably integrate with cpusets.

In sum -- I see a potential for useful integration of cpusets and
scheduler domains, I'll have to leave it up to those with expertise in
the scheduler to evaluate and perhaps accomplish this.  I do not see any
useful integration of cpusets and CKRM.

I continue to be befuddled as to why, Matthew, you confound potential
cpuset-scheddomain integration with potential cpuset-CKRM integration.
Scheduler domains and CKRM are distinct beasts, in my book, and the
contemplations of cpuset integration with these two beasts are also
distinct efforts.

And cpusets and CKRM are distinct beasts.

But I repeat myself ...

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
