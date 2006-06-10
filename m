Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030403AbWFJAjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWFJAjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWFJAjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:39:40 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10409 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030403AbWFJAjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:39:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 -mm merge plans
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605144328.GA12904@sergelap.austin.ibm.com>
	<m17j3r8lqd.fsf@ebiederm.dsl.xmission.com>
	<20060609232551.GA11240@sergelap.austin.ibm.com>
Date: Fri, 09 Jun 2006 18:39:24 -0600
In-Reply-To: <20060609232551.GA11240@sergelap.austin.ibm.com> (Serge
	E. Hallyn's message of "Fri, 9 Jun 2006 18:25:51 -0500")
Message-ID: <m1k67p6dz7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> Quoting Eric W. Biederman (ebiederm@xmission.com):
>> If you want to help with the bare pid to struct pid conversion I
>> don't have any outstanding patches, and getting that done kills
>> some theoretical pid wrap around problems as well as laying the ground
>> work for a simple pidspace implementation.
>> 
>> Eric
>
> Is this the sort of thing you are looking for?  Is this worthwhile for
> kernel_threads, or only for userspace threads - i.e. do we expect kernel
> threads to live?

For kernel threads we should simply be able to use their task
struct.

In this instance we have hit upon a different problem.  Anything
using the kernel_thread API instead of the kthread api needs 
to be updated.

The basic problem is that for kernel_threads can show up
inside of containers.

We can fix that by updating daemonize or we can simply
universally use the kthread api.  Since the kernel_thread
api is deprecated because of these kinds of reasons
what really makes sense is to work on the transition
to the kthread api.

> If we do want to do this for kernel threads, then I assume that
> eventually we'll want to change kernel_thread() itself.  I actually
> started to do that earlier, but of course that way every user would
> have to be changed in the same patch :)
>
> Subject: [PATCH] struct pid: convert ieee1394 to hold struct pid
>
> ieee1394 driver caches pid_t's for kernel threads.  Switch to
> holding a reference to a struct pid.  This prevents concern
> about the cached pid pointing to the wrong process after the
> kernel thread dies and pids wrap around.
>
> Signed-off-by: Serge Hallyn <serue@us.ibm.com>

Ok a couple of comments.

As I recall there are some pretty sane ways of going
from struct pid to a task_struct and then we can use things
like group_send_sig.

But otherwise you seem to be using struct pid ok.

Eric
