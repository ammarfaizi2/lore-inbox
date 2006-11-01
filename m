Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946953AbWKAR2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946953AbWKAR2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 12:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946954AbWKAR2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 12:28:48 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5303 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946953AbWKAR2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 12:28:46 -0500
Date: Wed, 1 Nov 2006 23:03:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: "Paul Menage" <menage@google.com>
Cc: dev@openvz.org, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       balbir@in.ibm.com, haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       pj@sgi.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [RFC] Resource Management - Infrastructure choices
Message-ID: <20061101173356.GA18182@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061030103356.GA16833@in.ibm.com> <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6599ad830610300251w1f4e0a70ka1d64b15d8da2b77@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 02:51:24AM -0800, Paul Menage wrote:
> The cpusets code which this was based on simply locked the task list,
> and traversed it to find threads in the cpuset of interest; you could
> do the same thing in any other resource controller.

Sure ..the point was about efficiency (whether you plough through
thousands of tasks to find those 10 tasks which belong to a group or
you have a list which gets to the 10 tasks immediately). But then the
cost of maintaining such a list is noted.

> Not keeping a list of tasks in the container makes fork/exit more
> efficient, and I assume is the reason that cpusets made that design
> decision. If we really wanted to keep a list of tasks in a container
> it wouldn't be hard, but should probably be conditional on at least
> one of the registered resource controllers to avoid unnecessary
> overhead when none of the controllers actually care (in a similar
> manner to the fork/exit callbacks, which only take the container
> callback mutex if some container subsystem is interested in fork/exit
> events).

Makes sense.

> How important is it for controllers/subsystems to be able to
> deregister themselves, do you think? I could add it relatively easily,
> but it seemed unnecessary in general.

Not very important perhaps.

> I've not really played with it yet, but I don't see any reason why the
> beancounter resource control concept couldn't also be built over
> generic containers. The user interface would be different, of course
> (filesysmem vs syscall), but maybe even that could be emulated if
> there was a need for backwards compatibility.

Hmm ..cpusets is in mainline already and hence we do need to worry abt
backward compatibility. If we were to go ahead with your patches, do we have 
the same backward compatibility concern for beancounter as well? :)

> > Consensus:
> >
> >         - Provide resource control over a group of tasks
> >         - Support movement of task from one resource group to another
> >         - Dont support heirarchy for now
> 
> Both CKRM/RG and generic containers support a hierarchy.

I guess the consensus (as was made at OLS BoF :
 http://lkml.org/lkml/2006/7/26/237) was more wrt controllers than 
the infrastructure.

> 
> >         - Support limit (soft and/or hard depending on the resource
> >           type) in controllers. Guarantee feature could be indirectly
> >           met thr limits.
> 
> That's an issue for resource controllers, rather than the underlying
> infrastructure, I think.

Hmm ..I dont think so. If we were to support both guarantee and limit,
then the infrastructure has to provide interfaces to set both values
for a group.

-- 
Regards,
vatsa
