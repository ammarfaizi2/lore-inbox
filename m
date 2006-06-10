Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbWFJBYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbWFJBYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 21:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFJBYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 21:24:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:20171 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932615AbWFJBYM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 21:24:12 -0400
Date: Fri, 9 Jun 2006 20:23:14 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
Message-ID: <20060610012314.GA2378@sergelap.austin.ibm.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060605144328.GA12904@sergelap.austin.ibm.com> <m17j3r8lqd.fsf@ebiederm.dsl.xmission.com> <20060609232551.GA11240@sergelap.austin.ibm.com> <m1k67p6dz7.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1k67p6dz7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eric W. Biederman (ebiederm@xmission.com):
> "Serge E. Hallyn" <serue@us.ibm.com> writes:
> 
> > Quoting Eric W. Biederman (ebiederm@xmission.com):
> >> If you want to help with the bare pid to struct pid conversion I
> >> don't have any outstanding patches, and getting that done kills
> >> some theoretical pid wrap around problems as well as laying the ground
> >> work for a simple pidspace implementation.
> >> 
> >> Eric
> >
> > Is this the sort of thing you are looking for?  Is this worthwhile for
> > kernel_threads, or only for userspace threads - i.e. do we expect kernel
> > threads to live?
> 
> For kernel threads we should simply be able to use their task
> struct.
> 
> In this instance we have hit upon a different problem.  Anything
> using the kernel_thread API instead of the kthread api needs 
> to be updated.
> 
> The basic problem is that for kernel_threads can show up
> inside of containers.
> 
> We can fix that by updating daemonize or we can simply
> universally use the kthread api.  Since the kernel_thread
> api is deprecated because of these kinds of reasons
> what really makes sense is to work on the transition
> to the kthread api.

Egads, I apologize.

Apparently I was in a daze, as I'd forgotten that converting
all kernel_thread users to kthread was something else we wanted
to work towards, and which Christoph had explicitly asked for
help with.

> Ok a couple of comments.
> 
> As I recall there are some pretty sane ways of going
> from struct pid to a task_struct and then we can use things
> like group_send_sig.

Oh, you mean instead of doing kill_proc(struct pid->nr), which
I guess was pretty braindead?  :)

Ok, futile as this may have seemed overall, I think it's helped
me figure out what to actually do.

thanks,
-serge
