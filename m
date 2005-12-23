Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbVLWAOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVLWAOg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLWAOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:14:36 -0500
Received: from mverd138.asia.info.net ([61.14.31.138]:29320 "EHLO
	kao2.melbourne.sgi.com") by vger.kernel.org with ESMTP
	id S1751186AbVLWAOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:14:35 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Lee Revell <rlrevell@joe-job.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Luck, Tony" <tony.luck@intel.com>, Tony Luck <tony.luck@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jack Steiner <steiner@sgi.com>,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay() 
In-reply-to: Your message of "Thu, 22 Dec 2005 16:45:08 CDT."
             <43AB1E64.6010504@tmr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 23 Dec 2005 11:14:24 +1100
Message-ID: <8270.1135296864@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005 16:45:08 -0500, 
Bill Davidsen <davidsen@tmr.com> wrote:
>Lee Revell wrote:
>> On Thu, 2005-12-15 at 18:12 -0800, John Hawkes wrote:
>> 
>>>From: "Lee Revell" <rlrevell@joe-job.com>
>>>
>>>>There are 10 drivers that udelay(10000) or more and a TON that
>>>>udelay(1000).  Turning those all into 1ms+ non preemptible sections will
>>>>be very bad.
>>>
>>>What about 100usec non-preemptible sections?
>> 
>> 
>> That will disappear into the noise, in normal usage these happen all the
>> time.  500usec non preemptible regions are rare (~1 hour to show up) and
>> 1ms very rare (24 hours).  My tests show that 300 usec or so is a good
>> place to draw the line if you don't want it to show up in latency tests.
>
>I may be misreading the original post, but the problem is described as 
>one where the TSC is not syncronised and a CPU switch takes place. Would 
>the correct solution be to somehow set CPU affinity temporarily in such 
>a way as to avoid disabling preempt at all?
>
>The preempt doesn't seem to be the root problem, so it's unlikely to be 
>the best solution...

Agreed.  See [RFC] Add thread_info flag for "no cpu migration"[1] on
lkml.  It got no response.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=113471059115107&w=2

