Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWGLXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWGLXYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWGLXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:24:46 -0400
Received: from thunk.org ([69.25.196.29]:22698 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751475AbWGLXYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:24:45 -0400
Date: Wed, 12 Jul 2006 19:24:14 -0400
From: Theodore Tso <tytso@mit.edu>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Ulrich Drepper <drepper@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Message-ID: <20060712232414.GI9040@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Ulrich Drepper <drepper@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
	Andi Kleen <ak@suse.de>
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com> <20060710155051.326e49da.rdunlap@xenotime.net> <m1veq4kcij.fsf@ebiederm.dsl.xmission.com> <1152601640.3128.7.camel@laptopd505.fenrus.org> <m1irm2bxk3.fsf_-_@ebiederm.dsl.xmission.com> <44B5283E.7090806@redhat.com> <m1hd1mafe0.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1hd1mafe0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 11:42:47AM -0600, Eric W. Biederman wrote:
> Unless a darn good reason for keeping it is found, sys_sysctl won't be
> in the kernel several months from now.  And uname is faster by a large
> margin than /proc.

Um, if glibc is using sys_sysctl, then that's a pretty good reason.
Once we remove it from the kernel, then people will be forced to
upgrade glibc's before they can install a newer kernel.  Can we please
give people some time for an version of glibc with this change to make
it out to most deployed systems, first?  It's really annoying when
it's not possible to install a stock kernel.org kernel on a system,
and often upgrading glibc is not a trivial thing to do on a
distribution userspace, especially if there is a concern for ISV
compatibility.  (Especially if C++ code is involved, unfortunately.)

> Right now because there has been a deprecated note in
> "include/linux/sysctl.h" since 2003 people currently feel fine with
> letting sys_sysctl code bit rot.  I am trying to resolve that
> situation most likely by just updating the few stray pieces of user
> space that care and then cutting out that chunk of kernel code.

What we should do is what we've done in the past before removing a
system call like this.  printk a deprecation warning no more than n
times an hours with the process name using the deprecated interface.
A deprecated note in a header isn't necessarily something which will
be noticed by userspace programmers.  Heck, it isn't even in
Documentation/feature-removal-schedule.txt yet.

If people want to remove it, let's please do this in an orderly
fashion, and with ample warning that people besides kernel developers
will actually *notice*.

						- Ted

P.S.  I happen to be one those developers who think the binary
interface is not so bad, and for compared to reading from /proc/sys,
the sysctl syscall *is* faster.  But at the same there, there really
isn't anything where really does require that kind of speed, so that
point is moot.  But at the same time, what is the cost of leaving
sys_sysctl in the kernel for an extra 6-12 months, or even longer,
starting from now?  

Or if we going to remove parts of sysctl, can we at least keep enough
there so that existing glibc systems don't break?
