Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284906AbRLKG3V>; Tue, 11 Dec 2001 01:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284908AbRLKG3M>; Tue, 11 Dec 2001 01:29:12 -0500
Received: from zero.tech9.net ([209.61.188.187]:15879 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S284906AbRLKG3E>;
	Tue, 11 Dec 2001 01:29:04 -0500
Subject: Re: [RFC] Multiprocessor Control Interfaces
From: Robert Love <rml@tech9.net>
To: Jason Baietto <jason.baietto@ccur.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1008015291.15138.0.camel@soybean>
In-Reply-To: <1008015291.15138.0.camel@soybean>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.06.08.57 (Preview Release)
Date: 11 Dec 2001 01:29:07 -0500
Message-Id: <1008052151.4300.18.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-10 at 15:14, Jason Baietto wrote:

> I'm currently working on adding multiprocessor control interfaces
> to Linux.  My current efforts can be found here:
> 
>    http://www.ccur.com/realtime/oss
> 
> These are clean-room implementations of similar tools that have
> been available in our proprietary *nix for quite some time, and
> so the interfaces have a fair amount of mileage under their belts.
> Note that the scope is somewhat wider than just MP.

Ahh, very neat.  This is a useful tool.

One idea would be to allow users to set CPUs processes _can't_ run on. 
On high-end systems sometimes a CPU is affined to a particular IRQ (say,
network interface).  Another situation is where you bind a RT task to a
given CPU.  In these situations, you want everything else to _not_ run
on the CPUs.  I.e., `run --bind=!1' (note its easy to generate the
bitmask here too, by ANDing the inverse of the given CPU against -1).

At any rate, what is needed most is to standardize on an interface for
these scheduling mechanisms.  I guess its just CPU affinity we have to
go ... since not much progress was made of my (proc-based) method vs.
Ingo's (syscall-based) method, at this point either of the two being
merged would make me happy.

> These services rely upon Robert Love's CPU Affinity patch
> (version 2.4.16-1 was used for testing) which is available here:
> 
>    http://www.kernel.org/pub/linux/kernel/people/rml/cpu-affinity/v2.4/

I assume you have no problems with it ... I think I'd like to add the
change that the CPUs reported correspond to the physical CPU number and
not the logical value we derive.  On x86 this won't make a difference,
but its a proper method I suspect.

	Robert Love

