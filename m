Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262446AbUAaARL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUAaARK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:17:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20296 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262446AbUAaARI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:17:08 -0500
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com>
	<401894DA.7000609@redhat.com>
	<20040129132623.GB13225@mail.shareable.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2004 17:10:13 -0700
In-Reply-To: <20040129132623.GB13225@mail.shareable.org>
Message-ID: <m1ekthx9ju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Ulrich Drepper wrote:
> > ~ alternatively use the symbol table the vdso has.  Export the new code
> > only via the symbol table.  No fixed address for the function, the
> > runtime gets it from the symbol table.  glibc will use weak symbol
> > references; if the symbol isn't there, the old code is used.  This will
> > require that every single optimized syscall needs to be handled special.
> > 
> > 
> > I personally like the first approach better.  The indirection table can
> > maintained in sync with the syscall table inside the kernel.  It all
> > comes at all times from the same source.  The overhead of the memory
> > load should be neglectable.
> 
> I like the second approach more.  You can change glibc to look up the
> weak symbol for _all_ syscalls, then none of them are special and it
> will work with future kernel optimisations.

There is one more piece to consider with either approach.  The
calling conventions.

With the x86-64 optimized vsyscall the syscall number does
not need to be placed into a register, because you have used
the proper entry point.  For any syscall worth tuning in
user space I suspect that level of optimization would be
beneficial.  A fast call path that does not waste a register.

Eric
