Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbUDGW52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUDGW52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:57:28 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:34775 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264203AbUDGW4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:56:38 -0400
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to
	CPU_DEAD handling
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       LHCS list <lhcs-devel@lists.sourceforge.net>,
       Joel Schopp <jschopp@austin.ibm.com>
In-Reply-To: <20040407141721.GA12876@in.ibm.com>
References: <20040405121824.GA8497@in.ibm.com>
	 <4071F9C5.2030002@yahoo.com.au> <20040406083713.GB7362@in.ibm.com>
	 <407277AE.2050403@yahoo.com.au> <1081310073.5922.86.camel@bach>
	 <20040407050111.GA10256@in.ibm.com> <1081315931.5922.151.camel@bach>
	 <20040407141721.GA12876@in.ibm.com>
Content-Type: text/plain
Message-Id: <1081378555.10367.9.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Apr 2004 08:55:56 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-08 at 00:17, Srivatsa Vaddagiri wrote:
> On Wed, Apr 07, 2004 at 03:32:12PM +1000, Rusty Russell wrote:
> > But other tasks can do a getaffinity() on it and see the wrong affinity.
> > Probably not a big issue.
> 
> hmm .. the fact that getaffinity reads the cpus_allowed mask w/o doing
> lock_cpu_hotplug makes it already racy wrt setaffinity?

But that's OK: that's a user race.  It's like reading a file at the same
time as writing it.

> Maybe it needs to take CPU hotplug sem before it reads the mask?

Yes, taking it in both syscalls would work, too.

> I would like to run my stress tests for longer time before I send it
> for inclusion (i would be on vacation till next tuesday ..so maybe i will send
> in the patch after that!)

Thanks.  BTW, can you take a look at the FIXME: in xics.c and change it
to be dynamic.  Joel is having trouble proving it's a problem, and yet
Anton assures me that ioremap is needed, so CPUs not present at boot
which are brought in should be failing...

Thanks!
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

