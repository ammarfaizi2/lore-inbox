Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVJLGpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVJLGpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 02:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbVJLGpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 02:45:34 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:41885 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932360AbVJLGpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 02:45:34 -0400
Date: Wed, 12 Oct 2005 02:38:51 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Lee Revell <rlrevell@joe-job.com>
cc: Mark Knecht <markknecht@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Latency data - 2.6.14-rc3-rt13
In-Reply-To: <1129080062.7094.7.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0510120233300.5830@localhost.localdomain>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com> 
 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com> 
 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> 
 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com> 
 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com> 
 <20051011111700.GA15892@elte.hu>  <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
  <1129075368.7094.3.camel@mindpipe>  <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
 <1129080062.7094.7.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Oct 2005, Lee Revell wrote:

> On Tue, 2005-10-11 at 18:09 -0700, Mark Knecht wrote:
> > Should free memory drop like that over time?
>
> Yes this is perfectly normal.  When a system first boots all the memory
> your apps aren't using is initially free.  As applications access more
> data over time then it will be cached in memory until free memory drops
> to near zero.
>
> "Free memory" is actually wasted memory - it's better to use all
> available RAM for caching.
>

But the swap being touched bothers me.  Although I've had problems with
leaving Mozilla up for long times and it leaking. Without Mozilla running
and running lots of other apps, I have almost 100% memory used, but 0%
swap.

If the swap starts to increase slowly over time, you _do_ have a
leak somewhere.  Probably not in the kernel (kernel memory never goes into
swap). But if you want to see if the kernel is leaking, examine
/proc/slabinfo once in a while and if you see something there constantly
growing, then that might indicate a leak.  Just pay attention to the first
column.

-- Steve

