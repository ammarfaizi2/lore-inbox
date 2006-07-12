Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWGLXcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWGLXcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 19:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGLXcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 19:32:01 -0400
Received: from ns1.suse.de ([195.135.220.2]:36237 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWGLXb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 19:31:59 -0400
From: Andi Kleen <ak@suse.de>
To: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Use uname not sysctl to get the kernel revision
Date: Thu, 13 Jul 2006 01:31:46 +0200
User-Agent: KMail/1.9.3
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
References: <m1psgdkrt8.fsf@ebiederm.dsl.xmission.com> <m1hd1mafe0.fsf@ebiederm.dsl.xmission.com> <20060712232414.GI9040@thunk.org>
In-Reply-To: <20060712232414.GI9040@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607130131.46753.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 01:24, Theodore Tso wrote:

> Um, if glibc is using sys_sysctl, then that's a pretty good reason.
> Once we remove it from the kernel, then people will be forced to
> upgrade glibc's before they can install a newer kernel.  Can we please
> give people some time for an version of glibc with this change to make
> it out to most deployed systems, first?  It's really annoying when
> it's not possible to install a stock kernel.org kernel on a system,
> and often upgrading glibc is not a trivial thing to do on a
> distribution userspace, especially if there is a concern for ISV
> compatibility.  (Especially if C++ code is involved, unfortunately.)

glibc still works, just slower. But I think the best strategy 
is just to emulate the single sysctl glibc is using and printk
for the rest.

> What we should do is what we've done in the past before removing a
> system call like this.  printk a deprecation warning no more than n
> times an hours with the process name using the deprecated interface.

We did this some time ago, but Andrew took it out (partly because
the original code was somewhat broken and the printk tended to trigger
too often in crashme) 

Hopefully he puts it back in now.

> P.S.  I happen to be one those developers who think the binary
> interface is not so bad, and for compared to reading from /proc/sys,
> the sysctl syscall *is* faster.  But at the same there, there really
> isn't anything where really does require that kind of speed, so that
> point is moot.  But at the same time, what is the cost of leaving
> sys_sysctl in the kernel for an extra 6-12 months, or even longer,
> starting from now?  

The numerical namespace for sysctl is unsalvagable imho. e.g. distributions
regularly break it because there is no central repository of numbers
so it's not very usable anyways in practice.
 
-Andi
