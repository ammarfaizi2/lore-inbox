Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbVENC7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbVENC7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 22:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVENC7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 22:59:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32941 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262686AbVENC7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 22:59:11 -0400
Date: Fri, 13 May 2005 19:58:51 -0700
From: Paul Jackson <pj@sgi.com>
To: dipankar@in.ibm.com
Cc: vatsa@in.ibm.com, dino@in.ibm.com, ntl@pobox.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050513195851.5d6665d0.pj@sgi.com>
In-Reply-To: <20050513210251.GI5044@in.ibm.com>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511195156.GE3614@otto>
	<20050513123216.GB3968@in.ibm.com>
	<20050513172540.GA28018@in.ibm.com>
	<20050513125953.66a59436.pj@sgi.com>
	<20050513202058.GE5044@in.ibm.com>
	<20050513135233.6eba49df.pj@sgi.com>
	<20050513210251.GI5044@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar, replying to pj:
> > What part of what I wrote are you saying "No" to?
> 
> The question right above "No" :)

Well ... that was less than obvious.  You quoted too much, and
responded with information about other semaphores, not about
why other duties of _this_ semaphore made such a rename wrong.

Fortunately, Nathan clarified matters.

So how would you, or Srivatsa or Nathan, respond to my more substantive
point, to repeat:

Srivatsa, replying to Dinakar:
> This in fact was the reason that we added lock_cpu_hotplug
> in sched_setaffinity.

Why just in sched_setaffinity()?  What about the other 60+ calls to
set_cpus_allowed().  Shouldn't most of those calls be checking that the
passed in cpus are online (holding lock_cpu_hotplug while doing all
this)?  Either that, or at least handling the error from
set_cpus_allowed() if the requested cpus end up not being online?  I see
only 2 set_cpus_allowed() calls that make any pretense of examining the
return value.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
