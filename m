Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030469AbWIMBKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030469AbWIMBKY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWIMBKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:10:24 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:25738 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030469AbWIMBKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:10:23 -0400
Subject: Re: [ckrm-tech] [PATCH] BC: resource
	beancounters	(v4)	(added	user	memory)
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: rohitseth@google.com
Cc: Rik van Riel <riel@redhat.com>, Srivatsa <vatsa@in.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, balbir@in.ibm.com,
       Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Andrey Savochkin <saw@sw.ru>, devel@openvz.org,
       Matt Helsley <matthltc@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
       Alexey Dobriyan <adobriyan@mail.ru>, Kirill Korotaev <dev@sw.ru>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Emelianov <xemul@openvz.org>
In-Reply-To: <1158107948.20211.47.camel@galaxy.corp.google.com>
References: <44FD918A.7050501@sw.ru> <44FDAB81.5050608@in.ibm.com>
	 <44FEC7E4.7030708@sw.ru> <44FF1EE4.3060005@in.ibm.com>
	 <1157580371.31893.36.camel@linuxchandra> <45011CAC.2040502@openvz.org>
	 <1157743424.19884.65.camel@linuxchandra>
	 <1157751834.1214.112.camel@galaxy.corp.google.com>
	 <1157999107.6029.7.camel@linuxchandra>
	 <1158001831.12947.16.camel@galaxy.corp.google.com>
	 <1158003725.6029.60.camel@linuxchandra>
	 <1158019099.12947.102.camel@galaxy.corp.google.com>
	 <1158105253.4800.20.camel@linuxchandra>
	 <1158107948.20211.47.camel@galaxy.corp.google.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 12 Sep 2006 18:10:18 -0700
Message-Id: <1158109818.4800.39.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 17:39 -0700, Rohit Seth wrote:
<snip>
> > yes, it would be there, but is not heavy, IMO.
> 
> I think anything greater than 1% could be a concern for people who are
> not very interested in containers but would be forced to live with them.

If they are not interested in resource management and/or containers, i
do not think they need to pay.
> 
> > > 
> > > > > 
> > > > > And anything running outside a container should be limited by default
> > > > > Linux settings.
> > > > 
> > > > note that the resource available to the default RG will be (total system
> > > > resource - allocated to RGs).
> > > 
> > > I think it will be preferable to not change the existing behavior for
> > > applications that are running outside any container (in your case
> > > default resource group).
> > 
> > hmm, when you provide QoS for a set of apps, you will affect (the
> > resource availability of) other apps. I don't see any way around it. Any
> > ideas ?
> 
> When I say, existing behavior, I mean not getting impacted by some
> artificial limits that are imposed by container subsystem.  IOW, if a

That is what I understood and replied above.
> sysadmin is okay to have certain apps running outside of container then
> he is basically forgoing any QoS for any container on that system.

Not at all. If the container they are interested in is guaranteed, I do
not see how apps running outside a container would affect them.

<snip>
> > > > Not really. 
> > > >  - Each RG will have a guarantee and limit of each resource. 
> > > >  - default RG will have (system resource - sum of guarantees)
> > > >  - Every RG will be guaranteed some amount of resource to provide QoS
> > > >  - Every RG will be limited at "limit" to prevent DoS attacks.
> > > >  - Whoever doesn't care either of those set them to don't care values.
> > > > 
> > > 
> > > For the cases that put this don't care, do you depend on existing
> > > reclaim algorithm (for memory) in kernel?
> > 
> > Yes.
> 
> So one container with these don't care condition(s) can turn the whole
> guarantee thing bad.  Because existing kernel reclaimer does not know
> about memory commitments to other containers.  Right?

No, the reclaimer would free up pages associated with the don't care RGs
( as the user don't care about the resource made available to them).

<snip>
> > > If the limits are set appropriately so that containers total memory
> > > consumption does not exceed the system memory then there shouldn't be
> > > any QoS issue (to whatever extent it is applicable for specific
> > > scenario).
> > 
> > Then you will not be work-conserving (IOW over-committing), which is one
> > of the main advantage of this type of feature.
> > 
> 
> If for the systems where QoS is important, not over-committing will be
> fine (at least to start with).

The problem is that you can't do it with just limit.

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


