Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261562AbSI0Qtz>; Fri, 27 Sep 2002 12:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSI0Qtz>; Fri, 27 Sep 2002 12:49:55 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:20490 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261562AbSI0Qtx>; Fri, 27 Sep 2002 12:49:53 -0400
Date: Fri, 27 Sep 2002 17:55:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Smalley <sds@tislabs.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020927175510.B32207@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Smalley <sds@tislabs.com>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, linux-security-module@wirex.com
References: <20020927003210.A2476@sgi.com> <Pine.GSO.4.33.0209270743170.22771-100000@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0209270743170.22771-100000@raven>; from sds@tislabs.com on Fri, Sep 27, 2002 at 08:09:50AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 08:09:50AM -0400, Stephen Smalley wrote:
> 
> On Fri, 27 Sep 2002, Christoph Hellwig wrote:
> 
> > Sorry, but this is bullshit (like most of the lsm changes).  Either you
> > leave the capable in and say it's enough or you add your random hook
> > and remove that one.  Just adding more and more hooks without thinking
> > gets us exactly nowhere except to an unmaintainable codebase.
> 
> The LSM hooks are primarily restrictive, i.e. a security module can deny
> access that would normally be granted by the existing Linux access checks.

In 2.5 LSM hooks are part of the Linux access checks, and any reason to
make your patch less intrusive inb 2.4 doesn't apply anymore.  Having
two checks for the same thing is indeed very bad in will cause harm
and maintaince burden in the long term.  Don't do it.

> > Also is there a _real_ need to pass in all the arguments?
> 
> Define _real_.

Show me a useful example that needs this argument.

> It is true that none of the existing open source security
> modules presently use this particular hook.  SELinux doesn't presently use
> it, but it seems reasonable to support finer-grained control over ioperm()
> than the all-or-nothing CAP_SYS_RAWIO.  Is the criteria that every hook
> and every parameter to every hook must be used by an existing open source
> security module?  If so, then yes, this hook can be dropped.

Linus traditionally uses a keep it simple approach and so far that has helped
a lot to keep the system in a maintainable state.  Given that these `hooks
allow plugin in large, unaudited codebases like selinux or even propritary
modules this seems even more important to me.

> In sys_create_module, you only know the name and size of the module and
> who is performing the operation.  In sys_init_module, you actually have
> information about the module available.  Hence, you can make a
> finer-grained decision in the module_initialize hook, and possibly deny
> even after a successful module_create.  As above, SELinux doesn't use
> these hooks presently.

And WTF is the use a security policy that checks module arguments?  Do
you want to disallow options that are quotes from books on the index
or not political correct enough for a US state agency?

