Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbRCFVh3>; Tue, 6 Mar 2001 16:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRCFVhS>; Tue, 6 Mar 2001 16:37:18 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:51461 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129525AbRCFVhE>; Tue, 6 Mar 2001 16:37:04 -0500
Date: Tue, 6 Mar 2001 15:36:26 -0600
To: "T.L.Madhu" <madhu.tarikere@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Info on adding system calls
Message-ID: <20010306153625.D28368@cadcamlab.org>
In-Reply-To: <Pine.PTX.3.96.1010302162652.16554L-100000@wipro.wipsys.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.PTX.3.96.1010302162652.16554L-100000@wipro.wipsys.sequent.com>; from madhu.tarikere@wipro.com on Fri, Mar 02, 2001 at 04:28:28PM +0530
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[T.L.Madhu]
> I want to add a function defined in my loadeble kernel module as
> system call.

You can't.  At least not without hackery -- anything is possible with a
bit of hackery.

And there are at least two good reasons for this.  First: adding
syscalls at runtime is a recipe for chaos in terms of applications
knowing what the ABI should be.  What if two modules wanted the same
unallocated syscall?  Should the second one fail, or should it just get
a free syscall, and somehow publish its syscall to userspace so apps
can use it?

The second is philosophical.  At the top of the COPYING file in the
kernel source, you see that Linus has made an exception to the GPL, to
allow anyone to write and distribute non-GPL modules, as long as they
do not compile directly into the kernel.  However, he doesn't want
people to use this as a general GPL circumvention device, so he will
not make it convenient to extend the system call interface this way.

Peter
