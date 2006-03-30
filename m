Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751230AbWC3QPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbWC3QPr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbWC3QPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:15:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12417 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751230AbWC3QPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:15:46 -0500
Date: Thu, 30 Mar 2006 10:15:21 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, Chris Wright <chrisw@sous-sol.org>,
       David Lang <dlang@digitalinsight.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330161521.GH2403@sergelap.austin.ibm.com>
References: <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com> <1143734855.24555.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143734855.24555.211.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Thu, 2006-03-30 at 08:32 -0600, Serge E. Hallyn wrote:
> > Frankly I thought, and am still not unconvinced, that containers owned
> > by someone other than the system owner would/should never want to load
> > their own LSMs, so that this wasn't a problem.  Isolation, as Chris has
> > mentioned, would be taken care of by the very nature of namespaces.
> > 
> > There are of course two alternatives...  First, we might want to allow the
> > machine admin to insert per-container/per-namespace LSMs.    To support
> > this case, we would need a way for the admin to tag a container some way
> > identifying it as being subject to a particular set of security_ops.  
> > 
> > Second, we might want container admins to insert LSMs.  In addition to
> > a straightforward way of tagging subjects/objects with their container,
> > we'd need to implement at least permissions for "may insert global LSM",
> > "may insert container LSM", and "may not insert any LSM."  This might be
> > sufficient if we trust userspace to always create full containers.
> > Otherwise we might want to support meta-policy along the lines of "may
> > authorize ptrace and mount hooks only", or even "not subject to the
> > global inode_permission hook, and may create its own."  (yuck)
> > 
> > But so much of this depends on how the namespaces/containers end up
> > being implemented...
> 
> FWIW, SELinux now has a notion of a type hierarchy in its policy, so the
> root admin can carve out a portion of the policy space and allow less
> privileged admins to then define sub-types that are strictly constrained
> by what was allowed to the parent type by the root admin.  This is
> handled in userspace, with the policy mediation performed by a userspace
> agent (daemon, policy management server), which then becomes the focal
> point for all policy loading.

Yes, my first response (which I cancelled) mentioned this as a possible
solution.

The global admin could assign certain max privileges to 'container_b'.
The admin in container_b could create container_b.root_t,
container_b.user_t, etc, which would be limited by the container_b
max perms.

Presumably the policy daemon, running in container 0, could accept input
from a socket from container 2, labeled appropriately automatically
ensuring that all types created by the policy in container 2 are
prefixed with container_b, and doing the obvious restrictions.

Or something like that :)

-serge
