Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946569AbWKAJxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946569AbWKAJxv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946744AbWKAJxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:53:51 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:12514 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946569AbWKAJxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:53:50 -0500
Date: Wed, 1 Nov 2006 01:53:37 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Pavel Emelianov <xemul@openvz.org>
cc: vatsa@in.ibm.com, dev@openvz.org, sekharan@us.ibm.com, menage@google.com,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, pj@sgi.com, matthltc@us.ibm.com,
       dipankar@in.ibm.com, rohitseth@google.com
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
In-Reply-To: <45486925.4000201@openvz.org>
Message-ID: <Pine.LNX.4.64N.0611010145370.32554@attu4.cs.washington.edu>
References: <20061030103356.GA16833@in.ibm.com> <45486925.4000201@openvz.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006, Pavel Emelianov wrote:

> > 	- Interaction of resource controllers, containers and cpusets
> > 		- Should we support, for instance, creation of resource
> > 		  groups/containers under a cpuset?
> > 	- Should we have different groupings for different resources?
> 
> I propose to discuss this question as this is the most important
> now from my point of view.
> 
> I believe this can be done, but can't imagine how to use this...
> 

I think cpusets, as abstracted away from containers by Paul Menage, simply 
become a client of the container configfs.  Cpusets would become more of a 
NUMA-type controller by default.

Different groupings for different resources was already discussed.  If we 
use the approach of a single-level "hierarchy" for process containers and 
then attach them each to a "node" of a controller, then the groupings have 
been achieved.  It's possible to change the network controller of a 
container or move processes from container to container easily through the 
filesystem.

> > 	- Support movement of all threads of a process from one group
> > 	  to another atomically?
> 
> I propose such a solution: if a user asks to move /proc/<pid>
> then move the whole task with threads.
> If user asks to move /proc/<pid>/task/<tid> then move just
> a single thread.
> 
> What do you think?

This seems to use my proposal of using procfs as an abstraction of process 
containers.  I haven't looked at the implementation details, but it seems 
like the most appropriate place given what it currently supports.  
Naturally it should be an atomic move but I don't think it's the most 
important detail in terms of efficiency because moving threads should not 
be such a frequent occurrence anyway.  This begs the question about how 
forks are handled for processes with regard to the various controllers 
that could be implemented and whether they should all be decendants of the 
parent container by default or have the option of spawning a new 
controller all together.  This would be an attribute of controllers and 
not containers, however.

		David
