Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262560AbVEMVKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbVEMVKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVEMVKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:10:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:36819 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262560AbVEMVIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:08:34 -0400
Date: Sat, 14 May 2005 02:36:59 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: Paul Jackson <pj@sgi.com>, vatsa@in.ibm.com, dino@in.ibm.com,
       Simon.Derr@bull.net, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050513210659.GJ5044@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050513123216.GB3968@in.ibm.com> <20050513172540.GA28018@in.ibm.com> <20050513125953.66a59436.pj@sgi.com> <20050513202058.GE5044@in.ibm.com> <20050513204652.GI3614@otto>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513204652.GI3614@otto>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 03:46:52PM -0500, Nathan Lynch wrote:
> > > In particular, in my view, locks should guard data.  What data does
> > > lock_cpu_hotplug() guard?  I propose that it guards cpu_online_map.
> > > 
> > > I recommend considering a different name for this lock.  Perhaps
> > > 'cpu_online_sem', instead of 'cpucontrol'?   And perhaps the
> > > lock_cpu_hotplug() should be renamed, to say 'lock_cpu_online'?
> > 
> > No. CPU hotplug uses two different locking - see both lock_cpu_hotplug()
> > and __stop_machine_run(). Anyone reading cpu_online_map with
> > preemption disabled is safe from cpu hotplug even without taking
> > any lock.
> 
> More precisely (I think), reading cpu_online_map with preemption
> disabled guarantees that none of the cpus in the map will go offline
> -- it does not prevent an online operation in progress (but most code
> only cares about the former case).  Also note that __stop_machine_run
> is used only to offline a cpu.
> 
> The cpucontrol semaphore does not only protect cpu_online_map and
> cpu_present_map, but also serializes cpu hotplug operations, so that
> only one may be in progress at a time.

Exactly. So, naming it lock_cpu_online() would make no sense.

> 
> I've been mulling over submitting a Documentation/cpuhotplug.txt,
> sounds like there's sufficient demand...

That would be very good considering the fact that CPU hotplug
is getting broken often. Another nice thing to see would be
i386 cpu hotplug support. That would allow lot more developers
to test their code with cpu hotplug. Not sure where that one is now.
Perhaps Zwane knows.

Thanks
Dipankar
