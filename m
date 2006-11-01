Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946724AbWKAPyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946724AbWKAPyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 10:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946835AbWKAPyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 10:54:43 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26521 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946724AbWKAPym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 10:54:42 -0500
Date: Wed, 1 Nov 2006 21:29:37 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Paul Menage <menage@google.com>, Paul Jackson <pj@sgi.com>, dev@openvz.org,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101155937.GA2928@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com> <20061030031531.8c671815.pj@sgi.com> <6599ad830610300404v1e036bb7o7ed9ec0bc341864e@mail.gmail.com> <20061030042714.fa064218.pj@sgi.com> <6599ad830610300953o7cbf5a6cs95000e11369de427@mail.gmail.com> <20061030123652.d1574176.pj@sgi.com> <6599ad830610301247k179b32f5xa5950d8fc5a3926c@mail.gmail.com> <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0610311951280.7538@attu4.cs.washington.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 08:39:27PM -0800, David Rientjes wrote:
> So here's our three process containers, A, B, and C, with our tasks m-t:
> 
> 	-----A-----	-----B-----	-----C-----
> 	|    |    |     |    |    |     |    |
> 	m    n    o	p    q    r	s    t
> 
> Here's our memory controller groups D and E and our containers set within 
> them:
> 
> 	-----D-----	-----E-----
> 	|         |	|
> 	A         B	C

This would forces all tasks in container A to belong to the same mem/io ctlr 
groups. What if that is not desired? How would we achieve something like
this:

	tasks (m) should belong to mem ctlr group D,
	tasks (n, o) should belong to mem ctlr group E
  	tasks (m, n, o) should belong to i/o ctlr group G

(this example breaks the required condition/assumption that a task belong to 
exactly only one process container).

Is this a unrealistic requirement? I suspect not and should give this
flexibilty, if we ever have to support task-grouping that is
unique to each resource. Fundamentally process grouping exists because
of various resource and not otherwise.

At this point, what purpose does having/exposing-to-user the generic process 
container abstraction A, B and C achieve?

IMHO what is more practical is to let res ctlr groups (like D, E, F, G)
be comprised of individual tasks (rather than containers). 

Note that all this is not saying that Paul Menages's patches are
pointless. In fact his generalization of cpusets to achieve process
grouping is indeed a good idea. I am only saying that his mechanism
should be used to define groups-of-tasks under each resource, rather
than to have groups-of-containers under each resource.


-- 
Regards,
vatsa
