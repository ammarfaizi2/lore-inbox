Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUJNLZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUJNLZD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUJNLZD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:25:03 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:16067 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S261239AbUJNLY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:24:58 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Thu, 14 Oct 2004 13:22:41 +0200
User-Agent: KMail/1.6.2
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <1344740000.1097172805@[10.10.2.4]> <m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410141322.41847.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 October 2004 12:35, Eric W. Biederman wrote:
> Sorry I spotted this thread late. 

The thread was actually d(r)ying out...

> People seem to be looking at how things
> are done on clusters and then apply them to numa machines.  Which I agree
> looks totally backwards.  
> 
> The actual application requirement (ignoring the sucky batch schedulers)
> is for a group of processes (a magic process group?) to all be
> simultaneously runnable.  On a cluster that is accomplished by having
> an extremely stupid scheduler place one process per machine.   On a
> NUMA machine you can do better because you can suspend and migrate
> processes.  

Eric, beyond wanting all processes scheduled at the same time we also
want separation and real isolation (CPU and memory-wise) of processes
belonging to different users. The first emails in the thread describe
the requirements well. They are too complex to be simply handled by
cpus_allowed and mems_allowed masks, basically a hierarchy is needed
in the cpusets allocation.

> > It all just seems like a lot of complexity for a fairly obscure set of
> > requirements for a very limited group of users, to be honest. 
> 
> I think that is correct to some extent.  I think the requirements are
> much more reasonable when people stop hanging on to the cludges they
> have been using because they cannot migrate jobs, or suspend
> sufficiently jobs to get out of the way of other jobs. 

Cpusets and alike have a long history originating from ccNUMA
machines. It is not simply simulating replicating cluster
behavior. Batch schedulers may be an unelegant solution but they are
reality and used since computers were invented (more or less).

> Martin does enhancing the scheduler to deal with a group of processes 
> that all run in lock-step, usually simultaneously computing or
> communicating sound sane?  Where preempting one is effectively preempting
> all of them.
> 
> I have been quite confused by this thread in that I have not seen
> any mechanism that looks beyond an individual processes at a time,
> which seems so completely wrong.

You seem to be suggesting a gang scheduler!!! YES!!! I would love
that! But I remember that 2 years ago there were some emails from
major kernel maintainers (I don't exactly remember whom) saying that a
gang scheduler will never go into Linux. So ... here's something which
somewhat simulates that behavior. Anyhow, cpusets makes sense (for
isolation of resources) anyway, no matter whether we have gang
scheduling or not.

> Eric

Regards,
Erich


