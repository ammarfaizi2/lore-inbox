Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWHOQgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWHOQgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965393AbWHOQgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:36:36 -0400
Received: from web36603.mail.mud.yahoo.com ([209.191.85.20]:60853 "HELO
	web36603.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965388AbWHOQgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:36:35 -0400
Message-ID: <20060815163634.8038.qmail@web36603.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 15 Aug 2006 09:36:34 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RFC] [PATCH] file posix capabilities
To: Stephen Smalley <sds@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
In-Reply-To: <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Stephen Smalley <sds@tycho.nsa.gov> wrote:


> The hard part of capabilities isn't the kernel
> mechanism - it is the
> proper assignment and management of the capability
> bits on files, and
> teaching userland that uid 0 is no longer magic.

Stephen is correct here. Getting the capability
settings correct on all setuid programs is a
tough nut. Training people out of the root
model isn't easy, either.

> Which is all work that
> is already well underway for SELinux, but you would
> have to replicate it
> for capabilities.

The work underway for SELinux is different
from that of capabilities. POSIX capabilities
offer substantial benefits without the high
cost of SELinux.

> And since there is no notion of
> equivalence classes
> ala SELinux types and the "policy" is completely
> distributed throughout
> the filesystem state, management is going to be even
> more painful for
> the capabilities.

This is not the experiance of Irix, which
has supported POSIX capabilities for years.

> On the kernel side, in addition to updating the
> bprm_secureexec logic,
> you would need to consider whether the capability
> module needs to
> implement capability comparisons for the other
> hooks, like task_kill.
> At present, many operations only involve uid
> comparisons and SELinux
> checks without explicitly comparing capability sets.

Yes. There is work to be done.

>  Properly isolating
> and protecting processes with different capability
> sets but the same uid
> is something SELinux already can do (based on
> domain), whereas the
> existing capability module doesn't really provide
> that. 

That's a matter of taste in policy. There
is certainly no Common Criteria requirement
for that.

Sure, SELinux and POSIX capabilities are
different. No arguement. POSIX capabilities
predate SELinux in the community and in the
Linux kernel. To date they have been limited
by the lack of xattr support, but now that 
that is available there is every reason to
complete the implementation.


Casey Schaufler
casey@schaufler-ca.com
