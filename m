Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265851AbUBCIwd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265941AbUBCIwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:52:33 -0500
Received: from mail.shareable.org ([81.29.64.88]:54477 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265851AbUBCIwc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:52:32 -0500
Date: Tue, 3 Feb 2004 08:52:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040203085224.GA15738@mail.shareable.org>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040201012803.GN26076@dualathlon.random> <401F251C.2090300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401F251C.2090300@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> You got to be kidding.  Some object fixed in the address space which can
> perform system calls.  Nothing is more welcome to somebody trying to
> exploit some bugs.

Two approaches to randomising the vdso address:

  1. Selecting a random address at boot time.  All tasks have the same
     vdso for that run of the kernel.  Advantages: no MSR write at
     each context switch; could patch libsyscall.so at boot time with
     address if we were fanatical about optimisation (i.e. other
     libcs, not Glibc :)  Disadvantages: the attacker may eventually
     learn the address.

  2. Select a random address for every new task.  Advantages: harder
     to guess from studying a machine for a long time.  Disadvantages:
     slower context switches; the gain from randomising each task is
     nothing if all the tasks are very long lived anyway.

-- Jamie
