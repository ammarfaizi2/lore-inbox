Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWDLHXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWDLHXO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 03:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDLHXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 03:23:13 -0400
Received: from odin2.bull.net ([129.184.85.11]:33223 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932097AbWDLHXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 03:23:13 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Date: Wed, 12 Apr 2006 09:23:05 +0200
User-Agent: KMail/1.7.1
References: <200604061416.00741.Serge.Noiraud@bull.net> <1144807126.26133.21.camel@localhost.localdomain> <20060412062559.GB8499@elte.hu>
In-Reply-To: <20060412062559.GB8499@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604120923.06832.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mercredi 12 Avril 2006 08:25, you wrote/vous avez écrit :
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > Why do we need such a size ?
> > 
> > It seems that the -rt kernel has increased the size of structures that 
> > are used in modules and are defined per cpu.
> 
> i'm still wondering what that could be. The most drastic increase is the 
> size of locks (spinlocks, mutexes, etc.), especially with debugging 
> enabled - maybe one of the drivers uses a big per-CPU array of locks?
> 
> ah. One thing that takes up _alot_ of per-CPU space is the 
> latency-histogram stuff. I made the latency tracer itself use 
> non-per-cpu constructs to avoid overflowing the per-cpu-area, but the 
> latency-histogram code still uses PER_CPU:
> 
...
> 
> where MAX_ENTRY_NUM is 10240 right now. So the space used up is 
> 10240*3*8 - roughly +256K per-cpu space!
I use effectively CONFIG_WAKEUP_LATENCY_HIST.
> 
> I think that explains it. So the rule for -rt is, +256K more per-cpu 
> area is needed if the latency histograms are turned on.
OK.
> 
> 	Ingo

-- 
Serge Noiraud
