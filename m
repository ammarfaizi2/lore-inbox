Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUGXAZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUGXAZL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 20:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUGXAZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 20:25:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:40320 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268199AbUGXAZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 20:25:07 -0400
Subject: Re: Another dumb question about  Voluntary Kernel Preemption Patch
From: Lee Revell <rlrevell@joe-job.com>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <40FEE26D.7060904@techsource.com>
References: <20040712163141.31ef1ad6.akpm@osdl.org>
	 <1090306769.22521.32.camel@mindpipe> <20040720071136.GA28696@elte.hu>
	 <200407202011.20558.musical_snake@gmx.de>
	 <1090353405.28175.21.camel@mindpipe>  <40FDAF86.10104@gardena.net>
	 <1090369957.841.14.camel@mindpipe> <40FDC625.9080804@techsource.com>
	 <40FEE26D.7060904@techsource.com>
Content-Type: text/plain
Message-Id: <1090628706.1471.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 23 Jul 2004 20:25:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-21 at 17:38, Timothy Miller wrote:
> 
> Lee Revell wrote:

> > My
> > understanding is that the kernel is already preemptible anytime that a
> > spin lock (including the BKL) is not held, and that the voluntary kernel
> > preemption patch adds some scheduling points in places where it is safe
> > to sleep, but preemption is disabled because we are holding the BKL, and
> > that the number of these should approach zero as the kernel is improved
> > anyway.
> 
> That's confusing to me.  It was my understanding that the BKL is used to
> completely lock down the kernel so that no other CPU can have a process
> get into the kernel... something like how SMP was done under 2.0.

Yes, I was incorrect.  The vountary kernel preemption patch takes
sections that are non-preemptible (aka holding a spinlock) and that
would otherwise run for an unbounded time and adds logic to break out of
those loops, releasing any locks, in order to allow a higher priority
process to run.  It is voluntary because even though you are in a
non-preemptible section you voluntarily release any locks and yield to a
higher priority process.  It has nothing to do with the BKL as such.

Lee 

