Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUAaGBO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 01:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUAaGBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 01:01:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:12618 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263625AbUAaGBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 01:01:12 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
	<401894DA.7000609@redhat.com>
	<20040129132623.GB13225@mail.shareable.org>
	<m1ekthx9ju.fsf@ebiederm.dsl.xmission.com>
	<20040131024100.GA9236@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2004 22:54:19 -0700
In-Reply-To: <20040131024100.GA9236@mail.shareable.org>
Message-ID: <m1oeskwtmc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > With the x86-64 optimized vsyscall the syscall number does
> > not need to be placed into a register, because you have used
> > the proper entry point.  For any syscall worth tuning in
> > user space I suspect that level of optimization would be
> > beneficial.  A fast call path that does not waste a register.
> 
> The cost of loading a constant into a register is _much_ lower than
> the cost of indirect jumps which we have been discussing.

I was thinking more of the register pressure in the load.

But in the case of gettimeofday I think it makes to do a kernel
implementation that is argument compatible with libc and then linker
magic could just short circuit the calls to the vsyscall page and libc
would not need to get involved at all, which removes one of the
indirect calls.

We could probably do that today by just renaming the function
gettimeofday.  But that is rude and has name space pollution issues.

Eric
