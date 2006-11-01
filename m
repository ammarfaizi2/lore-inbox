Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWKAWXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWKAWXj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbWKAWXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:23:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:10196 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750739AbWKAWXi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:23:38 -0500
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
From: Matt Helsley <matthltc@us.ibm.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Pavel Emelianov <xemul@openvz.org>, dev@openvz.org, vatsa@in.ibm.com,
       sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, pj@sgi.com,
       dipankar@in.ibm.com, rohitseth@google.com, menage@google.com
In-Reply-To: <Pine.LNX.4.64N.0611010145370.32554@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com>
	 <45486925.4000201@openvz.org>
	 <Pine.LNX.4.64N.0611010145370.32554@attu4.cs.washington.edu>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Wed, 01 Nov 2006 14:23:33 -0800
Message-Id: <1162419813.12419.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 01:53 -0800, David Rientjes wrote:
> On Wed, 1 Nov 2006, Pavel Emelianov wrote:
> 
> > > 	- Interaction of resource controllers, containers and cpusets
> > > 		- Should we support, for instance, creation of resource
> > > 		  groups/containers under a cpuset?
> > > 	- Should we have different groupings for different resources?
> > 
> > I propose to discuss this question as this is the most important
> > now from my point of view.
> > 
> > I believe this can be done, but can't imagine how to use this...
> > 
> 
> I think cpusets, as abstracted away from containers by Paul Menage, simply 
> become a client of the container configfs.  Cpusets would become more of a 
> NUMA-type controller by default.
> 
> Different groupings for different resources was already discussed.  If we 
> use the approach of a single-level "hierarchy" for process containers and 

At least in my mental model the depth of the hierarchy has nothing to do
with different groupings for different resources. They are just separate
hierarchies and where they are mounted does not affect their behavior.

> then attach them each to a "node" of a controller, then the groupings have 
> been achieved.  It's possible to change the network controller of a 
> container or move processes from container to container easily through the 
> filesystem.
> 
> > > 	- Support movement of all threads of a process from one group
> > > 	  to another atomically?
> > 
> > I propose such a solution: if a user asks to move /proc/<pid>
> > then move the whole task with threads.
> > If user asks to move /proc/<pid>/task/<tid> then move just
> > a single thread.
> > 
> > What do you think?
> 
> This seems to use my proposal of using procfs as an abstraction of process 
> containers.  I haven't looked at the implementation details, but it seems 
> like the most appropriate place given what it currently supports.  

I'm not so sure procfs is the right mechanism.

> Naturally it should be an atomic move but I don't think it's the most 
> important detail in terms of efficiency because moving threads should not 
> be such a frequent occurrence anyway.  This begs the question about how 
> forks are handled for processes with regard to the various controllers 
> that could be implemented and whether they should all be decendants of the 
> parent container by default or have the option of spawning a new 
> controller all together.  This would be an attribute of controllers and 

"spawning a new controller"?? Did you mean a new container?

> not containers, however.
> 
> 		David

	I don't follow. You seem to be mixing and separating the terms
"controller" and "container" and it doesn't fit with the uses of those
terms that I'm familiar with.

Cheers,
	-Matt Helsley

