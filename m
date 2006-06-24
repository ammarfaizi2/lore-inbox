Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933366AbWFXJY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933366AbWFXJY5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933367AbWFXJY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:24:57 -0400
Received: from ms-smtp-03.tampabay.rr.com ([65.32.5.133]:43136 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S933366AbWFXJY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:24:57 -0400
Message-ID: <449D04E0.5050104@cfl.rr.com>
Date: Sat, 24 Jun 2006 05:24:48 -0400
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Vernon Mauery <vernux@us.ibm.com>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rt1 - mm_struct leak
References: <20060618070641.GA6759@elte.hu> <200606231356.56267.vernux@us.ibm.com>
In-Reply-To: <200606231356.56267.vernux@us.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vernon Mauery wrote:
> On Sunday 18 June 2006 00:06, Ingo Molnar wrote:
>> i have released the 2.6.17-rt1 tree, which can be downloaded from the
>> usual place:
> 
> I was given a test case to run that seemed to cause the machine to run the 
> OOM-killer after a bunch of iterations.  The test was run like:
> 
> $ for ((i=0;i<50000;i++)); do ./test; done
> 
> and somewhere in there, the LowFree would drop very low and the test and the 
> bash shell running it would get killed.  And then since that didn't free up 
> much memory, the machine would become very unresponsive and would have to be 
> rebooted.
> 
> I don't have the source for the test myself and I am still trying to reproduce 
> it, but from what I have gathered, there is a problem cleaning up after 
> tasks.  I monitored the machine with slabtop while running the loop and found 
> that the size-32, pgd, pgm, and mm_struct slabs caches were constantly 
> growing while task_struct stayed where it should be.  At one point, there 
> were  127 task_structs and 3530 mm_structs.
> 
> I am still trying to figure out what is going on here, but I thought I might 
> throw this out there to see if anyone else has seen anything like this.  And 
> possibly pointers for how to track it down.  Right now I am trying to trace 
> down a possible mismatch between mmget and mmput in the process exit code.  I 
> will let you know what I find.
> 
> --Vernon

I reported a similar if not the same problem against 2.6.16-rt23
See this thread. Subject "possible 2.6.16-rt23 OOM problem"

http://lkml.org/lkml/2006/5/25/239

I found a way around the problem so didn't pursue it. Maybe "my way around it"
might help in tracking it down.

Mark
