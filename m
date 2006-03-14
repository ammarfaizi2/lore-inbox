Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWCNWND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWCNWND (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWCNWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:13:01 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:9095 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932522AbWCNWNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:13:00 -0500
Subject: Re: 2.6.16-rc1: 28ms latency when process with lots of swapped
	memory exits
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <20060314212207.GC23458@elte.hu>
References: <1142352926.13256.117.camel@mindpipe>
	 <20060314212207.GC23458@elte.hu>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 17:12:57 -0500
Message-Id: <1142374378.24603.20.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-14 at 22:22 +0100, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > I've been testign for weeks with 2.6.16-rc1 + the latency trace patch 
> > and the longest latencies measured were 10-15ms due to the well known 
> > rt_run_flush issue.  Today I got one twice as long, when a Firefox 
> > process with a bunch of acroreads in tabs, from a new code path.
> > 
> > It seems to trigger when a process with a large amount of memory 
> > swapped out exits.
> 
> btw., one good way to get such things fixed is to code up a testcase: a 
> .c file that just has to be run to reproduce the latency. It might be 
> less trivial to code that up in some cases (like this one - e.g. you 
> might have to first get a large chunk of memory swapped out which isnt 
> easy), but i think it's still worth the effort, as that way you can 
> gently pressure us lazy upstream maintainers to act quicker, and we can 
> also easily verify whether the fix does the trick :-)

Sure, I'll try.  But I've been pounding on this kernel for weeks and
only hit this once.  And I'm pretty sure I've killed processes with lots
of swapped memory.  The only new variable was acroread - open 5 PDFs in
Firefox tabs, leave it alone for a few days until the kernel swaps it
all out, then kill it...

Lee

