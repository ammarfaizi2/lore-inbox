Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265275AbUGGSVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265275AbUGGSVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUGGSVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 14:21:36 -0400
Received: from gate.in-addr.de ([212.8.193.158]:52879 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S265275AbUGGSSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 14:18:50 -0400
Date: Wed, 7 Jul 2004 20:16:50 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Daniel Phillips <phillips@redhat.com>
Cc: linux-kernel@vger.kernel.org, Lon Hohberger <lhh@redhat.com>
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Message-ID: <20040707181650.GD12255@marowsky-bree.de>
References: <200407050209.29268.phillips@redhat.com> <200407051627.51790.phillips@redhat.com> <20040706073444.GB19892@marowsky-bree.de> <200407061734.51023.phillips@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200407061734.51023.phillips@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-07-06T17:34:51,
   Daniel Phillips <phillips@redhat.com> said:

> > And the "industry" was very reluctant 
> > too. Which meant that everybody spend ages talking and not much
> > happening.
> We're showing up with loads of Sistina code this time.  It's up to 
> everybody else to ante up, and yes, I see there's more code out there.  
> It's going to be quite a summer reading project.

Yeah, I wish you the best. There's always been quite a bit of code to
show, but that alone didn't convince people ;-) I've certainly grown a
bit more experienced / cynical during that time. (Which, according to
Oscar Wilde, is the same anyway ;)

> It's for real, no question.  There are at least two viable GPL code 
> bases already, GFS and Lustre, with OCFS2 coming up fast.

Yes, they have some common requirements on the kernel VFS layer, though
Lustre certainly has the most extensive demands. I hope someone from CFS
Inc can make it to your summit.

> I can believe it.  What I have just done with my cluster snapshot target 
> over the last couple of weeks is, removed _every_ dependency on cluster 
> infrastructure and moved the one remaining essential interface to user 
> space.

Is there a KS presentation on this? I didn't get invited to KS and will
just be allowed in for OLS, but I'll be around town already...

> Oddly enough, there has been much discussion about quorum here as well.  
> This must be pluggable, and we must be able to handle multiple, 
> independent clusters, with a single node potentially belonging to more 
> than one at the same time.  Please see this, for a formal writeup on 
> our 2.6 code base:
> 
>    http://people.redhat.com/~teigland/sca.pdf

Thanks for the pointer, this is a good read.

> It looks like fencing is more of an issue, because having several node 
> fencing systems running at the same time in ignorance of each other is 
> deeply wrong.  We can't just wave our hands at this by making it 
> pluggable, we need to settle on one that works and use it.  I'll humbly 
> suggest that Sistina is furthest along in this regard.

Your fencing system is fine with me; based on the assumption that you
always have to fence a failed node, you are doing the right thing.
However, the issues are more subtle when this is no longer true, and in
a 1:1 how do you arbitate who is allowed to fence?

> Cluster resource management is the least advanced of the components that 
> our Red Hat Sistina group has to offer, mainly because it is seen as a 
> matter of policy, and so the pressing need at this state is to provide 
> suitable hooks.

> "STOMITH" :)  Yes, exactly.  Global load balancing is another big item, 
> i.e., which node gets assigned the job of running a particular service, 
> which means you need to know how much of each of several different 
> kinds of resources a particular service requires, and what the current 
> resource usage profile is for each node on the cluster.  Rik van Riel 
> is taking a run at this.

Right, cluster resource management is one of the things where I'm quite
happy with the approach the new heartbeat resource manager is heading
down (or up, I hope ;).

> It's a huge, scary problem.  We _must_ be able to plug in different 
> solutions, all the way from completely manual to completely automagic, 
> and we have to be able to handle more than one at once.

You can plug multiple ones as long as they are managing independent
resources, obviously. However, if the CRM is the one which ultimately
decides whether a node needs to be fenced or not - based on its
knowledge of which resources it owns or could own - this gets a lot more
scary still...

> Yes, again, fencing looks like the one we have to fret about.  The 
> others will be a lot easier to mix and match.

Mostly, yes. Unless you (like some) require quorum to report a cluster
membership, which some implementations do.

> Incidently, there is already a nice crosssection of the cluster 
> community on the way to sunny Minneapolis for the July meeting.  We've 
> reached about 50% capacity, and we have quorum, I think :-)

Uhm, do I have to be frightened of being fenced? ;)


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering	    \ ever tried. ever failed. no matter.
SUSE Labs, Research and Development | try again. fail again. fail better.
SUSE LINUX AG - A Novell company    \ 	-- Samuel Beckett

