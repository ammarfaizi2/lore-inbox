Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbVLOWC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbVLOWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVLOWC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:02:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25770 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751141AbVLOWCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:02:25 -0500
Subject: Re: [RFC][patch 00/21] PID Virtualization: Overview and Patches
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, vserver@list.linux-vserver.org,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       pagg@oss.sgi.com
In-Reply-To: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
References: <E1Emz6c-0006c3-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 17:02:20 -0500
Message-Id: <1134684140.28082.6.camel@elg11.watson.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-22) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 11:49 -0800, Gerrit Huizenga wrote:
> On Thu, 15 Dec 2005 09:35:57 EST, Hubertus Franke wrote:

> > PID Virtualization is based on the concept of a container.
> > The ultimate goal is to checkpoint/restart containers. 
> > 
> > The mechanism to start a container 
> > is to 'echo "container_name" > /proc/container'  which creates a new
> > container and associates the calling process with it. All subsequently
> > forked tasks then belong to that container.
> > There is a separate pid space associated with each container.
> > Only processes/task belonging to the same container "see" each other.
> > The exception is an implied default system container that has 
> > a global view.
> > 
> > The following patches accomplish 3 things:
> > 1) identify the locations at the user/kernel boundary where pids and 
> >    related ids ( pgrp, sessionids, .. ) need to be (de-)virtualized and
> >    call appropriate (de-)virtualization functions.
> > 2) provide the virtualization implementation in these functions.
> > 3) implement a container object and a simple /proc interface to create one
> > 4) provide a per container /proc/fs
> > 
> > -- Hubertus Franke    (frankeh@watson.ibm.com)
> > -- Cedric Le Goater   (clg@fr.ibm.com)
> > -- Serge E Hallyn     (serue@us.ibm.com)
> > -- Dave Hansen        (haveblue@us.ibm.com)
> 
> I think this is actually quite interesting in a number of ways - it
> might actually be a way of cleanly addressing several current out
> of tree problems, several of which are indpendently (occasionally) striving
> for mainline adoption:  vserver, openvz, cluster checkpoint/restart.

Indeed the entire set might be able to benefit wrt to pid
virtualization. I think we are quite open to embrace a larger set of
applications of pid virtualization.

> I think perhaps this could also be the basis for a CKRM "class"
> grouping as well.  Rather than maintaining an independent class
> affiliation for tasks, why not have a class devolve (evolve?) into
> a "container" as described here.  The container provides much of
> the same grouping capabilities as a class as far as I can see.  The
> right information would be availble for scheduling and IO resource
> management.  The memory component of CKRM is perhaps a bit tricky
> still, but an overall strategy (can I use that word here? ;-) might
> be to use these "containers" as the single intrinsic grouping mechanism
> for vserver, openvz, application checkpoint/restart, resource
> management, and possibly others?
> 
> Opinions, especially from the CKRM folks?  This might even be useful
> to the PAGG folks as a grouping mechanism, similar to their jobs or
> containers.
> 
Not being to alien to the CKRM concept, yes there is some nice synergy 
here. As well as to PAGG and SGI's jobs. CKRM provides resource
constraints and runtime enforcements based on some grouping of
processes. Similar to container, class membership is inherited (if
that's still the case from last time I looked at it) until explicitely
changed. Containers and in particular provide another dimension
namely the ability to constraint "visibility" of resources and objects,
in this particular case pids as the first resource used.

> "This patchset solves multiple problems".

> gerrit
> 
-- 
Hubertus Franke <frankeh@watson.ibm.com>

