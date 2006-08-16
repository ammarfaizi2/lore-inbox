Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbWHPCmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbWHPCmE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWHPCmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:42:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:26344 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750838AbWHPCmC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:42:02 -0400
Date: Tue, 15 Aug 2006 21:42:00 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060816024200.GD15241@sergelap.austin.ibm.com>
References: <20060730011338.GA31695@sergelap.austin.ibm.com> <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Tue, 2006-08-15 at 06:49 -0500, Serge E. Hallyn wrote:
> > Quoting Nicholas Miell (nmiell@comcast.net):
> > > OTOH, everybody seems to have moved from capability-based security
> > > models on to TE/RBAC-based security models, so maybe this isn't worth
> > > the effort?
> > 
> > One day perhaps, but that day isn't here yet.  People are still using
> > setuid (see /sbin/passwd), so obviously they're not sufficiently
> > comfortable using *only* TE/RBAC.
> 
> The hard part of capabilities isn't the kernel mechanism - it is the

I didn't claim to be doing the hard part  :)

> proper assignment and management of the capability bits on files, and
> teaching userland that uid 0 is no longer magic.

Of course setuid still works, so it doesn't need to be done all at once.

> Which is all work that
> is already well underway for SELinux, but you would have to replicate it
> for capabilities.  And since there is no notion of equivalence classes
> ala SELinux types and the "policy" is completely distributed throughout
> the filesystem state, management is going to be even more painful for
> the capabilities.

But since file capabilities cannot survive an exec, analysis with a gui
which walks the fs could be pretty simple.

> On the kernel side, in addition to updating the bprm_secureexec logic,
> you would need to consider whether the capability module needs to
> implement capability comparisons for the other hooks, like task_kill.
> At present, many operations only involve uid comparisons and SELinux
> checks without explicitly comparing capability sets.  Properly isolating
> and protecting processes with different capability sets but the same uid
> is something SELinux already can do (based on domain), whereas the
> existing capability module doesn't really provide that. 

Very good point.  Preventing communication channels i.e. through signals
isn't a concern, but user hallyn ptracing himself running /bin/passwd
certainly is.

Thanks.

-serge
