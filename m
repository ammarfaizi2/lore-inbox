Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWF3UzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWF3UzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 16:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWF3UzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 16:55:21 -0400
Received: from palrel12.hp.com ([156.153.255.237]:51919 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S932321AbWF3UzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 16:55:21 -0400
Date: Fri, 30 Jun 2006 13:47:17 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU context switch
Message-ID: <20060630204717.GC22835@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606230913.k5N9D73v032387@frankl.hpl.hp.com> <200606301633.35818.ak@suse.de> <20060630160203.GH22381@frankl.hpl.hp.com> <200606301908.03934.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301908.03934.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 07:08:03PM +0200, Andi Kleen wrote:
> On Friday 30 June 2006 18:02, Stephane Eranian wrote:
> > Andi,
> > 
> > As a first step, I am looking at implementing a TIF_DEBUG
> > for x86-64. AFAIK, debug registers must not be inherited on
> > fork().
> 
> Why not?  Especially for threads you probably want them
> in the new thread too.
> 
For this to work, the new thread must also inherit the ptrace
flag and ptrace re-parenting stuff. That would happen under
the cover as the ptracing application would not necessarily
know about this. It would also need to be able to name that new
thread (via gettid() and not getpid()) to be able to operate
on it.

In my mind, it has to work the other way around. The ptracing
process interesting in ptracing/debugging new threads, sets the
right ptrace notification options for CLONE, when it gets the
notification it attaches to the newly created thread and reprograms
the breakpoints. This is the way I allow a tool such as pfmon,
to monitor across fork, pthread_create(), for instance.

Of the top of my head, I think for Itanium, we disable breakpoints
for the child in copy_threads(). I don't know for the other architectures.

Anybody can comment on this?

-- 
-Stephane
