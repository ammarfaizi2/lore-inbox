Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWC3PaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWC3PaP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWC3PaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:30:14 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:32905 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750879AbWC3PaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:30:13 -0500
Date: Thu, 30 Mar 2006 17:30:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, David Lang <dlang@digitalinsight.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
Message-ID: <20060330153012.GA16720@MAIL.13thfloor.at>
Mail-Followup-To: "Serge E. Hallyn" <serue@us.ibm.com>,
	Chris Wright <chrisw@sous-sol.org>,
	David Lang <dlang@digitalinsight.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sam Vilain <sam@vilain.net>, Nick Piggin <nickpiggin@yahoo.com.au>,
	Bill Davidsen <davidsen@tmr.com>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net> <20060329182027.GB14724@sorel.sous-sol.org> <442B0BFE.9080709@vilain.net> <20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com> <20060330013618.GS15997@sorel.sous-sol.org> <Pine.LNX.4.62.0603291738290.266@qynat.qvtvafvgr.pbz> <20060330020445.GT15997@sorel.sous-sol.org> <20060330143224.GC6933@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330143224.GC6933@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 08:32:24AM -0600, Serge E. Hallyn wrote:
> Quoting Chris Wright (chrisw@sous-sol.org):
> > * David Lang (dlang@digitalinsight.com) wrote:
> > > what if the people administering the container are different from the 
> > > people administering the host?
> > 
> > Yes, I alluded to that.
> > 
> > > in that case the people working in the container want to be able to 
> > > implement and change their own policy, and the people working on the host 
> > > don't want to have to implement changes to their main policy config (wtih 
> > > all the auditing that would be involved with it) every time a container 
> > > wants to change it's internal policy.
> > 
> > *nod*
> > 
> > > I can definantly see where a container aware policy on the master would be 
> > > useful, but I can also see where the ability to nest seperate policies 
> > > would be useful.
> > 
> > This is all fine.  The question is whether this is a policy management
> > issue or a kernel infrastructure issue.  So far, it's not clear that this
> > really necessitates kernel infrastructure changes to support container
> > aware policies to be loaded by physical host admin/owner or the virtual
> > host admin.  The place where it breaks down is if each virtual host
> > wants not only to control its own policy, but also its security model.
> 
> What do you define as 'policy', and how is it different from the
> security model?
> 
> > Then we are left with stacking modules or heavier isolation (as in Xen).
> 
> Hmm, talking about 'container' in this sense is confusing, because we're
> not yet clear on what a container is.
> 
> So I'm trying to get a handle on what we really want to do.
> 
> Talking about namespaces is tricky. For instance if I do
> clone(CLONE_NEWNS), the new process is in a new fs namespace, but the
> fs objects are still the same, so if it loads an LSM, then perhaps at
> most the new process should only control mount activities in its own
> namespace.
>
> Frankly I thought, and am still not unconvinced, that containers owned
> by someone other than the system owner would/should never want to load
> their own LSMs, so that this wasn't a problem. Isolation, as Chris has
> mentioned, would be taken care of by the very nature of namespaces.
>
> There are of course two alternatives... First, we might want to
> allow the machine admin to insert per-container/per-namespace LSMs.
> To support this case, we would need a way for the admin to tag a
> container some way identifying it as being subject to a particular set
> of security_ops.
>
> Second, we might want container admins to insert LSMs. In addition
> to a straightforward way of tagging subjects/objects with their
> container, we'd need to implement at least permissions for "may insert
> global LSM", "may insert container LSM", and "may not insert any LSM."
> This might be sufficient if we trust userspace to always create full
> containers. Otherwise we might want to support meta-policy along the
> lines of "may authorize ptrace and mount hooks only", or even "not
> subject to the global inode_permission hook, and may create its own."

sorry folks, I don't think that we _ever_ want container
root to be able to load any kernel modues at any time
without having CAP_SYS_ADMIN or so, in which case the
modules can be global as well ... otherwise we end up
as a bad Xen imitation with a lot of security issues,
where it should be a security enhancement ...

best,
Herbert

> (yuck)
>
> But so much of this depends on how the namespaces/containers end up
> being implemented...
> 
> -serge
