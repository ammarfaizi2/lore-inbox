Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHVCvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHVCvD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 22:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbWHVCvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 22:51:03 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:42432 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751156AbWHVCvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 22:51:01 -0400
Date: Mon, 21 Aug 2006 21:50:36 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Crispin Cowan <crispin@novell.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "Serge E. Hallyn" <serue@us.ibm.com>,
       "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: [RFC] [PATCH] file posix capabilities
Message-ID: <20060822025036.GA31422@sergelap.austin.ibm.com>
References: <20060814220651.GA7726@sergelap.austin.ibm.com> <m1r6zirgst.fsf@ebiederm.dsl.xmission.com> <20060815020647.GB16220@sergelap.austin.ibm.com> <m13bbyr80e.fsf@ebiederm.dsl.xmission.com> <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com> <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil> <20060816024200.GD15241@sergelap.austin.ibm.com> <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil> <44E6714C.3090707@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E6714C.3090707@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Crispin Cowan (crispin@novell.com):
> Stephen Smalley wrote:
> > Also, think about the real benefits of capabilities, at least as defined
> > in Linux.  The coarse granularity and the lack of any per-object support
> > is a fairly significant deficiency there that is much better handled via
> > TE.
> Only if the user wants to buy all the way into TE. Making POSIX
> Capabilities, TE, and AppArmor composeable choices seems like a good
> goal. The question is whether POSIX Capabilities on their own are worth
> while. But consider:
> 
>     * They are already there on their own, pulling POSIX Capabilities
>       out seems like a non-option because too much already uses them.
>     * They are nearly useless without some kind of management interface.
>       Adding a decent management interface can only make it better.
> 
> Serge has proposed a reasonable model. I would like to suggest that
> people, especially Serge, consider the AppArmor model as well before
> deciding.

So far this is not deciding on anything, just trying to follow the
partially implemented draft to it's specified and logical conclusion.
It may well be that it will turn out to just not be manageable, safe, or
useful, or none of the three.

> To quickly summarize the AppArmor model, you have an external policy

Does this stack with the capability module, or do you use purely your
own logic?

> file that says that e.g. /usr/local/foo can have net_bind_service and
> ipc_lock. This is a bit mask overlaid on top of whatever capabilities
> the process already has, e.g. because it is UID 0 it has all of them. So
> if someone runs /usr/local/foo as an unprivileged user, it has no
> capabilities, and the bitmask does nothing. If someone runs
> /usr/local/foo as root, then instead of all 32 capabilities, they get
> only those 2.

Can't do that with the fs capabilities.

But, the fs caps aren't intended to be an alternative to a policy-basd
system.  What I like about them is simply that instead of making a
binary setuid 0, and expecting it to give up the caps it doesn't need,
it can be given just the caps it needs right off the bat.

The apparmor and selinux policies would be complementary and useful as
ever on top of those, just as they currently are on top of setuid.

> >  At least some of the Linux capabilities lend themselves to easy
> > privilege escalation to gaining other capabilities or effectively
> > bypassing them.
> >   
> Certainly; cap_sys_admin effectively gives you ownership of the machine.
> But that is fundamental to the POSIX Capabilities model, and not
> something that Serge can change.

Yup, sigh...

A better split of the caps might be more useful than fs caps
themselves...

-serge
