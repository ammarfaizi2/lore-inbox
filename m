Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVE0IpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVE0IpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 04:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbVE0IpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 04:45:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:35970 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261968AbVE0Io5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 04:44:57 -0400
Date: Fri, 27 May 2005 01:44:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, dino@in.ibm.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] cpuset exit NULL dereference fix
Message-Id: <20050527014430.0e228f21.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0505271000410.11050@openx3.frec.bull.fr>
References: <20050526082508.927.67614.sendpatchset@tomahawk.engr.sgi.com>
	<Pine.LNX.4.61.0505261050480.11050@openx3.frec.bull.fr>
	<20050526164018.4880ecac.pj@sgi.com>
	<Pine.LNX.4.61.0505271000410.11050@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> > Would it make sense, Simon, to recommend to Andrew that
> > he take the simple patch I submitted yesterday ...
> > 
> > Then, when we understand ... offer up a second patch?
> 
> Of course !

Ok - I'll resubmit that patch.  Hopefully you can reply to that
resubmitted patch with an "Acked-by: ..."

Andrew withdrew the original patch, when it became a matter needing
further discussion.

> My point is only that if you think there is a scaling problem in 
> taking cpuset_sem for each call to cpuset_exit(), that scaling problem 
> won't disappear by taking cpuset_sem only for 'notify_on_remove' cpusets, 

Yes - that is a good and valid point.

I also lack any real evidence of a scaling problem.  It's just a
theoretical concern.  My unreliable weather forecast is that it will be
a while before it's a serious concern.

This means I am willing to take simple measures to minimize the concern,
but I'd prefer to await hard evidence of the problem before trying more
ambitious measures.

==

My impression is that cpusets has two classes of users:
 1) Extreme HPC apps, scaling to hundreds or thousands of CPUs, and
 2) More mixed or service oriented apps, with less extreme scaling.

I also suspect that it is the second class that most requires
notify_on_release.  The extreme HPC guys have less need for
notify_on_release.

So I find a solution that lets one trade off extreme scaling versus
heavier use of notify_on_release to be appealing, if it can be done
trivially, as this patch does.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
