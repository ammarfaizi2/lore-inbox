Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267993AbUJCQEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267993AbUJCQEv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 12:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJCQEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 12:04:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39402 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267993AbUJCQEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 12:04:48 -0400
Date: Sun, 3 Oct 2004 09:02:09 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041003090209.69b4b561.pj@sgi.com>
In-Reply-To: <821020000.1096814205@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> The way cpusets uses the current cpus_allowed mechanism is, to me, the most
> worrying thing about it. Frankly, the cpus_allowed thing is kind of tacked
> onto the existing scheduler, and not at all integrated into it, and doesn't
> work well if you use it heavily (eg bind all the processes to a few CPUs,
> and watch the rest of the system kill itself). 

True.  One detail of what you say I'm unclear on -- how will the rest of
the system kill itself?  Why wouldn't the unemployed CPUs just idle
around, waiting for something to do?

As I recall, Ingo added task->cpus_allowed for the Tux in-kernel web
server a few years back, and I piggy backed the cpuset stuff on that, to
keep my patch size small.

Likely your same concerns apply to the task->mems_allowed field that
I added, in the same fashion, in my cpuset patch of recent.

We need a mechanism that the cpuset apparatus respects that maps each
CPU to a sched_domain, exactly one sched_domain for any given CPU at any
point in time, regardless of which task it is considering running at the
moment.  Somewhat like dual-channeled disks, having more than one
sched_domain apply at the same time to a given CPU leads to confusions
best avoided unless desparately needed.  Unlike dual-channeled disks, I
don't see the desparate need here for multi-channel sched_domains ;).

And of course, for the vast majority of normal systems in the world
not configured with cpusets, this has to collapse back to something
sensible "just like it is now."

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
