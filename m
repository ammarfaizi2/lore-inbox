Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVL2UVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVL2UVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbVL2UVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:21:04 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61658 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750957AbVL2UVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:21:01 -0500
Subject: Re: [patch] latency tracer, 2.6.15-rc7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1135887072.6804.9.camel@mindpipe>
References: <1135726300.22744.25.camel@mindpipe>
	 <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com>
	 <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu>
	 <20051229100233.GA12056@redhat.com>  <20051229101736.GA2560@elte.hu>
	 <1135887072.6804.9.camel@mindpipe>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 15:26:05 -0500
Message-Id: <1135887966.6804.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 15:11 -0500, Lee Revell wrote:
> On Thu, 2005-12-29 at 11:17 +0100, Ingo Molnar wrote:
> > * Dave Jones <davej@redhat.com> wrote:
> > 
> > >  > could test it by e.g. trying to reproduce the same VM latency as in the 
> > >  > -rt tree. [the two zlib patches are needed if you are using 4K stacks, 
> > >  > mcount increases stack footprint.]
> > > 
> > > kernel/latency.c: In function 'add_preempt_count_ti':
> > > kernel/latency.c:1703: warning: implicit declaration of function 'preempt_count_ti'
> > > kernel/latency.c:1703: error: invalid lvalue in assignment
> > > kernel/latency.c: In function 'sub_preempt_count_ti':
> > > kernel/latency.c:1764: error: invalid lvalue in assignment
> > 
> > indeed - i have fixed this and have uploaded a new version to:
> > 
> >    http://redhat.com/~mingo/latency-tracing-patches/
> 
> Still does not quite work for me on i386.  I applied all the patches as
> I'm using 4K stacks.
> 
> LD      .tmp_vmlinux1
> init/built-in.o: In function `start_kernel':
> : undefined reference to `preempt_max_latency'
> make: *** [.tmp_vmlinux1] Error 1
> 

This patch fixes the problem.

Lee

--- linux-2.6.15-rc5-rt2/kernel/latency.c~	2005-12-29 14:04:26.000000000 -0500
+++ linux-2.6.15-rc5-rt2/kernel/latency.c	2005-12-29 15:23:32.000000000 -0500
@@ -71,9 +71,9 @@
  * we clear it after bootup.
  */
 #ifdef CONFIG_LATENCY_HIST
-static cycles_t preempt_max_latency = (cycles_t)0UL;
+cycles_t preempt_max_latency = (cycles_t)0UL;
 #else
-static cycles_t preempt_max_latency = (cycles_t)ULONG_MAX;
+cycles_t preempt_max_latency = (cycles_t)ULONG_MAX;
 #endif
 
 static cycles_t preempt_thresh;


