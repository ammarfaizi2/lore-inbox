Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130461AbRCWKNA>; Fri, 23 Mar 2001 05:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRCWKMu>; Fri, 23 Mar 2001 05:12:50 -0500
Received: from [166.70.28.69] ([166.70.28.69]:41016 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S130466AbRCWKMi>;
	Fri, 23 Mar 2001 05:12:38 -0500
To: nbecker@fred.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: regression testing
In-Reply-To: <x88zoeeeyh8.fsf@adglinux1.hns.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Mar 2001 03:11:02 -0700
In-Reply-To: nbecker@fred.net's message of "22 Mar 2001 08:15:31 -0500"
Message-ID: <m1wv9g23t5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nbecker@fred.net writes:

> Hi.  I was wondering if there has been any discussion of kernel
> regression testing.  Wouldn't it be great if we didn't have to depend
> on human testers to verify every change didn't break something?

There is a some truth to this.  However for kernel development there
is one thing to keep in mind: most bugs are in the drivers (buggy
hardware with a software workaround counts as a driver bug).  Having
an army of human testers with weird machines with all kinds of
drivers is the only economical way of doing driver regression testing.

> OK, I'll admit I haven't given this a lot of thought.  What I'm
> wondering is whether the user-mode linux could help here (allow a way
> to simulate controlled activity).

The most devastating bugs are in the core kernel code, and a
regression test for that code is more likely.  Yes user-mode linux
could help here (you could stress test the core kernel without worry
that when it crashes your machine will crash as well).  

Additionally a good test suite that give the kernel a good going over
in a manner that exercises standard kinds of hardware could also help.  

Unless you are using profiling to verify you have covered all paths
in the code there will always be question such as does that code path
work in practice.

The other thing that can help a lot looks like the augmented static
analysis of the kernel.  Once that is generally available we should
be able to verify at compile time that a lot of little rules are
always obeyed.  It will never get the really hard things but the
compiler pointing out that there is an sti on all paths after a cli
could improve things significantly (especially with the drivers).

Eric
